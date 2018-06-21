package com.qgutech.km.base.controller;

import com.alibaba.fastjson.JSON;
import com.qgutech.km.module.im.service.MsgSendService;
import com.qgutech.km.module.uc.model.Authority;
import com.qgutech.km.module.uc.model.SessionContext;
import com.qgutech.km.module.uc.service.UserService;
import com.qgutech.km.utils.*;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.CorpInfo;
import com.qgutech.km.base.redis.PeJedisCommands;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.base.service.I18nService;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.AuthConstant;
import com.qgutech.km.constant.CookieKey;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.constant.RedisKey;
import com.qgutech.km.module.im.domain.ImTemplate;
import com.qgutech.km.module.uc.model.Role;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.module.uc.service.RoleAuthorityService;
import com.qgutech.km.module.uc.service.RoleService;
import com.qgutech.km.module.uc.service.UserRoleService;
import com.qgutech.km.utils.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.stream.Collectors;

public abstract class BaseController {

    protected final static Log LOG = LogFactory.getLog(BaseController.class);

    protected void storeLoginInfo(User loginUser, HttpServletResponse response) {
        String rememberPwdUUID = UUIDGenerator.uuid();
        String expireTime = PropertiesUtils.getConfigProp().getProperty("remember.pwd.time");
        PeRedisClient.getSessionJedis().setex(RedisKey.UC_REMEMBER_PWD + rememberPwdUUID, Integer.valueOf(expireTime) * 24 * 3600,
                JSON.toJSONString(loginUser));
        CookieUtil.setCookie(response, CookieKey.UC_REMEMBER_PWD_ID, rememberPwdUUID);
    }

    protected JsonResult<User> checkCorp(CorpInfo corpInfo) {
        JsonResult<User> jsonResult = new JsonResult<>();
        jsonResult.setSuccess(false);
        if (corpInfo.getEndTime() != null && new Date().after(corpInfo.getEndTime())) {
            jsonResult.setMessage("公司已过期");
            return jsonResult;
        }

        if (corpInfo.getConcurrentNum() > 0) {
            Set<String> userIds = PeRedisClient.getSessionJedis().keys(RedisKey.UC_ALREADY_LOGIN + PeConstant.REDIS_DIVISION +
                    ExecutionContext.getCorpCode() + PeConstant.REDIS_DIVISION + PeConstant.STAR);
            if (userIds.size() >= corpInfo.getConcurrentNum()) {
                jsonResult.setMessage("公司最大并发数已到达上限");
                return jsonResult;
            }
        }

        jsonResult.setSuccess(true);
        return jsonResult;
    }

    /**
     * 存储用户的session信息
     */
    protected String storeSession(HttpServletRequest request, HttpServletResponse response, User user, CorpInfo corpInfo) {
        String sessionId = UUIDGenerator.uuid();
        CookieUtil.setCookie(response, CookieKey.UC_LOGIN_SESSION_ID, sessionId);
        //session设置
        SessionContext sessionContext = new SessionContext();
        sessionContext.setSessionId(sessionId);
        sessionContext.setUserId(user.getId());
        sessionContext.setCorpCode(ExecutionContext.getCorpCode());
        if (User.RoleType.ADMIN.equals(user.getRoleType())) {
            sessionContext.setAdmin(true);
            UserRoleService userRoleService = SpringContextHolder.getBean("userRoleService");
            List<Role> roles = userRoleService.listByUserId(user.getId());
            if (CollectionUtils.isNotEmpty(roles)) {
                RoleService roleService = SpringContextHolder.getBean("roleService");
                String systemRoleId = roleService.getSystemId();
                roles.forEach(role -> {
                    if (role.getId().equals(systemRoleId)) {
                        sessionContext.setSystemAdmin(true);
                    }
                });
            }

            if (PeConstant.ADMIN.equals(user.getLoginName())) {
                sessionContext.setSuperAdmin(true);
            }

            //设置当前登录的权限码
            RoleAuthorityService roleAuthorityService = SpringContextHolder.getBean("roleAuthorityService");
            List<Authority> authorities = roleAuthorityService.listAuthorityByUserId(user.getId());
            Set<String> authCodes = new HashSet<>(0);
            if (CollectionUtils.isNotEmpty(authorities)) {
                authCodes = authorities.stream().map(Authority::getAuthCode).collect(Collectors.toSet());
            }

            //初始化版本权限
            if (corpInfo != null) {
                if (CorpInfo.CorpVersion.FREE.equals(corpInfo.getVersion())) {
                    authCodes.addAll(AuthConstant.FREE_VERSION_L);
                } else if (CorpInfo.CorpVersion.ENTERPRISE.equals(corpInfo.getVersion())) {
                    authCodes.addAll(AuthConstant.ENTERPRISE_VERSION_L);
                }
            }

            sessionContext.setAuthCodes(authCodes);
        }

        sessionContext.setIp(PeUtils.getIpAddress(request));
        sessionContext.setUserName(user.getUserName());
        try {
            //存储session
            String loginKey = RedisKey.UC_ALREADY_LOGIN + PeConstant.REDIS_DIVISION +
                    ExecutionContext.getCorpCode() + PeConstant.REDIS_DIVISION + user.getId();
            PeJedisCommands sessionJedis = PeRedisClient.getSessionJedis();
            //将userId对应登录sessionId存redis
            Long existIndex = sessionJedis.setnx(loginKey, sessionId);
            //互踢
            if (existIndex == null || existIndex == 0) {
                String loginSessionId = sessionJedis.get(loginKey);
                String loginSessionKey = RedisKey.UC_LOGIN_SESSION + PeConstant.REDIS_DIVISION + loginSessionId;
                LOG.info("Play each other session id :{" + loginSessionId + "}");
                sessionJedis.del(loginSessionKey);
                sessionJedis.set(loginKey, sessionId);
            }

            //存session
            //cookie设置
            Integer aliveSeconds = PeNumberUtils.transformInt(
                    PropertiesUtils.getConfigProp().getProperty("session.expire.time"));
            String sessionKey = RedisKey.UC_LOGIN_SESSION + PeConstant.REDIS_DIVISION + sessionId;
            sessionJedis.setex(sessionKey, aliveSeconds * 60, JSON.toJSONString(sessionContext));
            sessionJedis.expire(loginKey, aliveSeconds * 60);
            return sessionId;
        } catch (Exception e) {
            LOG.error("login error!", e);
            return sessionId;
        }
    }

    protected String storeSession(HttpServletRequest request, HttpServletResponse response, User user) {
        return storeSession(request, response, user, null);
    }




    protected JsonResult<User> bindLoginMobile(String mobile) {
        PeJedisCommands sessionRedis = PeRedisClient.getSessionJedis();
        String redisMobile = sessionRedis.get(RedisKey.UC_BING_MOBILE_VERIFY_CODE + ExecutionContext.getUserId());
        if (StringUtils.isBlank(redisMobile) || !redisMobile.equals(mobile)) {
            I18nService i18nService = SpringContextHolder.getBean("i18nService");
            return new JsonResult<>(false, i18nService.getI18nValue("error.bind.mobile.code"));
        }

        sessionRedis.del(RedisKey.UC_BING_MOBILE_VERIFY_CODE + ExecutionContext.getUserId());
        sendVerifyCode(mobile);
        return new JsonResult<>(true, JsonResult.SUCCESS);
    }

    /**
     * 发送验证码
     */
    protected void sendVerifyCode(String mobile) {
        String expiredTime = PropertiesUtils.getConfigProp().getProperty("verifyCode.time");
        String verifyCode = VerifyCodeUtils.randomCode(4);
        PeRedisClient.getCommonJedis().setex(RedisKey.UC_BING_MOBILE_VERIFY_CODE + ExecutionContext.getUserId() +
                PeConstant.REDIS_DIVISION + mobile, PeNumberUtils.transformInt(expiredTime), verifyCode);
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("CONFIRM_CODE", verifyCode);
        String templateName = ImTemplate.BIND_MOBILE_CONFIRM_CODE;
        MsgSendService.sendSmsMsg(templateName, Collections.singletonList(mobile), dataMap, true);
    }

    protected JsonResult<User> checkPwd(String pagePwd) {
        pagePwd = MD5Generator.getHexMD5(pagePwd);
        if (StringUtils.isBlank(pagePwd)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        UserService userService = SpringContextHolder.getBean("userService");
        String password = userService.getFieldValueById(ExecutionContext.getUserId(), User._password);
        if (!password.equalsIgnoreCase(pagePwd)) {
            I18nService i18nService = SpringContextHolder.getBean("i18nService");
            return new JsonResult<>(false, i18nService.getI18nValue("user.pwd.wrong"));
        }

        return new JsonResult<>(true, JsonResult.SUCCESS);
    }

    protected JsonResult<User> bindMobile(String mobile, String verifyCode) {
        if (StringUtils.isBlank(mobile) || StringUtils.isBlank(verifyCode)) {
            throw new IllegalArgumentException("Checking info is illegal!");
        }

        String codeRedisKey = RedisKey.UC_BING_MOBILE_VERIFY_CODE + ExecutionContext.getUserId() +
                PeConstant.REDIS_DIVISION + mobile;
        String redisVerifyCode = PeRedisClient.getCommonJedis().get(codeRedisKey);
        if (!StringUtils.equalsIgnoreCase(verifyCode, redisVerifyCode)) {
            I18nService i18nService = SpringContextHolder.getBean("i18nService");
            return new JsonResult<>(false, i18nService.getI18nValue("error.verifyCode.input"));
        }

        UserService userService = SpringContextHolder.getBean("userService");
        try {
            userService.updateMobile(mobile, ExecutionContext.getUserId());
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }

        return new JsonResult<>(true, JsonResult.SUCCESS);
    }

    protected JsonResult<User> checkMyMobile(String mobile) {
        UserService userService = SpringContextHolder.getBean("userService");
        User user = userService.getByMobile(mobile);
        if (user == null || user.getId().equals(ExecutionContext.getUserId())) {
            String codeExpireTime = PropertiesUtils.getConfigProp().getProperty("verifyCode.time");
            PeRedisClient.getSessionJedis().setex(RedisKey.UC_BING_MOBILE_VERIFY_CODE + ExecutionContext.getUserId(),
                    Integer.valueOf(codeExpireTime) * 60, mobile);
            return new JsonResult<>(true, JsonResult.SUCCESS);
        }

        return new JsonResult<>(false, "该手机号已经存在!");
    }
}
