package com.fp.cloud.module.uc.model;

import com.fp.cloud.base.model.BaseModel;

import javax.persistence.*;

/**
 * role authority rel domain
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年9月12日11:15:163
 */
@Entity
@Table(name = "t_uc_role_authority", uniqueConstraints = {@UniqueConstraint(name = "u_uc_role_authority_role_auth_id",
        columnNames = {"role_id", "authority_id"})},
        indexes = {@Index(name = "i_uc_role_authority_authorityId", columnList = "authority_id"),
                @Index(name = "i_uc_role_authority_corpCode", columnList = "corpCode")})
public class RoleAuthority extends BaseModel {
    public static final String _roleId = "role.id";
    public static final String _authority = "authority.id";
    public static final String _authorityUrl = "authority.authUrl";
    public static final String _authorityCode = "authority.authCode";
    public static final String _authorityAlisa = "authority";

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "authority_id", nullable = false)
    private Authority authority;

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Authority getAuthority() {
        return authority;
    }

    public void setAuthority(Authority authority) {
        this.authority = authority;
    }
}
