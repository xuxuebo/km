package com.qgutech.pe.module.im.task;

import com.alibaba.fastjson.JSON;
import com.qgutech.pe.constant.RedisKey;
import com.qgutech.pe.module.im.domain.ImConfig;
import com.qgutech.pe.module.im.domain.ImEmail;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.HtmlEmail;
import redis.clients.jedis.JedisCommands;

import javax.mail.internet.MimeUtility;

/**
 * 邮件发送任务
 */
public class EmailSendTask implements Runnable {

    protected final Log LOG = LogFactory.getLog(getClass());

    private static final String CHARSET_UTF_8 = "UTF-8";
    private static final String INVALID_ADDRESSES = "Invalid Addresses";

    private ImEmail emailMsg;
    private JedisCommands jedisCommands;

    public EmailSendTask(ImEmail emailMsg, JedisCommands jedisCommands) {
        this.emailMsg = emailMsg;
        this.jedisCommands = jedisCommands;
    }

    @Override
    public void run() {
        HtmlEmail htmlEmail = new HtmlEmail();
        String toEmailAddress = emailMsg.getEmail();
        try {
            htmlEmail.setHostName(ImConfig.msgEmailHostName);
            htmlEmail.setSmtpPort(Integer.valueOf(ImConfig.msgEmailSmtpPort));
            htmlEmail.setAuthenticator(new DefaultAuthenticator(ImConfig.msgEmailUserName, ImConfig.msgEmailPassword));
            htmlEmail.setFrom(ImConfig.msgEmailFromEmail, MimeUtility.encodeText(ImConfig.msgEmailFromEmail, CHARSET_UTF_8, "B"));
            htmlEmail.addTo(toEmailAddress, emailMsg.getUserName(), CHARSET_UTF_8);
            htmlEmail.setCharset(CHARSET_UTF_8);
            htmlEmail.setSubject(emailMsg.getSubject());
            htmlEmail.setHtmlMsg(emailMsg.getContent());
            htmlEmail.setTextMsg(emailMsg.getContent());
            LOG.info("Begin send email to : " + toEmailAddress);
            htmlEmail.setSocketConnectionTimeout(5000);
            htmlEmail.send();
            LOG.info("Email send success! to email :" + toEmailAddress);
        } catch (Exception e) {
            LOG.error("send email failed ! To : " + toEmailAddress, e);
            try {
                if (!INVALID_ADDRESSES.equals(e.getCause().getMessage())) {
                    String emailFailedKey = RedisKey.PE_IM_EMAIL_QUEUE_FAILED + "_" + toEmailAddress + "_" + emailMsg.getSubject();
                    String countStr = jedisCommands.get(emailFailedKey);
                    int failedCount = 0;
                    if (StringUtils.isNotEmpty(countStr)) {
                        failedCount = Integer.parseInt(countStr) + 1;
                    } else {
                        failedCount++;
                    }

                    if (failedCount > 10) {
                        jedisCommands.expire(emailFailedKey, 0);
                        addFailedEmailQueue(e);
                    } else {
                        jedisCommands.set(emailFailedKey, failedCount + "");
                        jedisCommands.expire(emailFailedKey, 7 * 24 * 60 * 60);
                        String objStr = JSON.toJSONString(emailMsg);
                        String[] emailAddressArr = toEmailAddress.split("@");
                        Integer hashCode = Math.abs(emailAddressArr[1].hashCode() % ImConfig.msgEmailSendSlowThreadPoolSize);
                        String msgQueue = RedisKey.PE_IM_EMAIL_QUEUE + String.valueOf(hashCode);
                        LOG.error("Begin rpush msg ... email address is : " + toEmailAddress);
                        jedisCommands.rpush(msgQueue, objStr);
                        LOG.error("End rpush msg ... email address is : " + toEmailAddress);
                    }
                } else {
                    addFailedEmailQueue(e);
                    LOG.error("Send email failed! To:" + toEmailAddress, e);
                }
            } catch (Exception ex) {
                addFailedEmailQueue(ex);
            }
        }
    }

    /*
     保存发送错误的消息
     */
    private void addFailedEmailQueue(Exception ex) {
        String errorInfo = ex.getCause().toString();
        if (StringUtils.isNotEmpty(errorInfo) && errorInfo.length() > 1000) {
            errorInfo = errorInfo.substring(0, 1000);
        }

        emailMsg.setErrorInfo(errorInfo);
        String objStr = JSON.toJSONString(emailMsg, true);
        jedisCommands.rpush(RedisKey.PE_IM_EMAIL_QUEUE_FAILED, objStr);
    }
}