package com.qgutech.km.base.websocket.config;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.constant.CookieKey;
import com.qgutech.km.module.uc.model.SessionContext;
import com.qgutech.km.utils.CookieUtil;
import com.qgutech.km.base.service.SessionService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import javax.servlet.http.Cookie;
import java.util.Map;

public class WebSocketHandshakeInterceptor implements HandshakeInterceptor {

    private static Log logger = LogFactory.getLog(HandshakeInterceptor.class);

    private SessionService sessionService;

    public WebSocketHandshakeInterceptor(SessionService sessionService) {
        this.sessionService = sessionService;
    }

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Map<String, Object> map) throws Exception {
        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
            Cookie cookie = CookieUtil.getCookie(servletRequest.getServletRequest(), CookieKey.UC_LOGIN_SESSION_ID);
            if (cookie == null) {
                throw new IllegalArgumentException("Cookie is not existed!");
            }

            String sessionId = cookie.getValue();
            SessionContext sessionContext = sessionService.loadBySessionId(sessionId);
            SessionContext.set(sessionContext);
            ExecutionContext.setUserId(sessionContext.getUserId());
        }

        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Exception e) {

    }
}
