package com.fp.cloud.module.ems.vo;

/**
 * 考试科目设置
 */
public class Ess {
    /**
     * 若该科目成绩未通过，则最终成绩强制未通过 subjectsPass
     */
    private boolean sp;

    /**
     * 强制科目顺序，只有通过该科目的考试，才能参加下面的科目考试 subjectOrder
     */
    private boolean so;

    public boolean isSo() {
        return so;
    }

    public void setSo(boolean so) {
        this.so = so;
    }

    public boolean isSp() {
        return sp;
    }

    public void setSp(boolean sp) {
        this.sp = sp;
    }
}
