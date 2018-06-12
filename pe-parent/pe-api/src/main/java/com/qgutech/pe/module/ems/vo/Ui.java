package com.qgutech.pe.module.ems.vo;

import java.util.List;

/**
 * 学员选择的题目顺序以及选项顺序
 */
public class Ui {

    private List<Integer> ots;

    private String id;

    public List<Integer> getOts() {
        return ots;
    }

    public void setOts(List<Integer> ots) {
        this.ots = ots;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
