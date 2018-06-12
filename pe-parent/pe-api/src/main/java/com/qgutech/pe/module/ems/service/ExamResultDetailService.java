package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.ExamResultDetail;

import java.util.List;

/**
 * 考试结果详情接口
 *
 * @author LiYanCheng@HF
 * @since 2017年1月4日09:58:27
 */
public interface ExamResultDetailService extends BaseService<ExamResultDetail> {

    /**
     * 【管理员端，获取学员考试详情】
     *
     * @param resultDetailId 考试详情ID
     * @return 考试详情记录
     * <ul>
     * <li>{@linkplain ExamResultDetail#score 分数}</li>
     * <li>{@linkplain ExamResultDetail#totalScore 总分}</li>
     * <li>{@linkplain ExamResultDetail#pass 是否通过}</li>
     * <li>{@linkplain ExamResultDetail#paper 试卷信息}</li>
     * </ul>
     * @since 2017年1月10日11:24:49
     */
    ExamResultDetail get(String resultDetailId);

    /**
     * 【管理员端，获取学员考试最高分详情】
     *
     * @param userId 学员ID
     * @param examId 考试ID
     * @return 考试详情记录
     * <ul>
     * <li>{@linkplain ExamResultDetail#score 分数}</li>
     * <li>{@linkplain ExamResultDetail#totalScore 总分}</li>
     * <li>{@linkplain ExamResultDetail#pass 是否通过}</li>
     * <li>{@linkplain ExamResultDetail#paper 试卷信息}</li>
     * </ul>
     * @since 2017年3月16日14:59:15
     */
    ExamResultDetail get(String userId, String examId);

    /**
     * 【管理员端，获取学员每次考试记录信息】
     *
     * @param userId 学员ID
     * @param examId 考试ID
     * @return 考试详情记录集合
     * <ul>
     * <li>{@linkplain ExamResultDetail#id 主键}</li>
     * <li>{@linkplain ExamResultDetail#markExam 补考ID}</li>
     * <li>{@linkplain ExamResultDetail#exam 考试ID}</li>
     * </ul>
     * @since 2017年3月16日14:59:15
     */
    List<ExamResultDetail> list(String userId, String examId);
}
