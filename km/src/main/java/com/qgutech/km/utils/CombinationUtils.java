package com.qgutech.km.utils;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.List;

/**
 * @author Created by zhangyang on 2016/11/25.
 */
public class CombinationUtils {

    /**
     * 组合算法，从给定的结果集合中抽取n个组合，不进行全排列
     *
     * @param srcStr 需要进行抽取的总的字符串
     * @param sep    切分条件
     * @param n      抽取的个数
     * @param result 返回的结果结合
     */
    public static void genCom(String srcStr, String sep, int n, List<String> result) {
        String[] str_list = srcStr.split(sep);

        //选号位
        int[] pos = new int[n];

        //选不出来
        if (str_list.length < n || str_list.length <= 0 || n <= 0) {
            return;
        }

        //初始化前n是选号位
        for (int i = 0; i < n; i++) {
            pos[i] = i;
        }

        //循环处理
        while (true) {
            //1.生成选择数据
            StringBuilder buff = new StringBuilder();
            for (int i = 0; i < n; i++) {
                if (i > 0) {
                    buff.append(sep);
                }

                buff.append(str_list[pos[i]]);
            }

            result.add(buff.toString());

            //2.进位
            //从选号位最右边开始，选择第一个可以右移的位置进行进位
            boolean is_move = false;

            for (int i = n - 1; i >= 0; i--) {
                if (pos[i] < str_list.length - n + i)    //可以进位
                {
                    pos[i]++;   //选位右移

                    //所有右边的选号全部归位
                    for (int k = i + 1; k < n; ++k) {
                        pos[k] = pos[i] + k - i;
                    }
                    is_move = true;

                    break;
                }
            }

            if (!is_move)   //没有成功移位,到头了
            {
                break;
            }
        }
    }

    /**
     * 全排列算法，从给定的结果中出去n个全排列结果的集合
     *
     * @param srcStr 需要进行抽取的总的字符串
     * @param sep    切分条件
     * @param n      抽取的个数
     * @param result 返回的结果
     */
    public static void genPerm(String srcStr, String sep, int n, List<String> result) {
        String[] str_list = srcStr.split(sep);

        //选号位
        int[] pos = new int[n];

        //选不出来
        if (str_list.length < n || str_list.length <= 0 || n <= 0) {
            return;
        }

        //初始化前n是选号位
        for (int i = 0; i < n; i++) {
            pos[i] = i;
        }

        //先算组合，对组合计算全排列

        //循环处理
        while (true) {
            //pos为选择位，pos_为排列位
            //生成排列数据
            int[] pos_ = new int[n];
            System.arraycopy(pos, 0, pos_, 0, n);

            //阶乘,排列个数
            long total = factorial(n).longValue();

            //生成选好号位的排列
            for (int i = 0, p = 0; i < total; i++) {
                //生成选择数据
                StringBuilder buff = new StringBuilder();
                for (int k = 0; k < n; k++) {
                    if (k > 0) {
                        buff.append(sep);
                    }

                    buff.append(str_list[pos_[k]]);
                }

                result.add(buff.toString());

                if (p == (n - 1)) {
                    p = 0;
                }

                if (n > 1) {
                    int tmp = pos_[p];
                    pos_[p] = pos_[p + 1];
                    pos_[p + 1] = tmp;
                }

                p++;
            }

            boolean is_move = false;

            //从选号位最右边起，进位
            for (int i = n - 1; i >= 0; i--) {
                if (pos[i] < str_list.length - n + i)    //可以进位
                {
                    pos[i]++;   //选位右移

                    //所有右边的选号全部归位
                    for (int k = i + 1; k < n; ++k) {
                        pos[k] = pos[i] + k - i;
                    }
                    is_move = true;

                    break;
                }
            }

            if (!is_move)   //没有成功移位,到头了
            {
                break;
            }
        }
    }

    /**
     * 允许重号排列算法，不用移位挑选组合号码
     */
    public static void genPosPerm(String srcStr, String sep, int n, List<String> result) {
        String[] str_list = srcStr.split(sep);

        //选号位
        int[] pos = new int[n];

        //选不出来
        if (str_list.length <= 0 || n <= 0) {
            return;
        }

        //初始化前n是选号位,缺省都是第一个
        for (int i = 0; i < n; i++) {
            pos[i] = 0;
        }

        //循环处理
        while (true) {
            //生成选择数据
            StringBuilder buff = new StringBuilder();
            for (int i = 0; i < n; i++) {
                if (i > 0) {
                    buff.append(sep);
                }

                buff.append(str_list[pos[i]]);
            }

            result.add(buff.toString());

            boolean is_move = false;

            //从右边起，进位
            for (int i = n - 1; i >= 0; i--) {
                pos[i]++;   //选位右移

                if (pos[i] == str_list.length)  //前位需要进位
                {
                    pos[i] = 0;

                    if (i > 0) {
                        if (pos[i - 1] + 1 < str_list.length)    //进位OK
                        {
                            pos[i - 1]++;
                            is_move = true;
                            break;
                        }
                    } else    //无法进位
                    {
                        break;
                    }
                } else    //本位+1 OK
                {
                    is_move = true;
                    break;
                }
            }

            if (!is_move)   //没有成功移位,到头了
            {
                break;
            }
        }
    }

    /**
     * 允许重号组合算法
     * 选号位可以重复
     */
    public static void genRepCom(String srcStr, String sep, int n, List<String> result) {
        String[] str_list = srcStr.split(sep);

        //选号位
        int[] pos = new int[n];

        //选不出来
        if (str_list.length < n || str_list.length <= 0 || n <= 0) {
            return;
        }

        //初始化首位是选号位
        for (int i = 0; i < n; i++) {
            pos[i] = 0;
        }

        //循环处理
        while (true) {
            //生成选择数据
            StringBuilder buff = new StringBuilder();
            for (int i = 0; i < n; i++) {
                if (i > 0) {
                    buff.append(sep);
                }

                buff.append(str_list[pos[i]]);
            }

            result.add(buff.toString());    //生成号码

            //进位
            //从选号位最右边起，进位
            boolean is_move = false;

            for (int i = n - 1; i >= 0; i--) {
                if (pos[i] < (str_list.length - 1))    //可以进位
                {
                    pos[i]++;   //选位右移

                    //所有右边的选号全部归位
                    //归至相同位置
                    for (int k = i + 1; k < n; ++k) {
                        pos[k] = pos[i];
                    }
                    is_move = true;

                    break;
                }
            }

            if (!is_move)   //没有成功移位,到头了
            {
                break;
            }
        }
    }

    /**
     * 阶乘算法
     */
    public static BigDecimal factorial(int n) {
        BigDecimal result = new BigDecimal(1);
        BigDecimal a;
        for (int i = 2; i <= n; i++) {
            a = new BigDecimal(i);//将i转换为BigDecimal类型
            result = result.multiply(a);//不用result*a，因为BigDecimal类型没有定义*操作</span><span>
        }

        return result;
    }

    /**
     * 获取组合的总个数，无排序
     *
     * @param total  待选数
     * @param select 选择数
     * @return 组合的总数
     */
    public static long getComTotal(int total, int select) {
        BigDecimal n = factorial(total);
        BigDecimal m = factorial(select);
        BigDecimal n_m = factorial(total - select);
        BigDecimal divide = n.divide((m.multiply(n_m)), MathContext.DECIMAL32);
        return divide.longValue();
    }

    /**
     * 获取排列的总个数，有序
     *
     * @param total  待选数
     * @param select 选择数
     * @return 组合的总数
     */
    public static long getPermTotal(int total, int select) {
        BigDecimal n = factorial(total);
        BigDecimal n_m = factorial(total - select);
        BigDecimal divide = n.divide((n_m), MathContext.DECIMAL32);
        return divide.longValue();
    }
}
