package com.qgutech.pe.module.im.domain;

import java.util.ResourceBundle;

/**
 * 消息发送配置
 */
public class ImConfig {

    /*----------------------- 发邮件配置 --------------------------*/
    public static final String msgEmailFromEmail = getPropertyValue("msg.email.fromEmail");

    public static final String msgEmailHostName = getPropertyValue("msg.email.hostName");

    public static final String msgEmailPassword = getPropertyValue("msg.email.password");

    public static final String msgEmailSmtpPort = getPropertyValue("msg.email.smtpPort");

    public static final String msgEmailUserName = getPropertyValue("msg.email.userName");

    /*---------------------- 发短信配置 -----------------------------*/
    public static final String msgSmsSenderCharset = getPropertyValue("msg.sms.sender.charset");

    public static final String msgSmsSenderPassword = getPropertyValue("msg.sms.sender.password");

    public static final String msgSmsSenderUrl = getPropertyValue("msg.sms.sender.url");

    public static final String msgSmsSenderUsername = getPropertyValue("msg.sms.sender.username");

    public static final String msgSmsSenderVeryCode = getPropertyValue("msg.sms.sender.veryCode");

    /*---------------------- 线程、时间间隔等配置 ---------------------*/
    /**
     * 启用发送邮件（慢）的线程数
     */
    public static final Integer msgEmailSendSlowThreadPoolSize = Integer.valueOf(getPropertyValue("msg.emailSend.SlowThreadPoolSize"));

    /**
     * redis数据读取，无数据时的间隔时间（秒）
     */
    public static final Integer msgSendRedisDataReadIntervalSeconds = Integer.valueOf(getPropertyValue("msg.send.redisDataReadIntervalSeconds"));

    /**
     * redis数据读取无限执行等待时间（毫秒）
     */
    public static final Integer msgSendRedisDataReadWaitInMillis = Integer.valueOf(getPropertyValue("msg.send.redisDataReadWaitInMillis"));

    /*---------------------- spring bean 名称 ----------------------------*/
    /**
     * spring 配置文件名
     */
    public static final String springConfigFileName = getPropertyValue("msg.spring.configFileName");

    /**
     * 消息redis的bean名称
     */
    public static final String msgRedisBeanName = getPropertyValue("msg.redis.beanName");

    /*---------------------------- 其他 ----------------------------------*/
    /**
     * 消息模板目录名
     */
    public static final String msgTemplateDir = getPropertyValue("msg.template.dir");

    private static String getPropertyValue(String key) {
        try {
            ResourceBundle resource = ResourceBundle.getBundle("env");
            return resource.getString(key);
        } catch (Exception e) {
            return "";
        }
    }
}