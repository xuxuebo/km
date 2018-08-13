package com.qgutech.km.base.interceptor;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.framework.RequestContext;
import com.qgutech.km.base.framework.RequestContextFactory;
import com.qgutech.km.base.model.CorpInfo;
import com.qgutech.km.base.service.CorpService;
import com.qgutech.km.base.service.SessionService;
import com.qgutech.km.constant.CookieKey;
import com.qgutech.km.module.uc.model.SessionContext;
import com.qgutech.km.utils.CookieUtil;
import com.qgutech.km.utils.HttpUtils;
import com.qgutech.km.utils.PropertiesUtils;
import com.tbc.framework.util.Signer;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * 电科院单点登录相关业务处理filter
 */
public class AuthenticateInterceptor implements HandlerInterceptor {

    public static String ssoCorpCode = "default";
    public static String actionName = "sso";
    public static String secret = "zhy123";
    public static String userInfoUrl = "http://172.17.50.134/api/users/userInfo";
    public static String loginUrl = "http://172.17.50.134/sso/login";

    @Resource
    private SessionService sessionService;
    @Resource
    private CorpService corpService;

    @Override
    public boolean preHandle(HttpServletRequest hRequest, HttpServletResponse hResponse, Object o) throws Exception {
        String token = hRequest.getHeader("Authorization");
        token = token == null ? hRequest.getParameter("token") : token;
        if (token == null) {
            String sessionId = hRequest.getParameter("sessionId");
            Cookie cookie = CookieUtil.getCookie(hRequest, CookieKey.UC_LOGIN_SESSION_ID);
            if (StringUtils.isBlank(sessionId) && cookie != null) {
                sessionId = cookie.getValue();
            }

            if (StringUtils.isNotBlank(sessionId)) {
                SessionContext sessionContext = sessionService.loadBySessionId(sessionId);
                SessionContext.set(sessionContext);
                String userId = sessionContext.getUserId();
                ExecutionContext.setUserId(userId);
                String corpCode = sessionContext.getCorpCode();
                ExecutionContext.setCorpCode(corpCode);
                if (StringUtils.isNotEmpty(userId) && StringUtils.isNotEmpty(corpCode)) {
                    return true;
                }
            }
        }

        RequestContext requestContext = RequestContextFactory.toRequestContext(hRequest, hResponse);
        RequestContext.set(requestContext);
        Map<String, String> contextMap = new HashMap<>();
        ExecutionContext.setContextMap(contextMap);
        String serverName = hRequest.getServerName();
        ExecutionContext.setServerName(serverName);
        ExecutionContext.setContextPath(hRequest.getContextPath());
        String channel = requestContext.getChannel();
        if (LoginInterceptor.LOGIN_CHANNEL.equals(channel)) {
            CorpInfo corpInfo = corpService.getByDomain(serverName);
            if (corpInfo == null) {
                return false;
            }

            ExecutionContext.setCorpCode(corpInfo.getCorpCode());
        }

        if (LoginInterceptor.isStaticResource(requestContext)) {
            return true;
        }

        Properties properties = PropertiesUtils.getConfigProp();
        String corpCode = properties.getProperty("sso_info_corpCode");
        String cuSecret = properties.getProperty("sso_info_secret");
        String infoUrl = properties.getProperty("sso_info_infoUrl");
        String cuLoginUrl = properties.getProperty("sso_info_loginUrl");
        String action = properties.getProperty("sso_info_actionName");
        if (StringUtils.isNotBlank(corpCode) && StringUtils.isNotBlank(cuSecret)
                && StringUtils.isNotBlank(infoUrl)
                && StringUtils.isNotBlank(cuLoginUrl)) {
            ssoCorpCode = corpCode;
            secret = cuSecret;
            userInfoUrl = infoUrl;
            loginUrl = cuLoginUrl;
            actionName = action;
        }

        String isChain = hRequest.getQueryString() == null ? "" : hRequest.getQueryString();
        if (isChain.contains("token")) {
            isChain = isChain.substring(0, isChain.indexOf("token"));
        }

        isChain = StringUtils.isNotBlank(isChain) ? "?" + isChain : isChain;
        String returnUrl = hRequest.getRequestURL().toString().concat(isChain);
        if (token == null) {
            //跳转登录页面,回调returnUrl时需要拼接上 token
            hResponse.sendRedirect(loginUrl + "?returnUrl=" + URLEncoder.encode(returnUrl, "UTF-8"));
            return false;
        }

        String username;
        try {
            String jsonStr = HttpUtils.doGet(userInfoUrl, token);
            JSONObject jsonObject = JSON.parseObject(jsonStr);
            username = jsonObject.getString("id");
            if (StringUtils.isBlank(username)) {
                throw new IllegalArgumentException("username is blank");
            }
        } catch (IllegalArgumentException e) {
            System.out.println("获取 user info 失败,token=[" + token + "]");
            hResponse.sendRedirect(loginUrl + "?returnUrl=" + URLEncoder.encode(returnUrl, "UTF-8"));
            e.printStackTrace();
            return false;
        }

        System.out.println("--------userName-----------" + username);
        String url = ssoLogin(hRequest, username, ssoCorpCode, URLEncoder.encode(returnUrl, "UTF-8"));
        System.out.println("--------SSO-URL-----------" + url);
        hResponse.sendRedirect(url);
        return false;
    }

    private String ssoLogin(HttpServletRequest request, String userName, String corpCode, String returnUrl) {
        Long time = System.currentTimeMillis();
        String signingText = Signer.calculateSign(actionName, secret, corpCode, userName.trim(), time);
        String sso = request.getContextPath() + "/login/ssoLogin?userName="
                + userName + "&corpCode=" + corpCode + "&sign=" + signingText
                + "&timestamp=" + time + "&returnUrl=";
        String requestURI = request.getRequestURI();
        String requestURL = request.getRequestURL().toString();
        requestURL = requestURL.replace(requestURI, "");
        return requestURL + sso + returnUrl;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
