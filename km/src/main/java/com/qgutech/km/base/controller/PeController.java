package com.qgutech.km.base.controller;


import com.qgutech.km.module.im.service.MsgSendService;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.CorpInfo;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.base.service.CorpService;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.constant.RedisKey;
import com.qgutech.km.module.im.domain.ImReceiver;
import com.qgutech.km.module.im.domain.ImTemplate;
import com.qgutech.km.module.uc.service.UserRoleService;
import com.qgutech.km.utils.*;
import com.qgutech.km.utils.*;
import com.qgutech.km.utils.*;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class PeController {

    protected final Log LOG = LogFactory.getLog(getClass());

    @Resource
    private CorpService corpService;
    @Resource
    private UserRoleService userRoleService;

    @RequestMapping(value = "/pages/**")
    public String main(HttpServletRequest request) {
        return StringUtils.substringAfter(request.getServletPath(), "/pages/");
    }

    /**
     * 官网短信 图形验证码
     */
    @RequestMapping("website/verifyImageCode")
    public void createVerifyCode(HttpServletResponse response, String sessionId) {
        String verifyCode = VerifyCodeUtils.randomCode(4);
        String expiredTime = PropertiesUtils.getConfigProp().getProperty("verifyCode.time");
        PeRedisClient.getCommonJedis().setex(RedisKey.WEBSITE_SMS_IMAGE_CODE
                + sessionId, PeNumberUtils.transformInt(expiredTime), verifyCode);
        VerifyCodeUtils.generateCode(60, 24, verifyCode, response);
    }

    /**
     * 获取短信验证码
     */
    @ResponseBody
    @RequestMapping("website/getSessionId")
    public String getSessionId() {
        return UUIDGenerator.uuid();
    }

    /**
     * 获取短信验证码
     */
    @ResponseBody
    @RequestMapping("website/getSmsCode")
    public JsonResult<String> getSmsCode(String sessionId, String mobile, String code) {
        if (StringUtils.isBlank(sessionId)) {
            return new JsonResult<>(false, "用户身份不合法，需要申请sessionId！");
        }

        if (StringUtils.isBlank(mobile) || !RegularUtils.checkMobile(mobile)) {
            return new JsonResult<>(false, "手机号码不合法!");
        }

        if (StringUtils.isBlank(code)) {
            return new JsonResult<>(false, "图形验证码不允许为空!");
        }


        String redisCode = PeRedisClient.getCommonJedis().get(RedisKey.WEBSITE_SMS_IMAGE_CODE + sessionId);
        if (StringUtils.isBlank(redisCode)) {
            return new JsonResult<>(false, "图形验证码已经失效!");
        }

        if (!code.equalsIgnoreCase(redisCode)) {
            return new JsonResult<>(false, "图形验证码不正确!");
        }

        CorpInfo dataCorpInfo = corpService.checkDomainName(mobile + PeConstant.DEFAULT_DOMAIN_SUFFIX);
        if (dataCorpInfo != null) {
            return new JsonResult<>(false, "您已经注册，请勿重新注册!" );
        }

        String smsCode = VerifyCodeUtils.randomCode(4);
        String expiredTime = PropertiesUtils.getConfigProp().getProperty("verifyCode.time");
        PeRedisClient.getCommonJedis().setex(RedisKey.WEBSITE_SMS_CODE + mobile, PeNumberUtils.transformInt(expiredTime),
                smsCode);
        Map<String, Object> paramData = new HashMap<>(2);
        paramData.put("REGISTER_CODE", smsCode);
        paramData.put("EXPIRE_TIME", (PeNumberUtils.transformInt(expiredTime) / 60));
        String templateName = ImTemplate.REGISTER_CORP_CODE;
        MsgSendService.sendSmsMsg(templateName, Collections.singletonList(mobile), paramData, true);
        PeRedisClient.getCommonJedis().del(RedisKey.WEBSITE_SMS_IMAGE_CODE + sessionId);
        return new JsonResult<>(true, "短信发送成功!");
    }

    /**
     * 注册提交试用公司
     */
    @ResponseBody
    @RequestMapping("website/registerCorp")
    public JsonResult<Integer> registerCorp(@ModelAttribute CorpInfo corpInfo, String smsCode) {
        if (StringUtils.isBlank(corpInfo.getContactsMobile())) {
            return new JsonResult<>(false, "手机号码不允许为空!");
        }

        if (StringUtils.isBlank(smsCode)) {
            return new JsonResult<>(false, "短信验证码不允许为空!");
        }

//        if (StringUtils.isBlank(corpInfo.getContacts())) {
//            return new JsonResult<>(false, "姓名不允许为空!");
//        }

        String redisCode = PeRedisClient.getCommonJedis().get(RedisKey.WEBSITE_SMS_CODE + corpInfo.getContactsMobile());
        if (StringUtils.isBlank(redisCode)) {
            return new JsonResult<>(false, "短信验证码已经失效!");
        }

        if (!smsCode.equalsIgnoreCase(redisCode)) {
            return new JsonResult<>(false, "短信验证码不正确!");
        }

        corpInfo.setCorpCode(corpInfo.getContactsMobile());
        corpInfo.setDomainName(corpInfo.getContactsMobile() + PeConstant.DEFAULT_DOMAIN_SUFFIX);
        corpInfo.setCorpName(corpInfo.getContactsMobile());
        CorpInfo dataCorpInfo = corpService.checkDomainName(corpInfo.getDomainName());
        if (dataCorpInfo != null) {
            return new JsonResult<>(false, "您已经注册，请勿重新注册!" ,1);
        }

//        corpInfo.setEndTime(DateUtils.addMonths(new Date(), 1)); 先将免费版的试用时间无限
        corpInfo.setRegisterNum(Long.parseLong(PropertiesUtils.getConfigProp().getProperty("trial.register.count")));
        corpInfo.setConcurrentNum(Long.parseLong(PropertiesUtils.getConfigProp().getProperty("trial.concurrent.count")));
        corpInfo.setVersion(CorpInfo.CorpVersion.FREE);
        try {
            ExecutionContext.setUserId(PeConstant.ADMIN);
            corpInfo.setMessageStatus(CorpInfo.MessageStatus.CLOSE);
            corpInfo.setFromAppType(CorpInfo.FromAppType.PE);
            if (StringUtils.isBlank(corpInfo.getCorpName())) {
                corpInfo.setCorpName(corpInfo.getContacts());
            }

            corpService.autoOpenCorp(corpInfo);
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }

        try {
            Map<String, Object> paramData = new HashMap<>(2);
            paramData.put("DOMAIN", corpInfo.getDomainName());
            paramData.put("LOGIN_NAME", PeConstant.ADMIN);
            paramData.put("PASSWORD", PropertiesUtils.getConfigProp().getProperty("default.user.password"));
            paramData.put("CONTACTS_MOBILE", PropertiesUtils.getConfigProp().getProperty("corp.contacts.mobile"));
            MsgSendService.sendSmsMsg(ImTemplate.OPEN_TRY_CORP, Collections.singletonList(corpInfo.getContactsMobile()),
                    paramData, true);
            paramData.put("CONTACTS", corpInfo.getContacts());
            paramData.put("CONTACTS_MOBILE", corpInfo.getContactsMobile());
            paramData.put("CONTACTS_EMAIL", corpInfo.getEmail());
            paramData.put("CORP_NAME", corpInfo.getCorpName());
            paramData.put("CONTACTS_POSITION", corpInfo.getContactsPosition());
            paramData.put("START_TIME", PeDateUtils.format(new Date(), PeDateUtils.FORMAT_YYYY_MM_DD));
            String targetEmail = PropertiesUtils.getConfigProp().getProperty("corp.contacts.email");
            ImReceiver receiver = new ImReceiver(targetEmail, targetEmail, targetEmail);
            MsgSendService.sendEmailMsg("noticeOpenCorp", "试用申请",
                    Collections.singletonList(receiver), paramData, true);
        } catch (Exception e) {
            LOG.error(e);
        }

        PeRedisClient.getCommonJedis().del(RedisKey.WEBSITE_SMS_CODE + corpInfo.getContactsMobile());
        return new JsonResult<>(true, corpInfo.getDomainName()+ "");
    }


    /**
     * 找回帐号
     */
    @ResponseBody
    @RequestMapping("website/retrieveCorp")
    public JsonResult<Integer> retrieveCorp(@ModelAttribute CorpInfo corpInfo, String smsCode) {
        if (StringUtils.isBlank(corpInfo.getContactsMobile())) {
            return new JsonResult<>(false, "手机号码不允许为空!");
        }

        if (StringUtils.isBlank(smsCode)) {
            return new JsonResult<>(false, "短信验证码不允许为空!");
        }

        String redisCode = PeRedisClient.getCommonJedis().get(RedisKey.WEBSITE_SMS_CODE + corpInfo.getContactsMobile());
        if (StringUtils.isBlank(redisCode)) {
            return new JsonResult<>(false, "短信验证码已经失效!");
        }

        if (!smsCode.equalsIgnoreCase(redisCode)) {
            return new JsonResult<>(false, "短信验证码不正确!");
        }

        corpInfo.setCorpCode(corpInfo.getContactsMobile());
        corpInfo.setDomainName(corpInfo.getContactsMobile() + PeConstant.DEFAULT_DOMAIN_SUFFIX);
        CorpInfo dataCorpInfo = corpService.checkDomainName(corpInfo.getDomainName());
        if (dataCorpInfo != null) {
            dataCorpInfo.setContactsMobile(corpInfo.getContactsMobile());
            dataCorpInfo.setCorpCode(corpInfo.getCorpCode());
            corpInfo = dataCorpInfo;
            try {
                Map<String, Object> paramData = new HashMap<>(2);
                paramData.put("DOMAIN", corpInfo.getDomainName());
                paramData.put("LOGIN_NAME", PeConstant.ADMIN);
                paramData.put("PASSWORD", PropertiesUtils.getConfigProp().getProperty("default.user.password"));
                paramData.put("CONTACTS_MOBILE", PropertiesUtils.getConfigProp().getProperty("corp.contacts.mobile"));
                MsgSendService.sendSmsMsg(ImTemplate.OPEN_TRY_CORP, Collections.singletonList(corpInfo.getContactsMobile()),
                        paramData, true);
            } catch (Exception e) {
                LOG.error(e);
            }
            return new JsonResult<>(true, corpInfo.getDomainName() + "");
        }else{
            return new JsonResult<>(false, "您未注册，请先注册!" , 1);
        }

    }

    /**
     * oms注册公司
     */
    @ResponseBody
    @RequestMapping("website/openCorpForElp")
    public JsonResult<CorpInfo> openCorpForElp(@ModelAttribute CorpInfo corpInfo) {
        try {
            corpService.openCorpForElp(corpInfo);
        } catch (PeException e) {
            LOG.error(e);
            return new JsonResult<>(false, e.getMessage());
        }

        return new JsonResult<>(true, JsonResult.SUCCESS);
    }

    /**
     * 根据corpCode ,userId和时间戳在redis中生成数据，保留5分钟
     */
    @ResponseBody
    @RequestMapping("website/storeElnMessage")
    public JsonResult storeElnMessage(String corpCode, String loginName, String timeStamp) {
        if (StringUtils.isBlank(corpCode) || StringUtils.isBlank(loginName) || StringUtils.isBlank(timeStamp)) {
            throw new IllegalArgumentException("Parameters are not valid!");
        }
        JsonResult jsonResult = new JsonResult();
        long stamp = Long.valueOf(timeStamp);
        long stampLong = stamp + 5000L;
        long now = System.currentTimeMillis();
        //  if (now >= stamp && now <= stampLong) {
        if (true) {
            String redisKey = corpService.storeElnToRedis(corpCode, loginName);
            if (redisKey == null) {
                jsonResult.setSuccess(false);
            } else {
                jsonResult.setSuccess(true);
                jsonResult.setData(redisKey);
            }

        } else {
            jsonResult.setSuccess(false);
        }
        return jsonResult;
    }

}
