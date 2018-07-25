package com.qgutech.km.utils;

import org.apache.commons.dbcp.BasicDataSource;
import sun.misc.BASE64Decoder;

import java.sql.SQLFeatureNotSupportedException;
import java.util.logging.Logger;

public class KMBasicDataSource extends BasicDataSource {

    @Override
    public void setPassword(String password) {
        super.setPassword(deEncryptString(password));
    }

    @Override
    public void setUsername(String username) {
        super.setUsername(deEncryptString(username));
    }

    private static String deEncryptString(String express) {
        try {
            BASE64Decoder decoder = new BASE64Decoder();
            byte[] bytes = decoder.decodeBuffer(express);
            for (int i = 0; i < 5; i++) {
                bytes = decoder.decodeBuffer(new String(bytes, "UTF-8"));
            }
            return new String(bytes, "UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public Logger getParentLogger() throws SQLFeatureNotSupportedException {
        return Logger.getLogger("KMBasicDataSource");
    }
}