package com.fp.cloud.utils;


import org.apache.log4j.Logger;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * md5 utils
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年8月19日13:15:31
 */
public final class MD5Generator {

    private static final String CHARSET = "UTF-8";
    private static final String MD5 = "MD5";
    private static char[] HEX_DIGITS = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
    public static final Logger LOG = Logger.getLogger(MD5Generator.class);
    private MessageDigest digest;

    public MD5Generator() {
        try {
            this.digest = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException var2) {
            LOG.error("Can\'t create message digest!", var2);
        }

    }

    public void update(byte[] data, int offset, int len) {
        if (this.digest != null && data != null) {
            this.digest.update(data, offset, len);
        }
    }

    public void update(byte[] data) {
        if (data != null) {
            this.update(data, 0, data.length);
        }
    }

    public String getHexMD5() {
        byte[] digestData = this.digest.digest();
        return hexDigest(digestData);
    }

    public byte[] getMD5() {
        return this.digest.digest();
    }

    public static String getHexMD5(String data) {
        try {
            MessageDigest e = MessageDigest.getInstance("MD5");
            byte[] bytes = data.getBytes("UTF-8");
            e.update(bytes);
            byte[] byteDigest = e.digest();
            return hexDigest(byteDigest).toLowerCase();
        } catch (Exception var4) {
            LOG.error("Can\'t create message digest!", var4);
            return null;
        }
    }

    public static String hexDigest(byte[] byteDigest) {
        char[] chars = new char[byteDigest.length * 2];

        for (int i = 0; i < byteDigest.length; ++i) {
            chars[i * 2] = HEX_DIGITS[byteDigest[i] >> 4 & 15];
            chars[i * 2 + 1] = HEX_DIGITS[byteDigest[i] & 15];
        }

        return new String(chars);
    }
}
