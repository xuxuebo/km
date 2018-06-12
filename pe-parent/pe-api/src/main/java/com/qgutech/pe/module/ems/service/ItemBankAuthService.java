package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.ItemBankAuth;

import java.util.List;
import java.util.Map;

/**
 * 题库权限服务类
 */
public interface ItemBankAuthService extends BaseService<ItemBankAuth> {
    /**
     * 该方法用于给指定题库添加授权人,已存在的直接跳过,可以批量添加操作
     *
     * @param bankId  题库主键Id
     * @param userIds 用户主键集合
     * @throws java.lang.IllegalArgumentException 当bankId或者userIds为空时
     * @since 2016年09月18日13:30:11 author by ZhangYang
     */
    void addUsers(String bankId, List<String> userIds);

    /**
     * 该方法用于删除指定题库下的授权人员
     *
     * @param bankId  题库主键
     * @param userIds 用户主键集合
     * @since 2016年09月18日13:30:11 author by ZhangYang
     */
    void deleteUsers(String bankId, List<String> userIds);

    /**
     * 该方法用于根据给定的题库Id,和指定人员的Id,更改当前人员对于题库的编辑权限
     *
     * @param bankId  题库Id
     * @param userId  用户Id
     * @param canEdit 是否有编辑权限
     * @throws java.lang.IllegalArgumentException 当bankId或者userId为空时
     */
    void updateCanEdit(String bankId, String userId, boolean canEdit);

    /**
     * 该方法用于根据权限主键更新权限是否可编辑
     *
     * @param authId  权限主键
     * @param canEdit 是否可更新
     * @since 2016年09月18日10:56:47
     */
    void updateCanEdit(String authId, boolean canEdit);

    /**
     * 该方法用于根据题库主键获取授权信息,授权信息中包括以下显式信息
     * <ul>
     * <li>{@linkplain com.qgutech.pe.module.uc.model.User#loginName 用户名}</li>
     * <li>{@linkplain com.qgutech.pe.module.uc.model.User#userName 姓名}</li>
     * <li>{@linkplain ItemBankAuth#canEdit 是否可以编辑}</li>
     * </ul>
     *
     * @param bankId 题库主键
     * @return 题库对应权限列表, 封装用户信息
     * @throws java.lang.IllegalArgumentException 当bankId为空时
     * @refactor by ZhangYang
     * @since 2016年09月18日11:17:57
     */
    List<ItemBankAuth> listByBankId(String bankId);

    /**
     * 该方法用于根据题库主键和当前用户主键来判断是否用户
     * 是否有题库的权限或者编辑权限。
     *
     * @param itemBankId 题库id
     * @param canEdit    能否编辑：true表示可以编辑，false表示不能编辑。
     * @return 是否能够编辑题库
     * @since 2016年10月12日17:33:12
     */
    Boolean checkAuth(String itemBankId, boolean canEdit);

    /**
     * 该方法用于根据题库主键和当前用户主键来判断是否用户
     * 是否有题库的权限或者编辑权限。
     *
     * @param bankIds 题库id集合
     * @param canEdit 能否编辑：true表示可以编辑，false表示不能编辑。
     * @return 是否能够编辑题库
     * @since 2016年10月12日17:33:12
     */
    Boolean checkAuth(List<String> bankIds, boolean canEdit);

    /**
     * 该方法用于根据题库主键和当前用户主键来判断是否用户
     * 是否有题库的权限或者编辑权限。
     *
     * @param itemBankId 题库id
     * @return 是否能够编辑题库
     * @since 2016年10月12日17:33:12
     */
    Boolean checkAuth(String itemBankId);

    /**
     * 查看题库对应的权限，读和写
     *
     * @param bankIds 题库ID集合
     * @return author by LiYanCheng@HF
     * @since 2016年10月17日16:28:12
     */
    Map<String, Boolean> find(List<String> bankIds);


    /**
     * 批量处理人员授权中添加或者移除人员的保存操作
     *
     * @param bankId        题库Id
     * @param itemBankAuths 题库授权的列表集合
     */
    void saveAuthUser(String bankId, List<ItemBankAuth> itemBankAuths);

    /**
     * 根据用户Id查询所有被授权的题库主键集合
     *
     * @param userId 用户Id
     * @return 题库Id集合
     * @since 2016年11月15日16:55:01 author by WuKang@HF
     */
    List<String> listBankByUserId(String userId);

    /**
     * 根据用户Id查询所有被授权的题库主键集合
     *
     * @param userId  用户Id
     * @param canEdit 是否编辑
     * @return 题库Id集合
     * @since 2016年11月15日16:55:01 author by WuKang@HF
     */
    List<String> listBankByUserId(String userId, boolean canEdit);
}