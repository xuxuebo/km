package com.fp.cloud.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

/**
 * 正则表达式 工具类
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月29日11:19:45
 */
public class RegularUtils {

    /**
     * @param str 陆手机号码11位数，匹配格式：前三位固定格式+后8位任意数
     *            此方法中前三位格式有：
     *            13+任意数
     *            15+除4的任意数
     *            18+除1和4的任意数
     *            17+除9的任意数
     *            147
     * @since 2016年10月29日11:20:52
     */
    public static boolean checkMobile(String str) throws PatternSyntaxException {
        String RULE_MOBILE = "^((13[0-9])|(15[^4])|(18[0,1,2,3,5-9])|(17[0-8])|(147))\\d{8}$";
        Pattern p = Pattern.compile(RULE_MOBILE);
        Matcher m = p.matcher(str);
        return m.matches();
    }

    /**
     * 正则表达式校验邮箱
     *
     * @param email 待匹配的邮箱
     * @since 2016年10月29日11:20:52
     */
    public static boolean checkEmail(String email) {
        String RULE_EMAIL = "^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$";
        Pattern p = Pattern.compile(RULE_EMAIL);
        Matcher m = p.matcher(email);
        return m.matches();
    }


    /**
     * 正则表达式身份号码
     *
     * @param idCard 待匹配的身份号码
     * @since 2016年10月29日11:20:52
     */
    public static boolean checkIdCard(String idCard) {
        String RULE_ID_15 = "^[1-9]\\d{7}((0[1-9])||(1[0-2]))((0[1-9])||(1\\d)||(2\\d)||(3[0-1]))\\d{3}$";
        String RULE_ID_18 = "^[1-9]\\d{5}[1-9]\\d{3}((0[1-9])||(1[0-2]))((0[1-9])||(1\\d)||(2\\d)||(3[0-1]))\\d{3}([0-9]||X)$";
        Pattern p = Pattern.compile(RULE_ID_15);
        Matcher m = p.matcher(idCard);
        boolean success = m.matches();
        if (success) {
            return true;
        }

        p = Pattern.compile(RULE_ID_18);
        m = p.matcher(idCard);
        return m.matches();
    }
}
