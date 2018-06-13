package com.fp.cloud.base.job;


import com.fp.cloud.base.ExecutionContext;
import com.fp.cloud.base.model.PeJob;
import com.fp.cloud.base.scheduler.PeScheduler;
import com.fp.cloud.base.service.JobLogService;
import com.fp.cloud.base.service.JobService;
import com.fp.cloud.utils.PeDateUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.*;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Component("quartzJobTrigger")
public class QuartzJobTrigger {

    private static final Log LOG = LogFactory.getLog(QuartzJobTrigger.class);

    @Resource
    private Scheduler scheduler;
    @Resource
    private JobService jobService;
    @Resource
    private JobLogService jobLogService;
    @Resource
    private PeScheduler peScheduler;

    @PostConstruct
    public void initJobTrigger() {
        List<PeJob> jobs = jobService.list(PeJob.ExecuteStatus.NO_START);
        if (CollectionUtils.isEmpty(jobs)) {
            return;
        }

        for (PeJob job : jobs) {
            try {
                if (!job.isCycle()) {
                    String cronExpression = job.getCronExpression();
                    Date date = PeDateUtils.parse(cronExpression, JobConstant.QUARTZ_EXPRESSION_FORMAT);
                    if (date == null) {
                        continue;
                    }

                    if (new Date().after(date)) {
                        job.setCronExpression(PeDateUtils.format(DateUtils.addMinutes(new Date(), 1),
                                JobConstant.QUARTZ_EXPRESSION_FORMAT));
                    }
                }

                String triggerName = JobConstant.TRIGGER + JobConstant.JMS_JOIN_SIGN + job.getId();
                TriggerKey triggerKey = TriggerKey.triggerKey(triggerName, Scheduler.DEFAULT_GROUP);
                CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
                ExecutionContext.setUserId(job.getCreateBy());
                ExecutionContext.setCorpCode(job.getCorpCode());
                if (null == trigger) {
                    processNewJob(job);
                    continue;
                }

                // Trigger已存在，那么更新相应的定时设置
                CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());
                // 按新的cronExpression表达式重新构建trigger
                trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();
                // 按新的trigger重新设置job执行
                scheduler.rescheduleJob(triggerKey, trigger);
            } catch (Exception e) {
                LOG.error(e);
                processErrorJob(job.getId(), e.getMessage());
            }
        }
    }

    private void processErrorJob(String jobId, String errorMsg) {
        jobService.update(jobId, PeJob._executeStatus, PeJob.ExecuteStatus.FAILED);
        jobLogService.save(jobId, PeJob.ExecuteStatus.FAILED, errorMsg);
    }

    private void processNewJob(PeJob job) throws SchedulerException {
        String jobDetailName = JobConstant.JOB + JobConstant.JMS_JOIN_SIGN + job.getId();
        String triggerName = JobConstant.TRIGGER + JobConstant.JMS_JOIN_SIGN + job.getId();
        JobDetail jobDetail = JobBuilder.newJob(QuartzExecute.class).withIdentity(jobDetailName, Scheduler.DEFAULT_GROUP).build();
        jobDetail.getJobDataMap().put("job", job);
        jobDetail.getJobDataMap().put("scheduler", scheduler);
        jobDetail.getJobDataMap().put("jobService", jobService);
        jobDetail.getJobDataMap().put("jobLogService", jobLogService);
        jobDetail.getJobDataMap().put("peScheduler", peScheduler);
        CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());
        CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(triggerName,
                Scheduler.DEFAULT_GROUP).withSchedule(scheduleBuilder).build();
        scheduler.scheduleJob(jobDetail, trigger);
    }
}
