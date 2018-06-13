package com.fp.cloud.module.ems.service;

import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.module.ems.model.SystemSetting;

/**
 * 系统消息设置服务类
 *
 * @since 2017年8月1日15:43:10
 */
public interface SystemSettingService extends BaseService<SystemSetting> {
    /**
     * 通过公司查询该公司的用户消息设置
     *
     * @param  systemType 系统类型
     * @return 返回系统消息设置
     *
     * @since 2017年8月2日 by wangxiaolong@hf
     */
    SystemSetting getByCorp(SystemSetting.SystemType systemType);

    /**
     * 是否开启了APP消息推送;
     * @return
     */
    boolean checkAppMsg();
    /**
     * 更新消息设置
     *
     * @param systemSetting
     *  <ul>
     *    <li>{@linkplain SystemSetting#id 系统设置}</li>
     *    <li>{@linkplain SystemSetting#examSetting 考试设置（和系统类型对应的不为空）}</li>
     *    <li>{@linkplain SystemSetting#userSetting 用户设置()}</li>
     *    <li>{@linkplain SystemSetting#systemType 系统类型}</li>
     * </ul>
     *
     */
    int updateMessage(SystemSetting systemSetting);
    /**
     * 保存系统消息消息设置
     *
     * @param systemSetting 系统设置信息
     * <ul>
     *    <li>{@linkplain SystemSetting#examSetting 考试设置}</li>
     *    <li>{@linkplain SystemSetting#userSetting 用户设置}</li>
     *    <li>{@linkplain SystemSetting#systemType 系统类型}</li>
     * </ul>
     * @since 2017年8月2日  by wangxiaolong@hf
     */
    void saveMessageSetting(SystemSetting systemSetting);

    /**
     * 获取系统设置信息；
     * @param systemType 系统设置类型
     * @return 系统设置
     */
    String  getMessage(SystemSetting.SystemType systemType);
}
