package com.fp.cloud.base.service;


import com.fp.cloud.base.model.PeJob;

import java.util.Date;
import java.util.List;

public interface JobService extends BaseService<PeJob> {

    /**
     * 保存job保存到数据库中
     *
     * @param job 定时任务详情，具体如下：
     *            <ul>
     *            <li>{@linkplain PeJob#jobName job名称}</li>
     *            <li>{@linkplain PeJob#functionCode 方法code}</li>
     *            <li>{@linkplain PeJob#cronExpression 表达式}</li>
     *            <li>{@linkplain PeJob#sourceId 源ID}</li>
     *            </ul>
     * @return ID
     * @since 2017年1月13日14:01:42
     */
    String save(PeJob job);

    /**
     * 保存job保存到数据库中
     *
     * @param functionCode 方法code
     * @param date         时间
     * @param sourceId     源ID
     * @return ID
     * @since 2017年1月13日14:01:42
     */
    String save(String functionCode, Date date, String sourceId);

    /**
     * 通过sourceId修改定时任务信息
     *
     * @param sourceId 来源ID
     * @param job      定时任务修改信息
     * @param fields   需要修改的字段
     * @return 影响的数量
     * @since 2017年1月13日14:09:17
     */
    int update(String sourceId, PeJob job, String... fields);

    /**
     * 通过sourceId获取对应的定时任务信息
     *
     * @param sourceId 来源ID
     * @param fields   字段信息
     * @return 定时任务信息
     * @since 2017年1月13日14:10:38
     */
    PeJob getBySourceId(String sourceId, String... fields);

    /**
     * 通过来源ID删除定时任务信息
     *
     * @param sourceId 来源ID
     * @return 执行结果
     * @since 2017年1月13日14:11:27
     */
    int deleteBySourceId(String sourceId);

    /**
     * 通过状态获取对应的job集合
     *
     * @param status job状态
     * @return job集合
     * @since 2017年1月13日14:21:19
     */
    List<PeJob> list(PeJob.ExecuteStatus... status);
}
