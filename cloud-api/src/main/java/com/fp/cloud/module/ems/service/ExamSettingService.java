package com.fp.cloud.module.ems.service;

import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.module.ems.model.ExamSetting;

import java.util.List;
import java.util.Map;


/**
 * 考试设置服务类
 *
 * @since 2016年11月17日10:55:18
 */
public interface ExamSettingService extends BaseService<ExamSetting> {

    /**
     * 【线上考试考试设置保存】
     * 考试设置实体有主键时为编辑，没有的时候为新增
     *
     * @param examSetting 考试设置信息
     * @return 考试设置主键
     * @since 2016年11月18日09:21:07 author by WuKang@HF
     */
    String saveOnline(ExamSetting examSetting);

    /**
     * 【线下考试考试设置保存】
     * 考试设置实体有主键时为编辑，没有的时候为新增
     *
     * @param examSetting 考试设置信息
     * @return 考试设置主键
     * @since 2016年11月18日09:48:09 author by WuKang@HF
     */
    String saveOffline(ExamSetting examSetting);

    /**
     * 保存考试设置
     *
     * @param examSetting 考试设置相关信息
     * @return 主键
     * @since 2017年3月27日17:43:04
     */
    String save(ExamSetting examSetting);

    /**
     * 【综合考试考试设置保存】
     * 考试设置实体有主键时为编辑，没有的时候为新增
     *
     * @param examSetting 考试设置信息
     * @return 考试设置主键
     * @since 2016年11月18日10:29:42 author by WuKang@HF
     */
    String saveComprehensive(ExamSetting examSetting);

    /**
     * 【根据考试Id获取考试的考试设置信息】
     *
     * @param examId 考试Id
     * @return 考试设置信息
     * @since 2016年11月22日17:32:36 author by WuKang@HF
     */
    ExamSetting getByExamId(String examId);

    /**
     * 【根据考试Id获取考试的考试设置信息】
     *
     * @param examId 考试Id
     * @return 考试设置信息
     * @since 2016年11月22日17:32:36 author by WuKang@HF
     */
    ExamSetting getByExamId(String examId, String... fields);

    /**
     * 【根据考试Id删除考试的考试设置信息】
     *
     * @param examId 考试Id
     * @return 受影响的行数
     * @since 2016年11月22日19:31:00 author by WuKang@HF
     */
    int deleteByExamId(String examId);

    /**
     * 根据综合考试的考试ID和考试类型查询出综合考试所有科目考试都是折算后的分数
     *
     * @param examIdList 综合考试下的所有科目Id的集合
     * @return 综合考试所有科目设置的类型都是CONVERT 然后算出总分 如果返回值为-1则未查到
     * @throws IllegalArgumentException 当examIdList为空时
     *                                  todo need to codeReview
     * @since 2016-12-1 20:46:43 by limengfan@HF
     */
    Double sumSubjectConvertMark(List<String> examIdList);

    /**
     * 【根据考试Id集合获取考试设置信息Map】
     *
     * @param examIdList 考试Id的集合
     * @return 考试设置信息<ur><li>key:考试ID</li><li>value:考试设置</li></ur>
     * @since 2016-12-3 15:57:55 by chenHuaMei@HF
     */
    Map<String, ExamSetting> findExamSettingMap(List<String> examIdList);

    /**
     * 保存考试设置并且启用考试
     *
     * @param examSetting 考试设置相关信息
     * @since 2017年3月27日13:36:25
     */
    void saveEnableExam(ExamSetting examSetting);

    /**
     * 保存考试设置并且启用科目
     *
     * @param examSetting 考试设置相关信息
     * @since 2017年3月27日13:36:25
     */
    void saveEnableSubject(ExamSetting examSetting);
}
