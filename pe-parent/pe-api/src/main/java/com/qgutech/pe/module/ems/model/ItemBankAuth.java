package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.uc.model.User;

import javax.persistence.*;

/**
 * 试题库权限表
 */
@Entity
@Table(name = "t_ems_item_bank_auth", uniqueConstraints = {
        @UniqueConstraint(name = "u_ems_item_bank_auth", columnNames = {"bank_id", "user_id"})},
        indexes = {@Index(name = "i_ems_item_bank_auth_userId", columnList = "user_id"),
                @Index(name = "i_ems_item_bank_auth_corpCode", columnList = "corpCode")})
public class ItemBankAuth extends BaseModel {

    public static final String _itemBank = "itemBank.id";
    public static final String _bankId = "bankId";
    public static final String _itemBankAlias = "itemBank";
    public static final String _user = "user.id";
    public static final String _userName = "user.userName";
    public static final String _userLoginName = "user.loginName";
    public static final String _userCreateTime = "user.createTime";
    public static final String _userAlias = "user";
    public static final String _canEdit = "canEdit";

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bank_id", nullable = false)
    private ItemBank itemBank;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    /**
     * 是否可以编辑题库
     */
    @Column
    private boolean canEdit = true;

    /**
     * 是否选中显示
     */
    @Transient
    private Boolean selected;

    @Transient
    private Boolean createBank;

    public ItemBank getItemBank() {
        return itemBank;
    }

    public void setItemBank(ItemBank itemBank) {
        this.itemBank = itemBank;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public boolean isCanEdit() {
        return canEdit;
    }

    public void setCanEdit(boolean canEdit) {
        this.canEdit = canEdit;
    }

    public Boolean getSelected() {
        return selected;
    }

    public void setSelected(Boolean selected) {
        this.selected = selected;
    }

    public Boolean getCreateBank() {
        return createBank;
    }

    public void setCreateBank(Boolean createBank) {
        this.createBank = createBank;
    }
}