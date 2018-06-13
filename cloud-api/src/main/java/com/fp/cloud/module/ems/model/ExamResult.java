package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.module.uc.model.User;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * 考试成绩表
 *
 * @author chenHuaMei@HF 2016年12月1日15:40:12
 */
@Entity
@Table(name = "t_ems_exam_result", indexes = {
        @Index(name = "i_ems_exam_result_examId", columnList = "exam_id"),
        @Index(name = "i_ems_exam_result_userId", columnList = "user_id"),
        @Index(name = "i_ems_exam_result_paperId", columnList = "paper_id"),
        @Index(name = "i_ems_exam_result_lastResultId", columnList = "last_result_id"),
        @Index(name = "i_ems_exam_result_corpCode", columnList = "corpCode")}, uniqueConstraints = {
        @UniqueConstraint(name = "u_ems_exam_result_examUser", columnNames = {"exam_id", "user_id"})
})
public class ExamResult extends BaseModel {
    public static final String _exam = "exam.id";
    public static final String _examAlias = "exam";
    public static final String _examName = "exam.examName";
    public static final String _examType = "exam.examType";
    public static final String _examSubject = "exam.subject";
    public static final String _markUpId = "exam.markUpId";
    public static final String _user = "user.id";
    public static final String _userName = "user.userName";
    public static final String _userFaceFileId = "user.faceFileId";
    public static final String _userFaceFileName = "user.faceFileName";
    public static final String _userIdCard = "user.idCard";
    public static final String _userAlias = "user";
    public static final String _judgeFlag = "judgeFlag";
    public static final String _judgeTime = "judgeTime";
    public static final String _examCount = "examCount";
    public static final String _totalScore = "totalScore";
    public static final String _score = "score";
    public static final String _needMakeUp = "needMakeUp";
    public static final String _status = "status";
    public static final String _pass = "pass";
    public static final String _publishTime = "publishTime";
    public static final String _paper = "paper.id";
    public static final String _paperContent = "paper.paperContent";
    public static final String _paperMark = "paper.mark";
    public static final String _paperItemCount = "paper.itemCount";
    public static final String _lastResultDetail = "lastResultDetail.id";
    public static final String _startTime = "startTime";
    public static final String _endTime = "endTime";
    public static final String _markExam = "markExam.id";
    public static final String _firstScore = "firstScore";
    public static final String _examArrange = "examArrange.id";
    public static final String _examArrangeExam = "examArrange.exam.id";
    public static final String _examArrangeAlias = "examArrange";
    public static final String _examArrangeStatus = "examArrange.status";

    public enum JudgeFlag {
        AUTO("自动评卷"), MANUAL("手动评卷");
        private String text;

        JudgeFlag(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum UserExamStatus {
        NO_START("未开始"),//数据库不记录这种状态
        WAIT_EXAM("待参加"),//数据库不记录这种状态
        PROCESS("考试中"),//数据库不记录这种状态
        ERROR_OUT("异常退出"),//数据库不记录这种状态
        MISS_EXAM("缺考"),//数据库不记录这种状态
        PASS("通过"),//数据库不记录这种状态
        NO_PASS("未通过"),//数据库不记录这种状态
        MARKING("待评卷"),
        RELEASE("已发布"),
        WAIT_RELEASE("待发布成绩"),
        OVER("已结束");//数据库不记录这种状态
        private String text;

        UserExamStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 考试（手动补考：被补考考试ID，非手动补考：当前考试ID）
     */
    @JoinColumn(name = "exam_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private Exam exam;

    /**
     * 人员
     */
    @JoinColumn(name = "user_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    /**
     * 最后一次考试的评卷标志
     */
    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private JudgeFlag judgeFlag;

    /**
     * 安排ID
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "arrange_id")
    private ExamArrange examArrange;

    /**
     * 最后一次评卷试卷ID
     */
    @JoinColumn(name = "paper_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Paper paper;

    /**
     * 最后一次考试的评卷时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "judge_time")
    private Date judgeTime;

    /**
     * 第N次考试，由1开始
     */
    @Column(nullable = false)
    private Integer examCount;

    /**
     * 第一次考试成绩
     */
    @Column
    private Double firstScore;

    /**
     * 最后一次考试的试卷总分
     */
    @Column
    private Double totalScore;

    /**
     * 最后一次考试的考试成绩
     */
    @Column
    private Double score;

    /**
     * 是否需要补考:学员交卷，后台评卷 直接给出，主要针对补考类考试
     */
    @Column
    private boolean needMakeUp;

    /**
     * 是否通过
     */
    @Column
    private boolean pass;

    /**
     * 学员考试状态
     */
    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private UserExamStatus status;

    /**
     * 发布成绩时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column
    private Date publishTime;

    /**
     * 考试考试时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(updatable = false)
    private Date startTime;

    /**
     * 考试结束时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(updatable = false)
    private Date endTime;

    /**
     * 最后一次考试ID
     */
    @JoinColumn(name = "last_result_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private ExamResultDetail lastResultDetail;

    /**
     * 最后一次手动补考ID
     */
    @JoinColumn(name = "mark_exam_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Exam markExam;

    /**
     * 通过
     */
    @Transient
    private List<Boolean> passStatus;

    @Transient
    private List<UserExamRecord> userExamRecords;

    /**
     * 是否复评
     */
    @Transient
    private boolean review;

    @Transient
    private String markUpExamId;

    @Transient
    private List<ExamResult.UserExamStatus> examStatuses;

    /**
     * 当前排行
     */
    @Transient
    private Long rankCount;

    /**
     * 参考人数
     */
    @Transient
    private Long attentCount;

    /**
     * 该人员最高分
     */
    @Transient
    private Double highScore;

    public Double getHighScore() {
        return highScore;
    }

    public void setHighScore(Double highScore) {
        this.highScore = highScore;
    }

    public Exam getExam() {
        return exam;
    }

    public void setExam(Exam exam) {
        this.exam = exam;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public JudgeFlag getJudgeFlag() {
        return judgeFlag;
    }

    public void setJudgeFlag(JudgeFlag judgeFlag) {
        this.judgeFlag = judgeFlag;
    }

    public Date getJudgeTime() {
        return judgeTime;
    }

    public void setJudgeTime(Date judgeTime) {
        this.judgeTime = judgeTime;
    }

    public Integer getExamCount() {
        return examCount;
    }

    public void setExamCount(Integer examCount) {
        this.examCount = examCount;
    }

    public Double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Double totalScore) {
        this.totalScore = totalScore;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public boolean isNeedMakeUp() {
        return needMakeUp;
    }

    public void setNeedMakeUp(boolean needMakeUp) {
        this.needMakeUp = needMakeUp;
    }

    public UserExamStatus getStatus() {
        return status;
    }

    public void setStatus(UserExamStatus status) {
        this.status = status;
    }

    public List<UserExamRecord> getUserExamRecords() {
        return userExamRecords;
    }

    public void setUserExamRecords(List<UserExamRecord> userExamRecords) {
        this.userExamRecords = userExamRecords;
    }

    public boolean isPass() {
        return pass;
    }

    public void setPass(boolean pass) {
        this.pass = pass;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public List<Boolean> getPassStatus() {
        return passStatus;
    }

    public void setPassStatus(List<Boolean> passStatus) {
        this.passStatus = passStatus;
    }

    public Paper getPaper() {
        return paper;
    }

    public void setPaper(Paper paper) {
        this.paper = paper;
    }

    public boolean isReview() {
        return review;
    }

    public void setReview(boolean review) {
        this.review = review;
    }

    public Double getFirstScore() {
        return firstScore;
    }

    public void setFirstScore(Double firstScore) {
        this.firstScore = firstScore;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public ExamResultDetail getLastResultDetail() {
        return lastResultDetail;
    }

    public void setLastResultDetail(ExamResultDetail lastResultDetail) {
        this.lastResultDetail = lastResultDetail;
    }

    public String getMarkUpExamId() {
        return markUpExamId;
    }

    public void setMarkUpExamId(String markUpExamId) {
        this.markUpExamId = markUpExamId;
    }

    public Exam getMarkExam() {
        return markExam;
    }

    public void setMarkExam(Exam markExam) {
        this.markExam = markExam;
    }

    public ExamArrange getExamArrange() {
        return examArrange;
    }

    public void setExamArrange(ExamArrange examArrange) {
        this.examArrange = examArrange;
    }

    public List<UserExamStatus> getExamStatuses() {
        return examStatuses;
    }

    public void setExamStatuses(List<UserExamStatus> examStatuses) {
        this.examStatuses = examStatuses;
    }

    public Long getRankCount() {
        return rankCount;
    }

    public void setRankCount(Long rankCount) {
        this.rankCount = rankCount;
    }

    public Long getAttentCount() {
        return attentCount;
    }

    public void setAttentCount(Long attentCount) {
        this.attentCount = attentCount;
    }
}
