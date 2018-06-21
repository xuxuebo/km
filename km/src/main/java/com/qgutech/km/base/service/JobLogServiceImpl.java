package com.qgutech.km.base.service;

import com.qgutech.km.base.model.PeJob;
import com.qgutech.km.base.model.PeJobLog;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

@Service("jobLogService")
public class JobLogServiceImpl extends BaseServiceImpl<PeJobLog> implements JobLogService {

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public String save(PeJobLog jobLog) {
        if (jobLog == null || jobLog.getJob() == null || StringUtils.isBlank(jobLog.getJob().getId())
                || jobLog.getExecuteStatus() == null) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        if (PeJob.ExecuteStatus.SUCCESS.equals(jobLog.getExecuteStatus())) {
            jobLog.setMsgDetail("执行成功...");
        }

        return super.save(jobLog);
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public String save(String jobId, PeJob.ExecuteStatus status, String megDetail) {
        if (StringUtils.isBlank(jobId) || status == null) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        PeJob peJob = new PeJob();
        peJob.setId(jobId);
        PeJobLog jobLog = new PeJobLog();
        jobLog.setJob(peJob);
        jobLog.setExecuteStatus(status);
        jobLog.setMsgDetail(megDetail);
        return save(jobLog);
    }
}
