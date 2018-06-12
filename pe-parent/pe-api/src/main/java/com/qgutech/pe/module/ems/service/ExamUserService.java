package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.ExamArrange;
import com.qgutech.pe.module.ems.model.ExamUser;
import com.qgutech.pe.module.uc.model.User;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 考试人员关联服务类
 *
 * @version 1.0.0
 * @since 2016年11月18日13:37:25
 */
public interface ExamUserService extends BaseService<ExamUser> {
    /**
     * 【考试批次人员查询】
     * <p>查询一场考试下某一场批次对应的考试人员</p>
     *
     * @param arrangeId 批次Id
     * @param user      查询条件
     *                  <ul>
     *                  <li>{@linkplain User#userName 姓名}</li>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#mobile 手机号}</li>
     *                  <li>{@linkplain User#employeeCode 工号}</li>
     *                  <li>{@linkplain User#positionId 岗位Id}</li>
     *                  <li>{@linkplain com.qgutech.pe.module.uc.model.Organize#id 部门Id}</li>
     *                  </ul>
     * @param pageParam 分页
     * @return 用户分页数据，封装部门、岗位信息
     */
    Page<User> searchSelectUser(String arrangeId, User user, PageParam pageParam);

    /**
     * 【考试关联的删除】
     * <p>考试管理批次中删除一场考试下某个批次关联的指定人员</p>
     *
     * @param arrangeId 批次Id
     * @param referIds  关联的Ids
     * @return 受影响的行数
     */
    int delete(String arrangeId, List<String> referIds);

    /**
     * 【考试关联的删除】
     * <p>考试管理科目中删除一场考试下指定人员</p>
     *
     * @param examId   考试ID
     * @param referIds 关联的Ids
     * @return 受影响的行数
     */
    int deleteSubjectUser(String examId, List<String> referIds);

    /**
     * 【考试选择待选人员】
     * <p>该方法用于查询一场考试下某个批次的待选人员的分页信息</p>
     *
     * @param examId    考试ID
     * @param user      查询条件
     *                  <ul>
     *                  <li>{@linkplain User#userName 姓名}</li>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#mobile 手机号}</li>
     *                  <li>{@linkplain User#employeeCode 工号}</li>
     *                  <li>{@linkplain User#positionId 岗位Id}</li>
     *                  <li>{@linkplain com.qgutech.pe.module.uc.model.Organize#id 部门Id}</li>
     *                  </ul>
     * @param pageParam 分页查询对象
     * @return 返回查询的分页数据
     */
    Page<User> searchWaitUser(String examId, User user, PageParam pageParam);

    /**
     * 【监控页面查看考试选择待选人员】
     * <p>该方法用于查询一场考试下某个批次的待选人员的分页信息</p>
     *
     * @param examId    考试ID
     * @param user      查询条件
     *                  <ul>
     *                  <li>{@linkplain User#userName 姓名}</li>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#mobile 手机号}</li>
     *                  <li>{@linkplain User#employeeCode 工号}</li>
     *                  <li>{@linkplain User#positionId 岗位Id}</li>
     *                  <li>{@linkplain com.qgutech.pe.module.uc.model.Organize#id 部门Id}</li>
     *                  </ul>
     * @param pageParam 分页查询对象
     * @return 返回查询的分页数据
     */
    Page<User> searchMonitorWaitUser(String examId, User user, PageParam pageParam);

    /**
     * 【考试批次新增人员】
     * <p>将指定的人员或者部门加入到指定考试的指定批次中，保存考试和人员或者部门、岗位的关联关系</p>
     *
     * @param arrangeId    批次ID
     * @param referIds     id集合
     * @param examUserType 类型
     *                     <ul>
     *                     <li>{@linkplain ExamUser.ExamUserType#ORGANIZE 部门}</li>
     *                     <li>{@linkplain ExamUser.ExamUserType#POSITION 岗位}</li>
     *                     <li>{@linkplain ExamUser.ExamUserType#USER 用户}</li>
     *                     </ul>
     * @return 影响的行数
     */
    List<String> saveUser(String arrangeId, List<String> referIds, ExamUser.ExamUserType examUserType);

    /**
     * 【考试科目新增人员】
     * <p>将指定的人员或者部门加入到指定考试中，保存考试和人员或者部门、岗位的关联关系</p>
     *
     * @param examId       考试ID
     * @param referIds     id集合
     * @param examUserType 类型
     *                     <ul>
     *                     <li>{@linkplain ExamUser.ExamUserType#ORGANIZE 部门}</li>
     *                     <li>{@linkplain ExamUser.ExamUserType#POSITION 岗位}</li>
     *                     <li>{@linkplain ExamUser.ExamUserType#USER 用户}</li>
     *                     </ul>
     * @return 影响的行数
     */
    List<String> saveSubUser(String examId, List<String> referIds, ExamUser.ExamUserType examUserType);

    /**
     * 获取指定考试批次下，用户关联的排序
     *
     * @param examId  考试Id
     * @param batchId 考试批次Id
     * @return 该考试批次下的最大关联排序
     */
    double getMaxShowOrder(String examId, String batchId);

    /**
     * 【查询考试关联的组织】
     * <p>分页查询指定考试下批次已经选择的部门</p>
     *
     * @param examArrange 考试安排ID 科目类型或者批次类型
     * @param pageParam   分页数据
     * @return 分页的部门对象
     */
    Page<ExamUser> searchSelectOrg(ExamArrange examArrange, PageParam pageParam);

    /**
     * 根据批次ID获取对应的类型数量
     *
     * @param arrangeIds 批次ID
     * @return author by LiYanCheng@HF
     * @since 2016年11月24日18:18:57
     */
    Map<String, Map<ExamUser.ExamUserType, Long>> groupExamUserType(List<String> arrangeIds);

    /**
     * 根据考试ID获取科目的考试对应的类型下的参加考试的人数
     *
     * @param examIds 考试ID
     * @since 2016年11月24日18:18:57
     */
    Map<String, Map<ExamUser.ExamUserType, Long>> groupSubjectExamUserType(List<String> examIds);

    /**
     * 根据给定的考试Id,查询该考试下每个批次关联的用户人数
     *
     * @param examId 考试Id
     * @return Map
     * <ul>key:批次ID</ul>
     * <ul>value:Map
     * <li>key:关联类型</li>
     * <li>value:该类型关联的人数</li>
     * </ul>
     */
    Map<String, Map<ExamUser.ExamUserType, Long>> findUserCountByExamId(String examId);

    /**
     * 【科目考试人员查询】
     * <p>查询一场综合考试下对应的考试人员</p>
     *
     * @param examId    考试Id
     * @param user      查询条件
     *                  <ul>
     *                  <li>{@linkplain User#userName 姓名}</li>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#mobile 手机号}</li>
     *                  <li>{@linkplain User#employeeCode 工号}</li>
     *                  <li>{@linkplain User#positionId 岗位Id}</li>
     *                  <li>{@linkplain com.qgutech.pe.module.uc.model.Organize#id 部门Id}</li>
     *                  </ul>
     * @param pageParam 分页
     * @return 用户分页数据，封装部门、岗位信息
     */
    Page<User> searchComSelectUser(String examId, User user, PageParam pageParam);

    /**
     * 【监控科目考试人员查询】
     * <p>查询一场综合考试下对应的考试人员</p>
     *
     * @param examId    科目Id
     * @param user      查询条件
     *                  <ul>
     *                  <li>{@linkplain User#userName 姓名}</li>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#mobile 手机号}</li>
     *                  <li>{@linkplain User#employeeCode 工号}</li>
     *                  <li>{@linkplain User#positionId 岗位Id}</li>
     *                  <li>{@linkplain com.qgutech.pe.module.uc.model.Organize#id 部门Id}</li>
     *                  </ul>
     * @param pageParam 分页
     * @return 用户分页数据，封装部门、岗位信息
     */
    Page<User> searchMonitorComSelectUser(String examId, User user, PageParam pageParam);

    /**
     * 根据考试Id,查询考试下关联的人员Id和组织Id
     *
     * @param examId 考试Id
     * @return Map
     * <ul>
     * <li>key:关联类型</li>
     * <li>value:关联类型下的用户Id或者组织Id</li>
     * </ul>
     */
    Map<ExamUser.ExamUserType, List<String>> findReferId(String examId);

    /**
     * 查询考试安排人员信息
     *
     * @param examId 考试Id
     * @return Map
     * <ul>
     * <li>key:关联类型</li>
     * <li>value:
     * <ol>
     * <li>{@linkplain ExamUser#referId 关联ID}</li>
     * <li>{@linkplain ExamUser#ticket 准考证号}</li>
     * </ol>
     * </li>
     * </ul>
     */
    Map<ExamUser.ExamUserType, List<ExamUser>> find(String examId);

    /**
     * 根据考试Id,查询考试下关联的人员Id和组织Id
     *
     * @param examId    考试Id
     * @param arrangeId 批次ID
     * @return Map
     * <ul>
     * <li>key:关联类型</li>
     * <li>value:关联类型下的用户Id或者组织Id</li>
     * </ul>
     */
    Map<ExamUser.ExamUserType, List<String>> findReferId(String examId, String arrangeId);

    /**
     * 查询考试安排人员信息
     *
     * @param examId    考试Id
     * @param arrangeId 批次ID
     * @return Map
     * <ul>
     * <li>key:关联类型</li>
     * <li>value:
     * <ol>
     * <li>{@linkplain ExamUser#referId 关联ID}</li>
     * <li>{@linkplain ExamUser#ticket 准考证号}</li>
     * </ol>
     * </li>
     * </ul>
     */
    Map<ExamUser.ExamUserType, List<ExamUser>> find(String examId, String arrangeId);

    /**
     * 根据用户ID获取对应的考试信息以及批次信息
     *
     * @param userId 用户ID
     * @return author by LiYanCheng@HF
     * @since 2016年12月1日10:23:38
     */
    List<ExamUser> list(String userId);

    /**
     * 通过考试id和批次id查出所有组织的id
     *
     * @param examId     考试id
     * @param arrangeIds 批次id
     * @return 返回组织id集合
     */
    List<String> list(String examId, String[] arrangeIds);

    /**
     * 获取对应类型的数量
     *
     * @param examId    考试ID
     * @param arrangeId 安排ID
     * @param userType  查询类型
     * @return 总数
     * @since 2017年6月2日10:27:53
     */
    Long count(String examId, String arrangeId, ExamUser.ExamUserType userType);

    /**
     * 根据传过来的examUserList集合，修改导入考试人员信息
     * 如果人员已经存在则需判断准考证号是否相同
     * 如果考试人员不存在则新增
     *
     * @param examUserList
     * @return
     */
    void updateImport(List<ExamUser> examUserList, String examId, String examArrangeId);

    /**
     * 【获取准考证信息】
     *
     * @param examId  考试ID
     * @param userIds 学员ID集合
     * @return key userId value 准考证信息
     */
    Map<String, String> findTicket(String examId, List<String> userIds);

    /**
     * 【获取准考证信息】
     *
     * @param arrangeId 批次ID
     * @param userIds   学员ID集合
     * @return key userId value 准考证信息
     */
    Map<String, String> findTicketByArrange(String arrangeId, List<String> userIds);

    /**
     * 获取考试所有的准考证信息
     *
     * @param examId 考试ID
     * @return 准考证信息集合
     * @since 2017年7月7日14:54:55
     */
    Set<String> listTicket(String examId);
}
