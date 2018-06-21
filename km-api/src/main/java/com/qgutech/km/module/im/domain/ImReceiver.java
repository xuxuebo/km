package com.qgutech.km.module.im.domain;

import java.io.Serializable;

/**
 * 消息接收者信息实体
 */
public class ImReceiver implements Serializable {

    private String mobile;
    private String email;
    private String userName;

    public ImReceiver() {

    }

    public ImReceiver(String mobile, String emailAddr, String userName) {
        this.mobile = mobile;
        this.email = emailAddr;
        this.userName = userName;
    }

    public ImReceiver(String emailAddr, String userName) {
        this.email = emailAddr;
        this.userName = userName;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
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
}
