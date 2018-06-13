package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.BaseModel;

import javax.persistence.*;

/**
 * 模板和固定试卷中的固定试题关联信息
 *
 * @author Created by zhangyang on 2016/10/19.
 */
@Entity
@Table(name = "t_ems_paper_template_item", indexes = {
        @Index(name = "i_ems_paper_template_item_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_paper_template_item_itemID", columnList = "item_id")},
        uniqueConstraints = {@UniqueConstraint(name = "u_ems_paper_template_item",
                columnNames = {"template_id", "item_id"})})
public class PaperTemplateItem extends BaseModel {
    public static final String _paperTemplate = "paperTemplate.id";
    public static final String _item = "item.id";
    public static final String _itemType = "item.type";
    public static final String _itemStatus = "item.status";
    public static final String _itemStemOutline = "item.stemOutline";
    public static final String _itemLevel = "item.level";
    public static final String _itemMark = "item.mark";
    public static final String _showOrder = "showOrder";
    //配置表别名
    public static final String _itemAlias = "item";

    /**
     * 模板信息
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "template_id", nullable = false)
    private PaperTemplate paperTemplate;

    /**
     * 试题信息
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "item_id", nullable = false)
    private Item item;

    /**
     * 试题排序
     */
    @Column(nullable = false)
    private double showOrder;

    /****************************************************
     * 非持久化字段                  *
     ****************************************************/

    public PaperTemplate getPaperTemplate() {
        return paperTemplate;
    }

    public void setPaperTemplate(PaperTemplate paperTemplate) {
        this.paperTemplate = paperTemplate;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public double getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(double showOrder) {
        this.showOrder = showOrder;
    }
}
