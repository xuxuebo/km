package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.module.ems.model.Exam;
import com.qgutech.pe.module.ems.model.ExamSetting;
import com.qgutech.pe.module.ems.model.Paper;
import com.qgutech.pe.module.ems.vo.Ei;
import com.qgutech.pe.module.ems.vo.Ua;
import com.qgutech.pe.module.ems.vo.Ur;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 操作redis中的考试信息 接口
 *
 * @author LiYanCheng@HF
 * @since 2016年12月6日09:21:42
 */
public interface ExamRedisService {

    /**
     * 【管理员端：保存redis中的考试基本信息】
     *
     * @param examId 考试ID
     * @return author by LiYanCheng@HF
     * @since 2016年12月21日14:14:59
     */
    String saveExamInfo(String examId);

    /**
     * 【学员端，获取考试信息 redis中】
     *
     * @param examId 考试ID
     * @param fields 字段新
     * @return 考试信息
     * @since 2016年12月12日15:51:45
     */
    Exam get(String examId, String... fields);

    /**
     * 【学员端，检测redis考试是否存在】
     *
     * @param examId 考试ID
     * @return 是否存在
     * @since 2016年12月12日15:51:45
     */
    Boolean exist(String examId);

    /**
     * 存储当天将要考试的人员信息存储到redis中
     *
     * @param examId 考试ID
     * @since 2016年12月21日14:57:30
     */
    void saveExamUser(String examId);

    /**
     * 存储当天将要考试的人员信息存储到redis中
     *
     * @param examId  考试ID
     * @param userIds 人员ID集合
     * @since 2016年12月21日14:57:30
     */
    void saveExamUser(String examId, List<String> userIds);

    /**
     * 【学员端，进入考试获取考试页面】
     * 主要流程如下：
     * 1、获取人员信息
     * 2、获取试卷信息
     * 3、更新redis中进入考试时间
     * 4、更新考试状态为考试中
     *
     * @param examId 考试ID 不可为空
     * @since 2016年12月3日13:13:02
     */
    Ur enterExam(String examId);

    /**
     * 【学员端，获取试卷信息】
     *
     * @param examId 试卷ID
     * @return 试卷信息
     * @since 2016年12月10日11:33:04
     */
    Paper getPaper(String examId);

    /**
     * 【评卷，获取学员试卷信息】
     *
     * @param examId 试卷ID
     * @return 试卷信息
     * @since 2016年12月10日11:33:04
     */
    Paper getPaper(String examId, String paperId);

    /**
     * 保存redis中考试信息试卷信息
     *
     * @param examId 考试ID
     * @since 2017年5月15日18:36:453
     */
    void savePaper(String examId);

    /**
     * 保存redis中考试信息试卷信息
     *
     * @param paperId 试卷ID
     * @since 2017年5月15日18:36:453
     */
    void savePaper(String paperId, String examId);

    /**
     * 【学员端，获取答题详情】
     * 主要流程如下：
     * 1、clientDate 为空时，直接返回redis中的答题情况
     * 2、对比clientDate，若redis中的更新时间小于clientDate，返回null；
     * 而客户端直接使用localStorage答题详情，并且客户端提交答题详情到服务端
     *
     * @param clientDate 客户端更新答题时间 可为空
     * @return 题号对应的答案 author by LiYanCheng@HF
     * @since 2016年12月3日13:13:31
     */
    Map<Integer, Ua> findUserAnswer(String examId, Date clientDate);

    /**
     * 【学员端，更新学员答题情况】
     * 主要流程如下：
     * 1、更新考生答题情况
     * 2、更新答题详情更新时间
     *
     * @param answerMap 答题详情
     * @return 更新时间 字符串 author by LiYanCheng@HF
     * @since 2016年12月3日13:18:33
     */
    String updateUserAnswer(String examId, Map<Integer, Ua> answerMap);

    /**
     * 更新考试时长
     *
     * @param examId 考试ID
     * @since 2016年12月9日14:38:25
     */
    void updateExamLength(String examId);

    /**
     * 【学员端，提交考试逻辑】
     * 1、更新redis考试提交试卷时间
     * 2、更新考试状态为待评卷
     * 3、考试答案详情移植到待评卷redis中，删除进行中的考试答案详情信息
     *
     * @param examId 考试ID
     * @return author by LiYanCheng@HF
     * @since 2016年12月6日09:24:26
     */
    int submitExam(String examId);

    /**
     * 【学员端，提交考试逻辑】
     * 1、更新redis考试提交试卷时间
     * 2、更新考试状态为待评卷
     * 3、考试答案详情移植到待评卷redis中，删除进行中的考试答案详情信息
     *
     * @param examId 考试ID
     * @return author by LiYanCheng@HF
     * @since 2016年12月6日09:24:26
     */
    int submitExam(String examId, String userId);

    /**
     * 【学员端，更新切屏次数】
     *
     * @param examId 考试ID
     * @return author by LiYanCheng@HF
     * @since 2016年12月3日17:47:43
     */
    int updateCutScreenTime(String examId);

    /**
     * 【管理员端，redis移除人员信息】
     *
     * @param examId  考试ID
     * @param userIds 人员ID集合
     * @return author by LiYanCheng@HF
     * @since 2016年12月5日15:38:32
     */
    int removeUser(String examId, List<String> userIds);

    /**
     * 获取考试中的答题详情
     *
     * @param examId 考试ID
     * @param userId 人员信息
     * @return author by LiYanCheng@HF
     * @since 2016年12月6日09:49:46
     */
    Ur getExamUr(String examId, String userId, String redisKey);

    /**
     * 获取考试中的答题详情
     *
     * @param examId  考试ID
     * @param userIds 人员信息
     * @return author by LiYanCheng@HF
     * @since 2016年12月6日09:49:46
     */
    Map<String, Ur> findExamUr(String examId, List<String> userIds, String redisKey);

    /**
     * 【学员端,存储学员考试记录信息到redis中】
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @param ur     学员考试记录信息
     * @since 2016年12月12日14:17:54
     */
    void saveExamUr(String examId, String userId, Ur ur, String redisKey);

    /**
     * 检测时长，是否超过考试时长
     *
     * @param examId 考试ID
     * @return 没有超过时长返回true author by LiYanCheng@HF
     * @since 2016年12月7日13:17:29
     */
    boolean checkExamLength(String examId);

    /**
     * 作废redis中的考试
     *
     * @param examId 考试ID
     * @return author by LiYanCheng@HF
     * @since 2016年12月5日16:28:36
     */
    int cancelExam(String examId);

    /**
     * 作废redis中的考试
     *
     * @param examId    考试ID
     * @param arrangeId 考试安排ID
     * @return author by LiYanCheng@HF
     * @since 2016年12月5日16:28:36
     */
    int cancelExam(String examId, String arrangeId);

    /**
     * 删除redis中的考试信息
     * 1、考试基本信息
     * 2、考试人员信息
     * 3、试卷信息
     *
     * @param examId 考试ID
     * @return author by LiYanCheng@HF
     * @since 2016年12月14日19:48:41
     */
    int removeExam(String examId);

    /**
     * 【管理员端，修改redis中考试设置信息】
     *
     * @param setting 考试设置信息
     * @param examId  考试ID
     * @return 执行数量
     * @since 2016年12月12日15:20:31
     */
    int saveExamSetting(ExamSetting setting, String examId);

    /**
     * 通过人员ID和考试ID获取对应的考试信息
     *
     * @param examId 考试ID
     * @param userId 人员ID
     * @return 考试开始时间以及结束时间
     * @since 2016年12月21日16:33:23
     */
    Ei getEi(String examId, String userId);

    /**
     * 删除缓存中的当天的考试配置
     *
     * @param examId
     */
    void deleteExamUser(String examId);


    /**
     * 【定时任务，处理所有公司今天结束的考试信息，主要处理redis中的数据信息】
     *
     * @return 执行考试的数量
     * @since 2017-10-26 15:40:29
     */
    int clearRedisExam();
}
