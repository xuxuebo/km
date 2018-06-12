package com.qgutech.pe.base.model;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

/**
 * 层级 类型的domain
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年9月9日08:39:27
 */
@MappedSuperclass
public class BaseLevelModel extends BaseModel {

    public static final String _parentId = "parentId";
    public static final String _showOrder = "showOrder";
    public static final String _idPath = "idPath";

    @Column
    private String parentId;

    @Column(nullable = false)
    private Float showOrder;

    @Column(nullable = false, length = 1300)
    private String idPath;

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public Float getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(Float showOrder) {
        this.showOrder = showOrder;
    }

    public String getIdPath() {
        return idPath;
    }

    public void setIdPath(String idPath) {
        this.idPath = idPath;
    }
}
