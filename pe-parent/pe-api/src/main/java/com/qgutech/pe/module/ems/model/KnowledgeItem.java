package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;

import javax.persistence.*;

/**
 * 知识点试题关联表
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月19日16:16:51
 */
@Entity
@Table(name = "t_ems_knowledge_item", indexes = {
        @Index(name = "i_ems_knowledge_item_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_knowledge_item_itemId", columnList = "item_id")},
        uniqueConstraints = {@UniqueConstraint(name = "u_ems_knowledge_item", columnNames = {"knowledge_id", "item_id"})})
public class KnowledgeItem extends BaseModel {

    public static final String _knowledge = "knowledge.id";
    public static final String _knowledgeName = "knowledge.knowledgeName";
    public static final String _knowledgeAlias = "knowledge";
    public static final String _item = "item.id";
    public static final String _itemAlias = "item";
    public static final String _itemCount = "itemCount";

    /**
     * 知识点Id
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "knowledge_id", nullable = false)
    private Knowledge knowledge;

    /**
     * 试题
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "item_id", nullable = false)
    private Item item;

    public Knowledge getKnowledge() {
        return knowledge;
    }

    public void setKnowledge(Knowledge knowledge) {
        this.knowledge = knowledge;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }
}
