package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.base.vo.ResultReport;
import com.qgutech.pe.module.ems.model.Exam;
import com.qgutech.pe.module.ems.model.ExamArrange;
import com.qgutech.pe.module.ems.model.ExamResult;
import com.qgutech.pe.module.ems.model.Knowledge;

import java.util.List;
import java.util.Map;


public interface ResultReportService extends BaseService<ExamResult> {

    /**
     * 【成绩分析，成绩总览】
     *
     * @param arrangeIds 安排ID集合
     * @param examId     考试ID
     * @return 成绩总览
     * @since 2017年1月14日18:08:09
     */
    ResultReport get(List<String> arrangeIds, String examId);

    /**
     * 【成绩分析，科目成绩总览】
     *
     * @param examId 综合类考试ID
     * @return 返回的信息如下：
     * <ul>
     * <li>{@linkplain Exam#examName 科目名称}</li>
     * <li>{@linkplain Exam#examType 科目类型}</li>
     * <li>{@linkplain ResultReport#passRate 及格率}</li>
     * <li>{@linkplain ResultReport#attendRate 参考率}</li>
     * <li>{@linkplain ResultReport#highScore 最高分}</li>
     * <li>{@linkplain ResultReport#lowScore 最低分}</li>
     * <li>{@linkplain ResultReport#averScore 平均分}</li>
     * </ul>
     * @throws IllegalArgumentException examId为空或者不存在科目
     * @since 2017年2月12日09:58:46
     */
    List<Exam> listSubject(String examId);

    /**
     * 【成绩分析，我的科目成绩总览】
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @return 科目集合，返回字段如下：
     * <ul>
     * <li>{@linkplain Exam#examName 科目名称}</li>
     * <li>{@linkplain Exam#examType 科目类型}</li>
     * <li>{@linkplain ExamArrange#startTime 开始时间}</li>
     * <li>{@linkplain ExamArrange#endTime 结束时间}</li>
     * <li>{@linkplain ExamResult#score 分数}</li>
     * <li>{@linkplain ExamResult#status 状态}</li>
     * </ul>
     * @since 2017年2月13日10:34:35
     */
    List<Exam> listSubject(String examId, String userId);

    /**
     * 【成绩分析，成绩总览】
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @return 成绩总览
     * @since 2017年1月14日18:08:09
     */
    ResultReport get(String examId, String userId);

    /**
     * 【成绩分析，弱项分析】
     *
     * @param examId 考试ID
     * @return 知识点集合
     * @since 2017年1月14日19:15:00
     */
    List<Knowledge> listKnowledge(String examId, String userId);

    /**
     * 【成绩分析，弱项分析】
     *
     * @param examIds 考试ID
     * @return 知识点集合
     * @since 2017年1月14日19:15:00
     */
    Map<String, List<Knowledge>> listKnowledge(List<String> examIds, String userId);

    /**
     * 【成绩分析，展示考试状态分布】
     *
     * @param examId 考试ID
     * @return 考试状态
     */
    List<ExamArrange> statisticExamStatus(String examId);

    /**
     * 【成绩分析，展示综合类考试状态分布】
     *
     * @param examId 考试ID
     * @return 考试状态
     */
    Exam statisticCompExamStatus(String examId);

    /**
     * 【成绩分析，展示考试分数分布】
     *
     * @param examId 考试ID
     * @return 考试分数
     */
    ResultReport statisticExamScore(String examId);

    /**
     * 【成绩分析，展示综合类或者科目考试分数分布】
     *
     * @param examId 考试ID
     * @return 考试分数
     */
    ResultReport statisticCompScore(String examId);

    /**
     * 【成绩分析，展示知识点分析】
     *
     * @param examId       考试ID
     * @param knowledgeIds 知识点ID集合
     * @since 2017年1月15日13:39:09
     */
    ResultReport statisticKnowledge(String examId, List<String> knowledgeIds);

    /**
     * 【成绩分析，展示知识点分析】
     *
     * @param examId       考试ID
     * @param knowledgeIds 知识点ID集合
     * @since 2017年1月15日13:39:09
     */
    ResultReport statisticCompKnowledge(String examId, List<String> knowledgeIds);

    /**
     * 【成绩分析，展示知识点分析】
     *
     * @param examId       考试ID
     * @param knowledgeIds 知识点ID集合
     * @since 2017年1月15日13:39:09
     */
    ResultReport statisticKnowledge(String examId, List<String> knowledgeIds, String userId);

    /**
     * 【成绩分析，获取科目的统计信息】
     *
     * @param examId 考试ID
     * @return 返回字段如下
     * <ul>
     * <li>{@linkplain Exam#examName 科目名称}</li>
     * <li>{@linkplain ExamArrange#missCount 缺考人数}</li>
     * <li>{@linkplain ExamArrange#passCount 通过人数}</li>
     * <li>{@linkplain ExamArrange#noPassCount 未通过人数}</li>
     * </ul>
     * @since 2017年2月12日14:15:13
     */
    List<Exam> statisticSubjectStatus(String examId);
}
