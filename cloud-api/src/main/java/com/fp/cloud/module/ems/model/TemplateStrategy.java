package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.BaseModel;

import javax.persistence.*;

/**
 * @author Created by zhangyang on 2016/10/19.
 */
@Entity
@Table(name = "t_ems_paper_template_strategy", indexes = {
        @Index(name = "i_ems_paper_template_strategy_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_paper_template_strategy_createBy", columnList = "createBy"),
        @Index(name = "i_ems_paper_template_strategy_objectId", columnList = "objectId")
}, uniqueConstraints = {@UniqueConstraint(name = "u_ems_paper_template_strategy", columnNames = {"templateId", "objectId"})})
public class TemplateStrategy extends BaseModel {
    public static final String _templateId = "templateId";
    public static final String _objectId = "objectId";
    public static final String _strategyType = "strategyType";

    public enum StrategyType {
        ITEM_BANK("题库"), KNOWLEDGE("知识点");
        private final String text;

        StrategyType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 关联ID
     */
    @Column(nullable = false, length = 32)
    private String objectId;

    /**
     * 模板ID
     */
    @Column(nullable = false, length = 32)
    private String templateId;

    /**
     * 类型
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private StrategyType strategyType;

    public String getObjectId() {
        return objectId;
    }

    public void setObjectId(String objectId) {
        this.objectId = objectId;
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
    }

    public StrategyType getStrategyType() {
        return strategyType;
    }

    public void setStrategyType(StrategyType strategyType) {
        this.strategyType = strategyType;
    }
}
