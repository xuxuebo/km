package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.Item;
import com.qgutech.pe.module.ems.model.Knowledge;
import com.qgutech.pe.module.ems.model.MockExam;
import com.qgutech.pe.module.ems.model.MockExamResultDetail;

import java.util.List;
import java.util.Map;

/**
 * 学员模拟考试成绩详情服务类
 */
public interface MockExamResultDetailService extends BaseService<MockExamResultDetail> {
    /**
     * 保存模拟考试的考试记录详情表并更新result表中记录
     *
     * @param examId
     */
    void saveMockExamResultDetail(String examId);

    /**
     * 学员提交答卷时，创建ResultDetail记录，并且更新Result表中的last_result_detail_id
     *
     * @param examId
     */
    void saveAndUpdateExamResultDetail(String examId);

    /**
     * 获取该学员在该模拟考试中的知识点，得分率
     *
     * @param exam 模拟考试的id
     * @return String knowledgeId知识点id,知识点详情
     */
    List<Map<String, Double>> searchItems(MockExam exam);

    /**
     * 获取该学员参加模拟考试的所有试卷的知识点
     *
     * @param examId 模拟考试的id
     * @return 学员参加考试的试卷中出现的知识点
     */
    List<Knowledge> listKnowledge(String examId);

    /***
     * 获取该学员参加的模拟考试试卷所有知识点的平均得分率
     *
     * @param exam 模拟考试id 和模拟考试的知识点
     * @return 知识点和知识点的平均得分率
     */
    Map<String, Double> searchTotalScoreRate(MockExam exam);
}
