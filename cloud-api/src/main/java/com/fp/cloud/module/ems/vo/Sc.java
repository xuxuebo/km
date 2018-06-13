package com.fp.cloud.module.ems.vo;

import java.util.Map;

/**
 * 设置试卷的题型和数量
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月20日10:12:35
 */
public class Sc {

    /**
     * 数量
     */
    private Long c;

    /**
     * 简答组卷策略
     */
    private int[] tps;

    /**
     * key : 复杂模板中每种类型难度试题分布;
     * 1:代表容易类型
     * 2:代表较容易
     * 3:代表中等
     * 4:代表较难
     * 5:代表困难
     * value： 数量
     */
    private Map<Integer, Long> m;

    /**
     * 复杂组卷策略
     */
    private Map<Integer, int[]> stps;

    public Long getC() {
        return c;
    }

    public void setC(Long c) {
        this.c = c;
    }

    public Map<Integer, Long> getM() {
        return m;
    }

    public void setM(Map<Integer, Long> m) {
        this.m = m;
    }

    public int[] getTps() {
        return tps;
    }

    public void setTps(int[] tps) {
        this.tps = tps;
    }

    public Map<Integer, int[]> getStps() {
        return stps;
    }

    public void setStps(Map<Integer, int[]> stps) {
        this.stps = stps;
    }
}
