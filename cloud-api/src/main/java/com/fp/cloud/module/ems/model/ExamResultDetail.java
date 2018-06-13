package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.module.uc.model.User;

import javax.persistence.*;
import java.util.Date;
import java.util.Map;

/**
 * 考试成绩详情表
 *
 * @author chenHuaMei@HF 2016年12月1日15:40:12
 */
@Entity
@Table(name = "t_ems_exam_result_detail", indexes = {
        @Index(name = "i_ems_exam_result_detail_examId", columnList = "exam_id"),
        @Index(name = "i_ems_exam_result_detail_userId", columnList = "user_id"),
        @Index(name = "i_ems_exam_result_detail_corpCode", columnList = "corpCode")})
public class ExamResultDetail extends BaseModel {
    public static final String _exam = "exam.id";
    public static final String _examAlias = "exam";
    public static final String _markUpId = "exam.markUpId";
    public static final String _markExam = "markExam.id";
    public static final String _user = "user.id";
    public static final String _userAlias = "user";
    public static final String _judgeFlag = "judgeFlag";
    public static final String _examCount = "examCount";
    public static final String _totalScore = "totalScore";
    public static final String _score = "score";
    public static final String _paper = "paper.id";
    public static final String _paperContent = "paper.paperContent";
    public static final String _paperMark = "paper.mark";
    public static final String _pass = "pass";
    public static final String _examResult = "examResult.id";
    public static final String _startTime = "startTime";
    public static final String _endTime = "endTime";

    /**
     * 补考ID
     */
    @JoinColumn(name = "mark_exam_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Exam markExam;

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
    private ExamResult.JudgeFlag judgeFlag;

    /**
     * 最后一次评卷试卷ID
     */
    @JoinColumn(name = "paper_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private Paper paper;

    /**
     * 第N次考试，由1开始
     */
    @Column(nullable = false)
    private Integer examCount;

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
     * 考试考试时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false, updatable = false)
    private Date startTime;

    /**
     * 考试结束时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false, updatable = false)
    private Date endTime;

    /**
     * 是否通过
     */
    @Column
    private boolean pass;

    @JoinColumn(name = "result_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private ExamResult examResult;

    @Transient
    private Map<String, UserExamRecord> userExamRecordMap;

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

    public ExamResult.JudgeFlag getJudgeFlag() {
        return judgeFlag;
    }

    public void setJudgeFlag(ExamResult.JudgeFlag judgeFlag) {
        this.judgeFlag = judgeFlag;
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

    public Paper getPaper() {
        return paper;
    }

    public void setPaper(Paper paper) {
        this.paper = paper;
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

    public Exam getMarkExam() {
        return markExam;
    }

    public void setMarkExam(Exam markExam) {
        this.markExam = markExam;
    }

    public boolean isPass() {
        return pass;
    }

    public void setPass(boolean pass) {
        this.pass = pass;
    }

    public Map<String, UserExamRecord> getUserExamRecordMap() {
        return userExamRecordMap;
    }

    public void setUserExamRecordMap(Map<String, UserExamRecord> userExamRecordMap) {
        this.userExamRecordMap = userExamRecordMap;
    }

    public ExamResult getExamResult() {
        return examResult;
    }

    public void setExamResult(ExamResult examResult) {
        this.examResult = examResult;
    }
}
