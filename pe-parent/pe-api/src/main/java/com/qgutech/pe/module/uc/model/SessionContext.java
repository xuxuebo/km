package com.qgutech.pe.module.uc.model;

import java.util.Map;
import java.util.Set;

/**
 * Session会话信息
 *
 * @author Created by zhangyang on 2016/11/8.
 */
public class SessionContext {
    public static transient ThreadLocal<SessionContext> threadLocal = new ThreadLocal<SessionContext>();
    private String sessionId;
    private String userId;
    private String userName;
    private boolean admin;
    private boolean superAdmin;
    private boolean systemAdmin;
    private String ip;
    private Set<String> authCodes;
    private String corpCode;

    public SessionContext() {
    }

    public String getIp() {
        return this.ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public static SessionContext get() {
        return threadLocal.get();
    }

    public static void set(SessionContext sessionContext) {
        threadLocal.set(sessionContext);
    }

    public String getSessionId() {
        return this.sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public String getUserId() {
        return this.userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return this.userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public boolean isAdmin() {
        return this.admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }

    public boolean isSuperAdmin() {
        return this.superAdmin;
    }

    public void setSuperAdmin(boolean superAdmin) {
        this.superAdmin = superAdmin;
    }

    public boolean isSystemAdmin() {
        return this.systemAdmin;
    }

    public void setSystemAdmin(boolean systemAdmin) {
        this.systemAdmin = systemAdmin;
    }

    public Set<String> getAuthCodes() {
        return this.authCodes;
    }

    public void setAuthCodes(Set<String> authCodes) {
        this.authCodes = authCodes;
    }

    public String getCorpCode() {
        return this.corpCode;
    }

    public void setCorpCode(String corpCode) {
        this.corpCode = corpCode;
    }
}
