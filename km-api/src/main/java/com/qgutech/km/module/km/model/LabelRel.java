package com.qgutech.km.module.km.model;

import com.qgutech.km.base.model.BaseModel;

import javax.persistence.*;
import java.util.List;

/**
 * 智慧云标签关联类实体
 *
 * @author zhaowei
 * @since 2018年06月22日
 */

@Entity
@Table(name = "t_km_label_rel", indexes = {@Index(name = "i_km_label_rel", columnList = "corpCode,knowledgeId")})
public class LabelRel extends BaseModel {

    public static String LABEL_ID = "labelId";
    public static String KNOWLEDGE_ID = "knowledgeId";

    /**
     * 文件主键
     */
    @Column(nullable = false, length = 32)
    private String knowledgeId;

    /**
     * 标签主键
     */
    @Column(nullable = false, length = 32)
    private String labelId;
    @Transient
    private List<String> labelIds;

    public LabelRel() {
    }

    public LabelRel(String knowledgeId, String labelId, String corpCode) {
        this.knowledgeId = knowledgeId;
        this.labelId = labelId;
        this.setCorpCode(corpCode);
    }

    public String getKnowledgeId() {
        return knowledgeId;
    }

    public void setKnowledgeId(String knowledgeId) {
        this.knowledgeId = knowledgeId;
    }

    public String getLabelId() {
        return labelId;
    }

    public void setLabelId(String labelId) {
        this.labelId = labelId;
    }

    public List<String> getLabelIds() {
        return labelIds;
    }

    public void setLabelIds(List<String> labelIds) {
        this.labelIds = labelIds;
    }
}
