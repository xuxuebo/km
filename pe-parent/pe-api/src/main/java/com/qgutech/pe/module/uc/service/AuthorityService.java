package com.qgutech.pe.module.uc.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.uc.model.Authority;

import java.util.List;

/**
 * @author Created by zhangyang on 2016/10/27.
 */
public interface AuthorityService extends BaseService<Authority> {
    /**
     * 该方法用于查询全部的权限集合，不指定查询条件
     *
     * @return 全部权限的对象集合
     */
    List<Authority> list();

    /**
     * 该方法用于查询全部的权限主键集合
     *
     * @return 全部权限对象的主键Id集合
     */
    List<String> listIds();

    /**
     * 获取权限信息
     *
     * @param corpCode 公司ID
     * @param authCode 权限编号
     * @return 权限信息
     */
    Authority get(String corpCode, String authCode);
}
