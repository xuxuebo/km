package com.qgutech.km.base.redis;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisShardInfo;
import redis.clients.util.Pool;

import java.net.URI;
import java.util.Map;

public class PeJedis extends Jedis implements PeJedisCommands {
    protected Pool<PeJedis> dataSource = null;

    public PeJedis() {
    }

    public PeJedis(String host) {
        super(host);
    }

    public PeJedis(String host, int port) {
        super(host, port);
    }

    public PeJedis(String host, int port, int timeout) {
        super(host, port, timeout);
    }

    public PeJedis(String host, int port, int connectionTimeout, int soTimeout) {
        super(host, port, connectionTimeout, soTimeout);
    }

    public PeJedis(JedisShardInfo shardInfo) {
        super(shardInfo);
    }

    public PeJedis(URI uri) {
        super(uri);
    }

    public PeJedis(URI uri, int timeout) {
        super(uri, timeout);
    }

    public PeJedis(URI uri, int connectionTimeout, int soTimeout) {
        super(uri, connectionTimeout, soTimeout);
    }

    public void setPesDataSource(Pool<PeJedis> jedisPool) {
        this.dataSource = jedisPool;
    }

    @Override
    public String set(Long key, String value) {
        return super.set(key.toString(), value);
    }

    @Override
    public String get(Long key) {
        return super.get(key.toString());
    }

    @Override
    public Boolean exists(Long key) {
        return super.exists(key.toString());
    }

    @Override
    public String hget(Long key, String field) {
        return super.hget(key.toString(), field);
    }

    @Override
    public Long hset(String key, String field, Long value) {
        return super.hset(key, field, value.toString());
    }

    @Override
    public Long hset(Long key, String field, String value) {
        return super.hset(key.toString(), field, value);
    }

    @Override
    public Long hset(Long key, String field, Long value) {
        return super.hset(key.toString(), field, value.toString());
    }

    @Override
    public Long hdel(Long key, String... field) {
        return super.hdel(key.toString(), field);
    }

    @Override
    public Long del(Long key) {
        return super.del(key.toString());
    }

    @Override
    public String hmset(Long key, Map<String, String> hash) {
        return super.hmset(key.toString(), hash);
    }

    @Override
    public Long setnx(String key, Long value) {
        return super.setnx(key, value.toString());
    }
}