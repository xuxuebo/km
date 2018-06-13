package com.fp.cloud.module.exercise.vo;

import java.util.Map;

/**
 * 练习的组卷策略
 *
 * @author liuChen
 * @since 2017年3月24日15:22:59
 */
public class Esr {
    //试题的总数
    private int n;
    /**
     * 试题类型分布
     * 1:单选题数
     * 2:多选题数
     * 3:不定项选择题数
     * 4:判断题数
     * 5:填空题数
     */
    private Map<Integer, Long> m;

    public int getN() {
        return n;
    }

    public void setN(int n) {
        this.n = n;
    }

    public Map<Integer, Long> getM() {
        return m;
    }

    public void setM(Map<Integer, Long> m) {
        this.m = m;
    }
}
