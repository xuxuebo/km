/*
 * 文件名:IndexKnowledge.java
 * 创建时间:2014-05-19
 * 版本:1.0
 * 版权所有:上海时代光华教育发展有限公司
 */
package com.qgutech.km.module.km.model;

/**
 * 索引知识对象，用于保存km-api中知识对象属性，摆脱sfm对km的依赖。（sfm为framework不应该依赖具体应用。）
 *
 * @author ZhaoJie@HF
 * @version 1.0
 * @since 2014-05-19
 */
public class IndexKnowledge {
    //知识id，唯一标识
    private String knowledgeId;
    //知识名称
    private String knowledgeName;
    //知识内容
    private String content;
    //知识状态
    private String optStatus;
    //知识标签
    private String tags;
    //知识简介
    private String introduction;
    //知识存储id
    private String storedFileId;
    //知识类型
    private String knowledgeType;
    //知识所属公司
    private String corpCode;
    //知识上传者的用户名
    private String uploaderUserName;
    //知识是否来自redis，默认为false
    private boolean fromRedis = false;
    //知识是否是平台分配的，默认为false
    private boolean assign = false;

    public String getKnowledgeId() {
        return knowledgeId;
    }

    public void setKnowledgeId(String knowledgeId) {
        this.knowledgeId = knowledgeId;
    }

    public String getKnowledgeName() {
        return knowledgeName;
    }

    public void setKnowledgeName(String knowledgeName) {
        this.knowledgeName = knowledgeName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getOptStatus() {
        return optStatus;
    }

    public void setOptStatus(String optStatus) {
        this.optStatus = optStatus;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getStoredFileId() {
        return storedFileId;
    }

    public void setStoredFileId(String storedFileId) {
        this.storedFileId = storedFileId;
    }

    public String getKnowledgeType() {
        return knowledgeType;
    }

    public void setKnowledgeType(String knowledgeType) {
        this.knowledgeType = knowledgeType;
    }

    public String getCorpCode() {
        return corpCode;
    }

    public void setCorpCode(String corpCode) {
        this.corpCode = corpCode;
    }

    public String getUploaderUserName() {
        return uploaderUserName;
    }

    public void setUploaderUserName(String uploaderUserName) {
        this.uploaderUserName = uploaderUserName;
    }

    public boolean isFromRedis() {
        return fromRedis;
    }

    public void setFromRedis(boolean fromRedis) {
        this.fromRedis = fromRedis;
    }

    public boolean isAssign() {
        return assign;
    }

    public void setAssign(boolean assign) {
        this.assign = assign;
    }
}
