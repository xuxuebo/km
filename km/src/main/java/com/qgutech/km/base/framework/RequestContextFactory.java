package com.qgutech.km.base.framework;

import com.qgutech.km.utils.CookieUtil;
import com.qgutech.km.utils.UUIDGenerator;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class RequestContextFactory {
    private static final String CLIENT_TOKEN = "clientToken";

    public static RequestContext toRequestContext(HttpServletRequest request,
                                                  HttpServletResponse response) throws IOException {
        RequestContext result = new RequestContext();

        String contextPath = request.getContextPath();

        if (contextPath == null) {
            return result;
        }
        result.setContextPath(contextPath);
        String requestURI = request.getRequestURI();
        String header = request.getHeader("User-Agent");
        String remoteAddr = getRealRemoteAddress(request);
        String clientCookie = getClientCookie(request, response);
        String referer = request.getHeader("Referer");
        result.setIp(remoteAddr);
        result.setClient(clientCookie);
        result.setUserAgent(header);
        result.setReferer(referer);
        return toRequestContext(result, contextPath, requestURI);

    }

    private static RequestContext toRequestContext(RequestContext result,
                                                   String contextPath, String requestURI) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date timestamp = new Date();
        result.setTimestamp(timestamp);
        result.setDate(simpleDateFormat.format(timestamp));

        String channel = null;
        String partAfterContextPath = requestURI.substring(contextPath.length());
        if (partAfterContextPath.length() > 1) {
            int pos = partAfterContextPath.indexOf('/', 1);
            if (pos != -1) {
                channel = partAfterContextPath.substring(1, pos);
            }
        }

        if (channel == null) {
            return result;
        }

        result.setChannel(channel);
        String partAfterController = partAfterContextPath.substring(channel.length() + 1);
        String action = null;
        if (partAfterController.length() > 1) {
            int pos = partAfterController.indexOf('?', 1);
            if (pos != -1) {
                action = partAfterController.substring(1, pos);
            } else {
                action = partAfterController.substring(1);
            }
        } else {
            action = "showDiscoverCourse"; // TODO change this
        }

        int posOfDot = action.indexOf('.');
        if (posOfDot == -1) {
            result.setAction(action);
        } else {
            result.setAction(action.substring(0, posOfDot));
            result.setFormat(action.substring(posOfDot + 1));
        }

        return result;
    }

    private static String getRealRemoteAddress(HttpServletRequest request) {
        String remoteAddr = request.getRemoteAddr();
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        return getRealRemoteAddress(remoteAddr, xForwardedFor);
    }

    private static String getRealRemoteAddress(ServerHttpRequest request) {
        String remoteAddr = request.getRemoteAddress().getHostName();
        String xForwardedFor = getHeader(request, "X-Forwarded-For");
        return getRealRemoteAddress(remoteAddr, xForwardedFor);
    }

    private static String getRealRemoteAddress(String remoteAddr,
                                               String xForwardedFor) {
        if (StringUtils.isEmpty(remoteAddr) || remoteAddr.startsWith("127.")
                || remoteAddr.startsWith("10.")) {
            // Assume as the remote Addr is not valid, try to use XFF
            // (X-Forwarded-For)
            if (StringUtils.isNotEmpty(xForwardedFor)) {
                int pos = xForwardedFor.indexOf(',');
                if (pos == -1) {
                    remoteAddr = xForwardedFor.trim();
                } else {
                    remoteAddr = xForwardedFor.substring(0, pos).trim();
                }
            }
        }

        return remoteAddr;
    }

    static String getClientCookie(HttpServletRequest request,
                                  HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();

        String requestToken = null;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                String name = cookie.getName();
                name = CookieUtil.matcher(name);
                if (name.equals(CLIENT_TOKEN)) {
                    requestToken = cookie.getValue();
                    requestToken = CookieUtil.matcher(requestToken);
                    break;
                }
            }
        }

        if (StringUtils.isEmpty(requestToken)) {
            requestToken = generateRequestToken();
        }

        Cookie cookie = newClientCookie(requestToken);
        cookie.setMaxAge(86400 * 365); // 1 year
        response.addCookie(cookie);

        return requestToken;
    }

    static String getClientCookie(ServerHttpRequest request,
                                  ServerHttpResponse response) {
        Map<String, String> cookieMap = CookieUtil.toCookieMap(getHeader(
                request, "Cookie"));

        return cookieMap.get(CLIENT_TOKEN);
    }

    private static Cookie newClientCookie(String requestToken) {
        Cookie cookie = new Cookie(CookieUtil.matcher(CLIENT_TOKEN), requestToken);
        cookie.setPath("/km");
        return cookie;
    }

    private static String generateRequestToken() {
        return UUIDGenerator.uuid();
    }

    public static RequestContext toRequestContext(ServerHttpRequest request,
                                                  ServerHttpResponse response) {

        RequestContext result = new RequestContext();

        String requestURI = request.getURI().getRawPath();
        String contextPath = getContextPath(requestURI);

        if (contextPath == null) {
            return result;
        }
        result.setContextPath(contextPath);

        String userAgent = getHeader(request, "User-Agent");
        String remoteAddr = getRealRemoteAddress(request);
        String clientCookie = getClientCookie(request, response);
        String referer = getHeader(request, "Referer");

        result.setIp(remoteAddr);
        result.setClient(clientCookie);
        result.setUserAgent(userAgent);
        result.setReferer(referer);

        return toRequestContext(result, contextPath, requestURI);
    }

    private static String getContextPath(String requestURI) {
        if (requestURI.length() < 2) {
            return null;
        }

        int pos = requestURI.indexOf("/", 1);
        if (pos == -1) {
            return requestURI;
        }

        return requestURI.substring(0, pos);
    }

    private static String getHeader(ServerHttpRequest request, String header) {
        List<String> list = request.getHeaders().get(header);
        if (list == null || list.isEmpty()) {
            return null;
        }

        return list.get(0);
    }
}