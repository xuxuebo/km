package com.qgutech.km.base.interceptor;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.framework.RequestContext;
import com.qgutech.km.base.framework.RequestContextFactory;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.base.service.CorpService;
import com.qgutech.km.base.service.SessionService;
import com.qgutech.km.constant.CookieKey;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.uc.model.SessionContext;
import com.qgutech.km.utils.CookieUtil;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.PeUri;
import com.qgutech.km.utils.PropertiesUtils;
import com.qgutech.km.base.model.CorpInfo;
import com.qgutech.km.constant.RedisKey;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;


public class LoginInterceptor implements HandlerInterceptor {

    @Resource
    private SessionService sessionService;
    @Resource
    private CorpService corpService;

    private final Log LOG = LogFactory.getLog(LoginInterceptor.class);
    private static final String MOBILE_CHANNEL = "mobile";
    private static final String LOGIN_CHANNEL = "login";
    private static final String CORP_CHANNEL = "corp";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        RequestContext requestContext = RequestContextFactory.toRequestContext(request, response);
        RequestContext.set(requestContext);
        Map<String, String> contextMap = new HashMap<>();
        ExecutionContext.setContextMap(contextMap);
        String serverName = request.getServerName();
        ExecutionContext.setServerName(serverName);
        ExecutionContext.setContextPath(request.getContextPath());
        String channel = requestContext.getChannel();
        if (MOBILE_CHANNEL.equals(channel)) {
            return getSessionContext(request, response, channel);
        }

        if (isStaticResource(requestContext)) {
            return true;
        }

        if (LOGIN_CHANNEL.equals(channel)) {
            CorpInfo corpInfo = corpService.getByDomain(serverName);
            if (corpInfo == null) {
                return false;
            }

            ExecutionContext.setCorpCode(corpInfo.getCorpCode());
        }

        return getSessionContext(request, response, channel);
    }

    private boolean isStaticResource(RequestContext requestContext) {

        return "web-static".equals(requestContext.getChannel()) || "css".equals(requestContext.getChannel())
                || "images".equals(requestContext.getChannel()) || "js".equals(requestContext.getChannel())
                || "file".equals(requestContext.getChannel());
    }

    /**
     * 登录拦截
     */
    private boolean getSessionContext(HttpServletRequest request, HttpServletResponse response, String channel) throws IOException {
        if (PeUri.isSessionNotRequired(RequestContext.get())) {
            return true;
        }

        String sessionId = request.getParameter("sessionId");
        Cookie cookie = CookieUtil.getCookie(request, CookieKey.UC_LOGIN_SESSION_ID);
        if (StringUtils.isBlank(sessionId) && (cookie == null || StringUtils.isBlank(cookie.getValue()))) {
            processLoginPage(request, response, channel,null);
            return false;
        }

        try {

            if (StringUtils.isBlank(sessionId) && null != cookie) {
                sessionId = cookie.getValue();
            }

            if (MOBILE_CHANNEL.equals(channel)) {
                //todo 手机端登录需要的参数以及参数设置
                if (StringUtils.isNotBlank(sessionId)) {
                    CookieUtil.setCookie(response, CookieKey.UC_LOGIN_SESSION_ID, sessionId);
                }

                String mobileType = request.getParameter("mobileType");
                if (StringUtils.isNotBlank(mobileType)) {
                    CookieUtil.setCookie(response, CookieKey.MOBILE_TYPE, mobileType);
                }
            }

            SessionContext sessionContext = sessionService.loadBySessionId(sessionId);
            SessionContext.set(sessionContext);
            ExecutionContext.setUserId(sessionContext.getUserId());
            ExecutionContext.setCorpCode(sessionContext.getCorpCode());
            if (RequestContext.get().getAction().contains(PeConstant.MANAGE_ACTION)
                    && (!SessionContext.get().isAdmin() || CollectionUtils.isEmpty(SessionContext.get().getAuthCodes()))) {
                return false;
            }

            if (CORP_CHANNEL.equals(channel) && (!PeConstant.DEFAULT_CORP_CODE.equals(ExecutionContext.getCorpCode())
                    || !SessionContext.get().isSystemAdmin())) {
                return false;
            }

        } catch (PeException e) {
            processLoginPage(request, response, channel, null);
            return false;
        }

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object o, ModelAndView modelAndView) throws Exception {
        RequestContext requestContext = RequestContextFactory.toRequestContext(request, response);
        String channel = requestContext.getChannel();
        if (MOBILE_CHANNEL.equals(channel) || modelAndView == null) {
            return;
        }

        if (isStaticResource(requestContext)) {
            return;
        }

        String corpCode = ExecutionContext.getCorpCode();
        if(StringUtils.isEmpty(corpCode)){
            redirect(request, response);
        }
        modelAndView.addObject("corpCode", ExecutionContext.getCorpCode());
        String titleName = PropertiesUtils.getConfigProp().getProperty("title.name." + corpCode);
        modelAndView.addObject("titleName", titleName);
        String icoUrl = PropertiesUtils.getConfigProp().getProperty("title.ico.url." + corpCode);
        modelAndView.addObject("icoUrl", icoUrl);
        String footExplain = PropertiesUtils.getConfigProp().getProperty("footer.explain." + corpCode);
        modelAndView.addObject("footExplain", footExplain);
        String logoUrl = PropertiesUtils.getConfigProp().getProperty("common.logo.url." + corpCode);
        modelAndView.addObject("logoUrl", logoUrl);
        String loginLogoUrl = PropertiesUtils.getConfigProp().getProperty("login.logo.url." + corpCode);
        modelAndView.addObject("loginLogoUrl", loginLogoUrl);
        String resourceVersion = PeRedisClient.getCommonJedis().get(RedisKey.STATIC_RESOURCE_VERSION);
        if (StringUtils.isBlank(resourceVersion)) {
            resourceVersion = PropertiesUtils.getConfigProp().getProperty("static.resource.version");
        }

        modelAndView.addObject("resourceVersion", resourceVersion);
        if (PropertiesUtils.getConfigProp().getProperty("https.open.corpCode").contains(corpCode)) {
            modelAndView.addObject("resourcePath", PropertiesUtils.getEnvProp().getProperty("static.resource.path.https"));
        }

    }

    private void processLoginPage(HttpServletRequest request, HttpServletResponse response, String channel, String mobileType) throws IOException {
        String requestType = request.getHeader("X-Requested-With");
        if ((requestType != null && "XMLHttpRequest".equalsIgnoreCase(requestType)) || MOBILE_CHANNEL.equals(channel)) {
            if (StringUtils.isNotBlank(mobileType)) {
                response.setContentType("application/json;charset=utf-8");
                response.getWriter().write("SESSION_LOSE_EFFICACY");
            }

            response.setStatus(403);
            response.setHeader("ajaxRequest", "loginFailed");
        } else {
            redirect(request, response);
        }

    }

    /**
     * 重定向
     *
     * @param request  request
     * @param response response
     * @throws IOException IOException
     */
    private void redirect(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //cookie为空直接跳转到login
        String sourceUrl = request.getRequestURL().toString();
        if (request.getQueryString() != null) {
            sourceUrl += "?" + request.getQueryString();
        }

        response.sendRedirect(request.getContextPath() + "/login/loginPage#url=" + URLEncoder.encode(sourceUrl, "UTF-8"));
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
