package com.qgutech.pe.module.uc.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.base.model.Category;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

/**
 * position domain
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年9月12日10:29:32
 */
@Entity
@Table(name = "t_uc_position", indexes = {
        @Index(name = "i_uc_position_corpCode", columnList = "corpCode"),
        @Index(name = "i_uc_position_categoryId", columnList = "category_id")})
public class Position extends BaseModel {
    public static final String _positionName = "positionName";
    public static final String _category = "category.id";
    public static final String _categoryAlias = "category";
    public static final String _categoryName = "category.categoryName";
    public static final String _categoryIdPath = "category.idPath";
    public static final String _positionStauts = "positionStatus";

    public enum PositionStatus {
        ENABLE("启用"), DELETE("彻底删除");

        private final String text;

        private PositionStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 岗位名称
     */
    @Column(nullable = false, length = 50)
    private String positionName;

    /**
     * 类别
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "position", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    public List<UserPosition> userPositions;

    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private PositionStatus positionStatus;

    @Transient
    private String categoryId;

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public Category getCategory() {
        return category;
    }
    /**********************************************
     *              非持久化字段                    *
     **********************************************/
    /**
     * 类别的名称
     */
    @Transient
    private String categoryName;

    @Transient
    private String categoryNamePath;

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryName() {
        return this.categoryName;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public List<UserPosition> getUserPositions() {
        return userPositions;
    }

    public void setUserPositions(List<UserPosition> userPositions) {
        this.userPositions = userPositions;
    }

    public PositionStatus getPositionStatus() {
        return positionStatus;
    }

    public void setPositionStatus(PositionStatus positionStatus) {
        this.positionStatus = positionStatus;
    }

    public String getCategoryNamePath() {
        return categoryNamePath;
    }

    public void setCategoryNamePath(String categoryNamePath) {
        this.categoryNamePath = categoryNamePath;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }
}
