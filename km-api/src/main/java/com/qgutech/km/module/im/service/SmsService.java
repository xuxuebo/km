package com.qgutech.km.module.im.service;

import java.util.Map;

/**
 * 消息统一管理
 *
 * @author LiYanCheng@HF
 * @since 2016年12月10日15:17:44
 */
public interface SmsService {

    /**
     * 【发送短息到执行的用户手机】
     *
     * @param templateName 短信模板名称
     * @param userId       用户名称
     * @param paramData    参数信息
     * @since 2016年12月10日15:24:14
     */
    void sendSmsMsg(String templateName, String userId, Map<String, Object> paramData, boolean isQuick);

    /**
     * 【发送短息到执行的用户手机】
     *
     * @param templateName 短信模板名称
     * @param userId       用户名称
     * @param paramData    参数信息
     * @since 2016年12月10日15:24:14
     */
    void sendSmsMsg(String templateName, String userId, Map<String, Object> paramData);
}
