package com.qgutech.pe.base.service;

import com.qgutech.pe.module.uc.model.SessionContext;

/**
 * 处理Session
 *
 * @author Created by zhangyang on 2016/11/9.
 */
public interface SessionService {
    /**
     * 获取Session信息，并做续时操作
     *
     * @param sessionId sessionId
     * @return session信息
     */
    SessionContext loadBySessionId(String sessionId);
    /**
     * 获取Session信息，并做续时操作
     *
     * @param sessionId sessionId
     * @return session信息
     */
    void expireSession(String sessionId);

}
