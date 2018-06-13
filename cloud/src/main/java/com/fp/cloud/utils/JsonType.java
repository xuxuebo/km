package com.fp.cloud.utils;

import com.alibaba.fastjson.JSON;
import com.fp.cloud.constant.PeConstant;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.engine.spi.SessionImplementor;
import org.hibernate.usertype.ParameterizedType;
import org.hibernate.usertype.UserType;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Properties;

/**
 * 自定义Json 对象
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月18日16:47:33
 */
public class JsonType implements UserType, ParameterizedType {

    private Properties properties;
    protected static final String CLASS_NAME_KEY = "clazzName";
    protected static final String IS_ARRAY = "isArray";

    @Override
    public int[] sqlTypes() {
        return new int[]{Types.VARCHAR};
    }

    /**
     * 映射Java值类型
     *
     * @return clazz
     */
    @Override
    public Class returnedClass() {
        String isArray = properties.getProperty(IS_ARRAY);
        if (StringUtils.isNotBlank(isArray) && PeConstant.TRUE.equalsIgnoreCase(isArray)) {
            return ArrayList.class;
        }

        String clazzName = properties.getProperty(CLASS_NAME_KEY);
        try {
            return Class.forName(clazzName);
        } catch (ClassNotFoundException e) {
            return null;
        }
    }

    @Override
    public boolean equals(Object x, Object y) throws HibernateException {
        return x == y || !(x == null || y == null) && x.equals(y);
    }

    @Override
    public int hashCode(Object x) throws HibernateException {
        return x.hashCode();
    }

    @Override
    public Object nullSafeGet(ResultSet resultSet, String[] names, SessionImplementor session, Object owner)
            throws HibernateException, SQLException {
        String jsonAsciiValue = resultSet.getString(names[0]);
        if (jsonAsciiValue == null) {
            return null;
        }

        String clazzName = properties.getProperty(CLASS_NAME_KEY);
        if (StringUtils.isBlank(clazzName)) {
            return null;
        }

        Class clazz;
        try {
            clazz = Class.forName(clazzName);
        } catch (ClassNotFoundException e) {
            return null;
        }

        String isArray = properties.getProperty(IS_ARRAY);
        if (StringUtils.isNotBlank(isArray) && PeConstant.TRUE.equalsIgnoreCase(isArray)) {
            return JSON.parseArray(jsonAsciiValue, clazz);
        }

        return JSON.parseObject(jsonAsciiValue, clazz);
    }

    @Override
    public void nullSafeSet(PreparedStatement preparedStatement, Object value, int index, SessionImplementor session)
            throws HibernateException, SQLException {
        if (value == null) {
            preparedStatement.setNull(index, Types.VARCHAR);
        } else {
            String jsonValue = JSON.toJSONString(value);
            preparedStatement.setString(index, jsonValue);
        }
    }

    @Override
    public Object deepCopy(Object value) throws HibernateException {
        return value;
    }

    @Override
    public boolean isMutable() {
        return false;
    }

    @Override
    public Serializable disassemble(Object value) throws HibernateException {
        return ((Serializable) value);
    }

    @Override
    public Object assemble(Serializable cached, Object owner) throws HibernateException {
        return cached;
    }

    @Override
    public Object replace(Object original, Object target, Object owner) throws HibernateException {
        return original;
    }

    @Override
    public void setParameterValues(Properties parameters) {
        this.properties = parameters;
    }
}