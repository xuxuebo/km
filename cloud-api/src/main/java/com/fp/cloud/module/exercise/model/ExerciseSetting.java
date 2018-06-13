package com.fp.cloud.module.exercise.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.module.uc.model.User;

import javax.persistence.*;

/**
 * 练习的设置的实体类
 * Created by Administrator on 2017/3/23.
 */
@Entity
@Table(name = "t_ems_exerciseSetting", indexes = {
        @Index(name = "i_ems_exercise_setting_exerciseId", columnList = "exercise_id"),
        @Index(name = "i_ems_exercise_setting_createBy", columnList = "createBy")},
        uniqueConstraints = {@UniqueConstraint(name = "u_ems_exerciseSetting_user",
                columnNames = {"exercise_id", "user_id"})})
public class ExerciseSetting extends BaseModel {
    public static final String _user = "user.id";
    public static final String _exercise = "exercise.id";
    public static final String _speed = "speed";
    public static final String _questionAnswer = "questionAnswer";
    public static final String _speedType = "speedType";
    public static final String _hasSubmit = "hasSubmit";

    public enum ItemNumberType {
        ALL("全部"), PORTION("部分");
        private final String text;

        ItemNumberType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum SpeedType {
        LIMIT("限制"), UNLIMIT("不限制");
        private final String text;

        SpeedType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum QuestionAnswer {
        SHOW("显示答案"), NOSHOW("不显示答案");
        private final String text;

        QuestionAnswer(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    @Column
    private Integer itemNumber;

    @Column
    private Integer speed;

    @Column(name = "speed_type", length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private SpeedType speedType;

    @Column(name = "question_answer", length = 20)
    @Enumerated(EnumType.STRING)
    private QuestionAnswer questionAnswer;

    @Column(name = "item_number_type", length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private ItemNumberType itemNumberType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exercise_id", nullable = false)
    private Exercise exercise;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    /*是否已经交卷了*/
    @Column(name = "has_submit", nullable = false)
    private Boolean hasSubmit;


    public Integer getSpeed() {
        return speed;
    }

    public void setSpeed(Integer speed) {
        this.speed = speed;
    }

    public Integer getItemNumber() {
        return itemNumber;
    }

    public void setItemNumber(Integer itemNumber) {
        this.itemNumber = itemNumber;
    }

    public Exercise getExercise() {
        return exercise;
    }

    public void setExercise(Exercise exercise) {
        this.exercise = exercise;
    }

    public QuestionAnswer getQuestionAnswer() {
        return questionAnswer;
    }

    public void setQuestionAnswer(QuestionAnswer questionAnswer) {
        this.questionAnswer = questionAnswer;
    }

    public SpeedType getSpeedType() {
        return speedType;
    }

    public void setSpeedType(SpeedType speedType) {
        this.speedType = speedType;
    }

    public ItemNumberType getItemNumberType() {
        return itemNumberType;
    }

    public void setItemNumberType(ItemNumberType itemNumberType) {
        this.itemNumberType = itemNumberType;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Boolean getHasSubmit() {
        return hasSubmit;
    }

    public void setHasSubmit(Boolean hasSubmit) {
        this.hasSubmit = hasSubmit;
    }


}
