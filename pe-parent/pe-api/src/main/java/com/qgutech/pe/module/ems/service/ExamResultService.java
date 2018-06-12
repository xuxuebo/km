package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.base.vo.SocketVo;
import com.qgutech.pe.module.ems.model.Exam;
import com.qgutech.pe.module.ems.model.ExamMonitor;
import com.qgutech.pe.module.ems.model.ExamResult;
import com.qgutech.pe.module.ems.vo.Ur;
import com.qgutech.pe.module.uc.model.User;

import java.util.List;
import java.util.Map;

/**
 * 考试成绩操作
 *
 * @since 2016年12月3日09:42:20
 */
public interface ExamResultService extends BaseService<ExamResult> {

    /**
     * 删除考试记录信息
     *
     * @param examId  考试ID
     * @param userIds 用户ID集合
     * @return 执行数量
     * @since 2016年12月23日15:31:50
     */
    int removeExamRecord(String examId, List<String> userIds);

    /**
     * 查询学员考试（除综合类考试之外）的考试最后一次成绩记录
     *
     * @param examIds 考试ID集合
     * @param userId  学员ID
     * @return 考试最后一次成绩记录 <ur><li>key:考试ID</li><li>value:考试成绩</li> </ur>
     */
    Map<String, ExamResult> find(List<String> examIds, String userId);

    /**
     * 【获取考试结果信息】
     *
     * @param examIds  考试ID集合
     * @param userId   学员ID
     * @param statuses 考试状态
     *                 <ul>
     *                 <li>{@linkplain com.qgutech.pe.module.ems.model.ExamResult.UserExamStatus#MISS_EXAM 缺考}</li>
     *                 <li>{@linkplain com.qgutech.pe.module.ems.model.ExamResult.UserExamStatus#RELEASE 已发布}</li>
     *                 </ul>
     * @return 结果信息：
     * <ul>
     * <li>{@linkplain Exam#id 考试ID}</li>
     * <li>{@linkplain Exam#examName 考试名称}</li>
     * <li>{@linkplain ExamResult#pass 是否通过}</li>
     * <li>{@linkplain ExamResult#status 学员参考状态}</li>
     * </ul>
     */
    List<ExamResult> list(List<String> examIds, String userId, List<ExamResult.UserExamStatus> statuses);

    /**
     * 查询学员考试（除综合类考试之外）的考试最后一次成绩记录
     *
     * @param examIds 考试ID集合
     * @param userId  学员ID
     * @return 考试最后一次成绩记录 <ur><li>key:考试ID&userId</li><li>value:考试成绩</li> </ur>
     */
    Map<String, ExamResult> find(List<String> examIds, List<String> userId);

    /**
     * 查询学员考试（除综合类考试之外）的考试最后一次成绩记录
     *
     * @param examId  考试ID
     * @param userIds 学员ID
     * @return 考试最后一次成绩记录 <ur><li>key:考试ID</li><li>value:考试成绩</li> </ur>
     */
    ExamResult get(String examId, String userIds);

    /**
     * 【管理员端，获取发布成绩列表】
     * 1、显示自己创建或者授权并且启用的考试
     * 2、去除考试结束并且全都发布成绩的考试
     * 3、查询已经完成评卷的数量并且没有发布成绩
     *
     * @param keyword 关键字搜索：考试名称/考试编号
     * @return 考试列表
     * @since 2016年12月22日11:15:34
     */
    List<Exam> listExam(String keyword);

    /**
     * 【管理员端，分组获取学员对应的状态】
     *
     * @param examIds 考试ID集合
     * @param status  状态
     * @return 考试ID以及数量
     * @since 2016年12月22日16:27:50
     */
    Map<String, Long> findUserCount(List<String> examIds, ExamResult.UserExamStatus status);

    /**
     * 【管理员端，分组获取学员对应的状态】
     *
     * @param examIds  考试ID集合
     * @param statuses 状态
     * @return 考试ID以及数量
     * @since 2016年12月22日16:27:50
     */
    Map<String, Long> findUserCount(List<String> examIds, List<ExamResult.UserExamStatus> statuses);

    /**
     * 【管理员端，分组获取学员对应的状态】
     *
     * @param examIds 考试ID集合
     * @param status  状态
     * @return 考试ID以及数量
     * @since 2016年12月22日16:27:50
     */
    Map<String, List<String>> findUser(List<String> examIds, ExamResult.UserExamStatus status);

    /**
     * 【管理员端，分组获取学员对应的状态】
     *
     * @param examIds  考试ID集合
     * @param statuses 状态集合
     * @return 考试ID以及数量
     * @since 2016年12月22日16:27:50
     */
    Map<String, List<String>> findUser(List<String> examIds, List<ExamResult.UserExamStatus> statuses);

    /**
     * 【管理员端，分页展示已发布成绩列表】
     *
     * @param user       用户查询信息
     *                   <ul>
     *                   <li>{@linkplain User#keyword 姓名/用户名/工号/手机号}</li>
     *                   <li>{@linkplain User#organize 部门}</li>
     *                   <li>{@linkplain User#positionId 岗位}</li>
     *                   <li>{@linkplain User#userStatusList 学员状态}</li>
     *                   </ul>
     * @param examResult 考试信息
     *                   <ul>
     *                   <li>{@linkplain ExamResult#exam 考试ID}</li>
     *                   <li>{@linkplain ExamResult#passStatus 通过状态}</li>
     *                   </ul>
     * @return 人员信息如下：
     * <ul>
     * <li>{@linkplain User#userName 姓名 }</li>
     * <li>{@linkplain User#loginName 用户名 }</li>
     * <li>{@linkplain User#employeeCode 工号 }</li>
     * <li>{@linkplain User#organize 部门 }</li>
     * <li>{@linkplain User#positionName 岗位名称 }</li>
     * <li>{@linkplain User#status 状态 }</li>
     * <li>{@linkplain ExamResult#status 考试状态 }</li>
     * </ul>
     */
    Page<ExamResult> searchReleaseResult(User user, ExamResult examResult, PageParam pageParam);

    /**
     * 【管理员端，获取应考、已发布成绩学员列表】
     *
     * @param user 用户查询信息
     *             <ul>
     *             <li>{@linkplain User#keyword 姓名/用户名/工号/手机号}</li>
     *             <li>{@linkplain User#organize 部门}</li>
     *             <li>{@linkplain User#positionId 岗位}</li>
     *             <li>{@linkplain User#userStatusList 学员状态}</li>
     *             </ul>
     * @return 人员信息如下：
     * <ul>
     * <li>{@linkplain User#userName 姓名 }</li>
     * <li>{@linkplain User#loginName 用户名 }</li>
     * <li>{@linkplain User#employeeCode 工号 }</li>
     * <li>{@linkplain User#organize 部门 }</li>
     * <li>{@linkplain User#positionName 岗位名称 }</li>
     * <li>{@linkplain User#status 状态 }</li>
     * <li>{@linkplain ExamResult#status 考试状态 }</li>
     * </ul>
     */
    Page<ExamMonitor> search(User user, String examId, PageParam pageParam);

    /**
     * 【管理员端，分页展示评卷中成绩列表】
     *
     * @param user   用户查询信息
     *               <ul>
     *               <li>{@linkplain User#keyword 姓名/用户名/工号/手机号}</li>
     *               <li>{@linkplain User#organize 部门}</li>
     *               <li>{@linkplain User#positionId 岗位}</li>
     *               <li>{@linkplain User#userStatusList 学员状态}</li>
     *               </ul>
     * @param examId 考试ID
     * @return 人员信息如下：
     * <ul>
     * <li>{@linkplain User#userName 姓名 }</li>
     * <li>{@linkplain User#loginName 用户名 }</li>
     * <li>{@linkplain User#employeeCode 工号 }</li>
     * <li>{@linkplain User#organize 部门 }</li>
     * <li>{@linkplain User#positionName 岗位名称 }</li>
     * <li>{@linkplain User#status 状态 }</li>
     * <li>{@linkplain ExamResult#status 考试状态 }</li>
     * </ul>
     */
    Page<User> searchMarkingResult(User user, String examId, PageParam pageParam);

    /**
     * 【管理员端，分页展示缺考人员列表】
     *
     * @param user   用户查询信息
     *               <ul>
     *               <li>{@linkplain User#keyword 姓名/用户名/工号/手机号}</li>
     *               <li>{@linkplain User#organize 部门}</li>
     *               <li>{@linkplain User#positionId 岗位}</li>
     *               <li>{@linkplain User#userStatusList 学员状态}</li>
     *               </ul>
     * @param examId 考试ID
     * @return 人员信息如下：
     * <ul>
     * <li>{@linkplain User#userName 姓名 }</li>
     * <li>{@linkplain User#loginName 用户名 }</li>
     * <li>{@linkplain User#employeeCode 工号 }</li>
     * <li>{@linkplain User#organize 部门 }</li>
     * <li>{@linkplain User#positionName 岗位名称 }</li>
     * <li>{@linkplain User#status 状态 }</li>
     * <li>{@linkplain ExamResult#status 考试状态 }</li>
     * </ul>
     */
    Page<User> searchMissResult(User user, String examId, PageParam pageParam);

    /**
     * 【管理员端，发布成绩】
     * 1、修改examResult状态
     * 2、发送短信
     *
     * @param examId 考试ID
     * @return 影响数量
     */
    int publishResult(String examId);

    /**
     * 【管理员端，更新学员考试状态显示考试结果信息】
     *
     * @param examId     考试ID
     * @param examResult 考试查询信息
     *                   <ul>
     *                   <li>{@linkplain ExamResult#passStatus 通过状态}</li>
     *                   <li>{@linkplain ExamResult#status 状态}</li>
     *                   </ul>
     * @param pageParam  分页条件
     * @return 考试结果信息
     * @since 2016年12月29日17:20:29
     */
    Page<ExamResult> search(String examId, ExamResult examResult, PageParam pageParam);

    /**
     * 【管理员端，分页展示待发布成绩的人员信息】
     *
     * @param examResult 考试查询条件 以及人员查询条件
     * @param pageParam  分页查询条件
     * @return 人员信息
     * @since 2016年12月30日15:12:47
     */
    Page<ExamResult> searchReviewExam(ExamResult examResult, PageParam pageParam);

    /**
     * 分页展示成绩列表
     *
     * @param exam      查询条件
     *                  <ul>
     *                  <li>{@linkplain Exam#examName 考试名称/编号}</li>
     *                  <li>{@linkplain Exam#startTime 考试开始时间范围}</li>
     *                  <li>{@linkplain Exam#endTime 考试开始时间范围}</li>
     *                  <li>{@linkplain Exam#examType 考试类型}</li>
     *                  </ul>
     * @param pageParam 分页条件
     * @return author by LiYanCheng@HF
     * @since 2017年1月6日20:38:14
     */
    Page<Exam> searchResult(Exam exam, PageParam pageParam);

    /**
     * 获取批次对应的应考学员数量
     *
     * @param arrangeIds 安排批次id集合
     * @param examStatus 状态
     * @return author by LiYanCheng@HF
     * @since 2017年1月6日21:29:44
     */
    Map<String, Long> findArrangeUserCount(List<String> arrangeIds, ExamResult.UserExamStatus examStatus);

    /**
     * 获取批次对应的补考次数
     *
     * @param arrangeIds 安排批次id集合
     * @return author by LiYanCheng@HF
     * @since 2017年1月6日21:29:44
     */
    Map<String, Long> findExamCount(List<String> arrangeIds);

    /**
     * 【管理员端，考生明细】
     *
     * @param examResult 考试结果查询条件
     *                   <ul>
     *                   <li>{@linkplain User#keyword 姓名/用户名/工号/手机号}</li>
     *                   <li>{@linkplain User#organize 部门}</li>
     *                   <li>{@linkplain User#positionId 岗位}</li>
     *                   <li>{@linkplain ExamResult#status 状态}</li>
     *                   </ul>
     * @param pageParam  分页查询条件
     * @return 返回结果如下：
     * <ul>
     * <li>{@linkplain User#userName 姓名}</li>
     * <li>{@linkplain User#employeeCode 工号}</li>
     * <li>{@linkplain User#organize 部门}</li>
     * <li>{@linkplain User#positionName 岗位}</li>
     * <li>{@linkplain User#status 人员状态}</li>
     * <li>{@linkplain ExamResult#status 状态}</li>
     * <li>{@linkplain ExamResult#score 成绩}</li>
     * <li>{@linkplain ExamResult#firstScore 首次成绩}</li>
     * <li>{@linkplain ExamResult#examCount 补考次数}</li>
     * </ul>
     * @since 2017年1月10日11:26:26
     */
    Page<ExamResult> searchUserDetail(ExamResult examResult, PageParam pageParam);

    /**
     * 发布综合类考试成绩
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @return author by LiYanCheng@HF
     * @since 2017年1月9日16:41:34
     */
    int updateCompResult(String examId, String userId);

    /**
     * 【学员端，展示我的考试信息】
     *
     * @param pageParam  分页条件
     * @param examResult 查询条件
     *                   <ul>
     *                   <li>{@linkplain ExamResult#status 考试状态}</li>
     *                   <li>{@linkplain Exam#startTime 开始时间}</li>
     *                   <li>{@linkplain Exam#endTime 结束时间}</li>
     *                   <li>{@linkplain Exam#examType 考试类型}</li>
     *                   </ul>
     * @return 具体列表数据如下：
     * <ul>
     * <li>{@linkplain Exam#examName 考试名称}</li>
     * <li>{@linkplain Exam#startTime 考试开始时间}</li>
     * <li>{@linkplain Exam#endTime 考试结束时间}</li>
     * <li>{@linkplain Exam#examType 考试类型}</li>
     * <li>{@linkplain ExamResult#status 考试状态}</li>
     * <li>{@linkplain ExamResult#score 考试成绩}</li>
     * </ul>
     */
    Page<Exam> searchMyExam(PageParam pageParam, ExamResult examResult);

    /**
     * 【评卷主要入口，学员答卷自动评卷客观题，评卷完成后自动保存到数据库中，并存考试记录】
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @since 2017年1月13日16:47:07
     */
    void markUserExam(String examId, String userId);

    /**
     * 【评卷主要入口，学员答卷自动评卷客观题，评卷完成后自动保存到数据库中，并存考试记录】
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @since 2017年1月13日16:47:07
     */
    void markUserExam(Ur ur, String examId, String userId);

    /**
     * 考试排行
     *
     * @param examId 考试ID
     * @return 结果展示
     * @since 2017年1月13日20:35:37
     */
    List<ExamResult> listRankExam(String examId);

    /**
     * 【学员端，获取当前人员对应的考试的排名、试卷分数】
     *
     * @param examId 考试ID
     * @return 考试结果
     * @since 2017年1月13日20:51:00
     */
    ExamResult getRankExam(String examId);

    /**
     * 【管理员、学员端获取当前人员的排名】
     *
     * @param examId 考试ID
     * @param userId 人员ID
     * @return 排行
     * @since 2017年1月14日19:23:11
     */
    Long getUserRank(String examId, String userId);

    /**
     * 【管理员、学员端获取当前人员的排名】
     *
     * @param examIds 考试ID集合
     * @param userId  人员ID
     * @return 排行
     * @since 2017年1月14日19:23:11
     */
    Map<String, Long> findUserRank(List<String> examIds, String userId);

    /**
     * 修改导入考试结果信息
     *
     * @param examResults 考试结果信息
     * @param examId      考试ID
     * @return 考试结果ID集合
     * @since 2017年1月14日14:58:34
     */
    int updateImport(List<ExamResult> examResults, String examId);

    /**
     * 统计考试信息
     *
     * @param examIds 考试ID集合
     * @return 统计信息
     * @since 2017年1月15日10:53:12
     */
    Map<String, Exam> statisticsExam(List<String> examIds);

    /**
     * 统计考试信息
     *
     * @param subjectIds 科目ID集合
     * @return 统计信息
     * @since 2017年1月15日10:53:12
     */
    Map<String, Exam> statisticsSubject(List<String> subjectIds);

    /**
     * 【学员端，定时循环保存学员答题记录】
     *
     * @param ur 学员答题记录
     * @since 2017年2月13日15:07:46
     */
    SocketVo saveUserAnswerProcess(Ur ur);

    /**
     * 统计个人考试信息
     *
     * @param userId 用户ID
     * @return 统计个人考试信息，具体字段如下：
     * <ul>
     * <li>{@linkplain Exam#missCount 缺考数}</li>
     * <li>{@linkplain Exam#passCount 通过数 }</li>
     * <li>{@linkplain Exam#noPassCount 未通过数 }</li>
     * <li>{@linkplain Exam#examCount 总数 }</li>
     * </ul>
     * @since 2017年2月23日14:18:46 author by LiYanCheng
     */
    Exam statisticsUserExam(String userId);

    /**
     * 获取考试id信息
     *
     * @param userId           学员ID
     * @param userExamStatuses 状态
     * @return 考试ID集合
     * @since 2017年3月8日13:22:08
     */
    List<String> listExamId(String userId, List<ExamResult.UserExamStatus> userExamStatuses);

    /**
     * 获取可以补考的考试id
     *
     * @param userId 学员ID
     * @return 考试ID集合
     * @since 2017年3月8日13:40:49
     */
    List<String> listMarkUpExamId(String userId);
}
