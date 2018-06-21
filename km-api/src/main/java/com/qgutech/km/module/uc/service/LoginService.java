package com.qgutech.km.module.uc.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.module.uc.model.User;

/**
 * 登录服务接口
 *
 * @author Created by zhangyang on 2016/11/4.
 */
public interface LoginService extends BaseService<User> {
    /**
     * 该方法用于根据用户登录名获取用户信息
     *
     * @param loginName 登录名是以下几种：
     *                  <ul>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#userName 姓名}</li>
     *                  <li>{@linkplain User#mobile 手机号}</li>
     *                  </ul>
     * @return 用户对象
     */
    User getUserByLoginName(String loginName);

    /**
     * 登录名是否存在
     *
     * @param loginName 登录名
     *                  <ul>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#userName 姓名}</li>
     *                  <li>{@linkplain User#mobile 手机号}</li>
     *                  </ul>
     * @return 是否存在 true 存在 false 不存在
     */
    boolean existLoginName(String loginName);

    /**
     * 【学员端，登录系统】
     *
     * @param loginUser 具体字段如下：
     *                  <ul>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#password 密码}</li>
     *                  </ul>
     * @return
     */
    JsonResult<User> login(User loginUser);
}
