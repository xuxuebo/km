package com.fp.cloud.base.service;

import com.fp.cloud.base.model.PeJob;
import com.fp.cloud.base.model.PeJobLog;


public interface JobLogService extends BaseService<PeJobLog> {

    /**
     * 保存定时任务执行结果信息
     *
     * @param jobLog 定时任务执行结果信息
     *               <ul>
     *               <li>{@linkplain PeJobLog#executeStatus 状态}</li>
     *               <li>{@linkplain PeJobLog#msgDetail 执行结果}</li>
     *               </ul>
     * @return 主键
     * @since 2017年1月13日14:13:42
     */
    String save(PeJobLog jobLog);

    String save(String jobId, PeJob.ExecuteStatus status, String megDetail);
}
