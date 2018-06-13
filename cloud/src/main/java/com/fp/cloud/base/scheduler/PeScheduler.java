package com.fp.cloud.base.scheduler;

import com.alibaba.fastjson.JSON;
import com.fp.cloud.base.job.JobConstant;
import com.fp.cloud.base.model.PeJob;
import com.fp.cloud.base.redis.PeRedisClient;
import com.fp.cloud.base.service.JobLogService;
import com.fp.cloud.base.service.JobService;
import com.fp.cloud.base.ExecutionContext;
import com.fp.cloud.base.redis.PeJedisCommands;
import com.fp.cloud.constant.RedisKey;
import com.fp.cloud.utils.LogUtil;
import jdk.nashorn.internal.scripts.JO;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;
import redis.clients.jedis.exceptions.JedisConnectionException;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
@Component
public class PeScheduler {

    private static final Log LOG = LogUtil.getLog();
    @Resource
    private JobService jobService;
    @Resource
    private JobLogService jobLogService;
    @Resource
    private ThreadPoolTaskExecutor taskExecutor;

    @PostConstruct
    public void init() {
        taskExecutor.submit((Runnable) () -> {
            LOG.info("PeJMS thread start ...");
            PeJedisCommands jedis = getJedis();
            ExecutorService executorService = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors() / 2 + 1);
            while (true) {
                try {
                    List<String> valueList = jedis.brpop(0, RedisKey.WAIT_CONSUME_FUNCTION_CODE,
                            RedisKey.CONSUMED_FUNCTION_CODE);
                    if (CollectionUtils.isEmpty(valueList)) {
                        continue;
                    }

                    executorService.submit((Runnable) () -> {
                        String key = valueList.get(0);
                        String json = valueList.get(1);
                        if (StringUtils.isEmpty(json)) {
                            return;
                        }

                        processJms(key, json);
                    });

                } catch (JedisConnectionException e) {
                    jedis = getJedis();
                } catch (Exception e) {
                    LOG.error("PeJMS failed with exception !", e);
                }
            }
        });
    }

    private void processJms(String key, String json) {
        switch (key) {
            case RedisKey.WAIT_CONSUME_FUNCTION_CODE:
                PeJob peJob = JSON.parseObject(json, PeJob.class);
                LOG.info("Consume job functionCode [" + peJob.getFunctionCode() + "] start...");
                ExecutionContext.setUserId(peJob.getCreateBy());
                ExecutionContext.setCorpCode(peJob.getCorpCode());
                try {
                    peJob.setExecuteStatus(PeJob.ExecuteStatus.SUCCESS);
                } catch (Exception e) {
                    LOG.error(e);
                    peJob.setExecuteStatus(PeJob.ExecuteStatus.FAILED);
                    peJob.setMsgDetail(e.getMessage());
                }

                if (!peJob.isCycle()) {
                    jobService.update(peJob.getId(), PeJob._executeStatus, peJob.getExecuteStatus());
                }

                jobLogService.save(peJob.getId(), peJob.getExecuteStatus(), peJob.getMsgDetail());
                LOG.info("Consume job functionCode [" + peJob.getFunctionCode() + "] end...");
                break;
            default:
        }
    }

    private PeJedisCommands getJedis() {
        PeJedisCommands jedis = null;
        while (jedis == null) {
            LOG.info("Get jedis from pool ...");
            jedis = PeRedisClient.getCommonJedis();
            if (jedis == null) {
                LOG.info("Get jedis from pool failed ! try again after 3 seconds ...");
                try {
                    Thread.sleep(1000 * 3);
                } catch (InterruptedException e) {
                    LOG.error(e.getMessage(), e);
                }
            }
        }

        LOG.info("Get jedis from pool success !");
        return jedis;
    }
}
