package com.qgutech.pe.module.exercise.model;

import com.qgutech.pe.base.model.BaseModel;

import javax.persistence.*;

/**
 * 练习的题库知识点关联表
 */
@Entity
@Table(name = "t_ems_exercise_strategy", indexes = {
        @Index(name = "i_ems_exercise_strategy_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_exercise_strategy_createBy", columnList = "createBy"),
        @Index(name = "i_ems_exercise_strategy_objectId", columnList = "objectId")
}, uniqueConstraints = {@UniqueConstraint(name = "u_ems_exercise_strategy_unique", columnNames = {"objectId", "exerciseId"})})
public class ExerciseStrategy extends BaseModel {
    public static final String _exercise = "exerciseId";
    public static final String _strategyType = "strategyType";
    public static final String _objectId="objectId";

    public enum StrategyType {
        ITEM_BANK("题库"), KNOWLEDGE("知识点");
        private String text;

        StrategyType(String text) {
            this.text = text;
        }

        String getText() {
            return text;
        }
    }

    /**
     * 关联ID
     */
    @Column(nullable = false, length = 32)
    private String objectId;

    /**
     * 模板ID
     */
    @Column(nullable = false, length = 32)
    private String exerciseId;

    /**
     * 类型
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private StrategyType strategyType;

    public String getObjectId() {
        return objectId;
    }

    public void setObjectId(String objectId) {
        this.objectId = objectId;
    }

    public String getExerciseId() {
        return exerciseId;
    }

    public void setExerciseId(String exerciseId) {
        this.exerciseId = exerciseId;
    }

    public StrategyType getStrategyType() {
        return strategyType;
    }

    public void setStrategyType(StrategyType strategyType) {
        this.strategyType = strategyType;
    }
}
