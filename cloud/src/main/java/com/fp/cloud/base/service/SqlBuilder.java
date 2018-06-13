package com.fp.cloud.base.service;

import java.sql.Timestamp;
import java.util.*;
import java.util.Map.Entry;

/**
 * 这个类用于帮助开发人员快速的构建sql语句和传递查询参数
 *
 * @author ELF@TEAM
 * @since 2016年2月25日 10:41:32
 */
public class SqlBuilder {

    private static final String BLANK = " ";
    private static final String EMPTY = "";

    private String sqlSplit;
    private StringBuilder builder;
    private List<Object> parameterList;
    private Map<String, Object> parameterMap;
    private Integer firstRecordIndex;
    private Integer maxRecordNum;

    public SqlBuilder() {
        super();
        init();
    }

    public SqlBuilder(String sqlSlice) {
        this();
        append(sqlSlice);
    }

    /**
     * 初始化当前的Hql Builder.
     */
    protected void init() {
        this.sqlSplit = BLANK;
        this.builder = new StringBuilder();
        this.parameterList = new ArrayList<Object>();
        this.parameterMap = new HashMap<String, Object>();
    }

    /**
     * 清理当前的Hql Builder,清空所有已经存在的数据.
     */
    public void clear() {
        init();
    }

    /**
     * 往Hql Builder里面增加新的Hql对象。
     *
     * @param sqlSlice sql片段
     * @return 当前HqlBuilder
     */
    public SqlBuilder append(String sqlSlice) {
        if (sqlSlice == null) {
            return this;
        }

        this.builder.append(sqlSplit);
        this.builder.append(sqlSlice);
        return this;
    }

    /**
     * 去掉当前Builder中最后的一个字符，如果当前串中没有任何字符。则返回自己。
     *
     * @return 当前HqlBuilder
     */
    public SqlBuilder removeLastCharacter() {
        int length = this.builder.length();
        if (length <= 0) {
            return this;
        }

        this.builder.deleteCharAt(length - 1);
        return this;
    }

    /**
     * 去掉当前Builder中最后的一个字符，如果当前串中没有任何字符。<br>
     * 则返回自己。 如果已经存在的字符的个数少于要删除的字符个数，则删除全部字符。
     *
     * @return 当前HqlBuilder
     */
    public SqlBuilder removeLastCharacters(int n) {
        int length = this.builder.length();
        if (length == 0) {
            return this;
        }

        int start = n > length ? 0 : length - n;
        this.builder.delete(start, length);
        return this;
    }

    public SqlBuilder enableSplit() {
        this.sqlSplit = BLANK;
        return this;
    }

    public SqlBuilder disableSplit() {
        this.sqlSplit = EMPTY;
        return this;
    }

    public String getSql() {
        return this.builder.toString();
    }

    public String getSqlSplit() {
        return this.sqlSplit;
    }

    public SqlBuilder append(SqlBuilder sqlBuilder) {
        if (sqlBuilder == null) {
            return this;
        }

        if (sqlBuilder == this) {
            return this;
        }

        this.append(sqlBuilder.getSql());
        this.addParameterMap(sqlBuilder.getParameterMap());
        return this;
    }

    /**
     * 拼写SQL语句 添加参数
     *
     * @param placeholder 参数名
     * @param value       参数值
     * @return 当前SQL
     */
    public SqlBuilder addParameter(String placeholder, Object value) {
        if (value instanceof java.util.Date) {
            java.util.Date date = (java.util.Date) value;
            value = new Timestamp(date.getTime());
        }
        parameterMap.put(placeholder, value);
        return this;
    }

    public SqlBuilder addParameterMap(Map<String, Object> parameters) {
        Set<Entry<String, Object>> entrySet = parameters.entrySet();
        for (Entry<String, Object> entry : entrySet) {
            String key = entry.getKey();
            Object value = entry.getValue();
            if (value instanceof java.util.Date) {
                java.util.Date date = (java.util.Date) value;
                value = new Timestamp(date.getTime());
            }
            parameterMap.put(key, value);
        }

        return this;
    }

    public Map<String, Object> getParameterMap() {
        return parameterMap;
    }

    public List<Object> getParameterList() {
        return parameterList;
    }

    public SqlBuilder setParameters(List<Object> parameters) {
        if (parameters == null) {
            this.parameterList = new ArrayList<Object>();
        } else {
            for (Object parameter : parameters) {
                if (parameter instanceof java.util.Date) {
                    java.util.Date date = (java.util.Date) parameter;
                    parameter = new Timestamp(date.getTime());
                }
                this.parameterList.add(parameter);
            }
        }
        return this;
    }

    @Override
    public String toString() {
        return this.getSql();
    }

    public Integer getFirstRecordIndex() {
        return firstRecordIndex;
    }

    public void setFirstRecordIndex(Integer firstRecordIndex) {
        this.firstRecordIndex = firstRecordIndex;
    }

    public Integer getMaxRecordNum() {
        return maxRecordNum;
    }

    public void setMaxRecordNum(Integer maxRecordNum) {
        this.maxRecordNum = maxRecordNum;
    }
}
