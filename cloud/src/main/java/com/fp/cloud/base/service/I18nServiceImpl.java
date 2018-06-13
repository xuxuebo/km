package com.fp.cloud.base.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月13日17:49:15
 */
@Service("i18nService")
public class I18nServiceImpl implements I18nService {
    private final Log LOG = LogFactory.getLog(getClass());
    private Properties properties = null;

    public I18nServiceImpl() {
        InputStream inputStream = I18nServiceImpl.class.getClassLoader().getResourceAsStream("pe_zh_CN.properties");
        try {
            properties = new Properties();
            properties.load(inputStream);
        } catch (IOException e) {
            LOG.error(e);
        }
    }

    @Override
    public String getI18nValue(String i18nKey) {
        return properties.getProperty(i18nKey);
    }
}
