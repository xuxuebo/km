package com.qgutech.km.base.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

/**
 * 智慧云分享类实体
 *
 * @author zhaowei
 * @since 2018年06月22日
 */

@Entity
@Table(name = "t_km_knowledge_share", indexes = {@Index(name = "i_km_knowledge_share", columnList = "corpCode")})
public class KnowledgeShare extends BaseModel{

    /**
     * 共享类型
     */
    @Column(nullable = false, length = 50)
    private String shareType;

    /**
     * 分享至共享库主键
     */
    @Column(nullable = false, length = 32)
    private String shareLibraryId;

    /**
     * 文件密码
     */
    @Column(length = 50)
    private String password;

    /**
     * 文件主键
     */
    @Column(nullable = false, length = 32)
    private String knowledgeId;

    /**
     * 有效期
     */
    @Column(nullable = false, length = 20)
    private String expireTime;

    public String getShareType() {
        return shareType;
    }

    public void setShareType(String shareType) {
        this.shareType = shareType;
    }

    public String getShareLibraryId() {
        return shareLibraryId;
    }

    public void setShareLibraryId(String shareLibraryId) {
        this.shareLibraryId = shareLibraryId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getKnowledgeId() {
        return knowledgeId;
    }

    public void setKnowledgeId(String knowledgeId) {
        this.knowledgeId = knowledgeId;
    }

    public String getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(String expireTime) {
        this.expireTime = expireTime;
    }
}
