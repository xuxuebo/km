package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.module.uc.model.User;

import javax.persistence.*;

/**
 * 模拟考试学员答题记录
 *
 * @author wangxiaolong
 * @since 2017-03-23 17:01:08
 */
@Entity
@Table(name = "t_ems_user_mock_exam_record", indexes = {
        @Index(name = "i_ems_user_exam_record_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_user_exam_record_itemId", columnList = "item_id"),
        @Index(name = "i_ems_user_exam_record_examId", columnList = "exam_id"),
        @Index(name = "i_ems_user_exam_record_detailId", columnList = "detail_id"),
        @Index(name = "i_ems_user_exam_record_userId", columnList = "user_id")})
public class UserMockExamRecord extends BaseModel {
    public static final String _user = "user.id";
    public static final String _item = "item.id";
    public static final String _itemAlias = "item";
    public static final String _exam = "exam.id";
    public static final String _paper = "paper.id";
    public static final String _score = "score";
    public static final String _answer = "answer";
    public static final String _sign = "sign";
    public static final String _realScore = "realScore";
    public static final String _isCorrect = "isCorrect";
    public static final String _mockExamResultDetail = "mockExamResultDetail.id";


    public static final String _totalScore = "totalScore";
    /**
     * 学员ID
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;


    /**
     * 试题ID
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "item_id", nullable = false)
    private Item item;

    /**
     * 考试ID
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exam_id", nullable = false)
    private MockExam exam;

    /**
     * 试卷id
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "paper_id", nullable = false)
    private Paper paper;
    /**
     * 折合后获得分数
     */
    @Column
    private double score;

    /**
     * 获得分数
     */
    @Column
    private double realScore;

    /**
     * 是否正确
     */
    @Column
    private boolean isCorrect;


    /**
     * 该题满分
     */
    @Column
    private double totalScore;

    /**
     * 学生答案
     */
    @Column(length = 1300)
    private String answer;

    /**
     * 是否标记
     */
    @Column
    private boolean sign;

    /**
     * 学员答题
     */
    @Transient
    private Integer[] options;

    /**
     * 考试ID
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "detail_id", nullable = false)
    private MockExamResultDetail mockExamResultDetail;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Item getItem() {
        return item;
    }

    public MockExam getExam() {
        return exam;
    }

    public void setExam(MockExam exam) {
        this.exam = exam;
    }

    public void setItem(Item item) {

        this.item = item;
    }

    public boolean isCorrect() {
        return isCorrect;
    }

    public void setCorrect(boolean correct) {
        isCorrect = correct;
    }
    public Paper getPaper() {
        return paper;
    }

    public void setPaper(Paper paper) {
        this.paper = paper;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public double getRealScore() {
        return realScore;
    }

    public void setRealScore(double realScore) {
        this.realScore = realScore;
    }

    public double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(double totalScore) {
        this.totalScore = totalScore;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public boolean isSign() {
        return sign;
    }

    public void setSign(boolean sign) {
        this.sign = sign;
    }

    public Integer[] getOptions() {
        return options;
    }

    public void setOptions(Integer[] options) {
        this.options = options;
    }

    public MockExamResultDetail getMockExamResultDetail() {
        return mockExamResultDetail;
    }

    public void setMockExamResultDetail(MockExamResultDetail mockExamResultDetail) {
        this.mockExamResultDetail = mockExamResultDetail;
    }

}
