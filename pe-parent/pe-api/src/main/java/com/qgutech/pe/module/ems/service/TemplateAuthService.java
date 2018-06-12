package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.PaperTemplateAuth;

import java.util.List;

/**
 * 试卷模板权限服务类
 */
public interface TemplateAuthService extends BaseService<PaperTemplateAuth> {

    /**
     * 该方法用于给指定试卷模板添加授权人,已存在的直接跳过,可以批量添加操作
     *
     * @param paperTemplateId 试卷模板主键Id
     * @param userIds         用户主键集合
     * @throws java.lang.IllegalArgumentException paperTemplateId or userIds
     * @since 2016年10月20日09:55:29 author by WuKang@HF
     */
    void addUsers(String paperTemplateId, List<String> userIds);

    /**
     * 该方法用于校验当前用户是否有查看试卷模板的权限
     *
     * @param paperTemplateId 试卷模板Id
     * @return 是否有能够查看试卷模板的权限
     * @since 2016年10月20日11:43:46 author by WuKang@HF
     */
    boolean checkAuth(String paperTemplateId);

    /**
     * 根据指定试卷模板Id集合删除权限信息
     *
     * @param paperTemplateIds 试卷模板Id集合
     * @return 受影响的行数
     * @since 2016年10月21日15:47:20 author by WuKang@HF
     */
    int batchDelete(List<String> paperTemplateIds);

    /**
     * 根据指定试卷模板Id获得被授权人员的列表信息
     *
     * @param paperTemplateId 试卷模板id
     * @return 被授权人员的分页信息
     * @since 2016年11月9日16:32:01 author by WuKang@HF
     */
    Page<PaperTemplateAuth> search(String paperTemplateId, PageParam pageParam);

    /**
     * 该方法用于根据试卷模板主键获取授权信息,授权信息中包括以下显式信息
     * <ul>
     * <li>{@linkplain com.qgutech.pe.module.uc.model.User#loginName 用户名}</li>
     * <li>{@linkplain com.qgutech.pe.module.uc.model.User#userName 姓名}</li>
     * </ul>
     *
     * @param paperTemplateId 试卷模板主键
     * @return 试卷模板对应权限列表, 封装用户信息
     * @throws java.lang.IllegalArgumentException 当paperTemplateId为空时
     * @since 2016年11月10日12:19:59 author by WuKang@HF
     */
    List<PaperTemplateAuth> listByTemplateId(String paperTemplateId);

    /**
     * 批量处理人员授权中添加或者移除人员的保存操作
     *
     * @param paperTemplateId    试卷模板Id
     * @param paperTemplateAuths 试卷模板授权的列表集合
     * @since 2016年11月10日12:52:26 author by WuKang@HF
     */
    void saveAuthUser(String paperTemplateId, List<PaperTemplateAuth> paperTemplateAuths);

    /**
     * 批量移除指定试卷模板的用户集合
     *
     * @param paperTemplateId 试卷模板Id
     * @param userIds 用户Id集合
     * @return 受影响的行数
     * @since 2016年11月10日19:24:49 author by WuKang@HF
     */
    int batchDelete(String paperTemplateId,List<String> userIds);
}
