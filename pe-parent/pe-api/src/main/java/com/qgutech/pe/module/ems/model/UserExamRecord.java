package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.uc.model.User;

import javax.persistence.*;

/**
 * 学员考试记录表(针对试题统计)
 *
 * @author LiYanCheng@HF
 * @since 2016年12月20日13:40:14
 */
@Entity
@Table(name = "t_ems_user_exam_record", indexes = {
        @Index(name = "i_ems_user_exam_record_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_user_exam_record_itemId", columnList = "item_id"),
        @Index(name = "i_ems_user_exam_record_examId", columnList = "exam_id"),
        @Index(name = "i_ems_user_exam_record_detailId", columnList = "detail_id"),
        @Index(name = "i_ems_user_exam_record_userId", columnList = "user_id")})
public class UserExamRecord extends BaseModel {
    public static final String _user = "user.id";
    public static final String _item = "item.id";
    public static final String _itemAlias = "item";
    public static final String _exam = "exam.id";
    public static final String _paper = "paper.id";
    public static final String _score = "score";
    public static final String _answer = "answer";
    public static final String _sign = "sign";
    public static final String _realScore = "realScore";
    public static final String _examResultDetail = "examResultDetail.id";
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
    private Exam exam;

    /**
     * 考试ID
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
     * 该题满分
     */
    @Column
    private double totalScore;

    /**
     * 学生答案
     */
    @Column
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
    private ExamResultDetail examResultDetail;

    /**
     * 是否评
     */
    @Transient
    private boolean review;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public Exam getExam() {
        return exam;
    }

    public void setExam(Exam exam) {
        this.exam = exam;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
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

    public Paper getPaper() {
        return paper;
    }

    public void setPaper(Paper paper) {
        this.paper = paper;
    }

    public double getRealScore() {
        return realScore;
    }

    public void setRealScore(double realScore) {
        this.realScore = realScore;
    }

    public Integer[] getOptions() {
        return options;
    }

    public void setOptions(Integer[] options) {
        this.options = options;
    }

    public ExamResultDetail getExamResultDetail() {
        return examResultDetail;
    }

    public void setExamResultDetail(ExamResultDetail examResultDetail) {
        this.examResultDetail = examResultDetail;
    }

    public boolean isReview() {
        return review;
    }

    public void setReview(boolean review) {
        this.review = review;
    }

    public double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(double totalScore) {
        this.totalScore = totalScore;
    }
}
