package com.qgutech.km.utils;

import java.math.BigDecimal;
import java.util.regex.Pattern;

/**
 * Created by jianbolin on 2018/5/31.
 */
public class PeMathUtils {

    /**
     * 两个Double相加
     *
     * @param v1
     * @param v2
     * @return
     */
    public static double add(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.add(b2).doubleValue();
    }


    /**
     * 两个Double	乘
     *
     * @param v1
     * @param v2
     * @return
     */

    public static double mul(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.multiply(b2).doubleValue();
    }


    /**
     * 两个Double数相除
     *
     * @param v1
     * @param v2
     * @return Double
     */
    public static Double div(Double v1, Double v2) {
        BigDecimal b1 = new BigDecimal(v1.toString());
        BigDecimal b2 = new BigDecimal(v2.toString());
        return b1.divide(b2, 10, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    /**
     * 提供精确的小数位四舍五入处理
     *
     * @param v
     * @param scale 小数点后保留几位
     * @return
     */
    public static double round(double v, int scale) {
        if (scale < 0) {
            throw new IllegalArgumentException(
                    "The scale must be a positive integer or zero");
        }

        //todo need to codeReview ZhangYang@HF 2015年11月2日11:15:22
        if (Double.isNaN(v)) {
            throw new IllegalArgumentException("v is NaN!");
        }

        if (Double.isInfinite(v)) {
            throw new IllegalArgumentException("v is Infinite!");
        }

        BigDecimal b = BigDecimal.valueOf(v);
        BigDecimal one = new BigDecimal("1");
        return b.divide(one, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    public static Integer compareValue(Integer mark, Integer totalScore) {

        Integer backValue = (int) Math.floor(mark.floatValue() / totalScore.floatValue() * 100);

        return backValue;

    }

    public static void main(String args[]) {

        Pattern pattern = Pattern.compile("^(?:50(?:\\.0)?|1?\\d(?:\\.\\d*)?)$"); // 判断是否非负数
        String str = "18.32";

        if (pattern.matcher(str).matches()) //判断是否为整数
        {
            System.out.print("ok");
        } else {
            System.out.print("error");
        }
    }
}
