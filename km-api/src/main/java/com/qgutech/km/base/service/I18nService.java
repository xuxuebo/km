package com.qgutech.km.base.service;

/**
 * 国际化 统一管理 service
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月13日17:45:35
 */
public interface I18nService {

    /**
     * 通过I18n key 获取 国际化值
     *
     * @param i18nKey i18n key
     * @return 国际化值
     * @since 2016年10月13日17:47:37
     */
    String getI18nValue(String i18nKey);
}
