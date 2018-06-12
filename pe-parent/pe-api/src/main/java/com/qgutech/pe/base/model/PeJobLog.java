package com.qgutech.pe.base.model;

import javax.persistence.*;

@Entity
@Table(name = "t_pe_job_log", indexes = {
        @Index(name = "i_pe_job_log_corpCode", columnList = "corpCode"),
        @Index(name = "i_pe_job_log_jobId", columnList = "job_id")})
public class PeJobLog extends BaseModel {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "job_id", nullable = false)
    private PeJob job;

    /**
     * 消息详情
     */
    @Column(nullable = false, length = 1300)
    private String msgDetail;

    /**
     * 执行状态
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private PeJob.ExecuteStatus executeStatus;

    public PeJob getJob() {
        return job;
    }

    public void setJob(PeJob job) {
        this.job = job;
    }

    public String getMsgDetail() {
        return msgDetail;
    }

    public void setMsgDetail(String msgDetail) {
        this.msgDetail = msgDetail;
    }

    public PeJob.ExecuteStatus getExecuteStatus() {
        return executeStatus;
    }

    public void setExecuteStatus(PeJob.ExecuteStatus executeStatus) {
        this.executeStatus = executeStatus;
    }
}
