package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.Exam;
import com.qgutech.pe.module.ems.model.ExamArrange;
import com.qgutech.pe.module.ems.model.ExamMonitor;
import com.qgutech.pe.module.ems.model.ExamResult;
import com.qgutech.pe.module.sfm.model.PeFile;
import com.qgutech.pe.module.uc.model.User;

import java.util.List;
import java.util.Map;

/**
 * 下发监控记录接口
 *
 * @author LiYanCheng@HF
 * @since 2016年12月21日11:33:56
 */
public interface ExamMonitorService extends BaseService<ExamMonitor> {

    /**
     * 【管理员端，分页展示考试中成绩列表】
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
    Page<User> searchProcessResult(User user, String examId, PageParam pageParam);


    /**
     * 【管理员端，定时下发考试】
     *
     * @since 2016年12月24日13:46:45
     */
    void executeIssuedExam();

    /**
     * 获取批次对应的应考学员数量
     *
     * @param arrangeIds 安排批次id集合
     * @return author by LiYanCheng@HF
     * @since 2017年1月6日21:29:44
     */
    Map<String, Long> findUserCount(List<String> arrangeIds);

    /**
     * 获取批次对应的各种状态的学员数量
     *
     * @param arrangeIds   安排批次id集合
     * @param answerStatus 考试的状态
     * @return author by LiYanCheng@HF
     * @since 2017年1月6日21:29:44
     */
    Map<String, Long> findUserCount(List<String> arrangeIds, ExamMonitor.AnswerStatus answerStatus);

    /**
     * 获取考试对应的应考学员数量
     *
     * @param examId 考试ID
     * @return author by LiYanCheng@HF
     * @since 2017年1月6日21:29:44
     */
    Long getUserCount(String examId);

    /**
     * 【根据条件查询考试监控列表】
     * 根据监控条件，查询监控列表。
     * {@linkplain Exam#examName 考试名称，迷糊匹配}
     * {@linkplain Exam#examCode 考试编号，迷糊匹配}
     * {@linkplain Exam#examStatus 考试状态(多选)}
     * {@linkplain Exam#startTime 考试开始时间}
     * {@linkplain Exam#endTime 考试结束时间}
     * {@linkplain Exam#createUser 考试创建人，模糊：
     * {@linkplain User#userName 姓名}、{@linkplain User#loginName 用户名}、{@linkplain User#employeeCode 工号}、{@linkplain User#mobile 手机号}}
     *
     * @param examCondition 需要查询的考试
     * @param pageParam     分页
     * @return 考试信息集合
     */
    Page<Exam> searchExam(Exam examCondition, PageParam pageParam);

    /**
     * 【管理员端，分页展示考试监控信息】
     *
     * @param examMonitor 监控查询条件，具体查询条件如下：
     *                    <ul>
     *                    <li>{@linkplain User#keyword 用户名/姓名/工号/手机号}</li>
     *                    <li>{@linkplain User#organize 部门}</li>
     *                    <li>{@linkplain User#positionId 岗位}</li>
     *                    </ul>
     * @param pageParam   分页条件
     * @return 返回字段如下：
     * <ul>
     * <li>{@linkplain User#userName 姓名}</li>
     * <li>{@linkplain User#loginName 用户名}</li>
     * <li>{@linkplain ExamMonitor#examTime 进入时间}</li>
     * <li>{@linkplain ExamMonitor#submitTime 提交试卷时间}</li>
     * <li>{@linkplain ExamMonitor#duration 答题时长}</li>
     * <li>{@linkplain ExamMonitor#exitTimes 退出次数}</li>
     * <li>{@linkplain ExamMonitor#cutScreenCount 切屏次数}</li>
     * <li>{@linkplain ExamMonitor#illegalCount 违纪次数}</li>
     * </ul>
     * @since 2017-2-15 15:43:072
     */
    Page<ExamMonitor> search(ExamMonitor examMonitor, PageParam pageParam);

    /**
     * 【学员端，更新监控状态为进行中，更新进入时间】
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @since 2017年2月16日09:05:35
     */
    void updateExamTime(String examId, String userId);

    /**
     * 管理员段监控未开始的考试的首页
     *
     * @param pageParam 分页条件
     * @param user      参加该批次考试的人员信息
     * @return 返回以下字段
     * <ul>
     * <li>{@linkplain User#userName 姓名}</li>
     * <li>{@linkplain User#loginName 用户名}</li>
     * <li>{@linkplain User#organizeName 部门名称}</li>
     * <li>{@linkplain User#positionName 岗位名称}</li>
     * <li>{@linkplain User#mobile 手机号}</li>
     * <li>{@linkplain User#email 邮箱}</li>
     * </ul>
     */
    Page<User> searchExamUserNoStart(PageParam pageParam, User user, String arrangeId);

    /**
     * 删除已交卷的学员答卷
     * 主要删除 t_ems_user_exam_record;t_ems_exam_result_detail；t_ems_exam_result;三张表中的记录，同事将监控表中的监控状态修改
     *
     * @param arrangeId 考试批次的id
     * @param userId    考试学员的id
     */
    void deleteExamUserPaper(String arrangeId, String userId);

    /**
     * 通过批次id获取该批次应到，实到，交卷人数
     *
     * @param arrangeId
     * @return 批次信息
     */
    ExamArrange getMonitorNum(String arrangeId);

    /**
     * 获取监控信息
     *
     * @param userIds 用户ID集合
     * @param examId  考试ID
     * @return 监控信息
     * @since 2017年2月22日10:13:08
     */
    Map<String, ExamMonitor> find(List<String> userIds, String examId);

    /**
     * 获取监控信息
     *
     * @param userId 用户ID
     * @param examId 考试ID
     * @return 监控信息
     * @since 2017年2月22日10:13:08
     */
    ExamMonitor get(String userId, String examId);

    /**
     * 获取监控信息
     *
     * @param examId 考试ID
     * @return 监控消息
     * @since 2017年3月3日16:06:01
     */
    Map<String, ExamMonitor> find(String examId);

    /**
     * 获取监控信息
     *
     * @param examIds 考试ID集合
     * @param userId  学员ID
     * @return 监控信息
     * @since 2017年3月8日14:00:55
     */
    Map<String, ExamMonitor> findByExamId(List<String> examIds, String userId);

}
