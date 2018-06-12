package com.qgutech.pe.base.model;

import javax.persistence.*;

/**
 * Category domain
 *
 * @author LiYanCheng@HF
 * @since 2016年9月12日10:21:11
 */
@Entity
@Table(name = "t_pe_category", indexes = {
        @Index(name = "i_pe_category_corpCode", columnList = "corpCode"),
        @Index(name = "i_pe_category_parentId", columnList = "parentId")})
public class Category extends BaseLevelModel {

    public static final String _categoryType = "categoryType";
    public static final String _categoryName = "categoryName";
    public static final String _categoryStatus = "categoryStatus";
    public static final String _isDefault = "isDefault";

    /**
     * 类别类型
     */
    public enum CategoryEnumType {
        POSITION("岗位"), ITEM_BANK("题库"), KNOWLEDGE("知识点"), PAPER("试卷");

        private final String text;

        private CategoryEnumType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum CategoryStatus {
        ENABLE("启用"), DELETE("彻底删除");

        private final String text;

        private CategoryStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 分类类型
     */
    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private CategoryEnumType categoryType;

    /**
     * 分类名称
     */
    @Column(nullable = false, length = 50)
    private String categoryName;

    /**
     * 类别状态
     */
    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private CategoryStatus categoryStatus;

    /**
     * 是否是默认值
     */
    @Column
    private boolean isDefault;

    @Transient
    private boolean include = false;


    @Transient
    private String namePath;

    public CategoryEnumType getCategoryType() {
        return categoryType;
    }

    public void setCategoryType(CategoryEnumType categoryType) {
        this.categoryType = categoryType;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public boolean isInclude() {
        return include;
    }

    public void setInclude(boolean include) {
        this.include = include;
    }

    public CategoryStatus getCategoryStatus() {
        return categoryStatus;
    }

    public void setCategoryStatus(CategoryStatus categoryStatus) {
        this.categoryStatus = categoryStatus;
    }

    public boolean isDefault() {
        return isDefault;
    }

    public void setDefault(boolean aDefault) {
        isDefault = aDefault;
    }


    public String getNamePath() {
        return namePath;
    }

    public void setNamePath(String namePath) {
        this.namePath = namePath;
    }
}
