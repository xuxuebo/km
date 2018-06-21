//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.qgutech.km.base.redis;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.aop.framework.ProxyFactory;
import org.springframework.beans.factory.FactoryBean;
import redis.clients.jedis.JedisCommands;
import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.exceptions.JedisConnectionException;

import java.lang.reflect.InvocationTargetException;

public class PeRedisFactoryBean implements MethodInterceptor, FactoryBean<JedisCommands> {
    private PeJedisPool jedisPool;
    private PeJedis jedis;
    private PeJedisCommands proxy;
    private String host;
    private int port;

    public PeRedisFactoryBean(String host, int port) {
        this.host = host;
        this.port = port;
        this.jedis = new PeJedis(host, port);
        this.proxy = (PeJedisCommands) (new ProxyFactory(PeJedisCommands.class, this)).getProxy();
    }

    public PeRedisFactoryBean(JedisPoolConfig jedisPoolConfig, String host, int port) {
        this.host = host;
        this.port = port;
        this.jedisPool = new PeJedisPool(jedisPoolConfig, host, port);
        this.proxy = (PeJedisCommands) (new ProxyFactory(PeJedisCommands.class, this)).getProxy();
    }

    public PeRedisFactoryBean(JedisPoolConfig jedisPoolConfig, String host, int port, int dbIndex) {
        this.host = host;
        this.port = port;
        this.jedisPool = new PeJedisPool(jedisPoolConfig, host, port, dbIndex);
        this.proxy = (PeJedisCommands) (new ProxyFactory(PeJedisCommands.class, this)).getProxy();
    }

    PeJedisCommands getJedis() {
        return this.proxy;
    }

    public Object invoke(MethodInvocation invocation) throws Throwable {
        return this.jedisPool == null ? this.invokeInternal(invocation) : this.invokeInternalWithPool(invocation);
    }

    public synchronized Object invokeInternal(MethodInvocation invocation) throws Throwable {
        try {
            return invocation.getMethod().invoke(this.jedis, invocation.getArguments());
        } catch (InvocationTargetException var6) {
            Throwable targetException = var6.getTargetException();
            if (targetException != null) {
                if (targetException instanceof JedisConnectionException) {
                    try {
                        this.jedis.disconnect();
                    } catch (Exception ignored) {
                    }

                    this.jedis = new PeJedis(this.host, this.port);
                }

                throw targetException;
            } else {
                throw var6;
            }
        }
    }

    public Object invokeInternalWithPool(MethodInvocation invocation) throws Throwable {
        PeJedis jedisFromPool = this.jedisPool.getResource();
        Object result;

        try {
            result = invocation.getMethod().invoke(jedisFromPool, invocation.getArguments());
        } catch (InvocationTargetException var6) {
            Throwable targetException = var6.getTargetException();
            if (targetException != null) {
                if (targetException instanceof JedisConnectionException) {
                    this.returnBrokenJedis(jedisFromPool);
                } else {
                    this.returnJedis(jedisFromPool);
                }

                throw targetException;
            }

            this.returnJedis(jedisFromPool);
            throw var6;
        }

        this.returnJedis(jedisFromPool);
        return result;
    }

    void returnBrokenJedis(PeJedis jedisFromPool) {
        try {
            this.jedisPool.returnBrokenResource(jedisFromPool);
        } catch (Exception var3) {
            var3.printStackTrace();
        }

    }

    void returnJedis(PeJedis jedisFromPool) {
        try {
            this.jedisPool.returnResource(jedisFromPool);
        } catch (Exception var3) {
            var3.printStackTrace();
        }

    }

    public PeJedisCommands getObject() throws Exception {
        return this.getJedis();
    }

    public Class<PeJedisCommands> getObjectType() {
        return PeJedisCommands.class;
    }

    public boolean isSingleton() {
        return true;
    }
}
