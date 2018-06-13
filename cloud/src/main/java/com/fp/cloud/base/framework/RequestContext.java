package com.fp.cloud.base.framework;



import java.util.Date;

public class RequestContext {
    public static transient ThreadLocal<RequestContext> threadLocal = new ThreadLocal<RequestContext>();
    private String contextPath;
    private String channel;
    private String entity;
    private String action;
    private String format;
    private boolean retrying;
    private String ip;
    private Date timestamp;
    private String date;
    private String userAgent;
    private String client;
    private String referer;

    public static RequestContext get() {
        return threadLocal.get();
    }

    public static void set(RequestContext requestContext) {
        threadLocal.set(requestContext);
    }

    public String getContextPath() {
        return contextPath;
    }

    public String getChannel() {
        return channel;
    }

    public String getEntity() {
        return entity;
    }

    public String getAction() {
        return action;
    }

    public boolean isQualified() {
        if (action == null || entity == null || channel == null
                || contextPath == null) {
            return false;
        }

        return true;
    }

    public String getFormat() {
        return format;
    }

    void setFormat(String format) {
        this.format = format;
    }

    public boolean isRetrying() {
        return retrying;
    }

    void setRetrying(boolean retrying) {
        this.retrying = retrying;
    }

    public String getIp() {
        return ip;
    }

    void setChannel(String channel) {
        this.channel = channel;
    }

    void setEntity(String entity) {
        this.entity = entity;
    }

    void setAction(String action) {
        this.action = action;
    }

    void setIp(String remoteAddress) {
        this.ip = remoteAddress;
    }

    void setContextPath(String contextPath) {
        this.contextPath = contextPath;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String agent) {
        this.userAgent = agent;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getReferer() {
        return referer;
    }

    public void setReferer(String referer) {
        this.referer = referer;
    }
}
