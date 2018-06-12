package com.qgutech.pe.base.websocket.util;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.Assert;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

public class WebSocketSessionHelp {
    private static Log LOG = LogFactory.getLog(WebSocketSessionHelp.class);
    public static Map<String, Map<String, WebSocketSession>> userToWebSocketSession = new ConcurrentHashMap<>();
    public static Map<String, String> webSocketSessionMap = new ConcurrentHashMap<>();

    public static void send(String msg, Set<String> toUserIds) throws Exception {
        Assert.hasLength(msg, "Msg is empty!");
        Assert.notEmpty(toUserIds, "ToUserIds is empty!");

        Map<String, Map<String, WebSocketSession>> userToWebSocketSession = WebSocketSessionHelp.userToWebSocketSession;
        for (String toUserId : toUserIds) {
            Map<String, WebSocketSession> stringWebSocketSessionMap = userToWebSocketSession.get(toUserId);
            if (MapUtils.isEmpty(stringWebSocketSessionMap)) {
                continue;
            }

            for (WebSocketSession webSocketSession : stringWebSocketSessionMap.values()) {
                try {
                    webSocketSession.sendMessage(new TextMessage(msg));
                } catch (IOException e) {
                    LOG.error("SendMessage error!", e);
                }
            }
        }
    }
}