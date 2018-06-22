package com.qgutech.km.base.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

/**
 * 智慧云标签关联类实体
 *
 * @author zhaowei
 * @since 2018年06月22日
 */

@Entity
@Table(name = "t_km_label_rel", indexes = {@Index(name = "i_km_label_rel", columnList = "corpCode,knowledgeId")})
public class LabelRel extends BaseModel {

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
}
