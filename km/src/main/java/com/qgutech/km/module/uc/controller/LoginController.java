package com.qgutech.km.module.uc.controller;

import com.alibaba.fastjson.JSON;
import com.qgutech.km.base.controller.BaseController;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.base.service.CorpService;
import com.qgutech.km.constant.CookieKey;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.im.domain.ImReceiver;
import com.qgutech.km.module.im.service.MsgSendService;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.module.uc.service.LoginService;
import com.qgutech.km.module.uc.service.UserRedisService;
import com.qgutech.km.module.uc.service.UserService;
import com.qgutech.km.utils.*;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.CorpInfo;
import com.qgutech.km.base.redis.PeJedisCommands;
import com.qgutech.km.base.service.I18nService;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.RedisKey;
import com.qgutech.km.module.im.domain.ImTemplate;
import com.qgutech.km.module.uc.service.UserRoleService;
import com.qgutech.km.utils.*;
import com.qgutech.km.utils.*;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * 登录的控制层
 *
 * @author Created by zhangyang on 2016/11/4.
 */
@Controller
public class LoginController extends BaseController {

    @Resource
    private I18nService i18nService;
    @Resource
    private UserService userService;
    @Resource
    private UserRedisService userRedisService;
    @Resource
    private LoginService loginService;
    @Resource
    private UserRoleService userRoleService;

    @RequestMapping("login/loginPage")
    public String initPage(HttpServletRequest request, HttpServletResponse response) {
        Cookie cookie = CookieUtil.getCookie(request, CookieKey.UC_REMEMBER_PWD_ID);
        if (cookie == null || StringUtils.isBlank(cookie.getValue())) {
            return "uc/login/login";
        }

        String userStr = PeRedisClient.getSessionJedis().get(RedisKey.UC_REMEMBER_PWD + cookie.getValue());
        if (StringUtils.isBlank(userStr)) {
            CookieUtil.deleteCookie(response, cookie);
            return "uc/login/login";
        }

        User user = JSON.parseObject(userStr, User.class);
        String newPwd = MD5Generator.getHexMD5(PeConstant.LOGIN_REMEMBER_PWD_PREFIX + user.getPassword());
        user.setPassword(newPwd);
        request.setAttribute("user", user);
        return "uc/login/login";
    }


    /**
     * 登录
     */
    @ResponseBody
    @RequestMapping("login/ajaxLogin")
    public JsonResult<User> ajaxLogin(User loginUser, HttpServletRequest request, HttpServletResponse response) {
        JsonResult<User> jsonResult = new JsonResult<>();
        CorpService corpService = SpringContextHolder.getBean("corpService");
        CorpInfo corpInfo = corpService.getByCode(ExecutionContext.getCorpCode());
        if (corpInfo == null) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("公司不存在");
            return jsonResult;
        }

        jsonResult = checkCorp(corpInfo);
        if (!jsonResult.isSuccess()) {
            return jsonResult;
        }

        Cookie cookie = CookieUtil.getCookie(request, CookieKey.UC_REMEMBER_PWD_ID);
        if (cookie != null) {
            String userStr = PeRedisClient.getSessionJedis().get(RedisKey.UC_REMEMBER_PWD + cookie.getValue());
            User redisUser = JSON.parseObject(userStr, User.class);
            if (redisUser != null) {
                String redisPwd = MD5Generator.getHexMD5(PeConstant.LOGIN_REMEMBER_PWD_PREFIX + redisUser.getPassword());
                if (StringUtils.isNotBlank(redisPwd) && redisPwd.equalsIgnoreCase(loginUser.getPassword())) {
                    loginUser.setPassword(redisUser.getPassword());
                }
            }
        }

        jsonResult = loginService.login(loginUser);
        if (!jsonResult.isSuccess()) {
            if (StringUtils.isBlank(loginUser.getExamId())) {
                return jsonResult;
            }

            if (StringUtils.isBlank(loginUser.getLoginName()) || StringUtils.isBlank(loginUser.getPassword())) {
                jsonResult.setMessage(i18nService.getI18nValue("login.name.password.not.empty"));
                return jsonResult;
            }

            String userId = PeRedisClient.getEmsJedis().hget(RedisKey.EXAM_USER_TICKET + loginUser.getExamId(), loginUser.getLoginName());
            if (StringUtils.isBlank(userId)) {
                return jsonResult;
            }

            String loginPwd = MD5Generator.getHexMD5(loginUser.getPassword());
            User user = userRedisService.get(userId, User._userName, User._mobile, User._email, User._roleType, User._loginName, User._password);
            if (user == null || !user.getPassword().equalsIgnoreCase(loginPwd)) {
                jsonResult.setMessage(i18nService.getI18nValue("login.user.not.match"));
                return jsonResult;
            }

            jsonResult.setData(user);
        }

        User user = jsonResult.getData();

        String sessionId = storeSession(request, response, user, corpInfo);
        jsonResult.setSuccess(true);
        user.setSessionId(sessionId);
        if (!loginUser.isRememberPwd()) {
            return jsonResult;
        }

        //记住密码
        storeLoginInfo(loginUser, response);
        return jsonResult;
    }

    /**
     * 验证邮箱，点击链接
     */
    @ResponseBody
    @RequestMapping("login/activateEmail")
    public JsonResult<User> activateEmail(String email, String loginName) {
        if (StringUtils.isBlank(email) || StringUtils.isBlank(loginName)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        User user = userService.getByLoginName(loginName);
        if (user != null) {
            user = userService.get(user.getId(), User._status);
            if (!User.UserStatus.ENABLE.equals(user.getStatus())) {
                return new JsonResult<>(false, "用户名不存在或被冻结");
            }

        } else {
            return new JsonResult<>(false, "用户名不存在或被冻结");
        }

        User userData = userService.getByEmail(email);
        String redisEmail = PeRedisClient.getCommonJedis().get(RedisKey.UC_BIND_Email + user.getId() + email);
        if (userData == null || User.UserStatus.DELETED.equals(userData.getStatus())) {
            if (StringUtils.equals(email, redisEmail)) {
                user.setEmail(email);
                user.setEmailVerify(true);
                ExecutionContext.setUserId(user.getId());
                userService.update(user, User._email, User._emailVerify);
                userRedisService.updateEmail(user.getId(), user.getEmail());
                return new JsonResult<>(true, JsonResult.SUCCESS);
            } else {
                return new JsonResult<>(false, "验证失败");
            }
        }

        return new JsonResult<>(false, "该邮箱已被注册");
    }

    @RequestMapping("login/bindEmail")
    public String bindEmail(String email, Model model) {
        if (StringUtils.isBlank(email)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }
        model.addAttribute("email", email);
        return "uc/login/bindEmail";
    }

    @RequestMapping("login/activeFirstEmail")
    public String activeFirstEmail(String email, Model model) {
        if (StringUtils.isBlank(email)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        User user = userService.getByEmail(email);
        if (user != null && User.UserStatus.ENABLE.equals(user.getStatus())) {
            user.setEmailVerify(true);
            user.setUpdateBy(user.getId());
            userService.update(user, User._emailVerify);
        }

        return "uc/login/bindEmail";
    }

    /**
     * 邮箱激活成功
     */
    @RequestMapping("login/activateSuccessful")
    public String activateSuccessful(String email, Model model) {
        if (StringUtils.isBlank(email)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        model.addAttribute("email", email);
        return "uc/login/bindEmailSuccessful";
    }

    /**
     * 忘记密码---初始化页面
     */
    @RequestMapping("login/forgetPwdPage")
    public String forgetPwdPage() {
        return "uc/login/findPassword";
    }

    /**
     * 忘记密码---验证身份页面
     */
    @RequestMapping("login/initMustPage")
    public String initMustPage(String account, Model model, HttpServletRequest request) {
        if (StringUtils.isBlank(account)) {
            return "redirect:/login/loginPage";
        }

        User user = userService.getByAccount(account);
        String mobile = user.getMobile();
        String email = user.getEmail();
        model.addAttribute("mobile", mobile);
        model.addAttribute("email", email);
        model.addAttribute("userId", user.getId());
        return "uc/login/verifyIdentityWay";
    }

    /**
     * 忘记密码---重置密码
     */
    @RequestMapping("login/resetPwdPage")
    public String resetPwdPage(String userId, Model model) {
        if (StringUtils.isBlank(userId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        model.addAttribute("userId", userId);
        return "uc/login/resetPassword";
    }

    /**
     * 忘记密码---完成页面
     */
    @RequestMapping("login/passwordSetSuccess")
    public String passwordSetSuccess() {
        return "uc/login/passwordSetSuccessful";
    }

    /**
     * 忘记密码:填写账号---生成的图形校验码
     */
    @RequestMapping("login/createVerifyCode")
    public void createVerifyCode(HttpServletResponse response, HttpServletRequest request) {
        String verifyCode = VerifyCodeUtils.randomCode(4);
        String expiredTime = PropertiesUtils.getConfigProp().getProperty("verifyCode.time");
        HttpSession session = request.getSession();
        PeRedisClient.getCommonJedis().setex(RedisKey.UC_LOGIN_FORGET_VERIFY_CODE
                + session.getId(), PeNumberUtils.transformInt(expiredTime), verifyCode);
        VerifyCodeUtils.generateCode(60, 24, verifyCode, response);
    }

    /**
     * 忘记密码:填写账号---校验账号
     */
    @ResponseBody
    @RequestMapping("login/checkAccount")
    public JsonResult checkAccount(String account, String verifyCode, HttpServletRequest request) {
        User user = userService.getByAccount(account);
        if (user == null) {
            return new JsonResult(false, i18nService.getI18nValue("account.not.exist"));
        }

        return checkVerifyCode(verifyCode, request);
    }

    /**
     * 忘记密码:填写账号---校验验证码
     */
    private JsonResult checkVerifyCode(String verifyCode, HttpServletRequest request) {
        if (StringUtils.isBlank(verifyCode)) {
            return new JsonResult(false, i18nService.getI18nValue("error.params"));
        }

        HttpSession session = request.getSession();
        String redisVerifyCode = PeRedisClient.getCommonJedis().get(RedisKey.UC_LOGIN_FORGET_VERIFY_CODE + session.getId());
        if (!StringUtils.equalsIgnoreCase(verifyCode, redisVerifyCode)) {
            return new JsonResult(false, i18nService.getI18nValue("error.verifyCode.input"));
        }

        return new JsonResult(true, JsonResult.SUCCESS);
    }


    @RequestMapping("login/toPhoneCode")
    public String toPhoneCode(Model model, User user) {
        //页面上对“手机、邮箱”都未绑定时做处理
        model.addAttribute(user);
        return "";
    }

    /**
     * 忘记密码:验证身份---生成手机或邮箱验证码
     */
    @ResponseBody
    @RequestMapping("login/createIdentityCode")
    public JsonResult<User> createIdentityCode(User user, HttpServletRequest request) {
        if (user == null || (StringUtils.isBlank(user.getMobile()) && StringUtils.isBlank(user.getEmail()))) {
            throw new IllegalArgumentException("Checking info is illegal!");
        }

        String phoneEmail;
        String expiredTime;
        String verifyCode = VerifyCodeUtils.randomCode(4);
        if (StringUtils.isNotBlank(user.getEmail())) {
            phoneEmail = user.getEmail();
            expiredTime = PropertiesUtils.getConfigProp().getProperty("verifyCode.time.email");
        } else {
            phoneEmail = user.getMobile();
            if (StringUtils.isBlank(user.getVerifyCode())) {
                return new JsonResult<>(false, "请输入图形验证码");
            }

            String redisCodeKey = RedisKey.UC_LOGIN_FORGET_VERIFY_CODE + request.getSession().getId();
            String redisVal = PeRedisClient.getCommonJedis().get(redisCodeKey);
            if (StringUtils.isBlank(redisVal) || !redisVal.equalsIgnoreCase(user.getVerifyCode())) {
                return new JsonResult<>(false, "图形验证码不正确");
            }

            PeRedisClient.getCommonJedis().del(redisCodeKey);
            expiredTime = PropertiesUtils.getConfigProp().getProperty("verifyCode.time");
        }

        PeRedisClient.getCommonJedis().setex(RedisKey.UC_LOGIN_FORGET_VERIFY_CODE
                + phoneEmail, PeNumberUtils.transformInt(expiredTime), verifyCode);
        User dataUser = userService.getByAccount(phoneEmail);
        sendVerifyCode(user, dataUser.getUserName(), verifyCode);
        return new JsonResult<>(true, JsonResult.SUCCESS);
    }

    /**
     * 发送邮件或者短信
     */
    private void sendVerifyCode(User user, String useName, String verifyCode) {
        Map<String, Object> paramData = new HashMap<>(2);
        paramData.put("CONFIRM_CODE", verifyCode);
        paramData.put("ACCOUNT_NAME", useName);
        String templateName = ImTemplate.REGISTER_CONFIRM_CODE;
        if (StringUtils.isNotBlank(user.getMobile())) {
            MsgSendService.sendSmsMsg(templateName, Collections.singletonList(user.getMobile()), paramData, true);
        } else {
            MsgSendService.sendEmailMsg(templateName, i18nService.getI18nValue("login.reset.password")
                    , Collections.singletonList(new ImReceiver(null, user.getEmail(), user.getUserName())), paramData, true);
        }
    }

    /**
     * 忘记密码:验证身份---校验手机或邮箱验证码
     */
    @ResponseBody
    @RequestMapping("login/checkIdentityCode")
    public JsonResult checkIdentityCode(User user) {
        if (user == null || (StringUtils.isBlank(user.getMobile())
                && StringUtils.isBlank(user.getEmail())) || StringUtils.isBlank(user.getVerifyCode())) {
            throw new IllegalArgumentException("Checking info is illegal!");
        }

        String phoneEmail;
        if (StringUtils.isBlank(user.getEmail())) {
            phoneEmail = user.getMobile();
        } else {
            phoneEmail = user.getEmail();
        }

        String redisVerifyCode = PeRedisClient.getCommonJedis().get(RedisKey.UC_LOGIN_FORGET_VERIFY_CODE + phoneEmail);
        if (!StringUtils.equalsIgnoreCase(user.getVerifyCode(), redisVerifyCode)) {
            return new JsonResult(false, i18nService.getI18nValue("error.verifyCode.input"));
        }

        return new JsonResult(true, JsonResult.SUCCESS);
    }

    /**
     * 忘记密码---重置密码
     */
    @ResponseBody
    @RequestMapping("login/updatePwd")
    public JsonResult updatePwd(User user) {
        if (user == null || StringUtils.isBlank(user.getId())
                || StringUtils.isBlank(user.getNewPassword())) {
            throw new IllegalArgumentException("User parameter is illegal!");
        }

        String userId = user.getId();
        ExecutionContext.setUserId(userId);
        User redisUser = userRedisService.get(userId, User._password);
        if (redisUser == null) {
            throw new IllegalArgumentException("User is not exist!");
        }

        String newPwd = user.getNewPassword();
        newPwd = MD5Generator.getHexMD5(newPwd);
        if (StringUtils.isBlank(newPwd)) {
            throw new IllegalArgumentException("User parameter is illegal!");
        }

        if (newPwd.equals(redisUser.getPassword())) {
            return new JsonResult(false, i18nService.getI18nValue("newPwd.equals.oldPwd"));
        }

        userRedisService.updatePwd(userId, newPwd);
        userService.update(userId, User._password, newPwd);

        return new JsonResult(true, i18nService.getI18nValue("update.success"));
    }

    @RequestMapping("client/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //删除cookie中的元素
        CookieUtil.deleteCookie(response, CookieUtil.getCookie(request, CookieKey.UC_LOGIN_SESSION_ID), "/");
        String loginKey = RedisKey.UC_ALREADY_LOGIN + PeConstant.REDIS_DIVISION + ExecutionContext.getCorpCode()
                + PeConstant.REDIS_DIVISION + ExecutionContext.getUserId();
        PeJedisCommands sessionJedis = PeRedisClient.getSessionJedis();
        String sessionId = sessionJedis.get(loginKey);
        sessionJedis.del(loginKey);
        if (StringUtils.isBlank(sessionId)) {
            return "redirect:/login/loginPage";
        }

        String sessionKey = RedisKey.UC_LOGIN_SESSION + PeConstant.REDIS_DIVISION + sessionId;
        sessionJedis.del(sessionKey);
        return "redirect:/login/loginPage";
    }

    @ResponseBody
    @RequestMapping("client/removeLoginCookie")
    public JsonResult<String> removeLoginCookie(HttpServletRequest request, HttpServletResponse response) {
        //删除cookie中的元素
        CookieUtil.deleteCookie(response, CookieUtil.getCookie(request, CookieKey.UC_LOGIN_SESSION_ID), "/");
        String loginKey = RedisKey.UC_ALREADY_LOGIN + PeConstant.REDIS_DIVISION + ExecutionContext.getCorpCode()
                + PeConstant.REDIS_DIVISION + ExecutionContext.getUserId();
        PeJedisCommands sessionJedis = PeRedisClient.getSessionJedis();
        String sessionId = sessionJedis.get(loginKey);
        sessionJedis.del(loginKey);
        if (StringUtils.isNotBlank(sessionId)) {
            String sessionKey = RedisKey.UC_LOGIN_SESSION + PeConstant.REDIS_DIVISION + sessionId;
            sessionJedis.del(sessionKey);
        }

        return new JsonResult<>(true, JsonResult.SUCCESS);
    }

    @RequestMapping("login/initBrowseLower")
    public String initBrowseLower() {
        return "uc/login/browerLowerInfo";
    }

    @RequestMapping("website/loadEln")
    public String loadEln(String secretePassWord, Model model, HttpServletRequest request, HttpServletResponse response) {
        if (StringUtils.isBlank(secretePassWord)) {
            throw new IllegalArgumentException("userId is null!");
        }

        PeJedisCommands commonJedis = PeRedisClient.getCommonJedis();
        String userValue = commonJedis.get(secretePassWord);
        if (StringUtils.isBlank(userValue)) {
            //// TODO: 2017/12/5 跳转到缺省页面
        }

        String[] userMessage = userValue.split(PeConstant.REDIS_DIVISION);
        String corpCode = userMessage[0];
        String userId = userMessage[1];
        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.eq(User._corpCode, corpCode));
        conjunction.add(Restrictions.eq(User._id, userId));
        User user = userService.getByCriterion(conjunction);
        ExecutionContext.setCorpCode(corpCode);
        ExecutionContext.setUserId(userId);
        storeSession(request, response, user);
        model.addAttribute("userName", user.getUserName());
        boolean isAdmin = userRoleService.checkSystemRole(userId);
        model.addAttribute("admin", isAdmin);
        return "myExamNav";
    }
}
