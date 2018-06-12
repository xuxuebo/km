package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.base.model.Category;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

/**
 * 试题库实体
 *
 * @since 2016年09月14日10:27:57
 */
@Entity
@Table(name = "t_ems_item_bank", indexes = {
        @Index(name = "i_ems_item_bank_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_item_bank_categoryId", columnList = "category_id")
})
public class ItemBank extends BaseModel {
    public static final String _bankName = "bankName";
    public static final String _category = "category.id";
    public static final String _categoryName = "category.categoryName";
    public static final String _itemBankAuths = "itemBankAuths";
    public static final String _itemAlias = "items";
    public static final String _itemCount = "itemCount";
    public static final String _categoryAlias = "category";
    public static final String _bankStatus = "bankStatus";
    public static final String _itemAttribute="itemAttribute";

    public enum BankStatus {
        ENABLE("启用"), DELETE("彻底删除");

        private final String text;

        private BankStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 题库名称
     */
    @Column(length = 50, nullable = false)
    private String bankName;

    /**
     * 类别
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "itemBank", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    public List<ItemBankAuth> itemBankAuths;


    @OneToMany(fetch = FetchType.LAZY, mappedBy = "itemBank", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    public List<Item> items;

    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private BankStatus bankStatus;

    /****************************************************
     *                      非持久化字段                  *
     ****************************************************/

    /**
     * 单选题数
     */
    @Transient
    private long singleNumber = 0;

    /**
     * 多选题数
     */
    @Transient
    private long multiNumber = 0;

    /**
     * 不定项选择题数
     */
    @Transient
    private long indefiniteNumber = 0;

    /**
     * 判断题数
     */
    @Transient
    private long judgmentNumber = 0;

    /**
     * 填空题数
     */
    @Transient
    private long fillNumber = 0;

    /**
     * 问答题数
     */
    @Transient
    private long questionsNumber = 0;

    @Transient
    private long allNumber = 0;

    /**
     * 能否编辑
     */
    @Transient
    private boolean canEdit = false;

    /**
     * 试题状态
     */
    @Transient
    private String itemStatus;
    /*
    * 查找试题的属性
    * EXAM 查找考试试题
    * EXERCISE 查找练习试题
    * All 查找全部试题
    */
    @Transient
    private String itemAttribute;

    public String getItemAttribute() {
        return itemAttribute;
    }

    public void setItemAttribute(String itemAttribute) {
        this.itemAttribute = itemAttribute;
    }

    @Transient
    private Boolean authBank;

    public long getAllNumber() {
        return allNumber;
    }

    public void setAllNumber(long allNumber) {
        this.allNumber = allNumber;
    }

    public long getQuestionsNumber() {
        return questionsNumber;
    }

    public void setQuestionsNumber(long questionsNumber) {
        this.questionsNumber = questionsNumber;
    }

    public long getFillNumber() {
        return fillNumber;
    }

    public void setFillNumber(long fillNumber) {
        this.fillNumber = fillNumber;
    }

    public long getJudgmentNumber() {
        return judgmentNumber;
    }

    public void setJudgmentNumber(long judgmentNumber) {
        this.judgmentNumber = judgmentNumber;
    }

    public long getIndefiniteNumber() {
        return indefiniteNumber;
    }

    public void setIndefiniteNumber(long indefiniteNumber) {
        this.indefiniteNumber = indefiniteNumber;
    }

    public long getMultiNumber() {
        return multiNumber;
    }

    public void setMultiNumber(long multiNumber) {
        this.multiNumber = multiNumber;
    }

    public long getSingleNumber() {
        return singleNumber;
    }

    public void setSingleNumber(long singleNumber) {
        this.singleNumber = singleNumber;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public boolean isCanEdit() {
        return canEdit;
    }

    public void setCanEdit(boolean canEdit) {
        this.canEdit = canEdit;
    }

    public List<ItemBankAuth> getItemBankAuths() {
        return itemBankAuths;
    }

    public void setItemBankAuths(List<ItemBankAuth> itemBankAuths) {
        this.itemBankAuths = itemBankAuths;
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    public String getItemStatus() {
        return itemStatus;
    }

    public void setItemStatus(String itemStatus) {
        this.itemStatus = itemStatus;
    }

    public BankStatus getBankStatus() {
        return bankStatus;
    }

    public void setBankStatus(BankStatus bankStatus) {
        this.bankStatus = bankStatus;
    }

    public Boolean getAuthBank() {
        return authBank;
    }

    public void setAuthBank(Boolean authBank) {
        this.authBank = authBank;
    }
}