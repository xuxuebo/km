package com.fp.cloud.utils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 读取config 配置文件 UTILS
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月10日17:47:16
 */
public class PropertiesUtils {

    private static final Log LOG = LogFactory.getLog(PropertiesUtils.class);
    private static Properties configProp = new Properties();
    private static Properties envProp = new Properties();

    static {
        InputStream inputStream = PropertiesUtils.class.getClassLoader().getResourceAsStream("config.properties");
        try {
            configProp.load(inputStream);

        } catch (IOException e) {
            LOG.error(e);
        }

        inputStream = PropertiesUtils.class.getClassLoader().getResourceAsStream("env.properties");
        try {
            envProp.load(inputStream);
        } catch (IOException e) {
            LOG.error(e);
        }
    }

    public static Properties getConfigProp() {
        return configProp;
    }

    public static Properties getEnvProp() {
        return envProp;
    }
}
