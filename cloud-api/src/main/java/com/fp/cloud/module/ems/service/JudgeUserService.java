package com.fp.cloud.module.ems.service;

import com.fp.cloud.module.ems.model.Exam;
import com.fp.cloud.module.ems.model.ExamUser;
import com.fp.cloud.base.model.Page;
import com.fp.cloud.base.model.PageParam;
import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.module.ems.model.Item;
import com.fp.cloud.module.ems.model.JudgeUser;
import com.fp.cloud.module.uc.model.User;

import java.util.List;
import java.util.Map;

/**
 * 考试人员评卷的关联服务接口
 *
 * @author Created by zhangyang on 2016/11/22.
 */
public interface JudgeUserService extends BaseService<JudgeUser> {
    /**
     * 【评卷已选人员】
     * <p>分页查询指定考试下的已经选择的评卷管理员的分页数据</p>
     *
     * @param judgeUserRel 考试人员关联
     *                     <ul>
     *                     <li>{@linkplain Exam#id 考试Id}</li>
     *                     <li>{@linkplain User#id 用户Id}</li>
     *                     <li>{@linkplain ExamUser#referType 关联类型{@see ExamUserRelType}}</li>
     *                     </ul>
     * @param pageParam    分页对象
     * @return 分页的管理员用户数据
     */
    Page<User> searchSelectUser(JudgeUser judgeUserRel, PageParam pageParam);

    /**
     * 【评卷待选人员】
     * <p>分页查询指定考试下的待选的评卷管理员分页</p>
     *
     * @param judgeUserRel 考试人员关联
     *                     <ul>
     *                     <li>{@linkplain Exam#id 考试Id}</li>
     *                     <li>{@linkplain User#id 用户Id}</li>
     *                     <li>{@linkplain ExamUser#referType 关联类型{@see ExamUserRelType}}</li>
     *                     </ul>
     * @param condition    查询条件
     *                     {@linkplain User#keyword 关键字}
     * @param pageParam    分页
     * @return 分页的管理员用户数据
     */
    Page<User> searchWaitUser(JudgeUser judgeUserRel, User condition, PageParam pageParam);

    /**
     * 【评卷新增评卷人】
     * <p>对指定的一场考试中的批量的试题，添加相应的多个评卷人</p>
     *
     * @param examId       考试Id
     * @param judgeRelType 评卷类型
     *                     <ul>
     *                     <li>{@linkplain JudgeUser.JudgeType#ITEM 试题}</li>
     *                     <li>{@linkplain JudgeUser.JudgeType#PAPER 试卷}</li>
     *                     </ul>
     * @param referIds     关联Ids
     * @param userIds      用户Ids
     */
    void save(String examId, JudgeUser.JudgeType judgeRelType, List<String> referIds, List<String> userIds);

    /**
     * 【评卷删除评卷人】
     * <p>对指定的一场考试中的批量的试题或者考试Id，删除多个评卷人</p>
     *
     * @param examId       考试Id
     * @param judgeRelType 评卷类型
     *                     <ul>
     *                     <li>{@linkplain JudgeUser.JudgeType#ITEM 试题}</li>
     *                     <li>{@linkplain JudgeUser.JudgeType#PAPER 试卷}</li>
     *                     </ul>
     * @param referIds     关联Ids
     * @param userIds      用户Ids
     * @return 影响的行数
     */
    int delete(String examId, JudgeUser.JudgeType judgeRelType, List<String> referIds, List<String> userIds);

    /**
     * 【删除评卷人】
     * <p>对指定的一场考试,删除所有评卷人</p>
     *
     * @param examId 考试Id
     * @return 影响的行数
     */
    int deleteByExamId(String examId);

    /**
     * 【删除评卷人】
     * <p>对指定的一场考试指定的评卷类型,删除该考试下该类型评卷的所有评卷人</p>
     *
     * @param examId       考试Id
     * @param judgeRelType 评卷类型
     *                     <ul>
     *                     <li>{@linkplain JudgeUser.JudgeType#ITEM 试题}</li>
     *                     <li>{@linkplain JudgeUser.JudgeType#PAPER 试卷}</li>
     *                     </ul>
     * @return 影响的行数
     */
    int deleteByExamId(String examId, JudgeUser.JudgeType judgeRelType);

    /**
     * 【人工评卷，按试卷分配评卷人】
     *
     * @param examId  考试Id
     * @param userIds 用户Ids
     * @throws IllegalArgumentException 当examId为空，userIds集合为空
     * @since 2016年11月26日10:57:16 chenHuaMei@HF
     */
    void savePaperUser(String examId, List<String> userIds);

    /**
     * 【分页查看一场考试下的所有试卷的主观题】
     * <p>查询指定的一场考试下的全部已经生成试卷</p>
     *
     * @param examId    考试Id
     * @param pageParam 分页
     * @return 封装好的分页信息
     */
    Page<Item> searchItem(String examId, PageParam pageParam);

    /**
     * 【查询试题的评卷人】
     * <p>查询一场考试下的给定的试题对应的评卷人的信息</p>
     *
     * @param examId  考试Id
     * @param itemIds 试题Ids
     * @return 试题对应的评卷人列表
     * <ul>
     * <li>key:试题Id</li>
     * <li>value:试题对应的用户列表</li>
     * </ul>
     */
    Map<String, List<User>> findJudgeUserByItemIds(String examId, List<String> itemIds);

    /**
     * 【查询试题的评卷人】
     * <p>查询一场考试下的给定的试题对应的评卷人的信息</p>
     *
     * @param examId  考试Id
     * @param itemIds 试题Ids
     * @return 试题对应的评卷人列表
     */
    List<User> listJudgeUserByItemIds(String examId, List<String> itemIds);

    /**
     * 【根据考试ID获取评卷人信息集合】
     *
     * @param examId       考试Id
     * @param judgeRelType 评卷类型,可以为空，当为空时则不区分类型
     * @return 评卷人信息集合
     * @since 2016年11月26日10:45:02 chenHuaMei@HF
     */
    List<JudgeUser> listByExamId(String examId, JudgeUser.JudgeType judgeRelType);

    /**
     * 【根据考试ID和试题ID获取评卷人信息集合】
     *
     * @param examId
     * @param itemId
     * @return
     */
    List<JudgeUser> listItemJudgeUserByExamId(String examId, String itemId);
}
