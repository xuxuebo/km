package com.fp.cloud.module.im.task;

import com.alibaba.fastjson.JSON;
import com.fp.cloud.base.redis.PeRedisClient;
import com.fp.cloud.constant.RedisKey;
import com.fp.cloud.module.im.domain.ImConfig;
import com.fp.cloud.module.im.domain.ImEmail;
import com.fp.cloud.module.im.domain.ImSms;
import com.fp.cloud.utils.SpringContextHolder;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

/**
 * 获取消息的任务
 */
public class MsgFetchTask {
    private final Log LOG = LogFactory.getLog(this.getClass());

    private HttpClient httpClient;
    private ThreadPoolTaskExecutor quickSmsTaskExecutor;
    private ThreadPoolTaskExecutor slowSmsTaskExecutor;
    private ThreadPoolTaskExecutor emailSendThreadPoolTaskQuick;

    public MsgFetchTask() {
        init();
    }

    public void init() {
        Thread producer = new Thread() {
            @Override
            public void run() {
                while (!Thread.currentThread().isInterrupted()) {
                    try {
                        // 短信（快）
                        boolean hasRedisDataSmsQuick = smsSend(RedisKey.PE_IM_SMS_QUEUE_QUICK, quickSmsTaskExecutor);

                        // 短信（慢）
                        boolean hasRedisDataSmsSlow = smsSend(RedisKey.PE_IM_SMS_QUEUE_SLOW, slowSmsTaskExecutor);

                        // 邮件（快）
                        boolean hasRedisDataEmailQuick = emailSend(RedisKey.PE_IM_EMAIL_QUEUE_QUICK, emailSendThreadPoolTaskQuick);

                        // 邮件（慢）
                        boolean hasRedisDataEmailFlow = false;
                        Integer poolSize = ImConfig.msgEmailSendSlowThreadPoolSize;
                        for (int i = 0; i < poolSize; i++) {
                            String beanName = "emailSendThreadPoolTask" + i;
                            ThreadPoolTaskExecutor threadPoolTaskExecutor = SpringContextHolder.getBean(beanName);
                            boolean hasRedisDataFlatTem;
                            hasRedisDataFlatTem = emailSend(RedisKey.PE_IM_EMAIL_QUEUE + String.valueOf(i), threadPoolTaskExecutor);
                            if (hasRedisDataFlatTem) {
                                hasRedisDataEmailFlow = true;
                            }
                        }

                        // 获取redis数据为空时，暂停时间
                        if (!hasRedisDataSmsQuick && !hasRedisDataSmsSlow && !hasRedisDataEmailQuick && !hasRedisDataEmailFlow) {
                            try {
                                Thread.sleep(ImConfig.msgSendRedisDataReadIntervalSeconds * 1000);
                            } catch (InterruptedException e) {
                                LOG.error(e);
                            }
                        }
                    } catch (Exception ex) {
                        LOG.error(ex.getMessage(), ex);
                    }

                    // 无限执行时，短暂等待
                    try {
                        Thread.sleep(ImConfig.msgSendRedisDataReadWaitInMillis);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        };

        producer.start();
    }

    private boolean smsSend(String redisKey, ThreadPoolTaskExecutor taskExecutor) {
        if (taskExecutor == null) {
            return false;
        }

        int maxPoolSize = taskExecutor.getMaxPoolSize();
        int activeCount = taskExecutor.getActiveCount();
        if (maxPoolSize <= activeCount) {
            LOG.warn("Can't execute `" + taskExecutor.getClass() + "`! ActiveCount:" + activeCount + "MaxPoolSize:" + maxPoolSize);
            return false;
        }

        String msgJson = PeRedisClient.getCommonJedis().lpop(redisKey);
        if (StringUtils.isEmpty(msgJson)) {
            return false;
        }

        try {
            ImSms smsMsg = JSON.parseObject(msgJson, ImSms.class);
            Runnable task = new SmsSendTask(smsMsg, httpClient, PeRedisClient.getCommonJedis());
            taskExecutor.submit(task);
        } catch (Exception e) {
            LOG.error(e);
        }

        return true;
    }

    /**
     * 邮件发送任务执行
     *
     * @param redisKey     redisKey
     * @param taskExecutor taskExecutor
     */
    private boolean emailSend(String redisKey, ThreadPoolTaskExecutor taskExecutor) {
        if (taskExecutor == null) {
            return false;
        }

        int maxPoolSize = taskExecutor.getMaxPoolSize();
        int activeCount = taskExecutor.getActiveCount();
        if (maxPoolSize <= activeCount) {
            LOG.warn("Can't execute `" + taskExecutor.getClass() + "`! ActiveCount:" + activeCount + "MaxPoolSize:" + maxPoolSize);
            return false;
        }

        String msgJson = PeRedisClient.getCommonJedis().lpop(redisKey);
        if (StringUtils.isEmpty(msgJson)) {
            return false;
        }

        try {
            ImEmail emailMsg = JSON.parseObject(msgJson, ImEmail.class);
            taskExecutor.submit(new EmailSendTask(emailMsg, PeRedisClient.getCommonJedis()));
        } catch (Exception e) {
            LOG.error(e);
        }

        return true;
    }

    public HttpClient getHttpClient() {
        return httpClient;
    }

    public void setHttpClient(HttpClient httpClient) {
        this.httpClient = httpClient;
    }

    public ThreadPoolTaskExecutor getQuickSmsTaskExecutor() {
        return quickSmsTaskExecutor;
    }

    public void setQuickSmsTaskExecutor(ThreadPoolTaskExecutor quickSmsTaskExecutor) {
        this.quickSmsTaskExecutor = quickSmsTaskExecutor;
    }

    public ThreadPoolTaskExecutor getSlowSmsTaskExecutor() {
        return slowSmsTaskExecutor;
    }

    public void setSlowSmsTaskExecutor(ThreadPoolTaskExecutor slowSmsTaskExecutor) {
        this.slowSmsTaskExecutor = slowSmsTaskExecutor;
    }

    public ThreadPoolTaskExecutor getEmailSendThreadPoolTaskQuick() {
        return emailSendThreadPoolTaskQuick;
    }

    public void setEmailSendThreadPoolTaskQuick(ThreadPoolTaskExecutor emailSendThreadPoolTaskQuick) {
        this.emailSendThreadPoolTaskQuick = emailSendThreadPoolTaskQuick;
    }
}
