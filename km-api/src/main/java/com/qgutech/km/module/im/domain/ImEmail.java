package com.qgutech.km.module.im.domain;

/**
 * 邮件消息
 */
public class ImEmail {

    //主题
    private String subject;
    //内容
    private String content;
    //用户名
    private String userName;
    //邮箱地址
    private String email;
    //错误信息
    private String errorInfo;

    public ImEmail() {

    }

    public ImEmail(String subject, String content, String userName, String email) {
        this.subject = subject;
        this.content = content;
        this.userName = userName;
        this.email = email;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getErrorInfo() {
        return errorInfo;
    }

    public void setErrorInfo(String errorInfo) {
        this.errorInfo = errorInfo;
    }
}
