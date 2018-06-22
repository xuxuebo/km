package com.qgutech.km.base.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

/**
 * 智慧云库实体
 *
 * @author zhaowei
 * @since 2018年06月22日
 */

@Entity
@Table(name = "t_km_library", indexes = {@Index(name = "i_km_library_corpCode", columnList = "corpCode")})
public class Library extends BaseModel{

    /**
     * 库名称
     */
    @Column(nullable = false, length = 50)
    private String libraryName;

    /**
     * 文件类型
     */
    @Column(nullable = false, length = 20)
    private String libraryType;

    /**
     * 父库ID
     */
    @Column(nullable = false,  length = 32)
    private String parentId;

    /**
     * 主键路径
     */
    @Column(nullable = false,  length = 32)
    private String idPath;
    /**
     * 排序
     */
    @Column
    private float showOrder;

    public String getLibraryName() {
        return libraryName;
    }

    public void setLibraryName(String libraryName) {
        this.libraryName = libraryName;
    }

    public String getLibraryType() {
        return libraryType;
    }

    public void setLibraryType(String libraryType) {
        this.libraryType = libraryType;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getIdPath() {
        return idPath;
    }

    public void setIdPath(String idPath) {
        this.idPath = idPath;
    }

    public float getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(float showOrder) {
        this.showOrder = showOrder;
    }
}
