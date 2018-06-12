package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.ExamTemporary;

/**
 * 考试交卷异常
 * Created by limengfan on 2017/7/27.
 */
public interface ExamTemporaryService extends BaseService<ExamTemporary> {

    /**
     * 根据考试id 用户id以及考试异常信息保存考试异常信息表
     *
     * @param urString 考试异常信息的字符串
     * @param examId   考试Id
     * @param userId   用户id
     * @return 评卷异常表的主键
     */
    String save(String urString, String examId, String userId);

}
