package com.qgutech.pe.module.uc.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.uc.model.Authority;
import com.qgutech.pe.module.uc.model.RoleAuthority;

import java.util.List;

/**
 * @author Created by zhangyang on 2016/10/27.
 */
public interface RoleAuthorityService extends BaseService<RoleAuthority> {
    /**
     * 该方法用于根据角色Id，查询该角色所关联的权限信息集合
     *
     * @param roleId 角色Id
     * @return 角色的关联的权限集合
     * @throws java.lang.IllegalArgumentException 当roleId为空时
     */
    List<Authority> listByRoleId(String roleId);

    /**
     * <p>该方法用于根据给定的角色Id，和传入的权限主键集合，更新当前角色所关联的权限</p>
     *
     * @param roleId       角色Id
     * @param authorityIds 权限主键集合
     */
    void updateByRoleIdAndAuthorityIds(String roleId, List<String> authorityIds);

    /**
     * <p>根据给定的角色Id，删除该角色所关联的权限数据</p>
     *
     * @param roleId 角色Id
     * @return 影响的行数
     */
    int deleteByRoleId(String roleId);

    /**
     * 根据用户Id查询当前用户的权限列表
     *
     * @param userId 用户Id
     * @return 该用户的权限列表
     */
    List<Authority> listAuthorityByUserId(String userId);
}
