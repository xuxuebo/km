package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.JudgeUserRecord;
import com.qgutech.pe.module.uc.model.User;

import java.util.List;
import java.util.Map;

/**
 * 评卷记录接口
 *
 * @author LiYanCheng@HF
 * @since 2016年12月26日17:28:42
 */
public interface JudgeUserRecordService extends BaseService<JudgeUserRecord> {

    /**
     * 【管理员端，获取已经卷卷数】
     *
     * @param examIds 考试ID集合
     * @param userId  用户ID
     * @return 考试ID、数量
     * @since 2016年12月26日17:33:18
     */
    Map<String, Long> findJudgeCount(List<String> examIds, String userId);

    /**
     * 【管理员端，获取已经卷卷数】
     *
     * @param examIds 考试ID集合
     * @return 考试ID、数量
     * @since 2016年12月26日17:33:18
     */
    Map<String, Long> findJudgeCount(List<String> examIds);

    /**
     * 【管理员端，保存评卷记录】
     *
     * @param judgeUserRecord 评卷记录信息
     *                        <ul>
     *                        <li>{@linkplain JudgeUserRecord#exam 考试ID}</li>
     *                        <li>{@linkplain JudgeUserRecord#user 用户ID}</li>
     *                        <li>{@linkplain JudgeUserRecord#season 理由}</li>
     *                        <li>{@linkplain JudgeUserRecord#score 总分}</li>
     *                        <li>{@linkplain JudgeUserRecord#markScoreMap 审批分数}</li>
     *                        </ul>
     * @return 主键
     * @since 2016年12月27日17:26:29
     */
    String save(JudgeUserRecord judgeUserRecord);

    /**
     * 【管理员端，分页预览已经评卷后的学员ID】
     *
     * @param examId    考试ID
     * @param pageParam 分页显示数据
     * @return 学员ID
     * @since 2016年12月28日11:02:34
     */
    Page<JudgeUserRecord> search(String examId, PageParam pageParam);

    /**
     * 【管理员端，获取对应的审批记录信息，封装用户信息】
     *
     * @param resultDetailId 考试结果ID
     * @param approvalType   审核类型
     * @return 审批记录信息
     * @since 2016年12月28日14:48:55
     */
    List<JudgeUserRecord> list(String resultDetailId, JudgeUserRecord.ApprovalType approvalType, String... fields);

    /**
     * 【管理员端，获取评卷人信息】
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @return key 评卷类型， value 评卷人信息
     * @since 2016年12月29日21:14:36
     */
    Map<JudgeUserRecord.ApprovalType, List<User>> findMarkUser(String examId, String userId);
}
