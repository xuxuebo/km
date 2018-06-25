package com.qgutech.km.module.km.model;

import com.qgutech.km.base.model.BaseModel;
import org.apache.http.annotation.ThreadSafe;

import javax.persistence.*;

/**
 * 智慧云文件实体
 *
 * @author zhaowei
 * @since 2018年06月22日
 */

@Entity
@Table(name = "t_km_knowledge", indexes = {@Index(name = "i_km_knowledge_corpCode", columnList = "corpCode")})
public class Knowledge extends BaseModel {

    public static String FILE_ID = "fileId";

    /**
     * 文件名称
     */
    @Column(nullable = false, length = 100)
    private String knowledgeName;

    /**
     * 文件路径
     */
    @Column(nullable = false, length = 200)
    private String fileId;

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
    @Column(length = 32)
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

    @Transient
    private String createTimeStr;


    public String getKnowledgeName() {
        return knowledgeName;
    }

    public void setKnowledgeName(String knowledgeName) {
        this.knowledgeName = knowledgeName;
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
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

    public Knowledge(String knowledgeName, String fileId, long knowledgeSize, String knowledgeType, String sourceKnowledgeId, String folder, float showOrder) {
        this.knowledgeName = knowledgeName;
        this.fileId = fileId;
        this.knowledgeSize = knowledgeSize;
        this.knowledgeType = knowledgeType;
        this.sourceKnowledgeId = sourceKnowledgeId;
        this.folder = folder;
        this.showOrder = showOrder;
    }

    public String getCreateTimeStr() {
        return createTimeStr;
    }

    public void setCreateTimeStr(String createTimeStr) {
        this.createTimeStr = createTimeStr;
    }
}
