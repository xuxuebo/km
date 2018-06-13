package com.fp.cloud.module.uc.service;

import com.fp.cloud.module.uc.model.Organize;
import com.fp.cloud.base.model.Page;
import com.fp.cloud.base.model.PageParam;
import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.module.uc.model.User;

import java.util.List;
import java.util.Map;

/**
 * user service
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月17日12:59:09
 */
public interface UserService extends BaseService<User> {

    /**
     * 通过关键字模糊搜索对应的UserId 集合
     *
     * @param keyword 姓名、用户名、工号、手机号码
     * @return userId 集合
     * @since 2016年10月17日13:00:48
     */
    List<String> listUserId(String keyword);

    /**
     * 根据关键字模糊匹配查询指定用户权限的userId，当roleType为空则不区分权限。排除已删除的用户
     *
     * @param keyword  模糊匹配关键字：<ul>
     *                 <li>{@linkplain User#userName 姓名}</li>
     *                 <li>{@linkplain User#loginName 用户名}</li>
     *                 <li>{@linkplain User#employeeCode 工号}</li>
     *                 <li>{@linkplain User#mobile 手机号}</li>
     *                 </ul>
     * @param roleType {@linkplain User.RoleType 角色}可以为空
     * @return 用户id集合
     */
    List<String> listUserId(String keyword, User.RoleType roleType);

    /**
     * 获取用户信息封装MAP
     *
     * @param userIds 用户ID集合
     * @return 用户集合信息
     * @since 2016年10月26日19:32:29
     */
    Map<String, User> find(List<String> userIds);

    /**
     * 分页显示用户信息，岗位封装
     *
     * @param user      查询条件 <ul>
     *                  <li>关键字：姓名、用户名、工号、手机号</li>
     *                  <li>{@link User#organize 部门}</li>
     *                  <li>{@link User#status 状态}</li>
     *                  <li>{@link User#sexType 性别}</li>
     *                  <li>角色</li>
     *                  <li>{@link User#userName 姓名}</li>
     *                  <li>{@link User#loginName 用户名}</li>
     *                  <li>{@link User#employeeCode 工号}</li>
     *                  <li>{@link User#idCard 身份证}</li>
     *                  <li>{@link User#mobile 手机号码}</li>
     *                  <li>{@link User#email 邮箱}</li>
     *                  <li>{@link User#entryTime 入职时间}</li>
     *                  </ul>
     * @param pageParam 页对象
     * @return 用户对象集合，具体属性如下：
     * <ul>
     * <li>{@link User#id 主键}</li>
     * <li>{@link User#userName 姓名}</li>
     * <li>{@link User#loginName 用户名}</li>
     * <li>{@link User#employeeCode 工号}</li>
     * <li>{@link User#mobile 手机号}</li>
     * <li>{@link User#status 状态}</li>
     * </ul>
     */
    Page<User> search(User user, PageParam pageParam);

    /**
     * 条件搜素符合条件的userId
     *
     * @param user    查询条件 <ul>
     *                <li>关键字：姓名、用户名、工号、手机号</li>
     *                <li>{@link User#organize 部门}</li>
     *                <li>{@link User#status 状态}</li>
     *                <li>{@link User#positionId 岗位}</li>
     *                </ul>
     * @param userIds 学员ID集合
     * @return 人员信息集合
     */
    List<User> list(User user, List<String> userIds);

    /**
     * @param userIds 学员ID集合
     * @return 人员信息集合
     * @since 2017年3月2日18:05:08
     */
    List<User> list(List<String> userIds);

    /**
     * @return 人员信息集合 全部持久化属性
     * @since 2017年3月3日11:03:22 author liuChen
     */
    List<User> getAllUser();

    /**
     * 批量更新用户状态信息
     *
     * @param userIds    用户ID集合
     * @param userStatus 用户状态
     * @return 执行数量
     * @since 2016年10月27日20:16:38
     */
    int updateStatus(List<String> userIds, User.UserStatus userStatus);

    /**
     * 批量修改密码
     *
     * @param userIds 用户ID集合
     * @param newPwd  新密码
     * @return 执行数量
     * @since 2016年10月27日20:32:52
     */
    int updatePwd(List<String> userIds, String newPwd);

    /**
     * 批量修改部门信息
     *
     * @param userIds    用户ID集合
     * @param organizeId 部门ID
     * @return 执行数量
     * @since 2016年10月27日20:36:41
     */
    int updateOrganize(List<String> userIds, String organizeId);

    /**
     * 编辑岗位信息
     *
     * @param userIds     用户ID集合
     * @param positionIds 岗位ID集合
     * @return
     */
    int updatePosition(List<String> userIds, List<String> positionIds);

    /**
     * 授权角色
     *
     * @param userId  用户ID
     * @param roleIds 角色ID集合
     * @return 执行数量
     * @since 2016年10月29日12:54:22
     */
    int updateRole(String userId, List<String> roleIds);

    /**
     * 查询部门下是否有人员
     *
     * @param organizeId 部门Id
     * @return 是否有人员
     * @since 2016年10月28日09:33:36 author by WuKang@HF
     */
    boolean checkOrganizeUser(String organizeId);

    /**
     * 保存用户信息
     *
     * @param user 用户信息集合，具体属性如下：<ul>
     *             <li>{@link User#userName 姓名} 不可为空</li>
     *             <li>{@link User#loginName 用户名} 不可为空</li>
     *             <li>{@link User#password 密码} 为空时，默认密码102030</li>
     *             <li>{@link User#employeeCode 密码}</li>
     *             <li>{@link User#mobile 手机号}</li>
     *             <li>{@link User#email 邮箱}</li>
     *             <li>{@link User#organize 部门}</li>
     *             <li>{@link User#positionId 岗位} 多个以,号分割</li>
     *             <li>{@link User#idCard 身份证}</li>
     *             <li>{@link User#sexType 性别}</li>
     *             <li>{@link User#roleId 角色} 多个以,号分割</li>
     *             <li>{@link User#address 地址}</li>
     *             <li>{@link User#faceFileId 头像}</li>
     *             </ul>
     * @return 主键信息
     * @since 2016年10月29日11:09:03
     */
    String save(User user);

    /**
     * 保存用户信息
     *
     * @param users 用户信息集合，具体属性如下：<ul>
     *              <li>{@link User#userName 姓名} 不可为空</li>
     *              <li>{@link User#loginName 用户名} 不可为空</li>
     *              <li>{@link User#password 密码} 为空时，默认密码102030</li>
     *              <li>{@link User#employeeCode 密码}</li>
     *              <li>{@link User#mobile 手机号}</li>
     *              <li>{@link User#email 邮箱}</li>
     *              <li>{@link User#organize 部门}</li>
     *              <li>{@link User#positionId 岗位} 多个以,号分割</li>
     *              <li>{@link User#idCard 身份证}</li>
     *              <li>{@link User#sexType 性别}</li>
     *              <li>{@link User#roleId 角色} 多个以,号分割</li>
     *              <li>{@link User#address 地址}</li>
     *              <li>{@link User#faceFileId 头像}</li>
     *              </ul>
     * @return 主键信息
     * @since 2016年10月29日11:09:03
     */
    List<String> save(List<User> users);

    /**
     * 保存用户信息
     *
     * @param user 用户信息集合，具体属性如下：<ul>
     *             <li>{@link User#userName 姓名} 不可为空</li>
     *             <li>{@link User#loginName 用户名} 不可为空</li>
     *             <li>{@link User#employeeCode 密码}</li>
     *             <li>{@link User#mobile 手机号}</li>
     *             <li>{@link User#email 邮箱}</li>
     *             <li>{@link User#organize 部门}</li>
     *             <li>{@link User#positionId 岗位} 多个以,号分割</li>
     *             <li>{@link User#idCard 身份证}</li>
     *             <li>{@link User#sexType 性别}</li>
     *             <li>{@link User#roleId 角色} 多个以,号分割</li>
     *             <li>{@link User#address 地址}</li>
     *             <li>{@link User#faceFileId 头像}</li>
     *             </ul>
     * @return 主键信息
     * @since 2016年10月29日11:09:03
     */
    int update(User user);

    /**
     * 验证手机号码是否已经存在
     *
     * @param mobile 手机号
     * @return 处理结果
     * @since 2016年10月29日11:53:01
     */
    User getByMobile(String mobile);

    /**
     * 验证邮箱是否已经存在
     *
     * @param email 邮箱
     * @return 处理结果
     * @since 2016年10月29日11:53:01
     */
    User getByEmail(String email);

    /**
     * 验证用户名是否已经存在
     *
     * @param loginName 用户名
     * @return 处理结果
     * @since 2016年10月29日11:53:01
     */
    User getByLoginName(String loginName);

    /**
     * 验证身份证号码是否已经存在
     *
     * @param idCard 身份证号码
     * @return 处理结果
     * @since 2016年10月29日11:53:01
     */
    User getByIdCard(String idCard);

    /**
     * 通过用户ID获取用户信息
     *
     * @param userId 用户ID
     * @return 用户对象
     * @since 2016年10月31日18:31:35
     */
    User get(String userId);

    /**
     * 验证用户名/手机/邮箱是否存在
     *
     * @param account 账号信息
     * @return 处理结果
     * @since 2016年11月4日17:20:09 author by WuKang@HF
     */
    User getByAccount(String account);

    /**
     * 通过用户ID封装用户信息集合,
     * 并过滤被冻结用户,具体属性如下:
     * <ul>
     * <li>{@link User#userName 姓名} 不可为空</li>
     * <li>{@link User#mobile 手机号}</li>
     * <li>{@link User#organize 部门}</li>
     * <li>{@link User#positionId 岗位} 多个以,号分割</li>
     * </ul>
     *
     * @param userIds 用户id集合
     * @return 用户信息map
     * @since 2016年11月10日09:41:19 author by WuKang@HF
     */
    Map<String, User> findUserInfo(List<String> userIds);

    /**
     * 该方法用于筛选给定的角色下，一个部门中未被该角色关联的人员的分页数据
     *
     * @param roleId    角色Id
     * @param user      用户筛选条件如下：
     *                  <ul>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#userName 姓名}</li>
     *                  <li>{@linkplain User#employeeCode 工号}</li>
     *                  <li>{@linkplain User#mobile 手机号}</li>
     *                  </ul>
     * @param pageParam 分页
     * @return 该角色下待选的人员分页数据
     */
    Page<User> searchWaitUserByRoleId(String roleId, User user, PageParam pageParam);

    /**
     * <p>该方法用于根据查询条件，查询角色人员的分页数据（按人员查看）</p>
     *
     * @param condition 查询条件
     *                  <ul>
     *                  <li>{@linkplain User#userName 姓名}</li>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#employeeCode 工号}</li>
     *                  <li>{@linkplain User#mobile 手机号}</li>
     *                  <li>{@linkplain User#status 状态}</li>
     *                  </ul>
     * @param pageParam 分页
     * @return 分页对象，User中包含{@link User#roleIds}角色对象
     */
    Page<User> searchUserRoleByCondition(User condition, PageParam pageParam);

    /**
     * 【根据部门id获取部门下所有人员信息】
     * 人员封装的属性有：
     *
     * @return 用户对象集合，具体属性如下：
     * <ul>
     * <li>{@link User#id 主键}</li>
     * <li>{@link User#userName 姓名}</li>
     * <li>{@link User#loginName 用户名}</li>
     * <li>{@link User#employeeCode 工号}</li>
     * <li>{@link User#mobile 手机号}</li>
     * <li>{@link User#positionName 岗位名称}</li>
     * </ul>
     */
    Page<User> searchByOrganize(Organize organize, PageParam pageParam);

    /**
     * 文件服务器校验session信息是否合法
     *
     * @param sid  sessionID
     * @param sign 秘钥
     * @return author by LiYanCheng@HF
     * @since 2017年2月8日09:21:47
     */
    Boolean checkSid(String sid, String sign);

    /**
     * 【学员端/手机端,修改密码】
     *
     * @param newPwd 新密码
     * @param oldPwd 旧密码
     * @param userId 学员ID
     * @return 执行数量
     * @since 2017年3月9日09:06:14
     */
    int updatePwd(String newPwd, String oldPwd, String userId);

    /**
     * 【学员端、手机端，修改手机号】
     *
     * @param mobile 手机号码
     * @param userId 学员ID
     * @return 执行数量
     * @since 2017年3月9日09:29:07
     */
    int updateMobile(String mobile, String userId);

    /**
     * 获取公司对应已经使用的账号数
     *
     * @param corpCodes 企业ID集合
     * @return 数量
     * @since 2017年3月21日14:53:23
     */
    Map<String, Long> findCount(List<String> corpCodes);

    /**
     * 查询手机号是否存在
     *
     * @param mobiles 手机号集合
     * @return 结果集
     * @since 2017年3月28日12:59:17
     */
    Map<String, Boolean> findMobile(List<String> mobiles);

    /**
     * 查询用户名是否存在
     *
     * @param loginNames 用户名集合
     * @return 结果集
     * @since 2017年3月28日12:59:17
     */
    Map<String, Boolean> findLogin(List<String> loginNames);

    /**
     * 查询邮箱是否存在
     *
     * @param emails 邮箱集合
     * @return 结果集
     * @since 2017年3月28日12:59:17
     */
    Map<String, Boolean> findEmail(List<String> emails);

    /**
     * 查询工号是否存在
     *
     * @param employeeCodes 工号集合
     * @return 结果集
     * @since 2017年3月28日12:59:17
     */
    Map<String, Boolean> findEmployeeCode(List<String> employeeCodes);

    /**
     * 查询身份证是否存在
     *
     * @param idCards 工号集合
     * @return 结果集
     * @since 2017年3月28日12:59:17
     */
    Map<String, Boolean> findIdCard(List<String> idCards);

    /**
     * 获取公司对应的学员注册数
     *
     * @return
     */
    Long getRegisterNum();

    /**
     * 【文件服务器获取头像路径信息】
     *
     * @param fileId   文件ID
     * @param faceName 文件名称
     * @return 文件路径
     * @since 2017年6月21日09:13:51
     */
    String getFacePath(String fileId, String faceName);

    /**
     * 根据loginNames查询loginName对应User的Map
     *
     * @param loginNames 登录名集合
     * @return 结果集
     * <ul>
     * <li>{@linkplain User#id 学员ID}</li>
     * </ul>
     */
    Map<String, User> findByLogin(List<String> loginNames);

    /**
     * 导入人员保存人员数据
     *
     * @param users
     */
    void batchSaveUser(List<User> users);
    /**

     * 封装用户岗位信息
     *
     * @param users 用户集合，
     *              <ul>
     *              <li>{@linkplain User#id 主键，不可为空}</li>
     *              </ul>
     * @since 2017-10-31 11:06:48
     */
    void packageUserPosition(List<User> users);
    /**
     * elp同步人员信息，具体步奏如下：
     * <ul>
     * <li>同步部门信息</li>
     * <li>同步岗位类别信息</li>
     * <li>同步岗位信息</li>
     * <li>同步人员信息</li>
     * </ul>
     *
     * @param corpCode 企业ID
     * @return 修改人员信息数量
     */
    int syncUserForElp(String corpCode);

    /**
     * 同步人员信息（针对ELP人员同步）
     *
     * @param users 人员信息集合，具体字段如下：
     *              <ul>
     *              <li>{@linkplain User#loginName 用户名}</li>
     *              <li>{@linkplain User#password 密码}</li>
     *              <li>{@linkplain User#userName 姓名}</li>
     *              <li>{@linkplain User#employeeCode 工号}</li>
     *              <li>{@linkplain User#mobile 手机号}</li>
     *              <li>{@linkplain User#email 邮箱}</li>
     *              <li>{@linkplain User#idCard 身份证}</li>
     *              <li>{@linkplain User#positionId 岗位ID}</li>
     *              <li>{@linkplain User#organizeId 部门ID}</li>
     *              </ul>
     * @return 影响数量
     */
    int syncUser(List<User> users);

    /**
     * 查询当前登陆的用户的输入的password是否正确
     * @param passWord passWord
     * @return true 正确 false 不正确
     */
    Boolean checkUserPassWord(String passWord);
}