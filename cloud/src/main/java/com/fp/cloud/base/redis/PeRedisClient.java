package com.fp.cloud.base.redis;

/**
 * Redis统一出入口
 */
public class PeRedisClient {
    private static PeJedisCommands sessionJedis;
    private static PeJedisCommands emsJedis;
    private static PeJedisCommands commonJedis;

    public static PeJedisCommands getSessionJedis() {
        return sessionJedis;
    }

    public void setSessionJedis(PeJedisCommands sessionJedis) {
        PeRedisClient.sessionJedis = sessionJedis;
    }

    public static PeJedisCommands getEmsJedis() {
        return emsJedis;
    }

    public void setEmsJedis(PeJedisCommands emsJedis) {
        PeRedisClient.emsJedis = emsJedis;
    }

    public static PeJedisCommands getCommonJedis() {
        return commonJedis;
    }

    public void setCommonJedis(PeJedisCommands commonJedis) {
        PeRedisClient.commonJedis = commonJedis;
    }
}
