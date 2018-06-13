package com.fp.cloud.module.uc.service;

import com.fp.cloud.module.uc.model.Role;
import com.fp.cloud.base.model.Page;
import com.fp.cloud.base.model.PageParam;
import com.fp.cloud.base.service.BaseService;

/**
 * @author Created by zhangyang on 2016/10/27.
 */
public interface RoleService extends BaseService<Role> {
    /**
     * 该方法用于根据角色Id获取角色详情，同时获取角色关联权限集合
     *
     * @param roleId 角色Id
     * @return 角色对象
     */
    Role getById(String roleId);

    /**
     * 该方法用于保存一个角色，保存角色时会保存角色和权限的关联关系
     * 需要把角色关联的权限存在{@linkplain Role#authorities 权限集合}中
     * 角色名称不能超过10字符，不能重复
     *
     * @param role 角色对象
     *             <ul>
     *             <li>{@linkplain Role#roleName 角色名称}</li>
     *             <li>{@linkplain Role#comments 角色说明}</li>
     *             <li>{@linkplain Role#authorities 角色权限}</li>
     *             </ul>
     * @return 主键Id
     */
    String save(Role role);

    /**
     * 该方法用于检测角色的名称，判断角色名称是否重复
     *
     * @param role 角色的对象
     *             {@linkplain Role#roleName 角色名称}
     * @return true:重复，false：不重复
     */
    boolean checkName(Role role);

    /**
     * 该方法用于更新角色的信息，或者更新角色关联的权限信息
     *
     * @param role 角色的对象
     *             <ul>
     *             <li>{@linkplain Role#roleName 角色名称}</li>
     *             <li>{@linkplain Role#comments 角色说明}</li>
     *             <li>{@linkplain Role#authorities 角色权限}</li>
     *             </ul>
     * @return 受影响的行数
     */
    int update(Role role);

    /**
     * 该方法用于按照角色查看，进行分页查询，可以带查询条件
     *
     * @param condition 查询条件
     *                  {@linkplain Role#roleName 角色名称}
     * @param pageParam 分页
     * @return 分页结果
     */
    Page<Role> search(Role condition, PageParam pageParam);

    /**
     * 该方法用于删除角色，同时需要删除角色关联的权限数据,删除角色和用户的关联数据
     *
     * @param roleId 角色Id
     * @return 受影响的行数
     */
    int delete(String roleId);

    /**
     * 获取系统管理员ID
     *
     * @return 系统管理员ID
     * @since 2017年2月7日11:11:13
     */
    String getSystemId();
}
