package com.fp.cloud.module.exercise.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.module.ems.model.Item;
import com.fp.cloud.module.uc.model.User;

import javax.persistence.*;

/**
 * 学员练习记录表
 */
@Entity
@Table(name = "t_ems_user_exercise_record", indexes = {
        @Index(name = "i_ems_user_exercise_record_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_user_exercise_record_itemId", columnList = "item_id"),
        @Index(name = "i_ems_user_exercise_record_exerciseId", columnList = "exercise_id"),
        @Index(name = "i_ems_user_exercise_record_settingId", columnList = "setting_id"),
        @Index(name = "i_ems_user_exercise_record_userId", columnList = "user_id")
})
public class UserExerciseRecord extends BaseModel {
    public static final String _user = "user.id";
    public static final String _exercise = "exercise.id";
    public static final String _item = "item.id";
    public static final String _setting = "exerciseSetting.id";
    public static final String _answer = "answer";
    public static final String _sign = "sign";
    public static final String _correct = "correct";
    public static final String _score = "score";
    public static final String _totalScore = "totalScore";

    @JoinColumn(name = "exercise_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private Exercise exercise;

    @JoinColumn(name = "user_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    @JoinColumn(name = "setting_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private ExerciseSetting exerciseSetting;

    @JoinColumn(name = "item_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private Item item;

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
     * 是否正确
     */
    @Column
    private boolean correct;

    @Column
    private double score;

    /**
     * 该题满分
     */
    @Column(name = "total_score", nullable = false)
    private double totalScore;

    @Transient
    private Integer showOrder;


    public Exercise getExercise() {
        return exercise;
    }

    public void setExercise(Exercise exercise) {
        this.exercise = exercise;
    }

    public double getScore() {
        return score;
    }

    public double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(double totalScore) {
        this.totalScore = totalScore;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public ExerciseSetting getExerciseSetting() {
        return exerciseSetting;
    }

    public void setExerciseSetting(ExerciseSetting exerciseSetting) {
        this.exerciseSetting = exerciseSetting;
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

    public boolean isCorrect() {
        return correct;
    }

    public void setCorrect(boolean correct) {
        this.correct = correct;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public Integer getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(Integer showOrder) {
        this.showOrder = showOrder;
    }

}
