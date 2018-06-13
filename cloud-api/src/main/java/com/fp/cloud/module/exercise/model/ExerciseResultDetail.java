package com.fp.cloud.module.exercise.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.module.uc.model.User;

import javax.persistence.*;

/**
 * 练习成绩详情表
 *
 * @since liuChen 2017年3月31日17:10:45
 */
@Entity
@Table(name = "t_ems_exercise_result_detail", indexes = {
        @Index(name = "i_ems_exercise_result_detail_exerciseId", columnList = "exercise_id"),
        @Index(name = "i_ems_exercise_result_detail_userId", columnList = "user_id"),
        @Index(name = "i_ems_exercise_result_detail_settingId", columnList = "setting_id"),
        @Index(name = "i_ems_exercise_result_detail_corpCode", columnList = "corpCode")})
public class ExerciseResultDetail extends BaseModel {
    public static final String _exercise = "exercise.id";
    public static final String _user = "user.id";
    public static final String _setting = "exerciseSetting.id";
    public static final String _accuracy = "accuracy";
    public static final String _completionRate = "completionRate";

    @JoinColumn(name = "exercise_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private Exercise exercise;

    @JoinColumn(name = "user_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    @JoinColumn(name = "setting_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private ExerciseSetting exerciseSetting;

    @Column(nullable = false)
    private Double accuracy;

    @Column(name = "completion_rate", nullable = false)
    private Double completionRate;

    /*@Column(name="exercise_count",nullable = false)
        private Integer exerciseCount;
    */
    @Transient
    private String itemId;
    @Transient
    private Integer showOrder;

    public Integer getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(Integer showOrder) {
        this.showOrder = showOrder;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Double getCompletionRate() {
        return completionRate;
    }

    public void setCompletionRate(Double completionRate) {
        this.completionRate = completionRate;
    }

    public Double getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(Double accuracy) {
        this.accuracy = accuracy;
    }

    public ExerciseSetting getExerciseSetting() {
        return exerciseSetting;
    }

    public void setExerciseSetting(ExerciseSetting exerciseSetting) {
        this.exerciseSetting = exerciseSetting;
    }

    public Exercise getExercise() {
        return exercise;
    }

    public void setExercise(Exercise exercise) {
        this.exercise = exercise;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }


}
