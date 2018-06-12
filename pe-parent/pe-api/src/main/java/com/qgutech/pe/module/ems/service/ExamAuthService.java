package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.Exam;
import com.qgutech.pe.module.ems.model.ExamAuth;
import com.qgutech.pe.module.uc.model.User;

import java.util.List;
import java.util.Map;

/**
 * 考试权限服务操作
 *
 * @since 2016年11月17日11:56:06
 */
public interface ExamAuthService extends BaseService<ExamAuth> {
    /**
     * 【保存考试管理员】
     * 该方法是保存考试和人员ID关系。
     *
     * @param examId  考试ID
     * @param userIds 人员ID集合
     * @throws java.lang.IllegalArgumentException 当examId或者userIds为空时
     */
    void saveAuthUser(String examId, List<String> userIds);

    /**
     * 【删除考试管理员】
     * <p>该方法用于删除已经保存的考试管理员的关联关系</p>
     *
     * @param examId  考试Id
     * @param userIds 用户Ids
     * @return 影响的行数
     */
    int deleteAuthUser(String examId, List<String> userIds);

    /**
     * 【考试管理员已选人员】
     * <p>查询考试下已经选择的管理员的分页数据</p>
     *
     * @param examId 考试Id
     * @return 人员的分页数据
     */
    Page<User> searchSelectUser(String examId, PageParam pageParam);

    /**
     * 【考试管理员待选的人员】
     * <p>查询考试下的待选的管理员的分页数据</p>
     *
     * @param examId    考试Id
     * @param user      查询条件
     *                  <ul>
     *                  <li>{@linkplain User#userName 姓名}</li>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#mobile 手机号}</li>
     *                  <li>{@linkplain User#employeeCode 工号}</li>
     *                  </ul>
     * @param pageParam 分页
     * @return 分页用户对象
     */
    Page<User> searchWaitUser(String examId, User user, PageParam pageParam);

    /**
     * 根据考试id获取考试权限信息集合
     *
     * @param examId 考试Id
     * @return 考试权限实体集合
     * @since 2016年11月25日10:08:02 author by chenHuaMei@HF
     */
    List<ExamAuth> listByExamId(String examId);

    /**
     * 获取该用户对应是否含有该批次的权限
     *
     * @param arrangeIds 批次ID集合
     * @param userId     用户ID
     * @return key arrangeId value true or false
     * @since 2017年7月25日15:07:27
     */
    Map<String, Boolean> findAuth(List<String> arrangeIds, String userId);

    /**
     * 获取该场考试权限人员信息列表
     *
     * @param examIds   考试ID集合
     * @param referType 考试类型
     * @return key arrangeId value true or false
     * @since 2017年7月25日15:07:27
     */
    Map<String, List<String>> findUser(List<String> examIds, ExamAuth.ReferType referType);

    /**
     * 根据考试id获取考试权限信息集合
     *
     * @param examId 考试Id
     * @param userId 学员ID
     * @return 考试权限实体集合
     * @since 2016年11月25日10:08:02 author by chenHuaMei@HF
     */
    Boolean checkAuthExam(String examId, String userId);

    /**
     * 根据当前userId获取当前用户被授权的examId集合
     *
     * @return 被授权的examId集合
     * @since 2016年11月28日16:24:33 author by WuKang@HF
     */
    List<String> listAuthExamId();

    /**
     * 根据当前userId获取当前用户被授权的考试管理员和批次管理员的examId集合
     *
     * @param referType 关联类型
     * @param userId    用户ID
     * @return 被授权的examId集合
     * @since 2017年7月18日11:26:17 autho by wangxl@hf
     */
    List<String> listAuthExamId(ExamAuth.ReferType referType, String userId);

    /**
     * 获取该用户对应是否含有该考试的权限
     *
     * @param examIds 考试ID
     * @param userId  用户ID
     * @return key arrangeId value true or false
     * @since 2017年7月25日15:07:27
     */
    Map<String, Boolean> findExamAuth(List<String> examIds, String userId);

    /**
     * 【管理员端添加监考员】
     *
     * @param arrangeId 考试安排ID
     * @param examId    考试ID
     * @param userIds   学员ID集合
     * @return 主键集合
     */
    List<String> save(String arrangeId, String examId, List<String> userIds);

    /**
     * 【管理员端删除监考员】
     *
     * @param arrangeId 考试安排ID
     * @param examId    考试ID
     * @return 主键集合
     */
    int delete(String arrangeId, String examId, ExamAuth.ReferType referType);

    /**
     * 【管理员端删除监考员】
     *
     * @param arrangeIds 考试安排ID集合
     * @param examId    考试ID
     * @return 主键集合
     */
    int delete(List<String> arrangeIds, String examId, ExamAuth.ReferType referType);

    /**
     * 【管理员端删除监考员】
     *
     * @param examId 考试ID
     * @return 主键集合
     */
    int delete(String examId, ExamAuth.ReferType referType);

    /**
     * 【管理员端获取监考员集合】
     *
     * @param arrangeId 考试安排ID
     * @param examId    考试ID
     * @return 用户信息集合，具体字段如下：
     * <ul>
     * <li>{@linkplain User#id 学员ID}</li>
     * <li>{@linkplain User#userName 姓名}</li>
     * <li>{@linkplain User#loginName 用户名}</li>
     * </ul>
     */
    List<User> listUser(String arrangeId, String examId);

    /**
     * 【管理员查询监考员信息】
     *
     * @param examId 考试ID
     * @return 用户信息，具体列表下：key 安排ID value
     * <ul>
     * <li>{@linkplain User#id 学员ID}</li>
     * <li>{@linkplain User#userName 姓名}</li>
     * <li>{@linkplain User#loginName 用户名}</li>
     * </ul>
     */
    Map<String, List<User>> findUser(String examId);
}
