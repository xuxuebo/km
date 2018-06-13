package com.fp.cloud.base.vo;

import com.fp.cloud.module.ems.model.Item;

import java.util.List;

/**
 * 预览试卷
 */
public class TemplatePreview {

    /**
     * 题目数量
     */
    private Integer itemCount;

    /**
     * 总分
     */
    private Double totalMark;

    /**
     * 试题集合
     */
    private List<Item> items;

    public Integer getItemCount() {
        return itemCount;
    }

    public void setItemCount(Integer itemCount) {
        this.itemCount = itemCount;
    }

    public Double getTotalMark() {
        return totalMark;
    }

    public void setTotalMark(Double totalMark) {
        this.totalMark = totalMark;
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }
}
