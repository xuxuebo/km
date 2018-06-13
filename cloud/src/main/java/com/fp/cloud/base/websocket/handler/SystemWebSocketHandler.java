package com.fp.cloud.base.websocket.handler;

import com.alibaba.fastjson.JSON;
import com.fp.cloud.module.uc.model.SessionContext;
import com.fp.cloud.base.ExecutionContext;
import com.fp.cloud.base.service.SessionService;
import com.fp.cloud.base.vo.SocketVo;
import com.fp.cloud.base.websocket.util.WebSocketSessionHelp;
import com.fp.cloud.constant.PeConstant;
import com.fp.cloud.module.ems.vo.Ur;
import com.fp.cloud.utils.LogUtil;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.springframework.web.socket.*;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class SystemWebSocketHandler implements WebSocketHandler {

    private static final Log LOG = LogUtil.getLog();
    @Resource
    private SessionService sessionService;

    /**
     * 连接到WebSocket,存放必要的信息
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        LOG.debug("connect to the websocket success......");
        String userId = ExecutionContext.getUserId();
        Map<String, Map<String, WebSocketSession>> userToWebSocketSession = WebSocketSessionHelp.userToWebSocketSession;

        Map<String, WebSocketSession> socketSessionMap = userToWebSocketSession.get(userId);
        if (MapUtils.isEmpty(socketSessionMap)) {
            socketSessionMap = new ConcurrentHashMap<>();
        }

        socketSessionMap.put(SessionContext.get().getSessionId(), session);
        userToWebSocketSession.put(userId, socketSessionMap);
        WebSocketSessionHelp.webSocketSessionMap.put(session.getId(), SessionContext.get().getSessionId());
    }

    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
        String userContent = ((TextMessage) message).getPayload();
        if (StringUtils.isBlank(userContent)) {
            return;
        }

        processUserInfo(session.getId());
        try {
            SocketVo socketVo = JSON.parseObject(userContent, SocketVo.class);
            if (socketVo == null) {
                return;
            }

            if (PeConstant.SOCKET_ANSWER_KEY.equals(socketVo.getKey())) {
                Ur ur = JSON.parseObject(socketVo.getValue(), Ur.class);

                sendMessageToUser(Collections.singletonList(ExecutionContext.getUserId()), JSON.toJSONString(socketVo));
            }

        } catch (RuntimeException e) {
            LOG.error(e);
        }
    }

    private void processUserInfo(String webSocketSessionId) {
        String sessionId = WebSocketSessionHelp.webSocketSessionMap.get(webSocketSessionId);
        if (sessionId == null) {
            throw new IllegalArgumentException("Session is not existed!");
        }

        SessionContext sessionContext = sessionService.loadBySessionId(sessionId);
        SessionContext.set(sessionContext);
        ExecutionContext.setUserId(sessionContext.getUserId());
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        if (session.isOpen()) {
            session.close();
        }

        LOG.info("websocket connection closed......");
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        LOG.info("WebSocket Closed: " + closeStatus);
        Map<String, String> contextMap = ExecutionContext.getContextMap();
        if (MapUtils.isEmpty(contextMap)) {
            return;
        }

        Map<String, Map<String, WebSocketSession>> userToWebSocketSession = WebSocketSessionHelp.userToWebSocketSession;
        if (MapUtils.isEmpty(userToWebSocketSession)) {
            return;
        }

        String userId = ExecutionContext.getUserId();
        if (StringUtils.isBlank(userId)) {
            LOG.warn("Websocket userId is not valid!");
            return;
        }

        Map<String, WebSocketSession> socketSessionMap = userToWebSocketSession.get(userId);
        if (MapUtils.isEmpty(socketSessionMap)) {
            return;
        }

        socketSessionMap.remove(SessionContext.get().getSessionId());
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 给所有在线用户发送消息
     */
    public static void sendMessageToUser(String message) {
        Map<String, Map<String, WebSocketSession>> userToWebSocketSession = WebSocketSessionHelp.userToWebSocketSession;
        for (Map<String, WebSocketSession> webSocketSessionMap : userToWebSocketSession.values()) {
            if (MapUtils.isEmpty(webSocketSessionMap)) {
                continue;
            }

            for (WebSocketSession webSocketSession : webSocketSessionMap.values()) {
                try {
                    webSocketSession.sendMessage(new TextMessage(message));
                } catch (IOException e) {
                    LOG.error("SendMessage error!", e);
                }
            }
        }
    }

    /**
     * 给某个用户发送消息
     */
    public static void sendMessageToUser(List<String> toUserIds, String message) {
        Map<String, Map<String, WebSocketSession>> userToWebSocketSession = WebSocketSessionHelp.userToWebSocketSession;
        for (String toUserId : toUserIds) {
            Map<String, WebSocketSession> stringWebSocketSessionMap = userToWebSocketSession.get(toUserId);
            if (MapUtils.isEmpty(stringWebSocketSessionMap)) {
                continue;
            }

            for (WebSocketSession webSocketSession : stringWebSocketSessionMap.values()) {
                try {
                    webSocketSession.sendMessage(new TextMessage(message));
                } catch (IOException e) {
                    LOG.error("SendMessage error!", e);
                }
            }
        }
    }
}