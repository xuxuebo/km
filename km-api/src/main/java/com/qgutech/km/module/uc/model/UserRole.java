package com.qgutech.km.module.uc.model;

import com.qgutech.km.base.model.BaseModel;

import javax.persistence.*;

/**
 * user role rel domain
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年9月12日11:05:19
 */
@Entity
@Table(name = "t_uc_user_role",
        uniqueConstraints = {@UniqueConstraint(name = "u_uc_user_role_user_role_id",
                columnNames = {"user_id", "role_id"})},
        indexes = {@Index(name = "i_uc_user_role_roleId", columnList = "role_id"),
                @Index(name = "i_uc_user_role_corpCode", columnList = "corpCode")})
public class UserRole extends BaseModel {

    public static final String _role = "role.id";
    public static final String _user = "user.id";
    public static final String _userAlias = "user";
    public static final String _roleAlias = "role";

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}