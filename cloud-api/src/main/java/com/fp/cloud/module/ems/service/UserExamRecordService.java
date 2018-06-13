package com.fp.cloud.module.ems.service;

import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.module.ems.model.Item;
import com.fp.cloud.module.ems.model.UserExamRecord;

import java.util.List;
import java.util.Map;

/**
 * 学员考试记录接口
 *
 * @author LiYanCheng@HF
 * @since 2016年12月20日15:30:54
 */
public interface UserExamRecordService extends BaseService<UserExamRecord> {

    /**
     * 【管理员端，更新学员每道题考试记录分数信息】
     *
     * @param resultDetailId 考试结果ID
     * @param scoreMap       每题分数
     * @param totalScore     总分
     * @return 影响数
     * @since 2016年12月28日09:35:35
     */
    int update(String resultDetailId, String examId, Map<String, Double> scoreMap, Double totalScore);

    /**
     * 【管理员端，获取题目类型的考试记录信息】
     *
     * @param examId    考试ID
     * @param userId    学员ID
     * @param itemTypes 题目类型集合
     * @return 试题ID、答题记录
     * @since 2016年12月28日14:05:34
     */
    Map<String, UserExamRecord> find(String examId, String userId, List<Item.ItemType> itemTypes);

    /**
     * 【管理员端，获取题目类型的考试记录信息】
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @return 试题ID、答题记录 key 试题ID value
     * <ul>
     * <li>{@linkplain UserExamRecord#totalScore 试题学员总分数}</li>
     * <li>{@linkplain UserExamRecord#item 试题ID}</li>
     * <li>{@linkplain UserExamRecord#score 学员获得分数}</li>
     * <li>{@linkplain UserExamRecord#realScore 试题源总分数}</li>
     * </ul>
     * @since 2016年12月28日14:05:34
     */
    Map<String, UserExamRecord> find(String examId, String userId);


    /**
     * 【管理员端，获取题目类型的考试记录信息】
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @param detailId 考试结果详情ID
     * @return 试题ID、答题记录 key 试题ID value
     * <ul>
     * <li>{@linkplain UserExamRecord#totalScore 试题学员总分数}</li>
     * <li>{@linkplain UserExamRecord#item 试题ID}</li>
     * <li>{@linkplain UserExamRecord#score 学员获得分数}</li>
     * <li>{@linkplain UserExamRecord#realScore 试题源总分数}</li>
     * </ul>
     * @since 2017年8月16日19:38:20
     */
    Map<String, UserExamRecord> find(String examId, String userId, String detailId);

    /**
     * 【管理员端，获取题目类型的考试记录信息】
     *
     * @param resultDetailId 考试结果详情ID
     * @param itemTypes      题目类型集合
     * @return 试题ID、答题记录
     * @since 2016年12月28日14:05:34
     */
    Map<String, UserExamRecord> find(String resultDetailId, List<Item.ItemType> itemTypes);

    /**
     * 【管理员端，获取题目类型的考试记录信息】
     *
     * @param resultDetailId 考试结果详情ID
     * @return 试题ID、答题记录
     * @since 2016年12月28日14:05:34
     */
    Map<String, UserExamRecord> find(String resultDetailId);

    /**
     * 【管理员端，查询当前学员考试试题学答题详情记录】
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @return 答题详情记录
     * @since 2016年12月29日21:39:17
     */
    List<UserExamRecord> list(String examId, String userId);
}
