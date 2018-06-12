package com.qgutech.pe.module.exercise.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.ems.model.Item;
import com.qgutech.pe.module.uc.model.User;

import javax.persistence.*;

/**
 * 练习与试题的关联表
 */
@Entity
@Table(name = "t_ems_exercise_item", indexes = {
        @Index(name = "i_ems_exercise_item_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_exercise_item_itemId", columnList = "item_id")},
        uniqueConstraints = {@UniqueConstraint(name = "u_ems_exercise_item",
                columnNames = {"exercise_id", "item_id"})})
public class ExerciseItem extends BaseModel {
    public static final String _exercise = "exercise.id";
    public static final String _itemAlias = "item";
    public static final String _user = "user.id";
    public static final String _showOrder = "showOrder";
    public static final String _item = "item.id";
    /**
     * 练习信息
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exercise_id", nullable = false)
    private Exercise exercise;

    /**
     * 试题信息
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "item_id", nullable = false)
    private Item item;

    /*
    * */

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    /**
     * 试题排序
     */
    @Column(nullable = false)
    private Integer showOrder;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Exercise getExercise() {
        return exercise;
    }

    public void setExercise(Exercise exercise) {
        this.exercise = exercise;
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
