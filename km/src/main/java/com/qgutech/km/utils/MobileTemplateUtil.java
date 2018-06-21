package com.qgutech.km.utils;

import org.springframework.util.Assert;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@SuppressWarnings("unchecked")
public class MobileTemplateUtil {

    private static final Map<String, String> mobileTemplateMap = new HashMap<String, String>();

    static {
        try {
            InputStream inputStream = MobileTemplateUtil.class.getClassLoader()
                    .getResourceAsStream("msg-template/mobileTemplate.properties");
            Properties properties = new Properties();
            properties.load(inputStream);
            mobileTemplateMap.putAll((Map) properties);
        } catch (Exception e) {
            throw new RuntimeException("mobileTemplate.properties in classpath not exist!", e);
        }
    }

    public static String getTemplateId(String templateName) {
        String templateId = mobileTemplateMap.get(templateName);
        Assert.hasText(templateId, "templateId[templateName:" + templateName + "] is not exist!");
        return templateId;
    }
}