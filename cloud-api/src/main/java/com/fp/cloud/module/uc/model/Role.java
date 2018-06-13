package com.fp.cloud.module.uc.model;

import com.fp.cloud.base.model.BaseModel;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

/**
 * 系统角色表
 *
 * @author TaoFaDeng@ELF@TEAM
 * @since 2016年2月23日17:03:00
 */
@Entity
@Table(name = "t_uc_role",
        uniqueConstraints = {@UniqueConstraint(columnNames = {"corpCode", "roleName"})})
public class Role extends BaseModel {
    public static final String _roleName = "roleName";
    public static final String _comments = "comments";
    public static final String _roleAuthorities = "roleAuthorities";
    public static final String _isDefault = "isDefault";

    /**
     * 开放类型
     */
    public enum AssignType {
        PART("部分"), ALL("全部");
        private final String text;

        private AssignType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 角色名称
     */
    @Column(nullable = false, length = 50)
    private String roleName;

    /**
     * 角色描述
     */
    @Column(length = 200)
    private String comments;

    /**
     * 是否是默认值
     */
    @Column
    private boolean isDefault;

    /**
     * 开放类型
     */
    @Column(length = 20)
    @Enumerated(EnumType.STRING)
    private AssignType assignType;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "role", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    private List<UserRole> userRoles;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "role", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    private List<RoleAuthority> roleAuthorities;

    /*********************************************
     * 非持久字段                     *
     *********************************************/

    @Transient
    private List<Authority> authorities;

    @Transient
    private List<User> users;

    @Transient
    private boolean canEdit = true;

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    public List<Authority> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(List<Authority> authorities) {
        this.authorities = authorities;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public AssignType getAssignType() {
        return assignType;
    }

    public void setAssignType(AssignType assignType) {
        this.assignType = assignType;
    }

    public List<UserRole> getUserRoles() {
        return userRoles;
    }

    public void setUserRoles(List<UserRole> userRoles) {
        this.userRoles = userRoles;
    }

    public List<RoleAuthority> getRoleAuthorities() {
        return roleAuthorities;
    }

    public void setRoleAuthorities(List<RoleAuthority> roleAuthorities) {
        this.roleAuthorities = roleAuthorities;
    }

    public boolean isCanEdit() {
        return canEdit;
    }

    public void setCanEdit(boolean canEdit) {
        this.canEdit = canEdit;
    }

    public boolean isDefault() {
        return isDefault;
    }

    public void setDefault(boolean aDefault) {
        isDefault = aDefault;
    }
}
