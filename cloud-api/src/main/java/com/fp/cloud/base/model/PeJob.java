package com.fp.cloud.base.model;

import javax.persistence.*;

@Entity
@Table(name = "t_pe_job", indexes = {
        @Index(name = "i_pe_job_corpCode", columnList = "corpCode"),
        @Index(name = "i_pe_job_sourceId", columnList = "sourceId")})
public class PeJob extends BaseModel {

    public static final String _jobName = "jobName";
    public static final String _appCode = "appCode";
    public static final String _functionCode = "functionCode";
    public static final String _cronExpression = "cronExpression";
    public static final String _executeStatus = "executeStatus";
    public static final String _sourceId = "sourceId";
    public static final String _cycle = "cycle";
    public static final String _jobAlias = "peJob";

    public enum ExecuteStatus {
        SUCCESS("成功"), FAILED("失败"), DOING("进行中"), NO_START("未开始");
        private final String text;

        ExecuteStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 任务名称
     */
    @Column(length = 100)
    private String jobName;

    /**
     * 方法code
     */
    @Column(length = 50, nullable = false)
    private String functionCode;

    /**
     * 任务执行表达式
     */
    @Column(length = 100, nullable = false)
    private String cronExpression;

    /**
     * 执行状态
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private ExecuteStatus executeStatus;

    /**
     * 来源ID
     */
    @Column(length = 32)
    private String sourceId;

    /**
     * 是否循环
     */
    @Column
    private boolean cycle;

    @Transient
    private String msgDetail;

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getFunctionCode() {
        return functionCode;
    }

    public void setFunctionCode(String functionCode) {
        this.functionCode = functionCode;
    }

    public String getCronExpression() {
        return cronExpression;
    }

    public void setCronExpression(String cronExpression) {
        this.cronExpression = cronExpression;
    }

    public ExecuteStatus getExecuteStatus() {
        return executeStatus;
    }

    public void setExecuteStatus(ExecuteStatus executeStatus) {
        this.executeStatus = executeStatus;
    }

    public String getSourceId() {
        return sourceId;
    }

    public void setSourceId(String sourceId) {
        this.sourceId = sourceId;
    }

    public boolean isCycle() {
        return cycle;
    }

    public void setCycle(boolean cycle) {
        this.cycle = cycle;
    }

    public String getMsgDetail() {
        return msgDetail;
    }

    public void setMsgDetail(String msgDetail) {
        this.msgDetail = msgDetail;
    }
}
