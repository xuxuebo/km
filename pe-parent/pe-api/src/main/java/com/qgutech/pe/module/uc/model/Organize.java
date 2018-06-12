package com.qgutech.pe.module.uc.model;

import com.qgutech.pe.base.model.BaseLevelModel;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

/**
 * 部门 DOMAIN
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年9月7日10:26:20
 */
@Entity
@Table(name = "t_uc_organize", indexes = {
        @Index(name = "i_uc_organize_corpCode", columnList = "corpCode"),
        @Index(name = "i_uc_organize_parent_id", columnList = "parentId")})
public class Organize extends BaseLevelModel {
    public static final String _organizeName = "organizeName";
    public static final String _organizeStauts = "organizeStatus";
    public static final String _userAlias = "users";
    public static final String _isDefault = "isDefault";

    public enum OrganizeStatus {
        ENABLE("启用"), DELETE("彻底删除");

        private final String text;

        OrganizeStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 组织名称
     */
    @Column(nullable = false, length = 50)
    private String organizeName;

    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private OrganizeStatus organizeStatus;

    /**
     * 是否是默认值
     */
    @Column
    private boolean isDefault;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "organize", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    public List<User> users;

    @Transient
    private boolean include = false;

    /**
     * 部门人数
     */
    @Transient
    private Long userCount;

    @Transient
    private String namePath;


    public boolean isInclude() {
        return include;
    }

    public void setInclude(boolean include) {
        this.include = include;
    }

    public String getOrganizeName() {
        return organizeName;
    }

    public void setOrganizeName(String organizeName) {
        this.organizeName = organizeName;
    }

    public OrganizeStatus getOrganizeStatus() {
        return organizeStatus;
    }

    public void setOrganizeStatus(OrganizeStatus organizeStatus) {
        this.organizeStatus = organizeStatus;
    }

    public Long getUserCount() {
        return userCount;
    }

    public void setUserCount(Long userCount) {
        this.userCount = userCount;
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    public String getNamePath() {
        return namePath;
    }

    public void setNamePath(String namePath) {
        this.namePath = namePath;
    }

    public boolean isDefault() {
        return isDefault;
    }

    public void setDefault(boolean aDefault) {
        isDefault = aDefault;
    }
}
