package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.ems.vo.Em;
import com.qgutech.pe.module.ems.vo.Ug;
import com.qgutech.pe.module.uc.model.User;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * 下发监控记录表
 *
 * @author LiYanCheng@HF
 * @since 2016年12月21日10:50:08
 */
@Entity
@Table(name = "t_ems_exam_monitor", indexes = {
        @Index(name = "i_ems_exam_monitor_examId", columnList = "exam_id"),
        @Index(name = "i_ems_exam_monitor_corpCode", columnList = "corpCode")},
        uniqueConstraints = {
                @UniqueConstraint(name = "u_ems_exam_monitor", columnNames = {"user_id", "exam_id"})
        })
public class ExamMonitor extends BaseModel {

    public static final String _exam = "exam.id";
    public static final String _examName = "exam.examName";
    public static final String _examStatus = "exam.status";
    public static final String _examType = "exam.examType";
    public static final String _markUpExam = "exam.markUpId";
    public static final String _examAlias = "exam";
    public static final String _user = "user.id";
    public static final String _userName = "user.userName";
    public static final String _userLoginName = "user.loginName";
    public static final String _userMobile = "user.mobile";
    public static final String _userEmail = "user.email";
    public static final String _userAlias = "user";
    public static final String _examArrange = "examArrange.id";
    public static final String _examArrangeExam = "examArrange.exam";
    public static final String _examArrangeStatus = "examArrange.status";
    public static final String _examArrangeAlias = "examArrange";
    public static final String _examArrangeSubjectSetting = "examArrange.subjectSetting";
    public static final String _examStartTime = "examStartTime";
    public static final String _examEndTime = "examEndTime";
    public static final String _submitTime = "submitTime";
    public static final String _examTime = "examTime";
    public static final String _forceSubmit = "forceSubmit";
    public static final String _illegalCount = "illegalCount";
    public static final String _cutScreenCount = "cutScreenCount";
    public static final String examCode = "exam.examCode";
    public static final String _examCreateBy = "exam.createBy";
    public static final String _duration = "duration";
    public static final String _exitTimes = "exitTimes";
    public static final String _ugs = "ugs";
    public static final String _answerStatus = "answerStatus";
    public static final String _images = "images";
    public static final String _ticket = "ticket";

    /**
     * 学员状态
     */
    public enum AnswerStatus {
        NO_ANSWER("未作答"), ANSWERING("正在作答"), SUBMIT_EXAM("已交卷");
        private final String text;

        AnswerStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 学员状态
     */
    public enum AttendStatus {
        ATTEND("参考"), NO_ATTEND("未参加");
        private final String text;

        AttendStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 学员ID
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    /**
     * 安排ID
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "arrange_id")
    private ExamArrange examArrange;

    /**
     * 考试ID
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exam_id", nullable = false)
    private Exam exam;

    /**
     * 考试开始时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false)
    private Date examStartTime;

    /**
     * 考试结束时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false)
    private Date examEndTime;

    /**
     * 考试时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column
    private Date examTime;

    /**
     * 提交试卷时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column
    private Date submitTime;

    /**
     * 考试时长(精确到秒)
     */
    @Column
    private Long duration;

    /**
     * 是否强制交卷
     */
    @Column
    private boolean forceSubmit;

    /**
     * 违纪次数
     */
    @Column
    private int illegalCount;

    /**
     * 异常退出次数
     */
    @Column
    private int exitTimes;

    /**
     * 切屏次数
     */
    @Column
    private int cutScreenCount;

    /**
     * 答题状态
     */
    @Column
    @Enumerated(EnumType.STRING)
    private AnswerStatus answerStatus;

    @Type(type = "com.qgutech.pe.utils.JsonType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "com.qgutech.pe.module.ems.vo.Ug"),
            @org.hibernate.annotations.Parameter(name = "isArray", value = "true")})
    @Column(name = "exam_record")
    private List<Ug> ugs;

    /**
     * 考试监控照片拍照
     */
    @Type(type = "com.qgutech.pe.utils.JsonType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "com.qgutech.pe.module.ems.vo.Em"),
            @org.hibernate.annotations.Parameter(name = "isArray", value = "true")})
    @Column(name = "exam_image")
    private List<Em> images;

    /**
     * 准考证号
     */
    @Column(length = 20)
    private String ticket;


    @Transient
    private ExamResult.UserExamStatus examStatus;

    /**
     * 应该参加考试的人数
     */
    @Transient
    private Integer joinNums;

    /**
     * 实际参加考试的人数
     */
    @Transient
    private Integer joinedNums;

    /**
     * 状态
     */
    @Transient
    private List<AnswerStatus> answerStatuses;

    /**
     * 是否参加考试
     */
    @Transient
    private List<AttendStatus> attendStatuses;

    public Integer getJoinNums() {
        return joinNums;
    }

    public void setJoinNums(Integer joinNums) {
        this.joinNums = joinNums;
    }

    public Integer getJoinedNums() {
        return joinedNums;
    }

    public void setJoinedNums(Integer joinedNums) {
        this.joinedNums = joinedNums;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Exam getExam() {
        return exam;
    }

    public void setExam(Exam exam) {
        this.exam = exam;
    }

    public Date getExamTime() {
        return examTime;
    }

    public void setExamTime(Date examTime) {
        this.examTime = examTime;
    }

    public Date getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
    }

    public boolean isForceSubmit() {
        return forceSubmit;
    }

    public void setForceSubmit(boolean forceSubmit) {
        this.forceSubmit = forceSubmit;
    }

    public int getIllegalCount() {
        return illegalCount;
    }

    public void setIllegalCount(int illegalCount) {
        this.illegalCount = illegalCount;
    }

    public int getCutScreenCount() {
        return cutScreenCount;
    }

    public void setCutScreenCount(int cutScreenCount) {
        this.cutScreenCount = cutScreenCount;
    }

    public Date getExamStartTime() {
        return examStartTime;
    }

    public void setExamStartTime(Date examStartTime) {
        this.examStartTime = examStartTime;
    }

    public Date getExamEndTime() {
        return examEndTime;
    }

    public void setExamEndTime(Date examEndTime) {
        this.examEndTime = examEndTime;
    }

    public ExamArrange getExamArrange() {
        return examArrange;
    }

    public void setExamArrange(ExamArrange examArrange) {
        this.examArrange = examArrange;
    }

    public ExamResult.UserExamStatus getExamStatus() {
        return examStatus;
    }

    public void setExamStatus(ExamResult.UserExamStatus examStatus) {
        this.examStatus = examStatus;
    }

    public Long getDuration() {
        return duration;
    }

    public void setDuration(Long duration) {
        this.duration = duration;
    }

    public int getExitTimes() {
        return exitTimes;
    }

    public void setExitTimes(int exitTimes) {
        this.exitTimes = exitTimes;
    }

    public List<Ug> getUgs() {
        return ugs;
    }

    public void setUgs(List<Ug> ugs) {
        this.ugs = ugs;
    }

    public List<AnswerStatus> getAnswerStatuses() {
        return answerStatuses;
    }

    public void setAnswerStatuses(List<AnswerStatus> answerStatuses) {
        this.answerStatuses = answerStatuses;
    }

    public AnswerStatus getAnswerStatus() {
        return answerStatus;
    }

    public void setAnswerStatus(AnswerStatus answerStatus) {
        this.answerStatus = answerStatus;
    }

    public List<AttendStatus> getAttendStatuses() {
        return attendStatuses;
    }

    public void setAttendStatuses(List<AttendStatus> attendStatuses) {
        this.attendStatuses = attendStatuses;
    }

    public List<Em> getImages() {
        return images;
    }

    public void setImages(List<Em> images) {
        this.images = images;
    }

    public String getTicket() {
        return ticket;
    }

    public void setTicket(String ticket) {
        this.ticket = ticket;
    }
}
