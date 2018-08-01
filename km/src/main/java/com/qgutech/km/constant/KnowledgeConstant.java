package com.qgutech.km.constant;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 * Created by Administrator on 2018/6/22.
 */
public class KnowledgeConstant {
    /**
     * 云库类型 我的云库
     */
    public static String MY_LIBRARY = "MY_LIBRARY";
    /**
     * 公共库
     */
    public static String PUBLIC_LIBRARY = "PUBLIC_LIBRARY";
    /**
     * 回收站
     */
    public static String RECYCLE_LIBRARY = "RECYCLE_LIBRARY";
    /**
     * 终极库
     */
    public static String FINAL_LIBRARY = "FINAL_LIBRARY";
    /**
     * 专业分类
     */
    public static String SPECIALTY_LIBRARY = "SPECIALTY_LIBRARY";
    /**
     * 重点项目
     */
    public static String PROJECT_LIBRARY = "PROJECT_LIBRARY";
    /**
     * 部门分享库（每个部门建成一个库）
     */
    public static String ORG_SHARE_LIBRARY = "ORG_SHARE_LIBRARY";
    /**
     * 部门分享类型--人员
     */
    public static String TYPE_USER = "USER";
    /**
     * 部门分享类型--部门
     */
    public static String TYPE_ORG = "ORG";


    //分享相关

    //分享有效期 永久有效
    public static String SHARE_PERMANENT_VALIDITY = "permanent_validity";
    //有密码
    public static String SHARE_HAVE_PASSWORD = "password";
    //无密码
    public static String SHARE_NO_PASSWORD = "no_password";

    public static String LOG_COPY = "COPY";
    public static String LOG_DELETE = "DELETE";
    public static String LOG_UPLOAD = "UPLOAD";
    public static String LOG_DOWNLOAD = "DOWNLOAD";
    public static String LOG_SHARE = "SHARE";

    public static final DateFormat TIME_FORMAT= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public static final DateFormat DATE_FORMAT= new SimpleDateFormat("yyyy-MM-dd");
}
