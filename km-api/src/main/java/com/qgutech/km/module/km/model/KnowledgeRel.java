package com.qgutech.km.module.km.model;

import com.qgutech.km.base.model.BaseModel;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

/**
 * 智慧云文件与库关联实体
 *
 * @author zhaowei
 * @since 2018年06月22日
 */

@Entity
@Table(name = "t_km_knowledge_rel", indexes = {@Index(name = "i_km_knowledge_rel", columnList = "corpCode,libraryId")})
public class KnowledgeRel extends BaseModel {

    public static String LIBRARY_ID = "libraryId";

    public static String KNOWLEDGE_ID = "knowledgeId";

    @Column(nullable = false, length = 32)
    private String knowledgeId;

    @Column(nullable = false, length = 32)
    private String libraryId;

    @Column(nullable = false, length = 32)
    private String shareId;

    public String getShareId() {
        return shareId;
    }

    public void setShareId(String shareId) {
        this.shareId = shareId;
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
}
