package com.qgutech.km.base;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.tbc.framework.util.Signer;
import com.tbc.paas.common.constants.ELNConfigure;
import com.tbc.paas.common.utils.CookieUtil;
import com.qgutech.km.utils.HttpUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoader;
import redis.clients.jedis.JedisCommands;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;

/**
 * 电科院单点登录相关业务处理filter
 */
public class SLoginFilter implements Filter {
    private JedisCommands jedisSession;
    private JedisCommands jedis;
    public static String ssoCorpCode = "ladeng.com";
    public static String actionName = "sso";
    public static String secret = "123456";
    public static String userInfoUrl = "http://47.96.39.117/api/users/userInfo";
    public static String loginUrl = "http://userauth.js.sgcc.com.cn:6001/UALogin/login";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        ApplicationContext applicationContext = ContextLoader.getCurrentWebApplicationContext();
        jedisSession = applicationContext.getBean("jedisSession", JedisCommands.class);
        jedis = applicationContext.getBean("jedis", JedisCommands.class);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (!(request instanceof HttpServletRequest)) {
            chain.doFilter(request, response);
            return;
        }

        HttpServletRequest hRequest = (HttpServletRequest) request;
        HttpServletResponse hResponse = (HttpServletResponse) response;
        String requestURI = hRequest.getRequestURI();
        if (requestURI.contains("/listCourseInfo/listCourseInfo")) {
            chain.doFilter(request, response);
            return;
        }

        String token = ((HttpServletRequest) request).getHeader("Authorization");
        token = token == null ? request.getParameter("token") : token;
        if (token == null) {
            Cookie cookie = CookieUtil.getCookie(hRequest, ELNConfigure.ELN_SESSION_ID);
            if (cookie != null && StringUtils.isNotEmpty(cookie.getValue())) {
                String elnSessionId = cookie.getValue();
                String corpCode = jedisSession.hmget(elnSessionId, ELNConfigure.CORP_CODE).get(0);
                String userId = jedisSession.hmget(elnSessionId, ELNConfigure.USER_ID).get(0);
                if (StringUtils.isNotEmpty(corpCode) && StringUtils.isNotEmpty(userId)) {
                    chain.doFilter(request, response);
                    return;
                }
            }
        }

        String corpCode = jedis.get("sso_info_corpCode");
        String cuSecret = jedis.get("sso_info_secret");
        String infoUrl = jedis.get("sso_info_infoUrl");
        String cuLoginUrl = jedis.get("sso_info_loginUrl");
        if (StringUtils.isNotBlank(corpCode) && StringUtils.isNotBlank(cuSecret)
                && StringUtils.isNotBlank(infoUrl)
                && StringUtils.isNotBlank(cuLoginUrl)) {
            ssoCorpCode = corpCode;
            secret = cuSecret;
            userInfoUrl = infoUrl;
            loginUrl = cuLoginUrl;
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
            return;
        }

        String username;
        try {
            String jsonStr = HttpUtils.doGet(userInfoUrl, token);
            JSONObject jsonObject = JSON.parseObject(jsonStr);
            username = jsonObject.getString("username");
            if (StringUtils.isBlank(username)) {
                throw new IllegalArgumentException("username is blank");
            }
        } catch (IllegalArgumentException e) {
            System.out.println("获取 user info 失败,token=[" + token + "]");
            hResponse.sendRedirect(loginUrl + "?returnUrl=" + URLEncoder.encode(returnUrl, "UTF-8"));
            return;
        }

        String url = ssoLogin(hRequest, username, ssoCorpCode, URLEncoder.encode(returnUrl, "UTF-8"));
        hResponse.sendRedirect(url);
    }

    private String ssoLogin(HttpServletRequest request, String userName, String corpCode, String returnUrl) {
        Long time = System.currentTimeMillis();
        //直接后台oms设置
        String signingText = Signer.calculateSign(actionName, secret, corpCode, userName.trim(), time);
        String sso = "/login/sso.init.do?userName="
                + userName + "&corpCode=" + corpCode + "&sign=" + signingText
                + "&timestamp=" + time + "&returnUrl=";
        String requestURI = request.getRequestURI();
        String requestURL = request.getRequestURL().toString();
        requestURL = requestURL.replace(requestURI, "");
        return requestURL + sso + returnUrl;
    }

    @Override
    public void destroy() {

    }
}
