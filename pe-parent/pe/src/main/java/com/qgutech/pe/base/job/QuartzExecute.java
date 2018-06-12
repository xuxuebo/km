package com.qgutech.pe.base.job;

import com.alibaba.fastjson.JSON;
import com.qgutech.pe.base.ExecutionContext;
import com.qgutech.pe.base.model.PeJob;
import com.qgutech.pe.base.redis.PeRedisClient;
import com.qgutech.pe.base.service.JobLogService;
import com.qgutech.pe.base.service.JobService;
import com.qgutech.pe.constant.RedisKey;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.*;


public class QuartzExecute implements Job {

    private static final Log LOG = LogFactory.getLog(QuartzExecute.class);

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        PeJob job = (PeJob) context.getJobDetail().getJobDataMap().get("job");
        ExecutionContext.setCorpCode(job.getCorpCode());
        ExecutionContext.setUserId(job.getCreateBy());
        JobService jobService = (JobService) context.getJobDetail().getJobDataMap().get("jobService");
        Scheduler scheduler = (Scheduler) context.getJobDetail().getJobDataMap().get("scheduler");
        JobLogService jobLogService = (JobLogService) context.getJobDetail().getJobDataMap().get("jobLogService");
        LOG.info(JobConstant.LOG_SIGN + "execute functionCode：" + job.getFunctionCode());
        jobService.update(job.getId(), PeJob._executeStatus, PeJob.ExecuteStatus.DOING);
        PeRedisClient.getCommonJedis().lpush(RedisKey.WAIT_CONSUME_FUNCTION_CODE, JSON.toJSONString(job));
        if (!job.isCycle()) {
            try {
                scheduler.unscheduleJob(context.getTrigger().getKey());
            } catch (SchedulerException e) {
                jobService.update(job.getId(), PeJob._executeStatus, PeJob.ExecuteStatus.FAILED);
                jobLogService.save(job.getId(), PeJob.ExecuteStatus.FAILED, e.getMessage());
            }
        }
    }
}
