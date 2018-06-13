package com.fp.cloud.module.ems.service;

import com.fp.cloud.module.ems.vo.Ua;
import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.module.ems.model.UserMockExamRecord;

import java.util.Map;

/**
 * 模拟考试答题记录服务类
 */
public interface UserMockExamRecordService extends BaseService<UserMockExamRecord> {
    /**
     * 保存模拟考试答题记录
     *
     * @param examId    模拟考试id
     * @param answerMap 学员答题记录
     */
    void saveUserAnswerRecord(String examId, Map<String, Ua> answerMap);

    /**
     * 通过模拟考试id,和学员id,查询出该学员的答题记录
     *
     * @param examId 模拟考试id
     * @param userId 学员id
     * @return itemid, 和答题记录
     */
    Map<String, UserMockExamRecord> getRecords(String examId, String userId);
}
