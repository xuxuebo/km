package com.qgutech.pe.utils;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.time.DateUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * pe date utils
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月9日14:34:01
 */
public class PeDateUtils {

    public static final String FORMAT_YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";
    public static final String FORMAT_YYYY_MM_DD_HH_MM = "yyyy-MM-dd HH:mm";
    public static final String FORMAT_YYYY_MM_DD = "yyyy-MM-dd";
    public static final String FORMAT_YYYYMMDDHHMMSS = "yyyyMMddHHmmss";
    public static final String FORMAT_YYYYMMDD="yyyy/MM/dd";

    public static String format(Date date, String formatStr) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(formatStr);
        return dateFormat.format(date);
    }

    public static Date parse(String dateString, String formatStr) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(formatStr);
        try {
            return dateFormat.parse(dateString);
        } catch (ParseException e) {
            return null;
        }
    }


    public static Date parse(Date date, String formatStr) {
        String dateString = format(date, formatStr);
        return parse(dateString, formatStr);
    }


    public static long reduceDate(Date date, Date reduceDate) {
        if (date == null || reduceDate == null) {
            return NumberUtils.INTEGER_ZERO;
        }

        return (date.getTime() - reduceDate.getTime()) / 1000;
    }

    public static Date getFirstDate(Date date) {
        Date firstDate = DateUtils.setHours(date, 0);
        firstDate = DateUtils.setMinutes(firstDate, 0);
        return DateUtils.setSeconds(firstDate, 0);
    }

    public static Date getEndDate(Date date) {
        Date lastTime = DateUtils.setHours(date, 23);
        lastTime = DateUtils.setMinutes(lastTime, 59);
        return DateUtils.setSeconds(lastTime, 59);
    }

    public static String secToTime(int time) {
        String timeStr = "00:00";
        if (time <= 0) {
            return timeStr;
        }

        int minute = time / 60;
        if (minute < 60) {
            int second = time % 60;
            timeStr = unitFormat(minute) + ":" + unitFormat(second);
        } else {
            int hour = minute / 60;
            if (hour > 99) {
                return "99:59:59";
            }

            minute = minute % 60;
            int second = time - hour * 3600 - minute * 60;
            timeStr = unitFormat(hour) + ":" + unitFormat(minute) + ":" + unitFormat(second);
        }

        return timeStr;
    }

    private static String unitFormat(int i) {
        if (i >= 0 && i < 10) {
            return "0" + i;
        }

        return "" + i;
    }

    /**
     * 凌晨
     * @param date
     * @flag 0 返回yyyy-MM-dd 00:00:00日期<br>
     *       1 返回yyyy-MM-dd 23:59:59日期
     * @return
     */
    public static Date weeHours(Date date, int flag) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int hour = cal.get(Calendar.HOUR_OF_DAY);
        int minute = cal.get(Calendar.MINUTE);
        int second = cal.get(Calendar.SECOND);
        //时分秒（毫秒数）
        long millisecond = hour*60*60*1000 + minute*60*1000 + second*1000;
        //凌晨00:00:00
        cal.setTimeInMillis(cal.getTimeInMillis()-millisecond);

        if (flag == 0) {
            return cal.getTime();
        } else if (flag == 1) {
            //凌晨23:59:59
            cal.setTimeInMillis(cal.getTimeInMillis()+23*60*60*1000 + 59*60*1000 + 59*1000);
        }
        return cal.getTime();
    }

    public static long getDiffTime(Date date){
        long nowTime = System.currentTimeMillis();
        long endTime = date.getTime();
        long time = endTime - nowTime;
        long dateTemp1=time/1000; //秒
        long dateTemp2=dateTemp1/60; //分钟
        long dateTemp3=dateTemp2/60; //小时
        long dateTemp4=dateTemp3/24; //天数
        long dateTemp5=dateTemp4/30; //月数
        return dateTemp5;
    }
}
