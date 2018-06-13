package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.module.uc.model.User;

import javax.persistence.*;


@Entity
@Table(name = "t_ems_exam_illegal_record", indexes = {
        @Index(name = "i_ems_exam_illegal_record_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_exam_illegal_record_monitorId", columnList = "monitor_id"),
        @Index(name = "i_ems_exam_illegal_record_processUserId", columnList = "process_user_id")
})
public class IllegalRecord extends BaseModel {

    public static final String _illegalType = "illegalType";
    public static final String _illegalContent = "illegalContent";
    public static final String _processUser = "processUser.id";
    public static final String _examMonitor = "examMonitor.id";

    /**
     * 试题类型
     */
    public enum IllegalType {
        STATUS("状态异常"), IDENTITY("身份异常"), OTHER("其他");
        private final String text;

        IllegalType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 违规类型
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private IllegalType illegalType;

    /**
     * 违规内容
     */
    @Column(length = 500)
    private String illegalContent;

    /**
     * 处理人
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "process_user_id", nullable = false)
    private User processUser;

    /**
     * 监控
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "monitor_id", nullable = false)
    private ExamMonitor examMonitor;

    public IllegalType getIllegalType() {
        return illegalType;
    }

    public void setIllegalType(IllegalType illegalType) {
        this.illegalType = illegalType;
    }

    public String getIllegalContent() {
        return illegalContent;
    }

    public void setIllegalContent(String illegalContent) {
        this.illegalContent = illegalContent;
    }

    public User getProcessUser() {
        return processUser;
    }

    public void setProcessUser(User processUser) {
        this.processUser = processUser;
    }

    public ExamMonitor getExamMonitor() {
        return examMonitor;
    }

    public void setExamMonitor(ExamMonitor examMonitor) {
        this.examMonitor = examMonitor;
    }
}
