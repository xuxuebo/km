package com.qgutech.km.module.mobile.uc;

import com.qgutech.km.module.uc.service.LoginService;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.controller.BaseController;
import com.qgutech.km.base.model.CorpInfo;
import com.qgutech.km.base.redis.PeJedisCommands;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.base.service.CorpService;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.CookieKey;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.constant.RedisKey;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.module.uc.service.UserService;
import com.qgutech.km.utils.CookieUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller("mobileLoginController")
@RequestMapping("mobile/login")
public class LoginController extends BaseController {

    @Resource
    private LoginService loginService;
    @Resource
    private CorpService corpService;

    @Resource
    private UserService userService;
    @ResponseBody
    @RequestMapping("refreshSession")
    public JsonResult<User> refreshSession(String sessionId) {
        if (StringUtils.isBlank(ExecutionContext.getCorpCode())) {
            return new JsonResult<>(false, "企业ID为空");
        }

        JsonResult<User> jsonResult = new JsonResult<>();
        jsonResult.setSuccess(false);
        CorpInfo corpInfo = corpService.getByCode(ExecutionContext.getCorpCode());
        if (corpInfo == null) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("公司不存在");
            PeJedisCommands sessionJedis = PeRedisClient.getSessionJedis();
            String sessionKey = RedisKey.UC_LOGIN_SESSION + PeConstant.REDIS_DIVISION + sessionId;
            String sessionString = sessionJedis.get(sessionKey);
            if (StringUtils.isEmpty(sessionString)) {
                return jsonResult;
            }
            sessionJedis.del(sessionKey);
            return jsonResult;
        }
        jsonResult.setSuccess(true);
        return jsonResult;
    }
    @ResponseBody
    @RequestMapping("ajaxLogin")
    public JsonResult<User> login(@ModelAttribute User loginUser, HttpServletResponse response, HttpServletRequest request) {
        if (StringUtils.isBlank(loginUser.getCorpCode())) {
            return new JsonResult<>(false, "企业ID为空");
        }

        JsonResult<User> jsonResult = new JsonResult<>();
        CorpInfo corpInfo = corpService.getByCode(loginUser.getCorpCode());
        if (corpInfo == null) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("公司不存在");
            return jsonResult;
        }

        ExecutionContext.setCorpCode(loginUser.getCorpCode());
        jsonResult = checkCorp(corpInfo);
        if (!jsonResult.isSuccess()) {
            return jsonResult;
        }

        jsonResult = loginService.login(loginUser);
        if (!jsonResult.isSuccess()) {
            return jsonResult;
        }

        User user = jsonResult.getData();
        String sessionId = storeSession(request, response, user);
        user.setSessionId(sessionId);
        jsonResult.setSuccess(true);
        if (!loginUser.isRememberPwd()) {
            return jsonResult;
        }

        //记住密码
        storeLoginInfo(loginUser, response);
        return jsonResult;
    }

    @ResponseBody
    @RequestMapping("logout")
    public JsonResult<User> logout(HttpServletResponse response, HttpServletRequest request) {
        //删除cookie中的元素
        CookieUtil.deleteCookie(response, CookieUtil.getCookie(request, CookieKey.UC_LOGIN_SESSION_ID), "/");
        String loginKey = RedisKey.UC_ALREADY_LOGIN + PeConstant.REDIS_DIVISION +
                ExecutionContext.getCorpCode() + PeConstant.REDIS_DIVISION + ExecutionContext.getUserId();
        PeJedisCommands sessionJedis = PeRedisClient.getSessionJedis();
        String sessionId = sessionJedis.get(loginKey);
        sessionJedis.del(loginKey);
        if (StringUtils.isBlank(sessionId)) {
            return new JsonResult<>(true, JsonResult.SUCCESS);
        }

        String sessionKey = RedisKey.UC_LOGIN_SESSION + PeConstant.REDIS_DIVISION + sessionId;
        sessionJedis.del(sessionKey);
        return new JsonResult<>(true, JsonResult.SUCCESS);
    }


}
