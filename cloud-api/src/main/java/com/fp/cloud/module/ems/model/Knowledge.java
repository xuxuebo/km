package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.Category;
import com.fp.cloud.base.model.BaseModel;

import javax.persistence.*;

/**
 * @author Created by zhangyang on 2016/10/12.
 */
@Entity
@Table(name = "t_ems_knowledge", indexes = {@Index(name = "i_ems_knowledge_categoryId", columnList = "category_id")})
public class Knowledge extends BaseModel {
    public static final String _knowledgeName = "knowledgeName";
    public static final String _KnowledgeStatus = "knowledgeStatus";
    public static final String _category = "category.id";
    public static final String _categoryAlias = "category";
    public static final String _categoryName = "category.categoryName";

    /**
     * 类别
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    /**
     * 试题类型
     */
    public enum KnowledgeStatus {
        ENABLE("启用"), DELETE("彻底删除");
        private final String text;

        KnowledgeStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    @Column(length = 50, nullable = false)
    private String knowledgeName;

    /**
     * 知识点类型
     */
    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private KnowledgeStatus knowledgeStatus;

    /**********************************************
     * 非持久化字段                *
     **********************************************/

    @Transient
    private Boolean expireKnowledge;

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getKnowledgeName() {
        return knowledgeName;
    }

    public void setKnowledgeName(String knowledgeName) {
        this.knowledgeName = knowledgeName;
    }

    public KnowledgeStatus getKnowledgeStatus() {
        return knowledgeStatus;
    }

    public void setKnowledgeStatus(KnowledgeStatus knowledgeStatus) {
        this.knowledgeStatus = knowledgeStatus;
    }

    public Boolean getExpireKnowledge() {
        return expireKnowledge;
    }

    public void setExpireKnowledge(Boolean expireKnowledge) {
        this.expireKnowledge = expireKnowledge;
    }
}
