package com.fp.cloud.base.redis;

import redis.clients.jedis.JedisCommands;
import redis.clients.jedis.MultiKeyCommands;

import java.util.Map;

/**
 * Common interface for sharded and non-sharded Jedis
 */
public interface PeJedisCommands extends JedisCommands, MultiKeyCommands {
    String set(Long key, String value);

    String get(Long key);

    Boolean exists(Long key);

    String hget(Long key, String field);

    Long hset(String key, String field, Long value);

    Long hset(Long key, String field, String value);

    Long hset(Long key, String field, Long value);

    Long hdel(Long key, String... field);

    Long del(Long key);

    String hmset(Long key, Map<String, String> hash);

    Long setnx(String key, Long value);
}
