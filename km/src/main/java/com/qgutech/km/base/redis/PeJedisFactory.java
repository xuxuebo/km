package com.qgutech.km.base.redis;

import org.apache.commons.pool2.PooledObject;
import org.apache.commons.pool2.PooledObjectFactory;
import org.apache.commons.pool2.impl.DefaultPooledObject;
import redis.clients.jedis.BinaryJedis;
import redis.clients.jedis.HostAndPort;
import redis.clients.jedis.exceptions.InvalidURIException;
import redis.clients.jedis.exceptions.JedisException;
import redis.clients.util.JedisURIHelper;

import java.net.URI;
import java.util.concurrent.atomic.AtomicReference;

class PeJedisFactory implements PooledObjectFactory<PeJedis> {
    private final AtomicReference<HostAndPort> hostAndPort = new AtomicReference<HostAndPort>();
    private final int connectionTimeout;
    private final int soTimeout;
    private final String password;
    private final int database;
    private final String clientName;

    public PeJedisFactory(final String host, final int port, final int connectionTimeout,
                          final int soTimeout, final String password, final int database, final String clientName) {
        this.hostAndPort.set(new HostAndPort(host, port));
        this.connectionTimeout = connectionTimeout;
        this.soTimeout = soTimeout;
        this.password = password;
        this.database = database;
        this.clientName = clientName;
    }

    public PeJedisFactory(final URI uri, final int connectionTimeout, final int soTimeout,
                          final String clientName) {
        if (!JedisURIHelper.isValid(uri)) {
            throw new InvalidURIException(String.format(
                    "Cannot open Redis connection due invalid URI. %s", uri.toString()));
        }

        this.hostAndPort.set(new HostAndPort(uri.getHost(), uri.getPort()));
        this.connectionTimeout = connectionTimeout;
        this.soTimeout = soTimeout;
        this.password = JedisURIHelper.getPassword(uri);
        this.database = JedisURIHelper.getDBIndex(uri);
        this.clientName = clientName;
    }

    public void setHostAndPort(final HostAndPort hostAndPort) {
        this.hostAndPort.set(hostAndPort);
    }

    @Override
    public void activateObject(PooledObject<PeJedis> pooledJedis) throws Exception {
        final BinaryJedis jedis = pooledJedis.getObject();
        if (jedis.getDB() != database) {
            jedis.select(database);
        }

    }

    @Override
    public void destroyObject(PooledObject<PeJedis> pooledJedis) throws Exception {
        final BinaryJedis jedis = pooledJedis.getObject();
        if (jedis.isConnected()) {
            try {
                try {
                    jedis.quit();
                } catch (Exception e) {
                }
                jedis.disconnect();
            } catch (Exception e) {

            }
        }

    }

    @Override
    public PooledObject<PeJedis> makeObject() throws Exception {
        final HostAndPort hostAndPort = this.hostAndPort.get();
        final PeJedis jedis = new PeJedis(hostAndPort.getHost(), hostAndPort.getPort(), connectionTimeout,
                soTimeout);

        try {
            jedis.connect();
            if (null != this.password) {
                jedis.auth(this.password);
            }
            if (database != 0) {
                jedis.select(database);
            }
            if (clientName != null) {
                jedis.clientSetname(clientName);
            }
        } catch (JedisException je) {
            jedis.close();
            throw je;
        }

        return new DefaultPooledObject<PeJedis>(jedis);

    }

    @Override
    public void passivateObject(PooledObject<PeJedis> pooledJedis) throws Exception {
        // TODO maybe should select db 0? Not sure right now.
    }

    @Override
    public boolean validateObject(PooledObject<PeJedis> pooledJedis) {
        final BinaryJedis jedis = pooledJedis.getObject();
        try {
            HostAndPort hostAndPort = this.hostAndPort.get();

            String connectionHost = jedis.getClient().getHost();
            int connectionPort = jedis.getClient().getPort();

            return hostAndPort.getHost().equals(connectionHost)
                    && hostAndPort.getPort() == connectionPort && jedis.isConnected()
                    && jedis.ping().equals("PONG");
        } catch (final Exception e) {
            return false;
        }
    }
}