package com.fp.cloud.module.im.service;

import com.alibaba.fastjson.JSON;
import com.fp.cloud.base.model.Message;
import com.fp.cloud.base.redis.PeRedisClient;
import com.fp.cloud.base.service.MessageService;
import com.fp.cloud.constant.RedisKey;
import com.fp.cloud.module.im.domain.ImConfig;
import com.fp.cloud.module.im.domain.ImEmail;
import com.fp.cloud.module.im.domain.ImReceiver;
import com.fp.cloud.module.im.domain.ImSms;
import com.fp.cloud.module.im.util.FreemarkerUtil;
import com.fp.cloud.module.uc.model.User;
import com.fp.cloud.utils.MobileTemplateUtil;
import com.fp.cloud.utils.SpringContextHolder;
import org.apache.commons.lang.StringUtils;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * 消息发送服务
 */
public class MsgSendService {

    private static final String MSG_TEMPLATE_SMS_SUFFIX = "_sms";
    private static final String MSG_TEMPLATE_EMAIL_SUFFIX = "_email";
    private static final String MSG_TEMPLATE_MESSAGE_SUFFIX = "_message";

    public static void sendSmsMsg(String templateName, String templateId, List<String> mobileList, Map<String, Object> paramData, boolean isQuick) {
        Assert.hasLength(templateName);
        Assert.notEmpty(mobileList);

        String content = FreemarkerUtil.getTextFromTemplate(templateName + MSG_TEMPLATE_SMS_SUFFIX, paramData);
        List<ImSms> smsMsgList = new ArrayList<ImSms>(mobileList.size());
        for (String mobile : mobileList) {
            ImSms smsMsg = new ImSms(mobile, content, templateId);
            smsMsgList.add(smsMsg);
        }

        storeSmsToRedis(smsMsgList, isQuick);
    }

    public static void sendSmsMsg(String templateName, String templateId, String mobile, Map<String, Object> paramData, boolean isQuick) {
        Assert.hasLength(templateName);
        Assert.hasLength(mobile);
        String content = FreemarkerUtil.getTextFromTemplate(templateName + MSG_TEMPLATE_SMS_SUFFIX, paramData);
        List<ImSms> smsMsgList = new ArrayList<>(1);
        ImSms smsMsg = new ImSms(mobile, content, templateId);
        smsMsgList.add(smsMsg);
        storeSmsToRedis(smsMsgList, isQuick);
    }

    public static void sendSmsMsg(String templateName, List<String> mobileList, Map<String, Object> paramData, boolean isQuick) {
        Assert.hasLength(templateName);
        Assert.notEmpty(mobileList);

        String templateId = MobileTemplateUtil.getTemplateId(templateName);

        sendSmsMsg(templateName, templateId, mobileList, paramData, isQuick);
    }

    public static void sendSmsMsg(String templateName, String mobile, Map<String, Object> paramData, boolean isQuick) {
        Assert.hasLength(templateName);
        Assert.hasLength(mobile);
        String templateId = MobileTemplateUtil.getTemplateId(templateName);
        sendSmsMsg(templateName, templateId, mobile, paramData, isQuick);
    }

    public static void sendEmailMsg(String templateName, String subject, List<ImReceiver> msgReceiverList, Map<String, Object> paramData, boolean isQuick) {
        Assert.hasLength(templateName);
        Assert.hasLength(subject);
        Assert.notEmpty(msgReceiverList);

        String content = FreemarkerUtil.getTextFromTemplate(templateName + MSG_TEMPLATE_EMAIL_SUFFIX, paramData);
        List<ImEmail> emailMsgList = new ArrayList<>(msgReceiverList.size());
        for (ImReceiver msgReceiver : msgReceiverList) {
            ImEmail emailMsg = new ImEmail(subject, content, msgReceiver.getUserName(), msgReceiver.getEmail());
            emailMsgList.add(emailMsg);
        }

        storeEmailToRedis(emailMsgList, isQuick);
    }

    public static void sendMessageMsg(String templateName, String userId, Map<String, Object> paramData) {
        Assert.hasLength(templateName);
        Assert.hasLength(userId);
        sendMessageMsg(templateName, Collections.singletonList(userId), paramData);
    }

    public static void sendMessageMsg(String templateName, List<String> userIds, Map<String, Object> paramData) {
        Assert.hasLength(templateName);
        Assert.notEmpty(userIds);
        String content = FreemarkerUtil.getTextFromTemplate(templateName + MSG_TEMPLATE_MESSAGE_SUFFIX, paramData);
        List<Message> messages = new ArrayList<>(userIds.size());
        for (String userId : userIds) {
            Message message = new Message();
            message.setContent(content);
            User user = new User();
            user.setId(userId);
            message.setRead(false);
            message.setUser(user);
            messages.add(message);
        }

        MessageService messageService = SpringContextHolder.getBean("messageService");
        messageService.batchSave(messages);
    }

    /**
     * `短信`数据存储到redis
     *
     * @param smsMsgList smsMsgList
     * @param quick      quick or slow
     */
    private static void storeSmsToRedis(List<ImSms> smsMsgList, boolean quick) {
        if (CollectionUtils.isEmpty(smsMsgList)) {
            return;
        }

        String msgQueue = quick ? RedisKey.PE_IM_SMS_QUEUE_QUICK : RedisKey.PE_IM_SMS_QUEUE_SLOW;
        for (ImSms smsMsg : smsMsgList) {
            String smsJsonStr = JSON.toJSONString(smsMsg);
            PeRedisClient.getCommonJedis().rpush(msgQueue, smsJsonStr);
        }
    }

    /**
     * `邮件`数据存储到redis
     * 按收件地址对应邮件服务器名的hashcode动态分布存储
     *
     * @param emailMsgList emailMsgList
     * @param quick        boolean
     */
    private static void storeEmailToRedis(List<ImEmail> emailMsgList, boolean quick) {
        if (CollectionUtils.isEmpty(emailMsgList)) {
            return;
        }

        String msgQueue = quick ? RedisKey.PE_IM_EMAIL_QUEUE_QUICK : null;
        for (ImEmail emailMsg : emailMsgList) {
            String emailJsonStr = JSON.toJSONString(emailMsg);
            if (StringUtils.isEmpty(msgQueue)) {
                String[] emailAddressArr = emailMsg.getEmail().split("@");
                Integer hashCode = Math.abs(emailAddressArr[1].hashCode() % ImConfig.msgEmailSendSlowThreadPoolSize);
                msgQueue = RedisKey.PE_IM_EMAIL_QUEUE + String.valueOf(hashCode);
            }

            PeRedisClient.getCommonJedis().rpush(msgQueue, emailJsonStr);
        }
    }
}