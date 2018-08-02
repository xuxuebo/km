package com.qgutech.km.module.km.model;

import com.qgutech.km.base.model.BaseModel;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

/**
 * 智慧云标签实体
 *
 * @author zhaowei
 * @since 2018年06月22日
 */

@Entity
@Table(name = "t_km_label", indexes = {@Index(name = "i_km_label", columnList = "corpCode")})
public class Label extends BaseModel {

    public static String PARENT_ID = "parentId";

    public static String LABEL_NAME = "labelName";

    public static String SHOW_ORDER = "showOrder";

    /**
     * 父类主键
     */
    @Column(length = 32)
    private String parentId;

    /**
     * 标签名称
     */
    @Column(nullable = false, length = 50)
    private String labelName;

    /**
     * 排序
     */
    @Column
    private float showOrder;

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getLabelName() {
        return labelName;
    }

    public void setLabelName(String labelName) {
        this.labelName = labelName;
    }

    public float getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(float showOrder) {
        this.showOrder = showOrder;
    }
}
