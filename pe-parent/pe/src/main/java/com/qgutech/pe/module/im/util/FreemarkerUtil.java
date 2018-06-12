package com.qgutech.pe.module.im.util;

import com.qgutech.pe.module.im.domain.ImConfig;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.net.URL;
import java.util.Map;

/**
 * Freemarker 工具类
 */
public class FreemarkerUtil {

    /**
     * 传入变量的值，获取相应的模板内容
     */
    public static String getTextFromTemplate(String templateName, Map<String, Object> param) {
        Configuration configuration = new Configuration();
        //设置模版所在文件夹
        try {
            URL url = FreemarkerUtil.class.getResource("/" + ImConfig.msgTemplateDir + "/");
            String filePath = url.getFile();
            configuration.setDirectoryForTemplateLoading(new File(filePath));
            //取得模版文件
            Template t = configuration.getTemplate(templateName + ".ftl");
            StringWriter writer = new StringWriter();
            t.process(param, writer);
            return writer.toString();
        } catch (IOException e) {
            throw new RuntimeException("send message IOException");
        } catch (TemplateException e) {
            throw new RuntimeException("send message TemplateException");
        }
    }
}
