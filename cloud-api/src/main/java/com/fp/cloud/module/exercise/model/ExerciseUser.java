package com.fp.cloud.module.exercise.model;

import com.fp.cloud.base.model.BaseModel;

import javax.persistence.*;

/**
 * 练习人员关联试题
 *
 * @author liuChen
 * @since 2017年3月20日11:14:59
 */
@Entity
@Table(name = "t_ems_exercise_user", indexes = {
        @Index(name = "i_ems_exercise_user_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_exercise_user_exerciseId", columnList = "exercise_id")
})
public class ExerciseUser extends BaseModel {
    public static final  String _exercise="exercise.id";
    public static final String _referType = "referType";
    public static final String _referId = "referId";


    public enum ExerciseUserType {
        USER("用户"), ORGANIZE("组织"), POSITION("岗位");
        private final String text;

        ExerciseUserType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 练习ID
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exercise_id", nullable = false)
    private Exercise exercise;
    /*
    *关联的类型
    */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private ExerciseUserType referType;

    /**
     * 关联的类型的Id
     */
    @Column(length = 50, nullable = false)
    private String referId;

    public String getReferId() {
        return referId;
    }

    public void setReferId(String referId) {
        this.referId = referId;
    }

    public ExerciseUserType getReferType() {
        return referType;
    }

    public void setReferType(ExerciseUserType referType) {
        this.referType = referType;
    }

    public Exercise getExercise() {
        return exercise;
    }

    public void setExercise(Exercise exercise) {
        this.exercise = exercise;
    }


}
