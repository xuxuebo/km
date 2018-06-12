package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.Exam;
import com.qgutech.pe.module.ems.model.ExamArrange;
import com.qgutech.pe.module.ems.model.ExamAuth;

import java.util.List;
import java.util.Map;

/**
 * 考试批次服务类
 *
 * @since 2016年11月17日10:56:06
 */
public interface ExamArrangeService extends BaseService<ExamArrange> {

    /**
     * 【删除考试批次】
     * <p>删除考试下某个批次数据</p>
     *
     * @param arrangeId 考试Id
     * @return 影响的行数
     */
    int delete(String arrangeId);

    /**
     * 【更新单个考试安排信息】
     *
     * @param examArrange 考试安排实体
     * @return 受影响的行数
     * @since 2016年12月8日15:48:44 author by WuKang@HF
     */
    int update(ExamArrange examArrange);

    /**
     * 【保存线上考试的考试批次信息，用于生成考试的批次号，便于进行考试-批次-人员关联】
     * 根据考试ID生成一个考试批次信息，考试批次排序依次增加
     *
     * @param examId 考试ID
     * @return 考试批次的主键
     * @since 2016年11月20日16:35:09 author by chenHuaMei@HF
     */
    ExamArrange saveBatch(String examId);

    /**
     * 【更新试批次信息】
     * 根据考试批次对象，更新考试批次信息，主要更新一些字段，且字段值不可为空<ul>
     * <li>{@linkplain ExamArrange#id}</li>
     * <li>{@linkplain ExamArrange#batchName 批次名称（当批次大于1时，该值不可为空）}</li>
     * <li>{@linkplain ExamArrange#startTime 批次开始时间}</li>
     * <li>{@linkplain ExamArrange#endTime 批次结束时间}</li>
     * </ul>
     *
     * @param examArranges 考试批次信息
     */
    void update(List<ExamArrange> examArranges);

    /**
     * 【保存考试科目设置】
     * 考试安排的科目设置包含主键时为编辑，不包含时为新增.
     *
     * @param examArranges 科目考试安排信息集合
     * @param examId       考试ID
     * @since 2016年11月20日15:49:09 author by chenHuaMei@HF
     */
    void saveSubjectSetting(List<ExamArrange> examArranges, String examId);

    /**
     * 【保存考试安排的科目时间】
     * 考试安排的科目时间保存，根据主键id去更新数据库
     *
     * @param subjects 科目设置信息集合，以下不可为空<ul>
     *                 <li>{@linkplain ExamArrange#id 考试安排主键}</li>
     *                 <li>{@linkplain ExamArrange#startTime 开始时间}</li>
     *                 <li>{@linkplain ExamArrange#endTime 结束时间}</li>
     *                 </ul>
     * @param examId   考试ID
     * @since 2016年11月20日14:10:09 author by chenHuaMei@HF
     */
    void saveSubjectTime(List<ExamArrange> subjects, String examId);

    /**
     * 【查询考试下的考试安排信息】
     * 根据考试id集合，查询对应考试的考试安排信息。key：考试ID，vlaue是考试安排信息集合
     *
     * @param examIds 考试id集合
     * @return key：考试ID，vlaue是考试安排信息集合
     * @since 2016年11月20日11:49:09 author by chenHuaMei@HF
     */
    Map<String, List<ExamArrange>> findExamArranges(List<String> examIds);

    /**
     * 【查询考试下的考试安排信息】
     * 根据考试id集合，查询对应考试的考试安排信息。key：考试ID，vlaue是考试安排信息集合
     *
     * @param examIds  考试id集合
     * @param statuses 批次状态
     *                 <ul>
     *                 <li>{@linkplain com.qgutech.pe.module.ems.model.Exam.ExamStatus#ENABLE 启用}</li>
     *                 <li>{@linkplain com.qgutech.pe.module.ems.model.Exam.ExamStatus#DRAFT 状态}</li>
     *                 <li>{@linkplain com.qgutech.pe.module.ems.model.Exam.ExamStatus#CANCEL 作废}</li>
     *                 </ul>
     * @return key：考试ID，vlaue是考试安排信息集合
     * @since 2016年11月20日11:49:09 author by chenHuaMei@HF
     */
    Map<String, List<ExamArrange>> find(List<String> examIds, List<Exam.ExamStatus> statuses);

    /**
     * 【查询考试下的考试安排信息】
     * 根据考试id集合，查询对应考试的考试安排信息。key：考试ID，vlaue是考试安排信息集合
     *
     * @param subjectIds 科目id集合
     * @param statuses   批次状态
     *                   <ul>
     *                   <li>{@linkplain com.qgutech.pe.module.ems.model.Exam.ExamStatus#ENABLE 启用}</li>
     *                   <li>{@linkplain com.qgutech.pe.module.ems.model.Exam.ExamStatus#DRAFT 状态}</li>
     *                   <li>{@linkplain com.qgutech.pe.module.ems.model.Exam.ExamStatus#CANCEL 作废}</li>
     *                   </ul>
     * @return key：考试ID，vlaue是考试安排信息集合
     * @since 2016年11月20日11:49:09 author by chenHuaMei@HF
     */
    Map<String, ExamArrange> findBySubject(List<String> subjectIds, List<Exam.ExamStatus> statuses);

    /**
     * 获取当前考试下，考试安排的最大排序
     *
     * @param examId 考试Id
     * @return 该考试安排的最大排序
     */
    float getMaxShowOrder(String examId);

    /**
     * 根据考试id获取考试安排信息集合
     *
     * @param examId 考试Id
     * @return 考试安排实体集合
     * @since 2016年11月23日16:12:02 author by WuKang@HF
     */
    List<ExamArrange> listByExamId(String examId);

    /**
     * 获取综合类下科目信息
     *
     * @param examId 综合类考试ID
     * @return 返回的字段如下：
     * <ul>
     * <li>{@linkplain Exam#examName 科目名称}</li>
     * <li>{@linkplain Exam#id 科目ID}</li>
     * <li>{@linkplain Exam#examType 科目类型}</li>
     * </ul>
     * @since 2017年2月12日10:24:21
     */
    List<Exam> listSubject(String examId);

    /**
     * 【根据考试安排Id作废批次或科目】
     * 如果考试安排实体的subject属性为空则作废批次，
     * 否则作废科目。
     *
     * @param examArrangeId 考试安排id
     * @return 受影响的行数
     * @since 2016年12月1日10:12:54 author by WuKang@HF
     */
    int cancelExamArrange(String examArrangeId);

    /**
     * 【定时任务，获取考试安排信息】
     * 1、获取今天将要进行安排考试
     *
     * @return author by LiYanCheng@HF
     * @since 2016年12月14日18:42:55
     */
    List<ExamArrange> listToday();

    /**
     * 【定时任务，获取考试已经结束的考试安排信息】
     * 1、获取昨天结束的考试安排信息
     *
     * @return
     */
    List<ExamArrange> listOver();

    /**
     * 保存补考相应设置
     *
     * @param examArrange 补考安排
     * @return author by LiYanCheng@HF
     * @since 2017年1月6日19:22:57
     */
    String saveMarkUpExam(ExamArrange examArrange);

    /**
     * 更新补考设置
     *
     * @param examArrange 补考信息
     * @return author by LiYanCheng@HF
     * @since 2017年1月7日18:59:56
     */
    int updateMarkExam(ExamArrange examArrange);

    /**
     * 【管理员端，总控制台获取批次信息】
     *
     * @param examArrange 查询条件
     *                    <ul>
     *                    <li>{@linkplain ExamArrange#batchName 批次名称 模糊搜索}</li>
     *                    <li>{@linkplain ExamArrange#arrangeStatus 批次状态}</li>
     *                    <li>{@linkplain ExamArrange#exam 考试ID}</li>
     *                    </ul>
     * @return 具体返回字段，如下：
     * <ul>
     * <li>{@linkplain ExamArrange#batchName 批次名称}</li>
     * <li>{@linkplain ExamArrange#startTime 批次开始时间}</li>
     * <li>{@linkplain ExamArrange#endTime 批次结束时间}</li>
     * <li>{@linkplain ExamArrange#startTime 批次结束时间}</li>
     * <li>{@linkplain ExamArrange#testCount 应该人数}</li>
     * <li>{@linkplain ExamArrange#joinedCount 参加人数}</li>
     * <li>{@linkplain ExamArrange#submitCount 交卷人数}</li>
     * <li>{@linkplain ExamArrange#monitorUsers 监考老师}</li>
     * </ul>
     */
    List<ExamArrange> list(ExamArrange examArrange);
}
