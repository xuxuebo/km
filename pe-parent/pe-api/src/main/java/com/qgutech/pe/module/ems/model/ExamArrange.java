package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.ems.vo.Ess;
import com.qgutech.pe.module.uc.model.User;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 考试安排，针对批次和科目设置
 *
 * @author Created by zhangyang on 2016/11/14.
 */
@Entity
@Table(name = "t_ems_exam_arrange", indexes = {
        @Index(name = "i_ems_exam_arrange_examId", columnList = "exam_id"),
        @Index(name = "i_ems_exam_arrange_createBy", columnList = "createBy"),
        @Index(name = "i_ems_exam_arrange_corpCode", columnList = "corpCode")
})
public class ExamArrange extends BaseModel {
    public static final String _batchName = "batchName";
    public static final String _startTime = "startTime";
    public static final String _endTime = "endTime";
    public static final String _exam = "exam.id";
    public static final String _examEnableTicket = "exam.enableTicket";
    public static final String _examAlias = "exam";
    public static final String _examStatus = "exam.status";
    public static final String _examStartTime = "exam.startTime";
    public static final String _examType = "exam.examType";
    public static final String _examMarkUpId = "exam.markUpId";
    public static final String _examName = "exam.examName";
    public static final String _examEndTime = "exam.endTime";
    public static final String _examAuthAlias = "examAuths";
    public static final String _showOrder = "showOrder";
    public static final String _subject = "subject.id";
    public static final String _subjectName = "subject.examName";
    public static final String _subjectType = "subject.examType";
    public static final String _status = "status";
    public static final String _subjectSetting = "subjectSetting";
    public static final String _markUpType = "markUpType";
    public static final String _enableTicket = "exam.enableTicket";

    public enum MarkUpType {

        NO_PASS("未通过"),
        MISS_EXAM("缺考");
        private String text;

        MarkUpType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 批次名称
     */
    @Column(length = 50)
    private String batchName;

    /**
     * 开始时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "start_time")
    private Date startTime;

    /**
     * 结束时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "end_time")
    private Date endTime;

    /**
     * 考试关联
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exam_id", nullable = false)
    private Exam exam;

    /**
     * 考试关联科目
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "subject_id")
    private Exam subject;

    /**
     * 排序
     */
    @Column(nullable = false)
    private Float showOrder;

    /**
     * 考试科目设置
     */
    @Type(type = "com.qgutech.pe.utils.JsonType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "com.qgutech.pe.module.ems.vo.Ess")})
    @Column(name = "exam_subject_setting")
    private Ess subjectSetting;

    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private Exam.ExamStatus status;

    /**
     * 补考对象类型
     */
    @Column(length = 50)
    private String markUpType;

    /***************************************************
     * 非持久化字段                     *
     ***************************************************/

    /**
     * 关联id集合
     */
    @Transient
    private List<String> referIds;

    /**
     * 考试安排的状态
     */
    @Transient
    private Exam.ExamStatus arrangeStatus;

    @Transient
    private Map<String, Long> typeCountMap;

    @Transient
    private String startTimeStr;

    @Transient
    private String endTimeStr;

    @Transient
    private List<String> markUpTypes;

    /**
     * 应考人员
     */
    @Transient
    private long testCount;

    /**
     * 通过人员
     */
    @Transient
    private long passCount;


    /**
     * 未通过人员
     */
    @Transient
    private long noPassCount;

    /**
     * 缺考人员
     */
    @Transient
    private long missCount;

    /**
     * 补考次数
     */
    @Transient
    private long examCount;

    /**
     * 批次考试考场图片展示
     */
    @Transient
    private String arrangeImgUrl;

    /**
     * 评卷中的数量
     */
    @Transient
    private long markingCount;


    @Transient
    private Map<String, Long> scoreUserMap;

    /**
     * 参加考试的人数
     */
    @Transient
    private long joinedCount;

    /**
     * 交卷数量
     */
    @Transient
    private long submitCount;

    /**
     * 考场图片路径
     */
    @Transient
    private String classImgPath;

    /**
     * 监考员ID集合
     */
    @Transient
    private List<String> monitorUserIds;

    /**
     * 监控人员集合
     */
    @Transient
    private List<User> monitorUsers;

    /**
     * 是否可以监控
     */
    @Transient
    private boolean canMonitor;

    public String getArrangeImgUrl() {
        return arrangeImgUrl;
    }

    public void setArrangeImgUrl(String arrangeImgUrl) {
        this.arrangeImgUrl = arrangeImgUrl;
    }

    public long getJoinedCount() {
        return joinedCount;
    }

    public void setJoinedCount(long joinedCount) {
        this.joinedCount = joinedCount;
    }

    public Float getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(Float showOrder) {
        this.showOrder = showOrder;
    }

    public String getBatchName() {
        return batchName;
    }

    public void setBatchName(String batchName) {
        this.batchName = batchName;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Exam getExam() {
        return exam;
    }

    public void setExam(Exam exam) {
        this.exam = exam;
    }

    public Ess getSubjectSetting() {
        return subjectSetting;
    }

    public void setSubjectSetting(Ess subjectSetting) {
        this.subjectSetting = subjectSetting;
    }

    public List<String> getReferIds() {
        return referIds;
    }

    public void setReferIds(List<String> referIds) {
        this.referIds = referIds;
    }

    public Exam getSubject() {
        return subject;
    }

    public void setSubject(Exam subject) {
        this.subject = subject;
    }

    public Exam.ExamStatus getStatus() {
        return status;
    }

    public void setStatus(Exam.ExamStatus status) {
        this.status = status;
    }

    public Exam.ExamStatus getArrangeStatus() {
        return arrangeStatus;
    }

    public void setArrangeStatus(Exam.ExamStatus arrangeStatus) {
        this.arrangeStatus = arrangeStatus;
    }

    public Map<String, Long> getTypeCountMap() {
        return typeCountMap;
    }

    public void setTypeCountMap(Map<String, Long> typeCountMap) {
        this.typeCountMap = typeCountMap;
    }

    public String getStartTimeStr() {
        return startTimeStr;
    }

    public void setStartTimeStr(String startTimeStr) {
        this.startTimeStr = startTimeStr;
    }

    public String getEndTimeStr() {
        return endTimeStr;
    }

    public void setEndTimeStr(String endTimeStr) {
        this.endTimeStr = endTimeStr;
    }

    public String getMarkUpType() {
        return markUpType;
    }

    public void setMarkUpType(String markUpType) {
        this.markUpType = markUpType;
    }

    public List<String> getMarkUpTypes() {
        return markUpTypes;
    }

    public void setMarkUpTypes(List<String> markUpTypes) {
        this.markUpTypes = markUpTypes;
    }

    public long getExamCount() {
        return examCount;
    }

    public void setExamCount(long examCount) {
        this.examCount = examCount;
    }

    public long getMissCount() {
        return missCount;
    }

    public void setMissCount(long missCount) {
        this.missCount = missCount;
    }

    public long getNoPassCount() {
        return noPassCount;
    }

    public void setNoPassCount(long noPassCount) {
        this.noPassCount = noPassCount;
    }

    public long getPassCount() {
        return passCount;
    }

    public void setPassCount(long passCount) {
        this.passCount = passCount;
    }

    public long getTestCount() {
        return testCount;
    }

    public void setTestCount(long testCount) {
        this.testCount = testCount;
    }

    public long getMarkingCount() {
        return markingCount;
    }

    public void setMarkingCount(long markingCount) {
        this.markingCount = markingCount;
    }

    public Map<String, Long> getScoreUserMap() {
        return scoreUserMap;
    }

    public void setScoreUserMap(Map<String, Long> scoreUserMap) {
        this.scoreUserMap = scoreUserMap;
    }

    public String getClassImgPath() {
        return classImgPath;
    }

    public void setClassImgPath(String classImgPath) {
        this.classImgPath = classImgPath;
    }

    public List<String> getMonitorUserIds() {
        return monitorUserIds;
    }

    public void setMonitorUserIds(List<String> monitorUserIds) {
        this.monitorUserIds = monitorUserIds;
    }

    public List<User> getMonitorUsers() {
        return monitorUsers;
    }

    public void setMonitorUsers(List<User> monitorUsers) {
        this.monitorUsers = monitorUsers;
    }

    public boolean isCanMonitor() {
        return canMonitor;
    }

    public void setCanMonitor(boolean canMonitor) {
        this.canMonitor = canMonitor;
    }

    public long getSubmitCount() {
        return submitCount;
    }

    public void setSubmitCount(long submitCount) {
        this.submitCount = submitCount;
    }
}
