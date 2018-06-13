package com.fp.cloud.module.ems.vo;

import java.util.Map;

/**
 * 真正的试卷内容对象,Pr为Paper的简写
 *
 * @author Created by zhangyang on 2016/10/19.
 */
public class Prc {

    private Map<String, Pr> prm;

    public Map<String, Pr> getPrm() {
        return prm;
    }

    public void setPrm(Map<String, Pr> prm) {
        this.prm = prm;
    }
}
