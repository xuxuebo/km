package com.qgutech.km.module.km.model;

import com.qgutech.km.base.model.BaseModel;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

/**
 * 分享记录实体
 * Created by Administrator on 2018/6/22.
 */
@Entity
@Table(name = "t_km_share", indexes = {@Index(name = "t_km_share", columnList = "corpCode")})
public class Share extends BaseModel {

    public static final String KNOWLEDGE_ID="knowledgeId";

    /**
     * 共享类型
     */
    @Column(nullable = false, length = 50)
    private  String shareType;

    /**
     * 分享至共享库主键
     */
    @Column(nullable = false, length = 50)
    private String shareLibraryId;

    /**
     * 文件密码
     */
    @Column(nullable = false, length = 50)
    private String password;

    /**
     * 文件主键
     */
    @Column(nullable = false, length = 32)
    private String knowledgeId;

    /**
     * 有效时间
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
