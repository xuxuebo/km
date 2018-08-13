package com.qgutech.km.base.service;

import com.alibaba.fastjson.JSON;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.uc.model.SessionContext;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.PeNumberUtils;
import com.qgutech.km.utils.PropertiesUtils;
import com.qgutech.km.base.redis.PeJedisCommands;
import com.qgutech.km.constant.RedisKey;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 * @author Created by zhangyang on 2016/11/9.
 */
@Service("sessionService")
public class SessionServiceImpl implements SessionService {

    protected final Log LOG = LogFactory.getLog(getClass());

    @Override
    public SessionContext loadBySessionId(String sessionId) {
        SessionContext sessionContext;
        PeJedisCommands sessionJedis = PeRedisClient.getSessionJedis();
        String sessionKey = RedisKey.UC_LOGIN_SESSION + PeConstant.REDIS_DIVISION + sessionId;
        String sessionString = sessionJedis.get(sessionKey);
        if (StringUtils.isEmpty(sessionString)) {
            return new SessionContext();
//            throw new PeException("sessionToken is not found in server，sessionId:{" + sessionId + "}");
        }

        Integer aliveSeconds = PeNumberUtils.transformInt(PropertiesUtils.getConfigProp().
                getProperty("session.expire.time"));
        sessionJedis.expire(sessionKey, aliveSeconds * 60);
        sessionContext = JSON.parseObject(sessionString, SessionContext.class);
        String loginKey = RedisKey.UC_ALREADY_LOGIN + PeConstant.REDIS_DIVISION + sessionContext.getCorpCode() +
                PeConstant.REDIS_DIVISION + sessionContext.getUserId();
        sessionJedis.expire(loginKey, aliveSeconds * 60);
        return sessionContext;
    }

    @Override
    public void expireSession(String sessionId) {
        PeJedisCommands sessionJedis = PeRedisClient.getSessionJedis();
        String sessionKey = RedisKey.UC_LOGIN_SESSION + PeConstant.REDIS_DIVISION + sessionId;
        String sessionString = sessionJedis.get(sessionKey);
        if (StringUtils.isEmpty(sessionString)) {
            return;
        }
        sessionJedis.expire(sessionKey, 0);
        SessionContext sessionContext = JSON.parseObject(sessionString, SessionContext.class);
        String loginKey = RedisKey.UC_ALREADY_LOGIN + PeConstant.REDIS_DIVISION + sessionContext.getCorpCode() +
                PeConstant.REDIS_DIVISION + sessionContext.getUserId();
        sessionJedis.del(loginKey);
        return;
    }
}
