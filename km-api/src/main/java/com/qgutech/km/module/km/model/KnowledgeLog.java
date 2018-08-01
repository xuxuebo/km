package com.qgutech.km.module.km.model;

import com.qgutech.km.base.model.BaseModel;

import javax.persistence.*;
import java.util.Date;

/**
 * 智慧云知识库中的知识操作日志实体
 *
 * @author TangFD@HF
 * @since 2018-8-1
 */

@Entity
@Table(name = "t_km_knowledge_log", indexes = {@Index(name = "i_km_knowledge_log", columnList = "corpCode")})
public class KnowledgeLog extends BaseModel {

    public static final String LIBRARY_ID = "libraryId";
    public static final String KNOWLEDGE_ID = "knowledgeId";
    public static final String TYPE = "type";
    public static final String REMARK = "remark";

    @Column(nullable = false, length = 32)
    private String knowledgeId;

    @Column(nullable = false, length = 32)
    private String libraryId;

    /**
     * 操作类型，DELETE:删除，UPLOAD:上传，DOWNLOAD:下载，SHARE:分享，COPY:复制
     */
    @Column(nullable = false, length = 20)
    private String type;

    @Column
    private String remark;

    public KnowledgeLog() {
    }

    public KnowledgeLog(String knowledgeId, String libraryId, String type) {
        this.knowledgeId = knowledgeId;
        this.libraryId = libraryId;
        this.type = type;
    }

    @Transient
    private String knowledgeName;
    @Transient
    private String userName;
    @Transient
    private String createTimeStr;
    @Transient
    private Date startTime;
    @Transient
    private Date endTime;

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getKnowledgeName() {
        return knowledgeName;
    }

    public void setKnowledgeName(String knowledgeName) {
        this.knowledgeName = knowledgeName;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getKnowledgeId() {
        return knowledgeId;
    }

    public void setKnowledgeId(String knowledgeId) {
        this.knowledgeId = knowledgeId;
    }

    public String getLibraryId() {
        return libraryId;
    }

    public void setLibraryId(String libraryId) {
        this.libraryId = libraryId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCreateTimeStr() {
        return createTimeStr;
    }

    public void setCreateTimeStr(String createTimeStr) {
        this.createTimeStr = createTimeStr;
    }
}
