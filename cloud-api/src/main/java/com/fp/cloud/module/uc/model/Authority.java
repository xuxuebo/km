package com.fp.cloud.module.uc.model;

import com.fp.cloud.base.model.BaseLevelModel;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

/**
 * 系统权限表
 *
 * @author ELF@TEAM
 * @since 2016年2月23日17:03:00
 */
@Entity
@Table(name = "t_uc_authority", indexes = {
        @Index(name = "i_uc_authority_parentId", columnList = "parentId"),
        @Index(name = "i_uc_authority_corpCode", columnList = "corpCode")})
public class Authority extends BaseLevelModel {

    public static final String _authUrl = "authUrl";
    public static final String _authName = "authName";
    public static final String _comments = "comments";
    public static final String _roles = "roles.id";
    public static final String _authCode = "authCode";

    /**
     * 权限路径URL
     */
    @Column(nullable = false, length = 1300)
    private String authUrl;

    /**
     * 权限名称
     */
    @Column(nullable = false, length = 50)
    private String authName;

    /**
     * 权限编号
     */
    @Column(nullable = false, length = 20)
    private String authCode;

    /**
     * 权限描述
     */
    @Column(length = 200)
    private String comments;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "authority", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    public List<RoleAuthority> roleAuthorities;

    public String getAuthUrl() {
        return authUrl;
    }

    public void setAuthUrl(String authUrl) {
        this.authUrl = authUrl;
    }

    public String getAuthName() {
        return authName;
    }

    public void setAuthName(String authName) {
        this.authName = authName;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public List<RoleAuthority> getRoleAuthorities() {
        return roleAuthorities;
    }

    public void setRoleAuthorities(List<RoleAuthority> roleAuthorities) {
        this.roleAuthorities = roleAuthorities;
    }

    public String getAuthCode() {
        return authCode;
    }

    public void setAuthCode(String authCode) {
        this.authCode = authCode;
    }
}
