package com.qgutech.km.module.uc.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.uc.model.Role;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.module.uc.model.UserRole;
import com.qgutech.km.base.model.PageParam;

import java.util.List;
import java.util.Map;

/**
 * @author Created by zhangyang on 2016/10/28.
 */
public interface UserRoleService extends BaseService<UserRole> {
    /**
     * 该方法用于根据传入的角色Id，查询出来指定的角色Id对应授权人的分页数据
     *
     * @param roleId    角色Id
     * @param pageParam 分页
     * @return 当前角色已经授权的人员分页列表
     * <ul>
     * <li>{@linkplain User#loginName 用户名}</li>
     * <li>{@linkplain User#userName 姓名}</li>
     * <li>{@linkplain User#employeeCode 工号}</li>
     * <li>{@linkplain User#mobile 手机号}</li>
     * <li>{@linkplain User#status 状态}</li>
     * </ul>
     */
    Page<User> searchByRoleId(String roleId, PageParam pageParam);

    /**
     * <p>该方法用于根据给定的用户Id，查询当前用户对应的角色列表</p>
     *
     * @param userId 用户Id
     * @return 当前用户对应的角色列表
     */
    List<Role> listByUserId(String userId);

    /**
     * <p>删除指定人员的指定的角色权限</p>
     *
     * @param userId  人员Id
     * @param roleIds 角色Id集合
     * @return 受影响的行数
     */
    int deleteSpecialRoleByUserId(String userId, List<String> roleIds);

    /**
     * 通过用户id删除角色信息
     *
     * @param userId 用户id
     * @return 执行数量
     * @since 2016年10月29日12:56:02
     */
    int deleteByUserId(String userId);

    /**
     * 通过角色Id，删除角色Id所关联的用户数据
     *
     * @param roleId 角色Id
     * @return 影响的行数
     */
    int deleteByRoleId(String roleId);

    /**
     * <p>删除指定角色下的指定的人员权限</p>
     *
     * @param roleId  角色Id
     * @param userIds 需要取消关联的人员Id
     * @return 影响的行数
     */
    int deleteSpecialUsersByRoleId(String roleId, List<String> userIds);

    /**
     * 分页展示管理员用户信息
     *
     * @param user 用户查询条件
     * @return admin 用户信息 author by LiYanCheng@HF
     * @since 2016年11月8日09:14:19
     */
    Page<User> searchAdmin(User user, PageParam pageParam);

    /**
     * 分页展示指定条件查询获取的管理员用户信息
     *
     * @param user           用户查询条件
     * @param excludeUserIds 不包含的指定管理员ID集合，可以为空，则查询全部人员
     * @param pageParam      分页
     * @return admin 用户信息 author by chenHuaMei@HF
     */
    Page<User> searchAdminByCondition(User user, List<String> excludeUserIds, PageParam pageParam);

    /**
     * 该方法用于根据给定一组用户Ids,查询这组用户Id分别对应的角色集合
     *
     * @param userIds 需要查询的用户Ids
     * @return Map
     * <ul>
     * <li>key:用户Id</li>
     * <li>value:用户对应的角色列表</li>
     * </ul>
     */
    Map<String, List<Role>> findRolesByUserIds(List<String> userIds);

    /**
     * 批量保存用户角色信息
     *
     * @param userRoles 用户角色集合信息
     * @return author by LiYanCheng@HF
     * @since 2016年11月20日13:44:55
     */
    List<String> save(List<UserRole> userRoles);

    /**
     * 判断该用户是不是系统管理员
     *
     * @param userId 用户ID
     * @return ture or false
     * @since 2017年3月28日09:46:27
     */
    Boolean checkSystemRole(String userId);
}
