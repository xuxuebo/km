package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.uc.model.User;

import javax.persistence.*;
import java.util.Date;

/***
 * 模拟考试成绩详情表
 *
 * @author wangxiaolong
 * @since 2017年3月23日17:06:15
 */
@Entity
@Table(name = "t_ems_mock_exam_result_detail", indexes = {
        @Index(name = "i_ems_exam_result_detail_examId", columnList = "exam_id"),
        @Index(name = "i_ems_exam_result_detail_userId", columnList = "user_id"),
        @Index(name = "i_ems_exam_result_detail_corpCode", columnList = "corpCode")})
public class MockExamResultDetail extends BaseModel {
    public static final String _exam = "exam.id";
    public static final String _examAlias = "exam";
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
    public static final String _over = "isOver";

    /**
     * 考试（手动补考：被补考考试ID，非手动补考：当前考试ID）
     */
    @JoinColumn(name = "exam_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private MockExam exam;

    /**
     * 人员
     */
    @JoinColumn(name = "user_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    /**
     * 最后一次评卷试卷ID
     */
    @JoinColumn(name = "paper_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private Paper paper;

    /**
     * 最后一次考试的试卷总分
     */
    @Column
    private Double totalScore;
    /**
     * 该场模拟考试是否已经结束
     */
    @Column(name = "is_over")
    private Boolean isOver;

    public Boolean getOver() {
        return isOver;
    }

    public void setOver(Boolean over) {
        isOver = over;
    }

    /**
     * 最后一次考试的考试成绩
     */
    @Column
    private Double score;

    /**
     * 是否通过
     */
    @Column
    private boolean pass;

    @JoinColumn(name = "result_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private MockExamResult examResult;

    public MockExam getExam() {
        return exam;
    }

    public void setExam(MockExam exam) {
        this.exam = exam;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Paper getPaper() {
        return paper;
    }

    public void setPaper(Paper paper) {
        this.paper = paper;
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

    public boolean isPass() {
        return pass;
    }

    public void setPass(boolean pass) {
        this.pass = pass;
    }

    public MockExamResult getExamResult() {
        return examResult;
    }

    public void setExamResult(MockExamResult examResult) {
        this.examResult = examResult;
    }
}
