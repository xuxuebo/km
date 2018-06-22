package com.qgutech.km.module.km.model;

import com.qgutech.km.base.model.BaseModel;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

/**
 * 智慧云文件实体
 *
 * @author zhaowei
 * @since 2018年06月22日
 */

@Entity
@Table(name = "t_km_knowledge", indexes = {@Index(name = "i_km_knowledge_corpCode", columnList = "corpCode")})
public class Knowledge extends BaseModel {

    /**
     * 文件名称
     */
    @Column(nullable = false, length = 100)
    private String knowledgeName;

    /**
     * 文件路径
     */
    @Column(nullable = false, length = 200)
    private String knowledgePath;

    /**
     * 文件大小
     */
    @Column
    private long knowledgeSize;

    /**
     * 文件类型
     */
    @Column(nullable = false, length = 20)
    private String knowledgeType;

    /**
     * 来源文件主键
     */
    @Column(nullable = false, length = 32)
    private String sourceKnowledgeId;

    /**
     * 文件夹主键
     */
    @Column(length = 32)
    private String folder;

    /**
     * 排序
     */
    @Column
    private float showOrder;

    public String getKnowledgeName() {
        return knowledgeName;
    }

    public void setKnowledgeName(String knowledgeName) {
        this.knowledgeName = knowledgeName;
    }

    public String getKnowledgePath() {
        return knowledgePath;
    }

    public void setKnowledgePath(String knowledgePath) {
        this.knowledgePath = knowledgePath;
    }

    public long getKnowledgeSize() {
        return knowledgeSize;
    }

    public void setKnowledgeSize(long knowledgeSize) {
        this.knowledgeSize = knowledgeSize;
    }

    public String getKnowledgeType() {
        return knowledgeType;
    }

    public void setKnowledgeType(String knowledgeType) {
        this.knowledgeType = knowledgeType;
    }

    public String getSourceKnowledgeId() {
        return sourceKnowledgeId;
    }

    public void setSourceKnowledgeId(String sourceKnowledgeId) {
        this.sourceKnowledgeId = sourceKnowledgeId;
    }

    public String getFolder() {
        return folder;
    }

    public void setFolder(String folder) {
        this.folder = folder;
    }

    public float getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(float showOrder) {
        this.showOrder = showOrder;
    }

    public Knowledge() {
    }

    public Knowledge(String knowledgeName, String knowledgePath, long knowledgeSize, String knowledgeType, String sourceKnowledgeId, String folder, float showOrder) {
        this.knowledgeName = knowledgeName;
        this.knowledgePath = knowledgePath;
        this.knowledgeSize = knowledgeSize;
        this.knowledgeType = knowledgeType;
        this.sourceKnowledgeId = sourceKnowledgeId;
        this.folder = folder;
        this.showOrder = showOrder;
    }
}
