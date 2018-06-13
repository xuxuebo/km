package com.fp.cloud.module.im.task;

import com.alibaba.fastjson.JSON;
import com.fp.cloud.module.im.domain.ImSms;
import com.fp.cloud.constant.RedisKey;
import com.fp.cloud.module.im.domain.ImConfig;
import org.apache.commons.httpclient.*;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.io.SAXReader;
import redis.clients.jedis.JedisCommands;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * 发送短信任务
 */
public class SmsSendTask implements Runnable {

    private final Log log = LogFactory.getLog(this.getClass());

    private ImSms smsMsg;
    private HttpClient httpClient;
    private JedisCommands jedisCommands;

    public SmsSendTask(ImSms smsMsg, HttpClient httpClient, JedisCommands jedisCommands) {
        this.smsMsg = smsMsg;
        this.httpClient = httpClient;
        this.jedisCommands = jedisCommands;
    }

    @Override
    public void run() {
        PostMethod method = new PostMethod(ImConfig.msgSmsSenderUrl);
        // 当前使用系统提供的默认恢复策略，出现网络原因引起的异常将自动重试3次
        method.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler());
        method.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, ImConfig.msgSmsSenderCharset);

        // 末尾必须加全角空格
        if (StringUtils.isNotEmpty(smsMsg.getTemplateId()) && smsMsg.getContent().endsWith("@=")) {
            smsMsg.setContent(smsMsg.getContent() + "　");
        }

        // 设置POST参数
        List<NameValuePair> data = new ArrayList<NameValuePair>();
        data.add(setHttpParam("method", "sendMsg"));
        data.add(setHttpParam("veryCode", ImConfig.msgSmsSenderVeryCode));
        data.add(setHttpParam("code", ImConfig.msgSmsSenderCharset));
        data.add(setHttpParam("username", ImConfig.msgSmsSenderUsername));
        data.add(setHttpParam("password", ImConfig.msgSmsSenderPassword));
        data.add(setHttpParam("mobile", StringUtils.defaultString(smsMsg.getMobile())));
        data.add(setHttpParam("content", StringUtils.defaultString(smsMsg.getContent())));
        //短信类型 1-普通短信，2-模板短信
        if (StringUtils.isNotEmpty(smsMsg.getTemplateId())) {
            data.add(setHttpParam("msgtype", "2"));
            data.add(setHttpParam("tempid", StringUtils.defaultString(smsMsg.getTemplateId())));
        } else {
            data.add(setHttpParam("msgtype", "1"));
        }

        NameValuePair[] dataTem = data.toArray(new NameValuePair[data.size()]);
        method.setRequestBody(dataTem);
        try {
            log.info("Send sms : " + smsMsg.toString());
            int statusCode = httpClient.executeMethod(method);
            if (statusCode != HttpStatus.SC_OK) {
                log.error("Send sms status code error ! status code is : " + statusCode);
                throw new RuntimeException("Send sms error with status code : " + statusCode);
            }

            // 读取内容
            InputStream inputStream = method.getResponseBodyAsStream();
            if (inputStream != null) {
                SAXReader reader = new SAXReader();
                org.dom4j.Document doc = reader.read(inputStream);
                org.dom4j.Element rootElt = doc.getRootElement();
                Iterator iterator = rootElt.elementIterator("mt");
                String status = null;
                while (iterator.hasNext()) {
                    org.dom4j.Element recordEle = (org.dom4j.Element) iterator.next();
                    status = recordEle.elementTextTrim("status");
                }

                if (status != null && StringUtils.isNotEmpty(status)) {
                    if (status.equals(String.valueOf(0))) {
                        log.info("SMS send success. status: " + status + "; mobile: " + smsMsg.getMobile() + "; content: " + smsMsg.getContent());
                    } else {
                        log.error("SMS send fail. status: " + status + "; mobile: " + smsMsg.getMobile());
                        // 记录7天内发送失败短信，使用zadd，获取结果时，对重复内容去重
                        saveSendFailSms(smsMsg, status);
                    }
                } else {
                    log.error("SMS send status: " + status + "; mobile: " + smsMsg.getMobile());
                }
            }
        } catch (HttpException e) {
            // 发生致命的异常，可能是协议错误或返回内容不正确
            log.error("SMS send failed with HttpException", e);
            throw new RuntimeException("SMS send failed with HttpException", e);
        } catch (Exception e) {
            log.error("SMS send failed !", e);
            throw new RuntimeException("SMS send failed !", e);
        } finally {
            // 释放连接
            method.releaseConnection();
        }
    }

    private NameValuePair setHttpParam(String key, String value) {
        return new NameValuePair(key, StringUtils.defaultString(value));
    }

    /**
     * 保存发送失败短信记录到Redis，及错误信息
     * 7天后过期
     *
     * @param smsMsg 短信信息
     * @param result 短信服务商返回结果
     */
    private void saveSendFailSms(ImSms smsMsg, String result) {
        // 记录7天内发送失败短信，使用zadd，获取结果时，对重复内容去重
        smsMsg.setErrorInfo(StringUtils.abbreviate(result, 300));
        String smsStr = JSON.toJSONString(smsMsg);
        jedisCommands.zadd(RedisKey.PE_IM_SMS_QUEUE_FAILED, System.currentTimeMillis(), smsStr);
        jedisCommands.expire(RedisKey.PE_IM_SMS_QUEUE_FAILED, 7 * 24 * 3600);
    }
}