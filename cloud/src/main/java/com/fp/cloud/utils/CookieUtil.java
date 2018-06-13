package com.fp.cloud.utils;

import org.apache.commons.lang.StringUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 *
 */
public class CookieUtil {

    private static final int MINUTE_SECONDS = 60;

    /**
     * 设置cookie名和对应的值,默认有效时间1天
     *
     * @param response HttpServletResponse
     * @param name     cookie名称
     * @param value    cookie值
     */
    public static void setCookie(HttpServletResponse response, String name, String value) {
        setCookie(response, name, value, "/", null, null);
    }

    /**
     * 设置cookie名和对应的值
     *
     * @param response HttpServletResponse
     * @param name     cookie名称
     * @param value    值
     * @param path     存储路径
     * @param age      分钟
     * @param domain   域
     */
    public static void setCookie(HttpServletResponse response, String name, String value, String path, String age,
                                 String domain) {
        Cookie cookie = new Cookie(name, value);
        cookie.setSecure(false);
        cookie.setPath(path);
        if (StringUtils.isNotEmpty(domain)) {
            cookie.setDomain(domain);
        }

        int maxAge = getAgeIntValue(age);
        if (maxAge > 0) {
            cookie.setMaxAge(maxAge);
        }

        response.addCookie(cookie);
    }

    private static int getAgeIntValue(String age) {
        try {
            return Integer.valueOf(age) * MINUTE_SECONDS;
        } catch (Exception e) {
            return -1;
        }
    }

    /**
     * 该方法用于根据cookie的名称获取cookie的值
     *
     * @param request HttpServletRequest
     * @param name    cookie的名称
     * @return cookie的名称对应的值
     */
    public static Cookie getCookie(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            return null;
        }

        Cookie returnCookie = null;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(name)) {
                returnCookie = cookie;
                break;
            }
        }

        return returnCookie;
    }

    /**
     * 该方法用于根据cookie的名称获取cookie的值
     *
     * @param request HttpServletRequest
     * @param name    cookie的名称
     * @return cookie的名称对应的值
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie cookie = getCookie(request, name);
        if (cookie == null) {
            return null;
        }

        return cookie.getValue();
    }

    /**
     * 该方法用于获取request中所有cookie的名称和值
     *
     * @param request HttpServletRequest
     * @return mao key:cookieName value:cookieValue
     */
    public static Map<String, String> getCookieMap(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies == null || cookies.length <= 0) {
            return new HashMap<String, String>();
        }

        Map<String, String> cookieMap = new HashMap<String, String>(cookies.length);
        for (Cookie cookie : cookies) {
            cookieMap.put(cookie.getName(), cookie.getValue());
        }

        return cookieMap;
    }

    /**
     * 该方法用于删除cookie
     *
     * @param response HttpServletResponse
     * @param cookie   Cookie对象
     * @param path     路径
     */
    public static void deleteCookie(HttpServletResponse response, Cookie cookie, String path) {
        if (cookie != null) {
            cookie.setMaxAge(0);
            cookie.setPath(path);
            response.addCookie(cookie);
        }
    }

    /**
     * 该方法用于删除cookie,默认删除"/"路径下的
     *
     * @param response HttpServletResponse
     * @param cookie   Cookie对象
     */
    public static void deleteCookie(HttpServletResponse response, Cookie cookie) {
        deleteCookie(response, cookie, "/");
    }

    /**
     * Convenience method to get the application's URL based on request
     * variables.
     */

    /**
     * 该方法用于获取request求求的完整域名
     *
     * @param request HttpServletRequest
     * @return 完整的域名
     */
    public static String getAppURL(HttpServletRequest request) {
        StringBuilder url = new StringBuilder();
        int port = request.getServerPort();
        if (port < 0) {
            port = 80; // Work around java.net.URL bug
        }

        String scheme = request.getScheme();
        url.append(scheme);
        url.append("://");
        url.append(request.getServerName());
        if ((scheme.equals("http") && (port != 80))
                || (scheme.equals("https") && (port != 443))) {
            url.append(':');
            url.append(port);
        }

        url.append(request.getContextPath());
        return url.toString();
    }

    /**
     * 该方法用于解析cookies到map
     *
     * @param cookiesText 传入的cookies
     * @return 解析的map
     */
    public static Map<String, String> toCookieMap(String cookiesText) {
        Map<String, String> result = new HashMap<String, String>();
        String[] texts = StringUtils.split(cookiesText, ";");
        for (String text : texts) {
            int pos = text.indexOf('=');
            String key = text.substring(0, pos);
            String value = text.substring(pos + 1);
            value = value.trim();
            if (value.startsWith("\"") && value.endsWith("\"")) {
                value = value.substring(1, value.length() - 1);
            }

            result.put(key.trim(), value);
        }

        return result;
    }
}
