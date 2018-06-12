package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.uc.model.User;

import javax.persistence.*;
import java.util.Date;

/***
 * 模拟考试结果表
 *
 * @author wangxiaolong
 * @since 2017-03-23 17:12:37
 */
@Entity
@Table(name = "t_ems_mock_exam_result", indexes = {
        @Index(name = "i_ems_exam_result_examId", columnList = "exam_id"),
        @Index(name = "i_ems_exam_result_userId", columnList = "user_id"),
        @Index(name = "i_ems_exam_result_paperId", columnList = "paper_id"),
        @Index(name = "i_ems_exam_result_corpCode", columnList = "corpCode")}, uniqueConstraints = {
        @UniqueConstraint(name = "u_ems_exam_result_examUser", columnNames = {"exam_id", "user_id"})
})
public class MockExamResult extends BaseModel {
    public static final String _exam = "exam.id";
    public static final String _examAlias = "exam";
    public static final String _examName = "exam.examName";
    public static final String _user = "user.id";
    public static final String _userName = "user.userName";
    public static final String _userFaceFileId = "user.faceFileId";
    public static final String _userFaceFileName = "user.faceFileName";
    public static final String _userIdCard = "user.idCard";
    public static final String _userAlias = "user";
    public static final String _examCount = "examCount";
    public static final String _totalScore = "totalScore";
    public static final String _score = "score";
    public static final String _paper = "paper.id";
    public static final String _paperContent = "paper.paperContent";
    public static final String _paperMark = "paper.mark";
    public static final String _paperItemCount = "paper.itemCount";
    public static final String _lastResultDetail = "lastResultDetailId";
    public static final String _highestScore = "highestScore";
    public static final String _lowestScore = "lowestScore";
    public static final String _passCount = "passCount";

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
    @JoinColumn(name = "paper_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Paper paper;


    /**
     * 第N次考试，由1开始
     */
    @Column(nullable = false)
    private Integer examCount;

    /**
     * 最高模拟考试成绩
     */
    @Column
    private Double highestScore;
    /**
     * 最低模拟考试成绩
     */
    @Column
    private Double lowestScore;
    /**
     * 通过次数
     */
    @Column
    private Integer passCount;
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
     * 最后一次考试ID
     */
    @Column
    private String lastResultDetailId;


    public Double getAverageScore() {
        return averageScore;
    }

    public void setAverageScore(Double averageScore) {
        this.averageScore = averageScore;
    }

    @Transient
    private Double averageScore;

    @Transient
    private Boolean pass;

    @Transient
    private Integer noPassCount;//未通过次数

    @Transient
    private Double passRate;//通过率

    public Integer getNoPassCount() {
        return noPassCount;
    }

    public void setNoPassCount(Integer noPassCount) {
        this.noPassCount = noPassCount;
    }

    public Double getPassRate() {
        return passRate;
    }

    public void setPassRate(Double passRate) {
        this.passRate = passRate;
    }

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

    public Integer getExamCount() {
        return examCount;
    }

    public void setExamCount(Integer examCount) {
        this.examCount = examCount;
    }

    public Double getHighestScore() {
        return highestScore;
    }

    public void setHighestScore(Double highestScore) {
        this.highestScore = highestScore;
    }

    public Double getLowestScore() {
        return lowestScore;
    }

    public void setLowestScore(Double lowestScore) {
        this.lowestScore = lowestScore;
    }

    public Integer getPassCount() {
        return passCount;
    }

    public void setPassCount(Integer passCount) {
        this.passCount = passCount;
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

    public String getLastResultDetailId() {
        return lastResultDetailId;
    }

    public void setLastResultDetailId(String lastResultDetailId) {
        this.lastResultDetailId = lastResultDetailId;
    }

    public Boolean getPass() {
        return pass;
    }

    public void setPass(Boolean pass) {
        this.pass = pass;
    }
}
