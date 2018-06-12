package com.qgutech.pe.module.exercise.vo;

import com.qgutech.pe.module.ems.model.Item;

/**
 * 练习的结果报告
 *
 * @author liuChen
 * @since 2017年4月6日16:14:53
 */
public class ExerciseReport {

    /**
     * 题干
     */
    private String ct;

    /**
     * 题型
     */
    private Item.ItemType itemType;

    /**
     * 答对人次
     */
    private Integer rightCount;
    /**
     * 答错人次
     */
    private Integer wrongCount;
    /**
     * 试题ID
     */
    private String id;

    /**
     * 正确率
     */
    private Double accuracy;

    public String getCt() {
        return ct;
    }

    public void setCt(String ct) {
        this.ct = ct;
    }

    public Double getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(Double accuracy) {
        this.accuracy = accuracy;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getWrongCount() {
        return wrongCount;
    }

    public void setWrongCount(Integer wrongCount) {
        this.wrongCount = wrongCount;
    }

    public Item.ItemType getItemType() {
        return itemType;
    }

    public void setItemType(Item.ItemType itemType) {
        this.itemType = itemType;
    }

    public Integer getRightCount() {
        return rightCount;
    }

    public void setRightCount(Integer rightCount) {
        this.rightCount = rightCount;
    }
}
