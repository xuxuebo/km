package com.fp.cloud.module.uc.service;

import com.fp.cloud.module.uc.model.Organize;
import com.fp.cloud.module.uc.model.User;

import java.util.List;

/**
 * redis 存储用户信息 service
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月27日11:28:23
 */
public interface UserRedisService {

    /**
     * 删除登录信息
     *
     * @param userId 用户ID
     * @return 用户ID
     * @since 2016年10月27日17:28:02
     */
    int remove(String userId);

    /**
     * 删除登录信息
     *
     * @param userIds 用户ID
     * @return 用户ID
     * @since 2016年10月27日17:28:02
     */
    int remove(List<String> userIds);

    /**
     * 保存user对象到redis中
     *
     * @param user 需要保存redis的用户信息
     * @return 用户ID
     * @since 2016年10月27日15:07:03
     */
    String save(User user);

    /**
     * 保存user对象到redis中
     *
     * @param users 需要保存redis的用户信息
     * @return 用户ID
     * @since 2016年10月27日15:07:03
     */
    List<String> save(List<User> users);

    /**
     * 更新用户角色信息为admin
     *
     * @param userId 用户ID
     * @return 用户ID
     * @since 2016年10月27日16:51:12
     */
    String saveAdmin(String userId);

    /**
     * 删除redis 用户管理员角色信息
     *
     * @param userId 用户ID
     * @return 执行数量
     * @since 2016年10月27日17:02:40
     */
    int removeAdmin(String userId);

    /**
     * 变更登录信息 用户名、手机号、邮箱、密码
     *
     * @param user 用户
     * @return 执行数量
     * @since 2016年10月27日17:14:06
     */
    int updateLogin(User user);

    /**
     * 修改密码
     *
     * @param userId 学员ID
     * @param newPwd 新密码
     * @return 执行数量
     * @since 2016年10月27日17:23:58
     */
    int updatePwd(String userId, String newPwd);

    /**
     * 修改密码
     *
     * @param userIds 学员ID
     * @param newPwd  新密码
     * @return 执行数量
     * @since 2016年10月27日17:23:58
     */
    int updatePwd(List<String> userIds, String newPwd);

    /**
     * 修改用户部门信息
     *
     * @param userId   用户ID
     * @param organize 部门
     * @return 执行数量
     * @since 2016年10月27日20:38:13
     */
    int updateOrganize(String userId, Organize organize);

    /**
     * 修改用户部门信息
     *
     * @param userIds  用户ID
     * @param organize 部门
     * @return 执行数量
     * @since 2016年10月27日20:38:13
     */
    int updateOrganize(List<String> userIds, Organize organize);

    /**
     * 获取用户属性信息
     *
     * @param userId 用户ID
     * @param fields 需要获取哪些属性
     * @return 执行数量
     */
    User get(String userId, String... fields);

    /**
     * 学员端更新用户的手机,手机号激活状态
     *
     * @param userId 用户ID
     * @param mobile 用户手机号
     * @return 执行数量
     * @since 2017年3月2日14:14:101
     */
    int updateMobile(String userId, String mobile);

    /**
     * 学员更新用户的邮箱，邮箱的激活状态
     *
     * @param userId 用户ID
     * @param email  用户邮箱号
     * @return 执行数量
     * @since 2017年3月2日14:14:101
     */
    int updateEmail(String userId, String email);

    /**
     * 更新用户头像的id，
     *
     * @param userId 用户的ID
     * @param faceFileId 头像的Id
     * @param faceFileName 头像的名字
     * @return 执行数量
     * @since 2017年3月2日17:09:27 author liuChen
     */
    int updateUserFace(String userId, String faceFileId, String faceFileName);


}
