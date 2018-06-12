package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.Exam;
import com.qgutech.pe.module.ems.model.ExamSetting;
import com.qgutech.pe.module.uc.model.User;

import java.util.List;
import java.util.Map;

/**
 * 考试管理服务类
 *
 * @since 2016年11月17日10:55:40
 */
public interface ExamService extends BaseService<Exam> {

    /**
     * 【保存考试基本信息】
     * 该接口根据考试Id来判断是新增还是编辑考试的基本信息
     *
     * @param exam 考试基本信息
     * @return 主键
     * @since 2016年11月17日14:00:40 author by WuKang@HF
     */
    String save(Exam exam);

    /**
     * 【根据考试编号获取考试信息】
     *
     * @param examCode 考试编号
     * @return 考试信息
     * @since 2016年11月17日14:30:27 author by WuKang@HF
     */
    Exam getByExamCode(String examCode);

    /**
     * 【保存考试设置,并修改考试状态操作】
     *
     * @param examSetting 考试设置
     * @param examStatus  考试状态：{@linkplain Exam.ExamStatus#DRAFT 草稿} {@linkplain Exam.ExamStatus#PROCESS 启用}
     * @throws java.lang.IllegalArgumentException 当examSetting未空，或者examStatus为空
     */
    void saveExamSettingAndExamStatus(ExamSetting examSetting, Exam.ExamStatus examStatus);

    /**
     * 【发布考试】
     * 根据考试ID去发布考试
     * 具体操作：1、更新考试状态；2、下发考试到学员
     *
     * @param examId 考试ID
     * @throws java.lang.IllegalArgumentException 当examId未空
     *                                            com.qgutech.pe.utils.PeException
     *                                            <ul>
     *                                            <li>当examId对应的考试不存等会抛出异常</li>
     *                                            </ul>
     */
    void releaseExam(String examId);

    /**
     * 【根据条件查询考试列表】
     * 根据考试条件，查询考试结果列表。
     * 考试查询条件：
     * {@linkplain Exam#examName 考试名称，迷糊匹配}
     * {@linkplain Exam#examCode 考试编号，迷糊匹配}
     * {@linkplain Exam#examStatus 考试状态(多选)}
     * {@linkplain Exam#examTypes 考试类型(多选)}
     * {@linkplain Exam#startTime 考试时间范围开始时间}
     * {@linkplain Exam#endTime 考试时间范围结束时间}
     * {@linkplain Exam#createUser 考试创建人，模糊：
     * {@linkplain User#userName 姓名}、{@linkplain User#loginName 用户名}、{@linkplain User#employeeCode 工号}、{@linkplain User#mobile 手机号}}
     *
     * @param examCondition 考试筛选条件
     * @param pageParam     分页
     * @return 考试查询结果
     */
    Page<Exam> searchExam(Exam examCondition, PageParam pageParam);

    /**
     * 【根据条件查询科目列表】
     * 根据{@linkplain Exam#includeCreator 是否包含创建人}来关键字查询
     * 是否包含“创建人”条件
     * <p>
     * 科目查询条件：
     * {@linkplain Exam#examType 科目类型（多选）}
     * 关键字模糊查询：
     * {@linkplain Exam#examName 科目名称，迷糊匹配}
     * {@linkplain Exam#_examCode 科目编号}
     * {@linkplain Exam#createUser 考试创建人，模糊：
     * {@linkplain User#userName 姓名}、{@linkplain User#loginName 用户名}、{@linkplain User#employeeCode 工号}、{@linkplain User#mobile 手机号}}
     *
     * @param examCondition 科目筛选条件
     * @param pageParam     分页
     * @return 科目查询结果
     */
    Page<Exam> searchSubject(Exam examCondition, PageParam pageParam);

    /**
     * 【根据考试Id删除考试】
     * 若为考试实体，则该考试只能是草稿状态；
     * 同时删除考试关联的考试设置和考试关联的试卷,具体删除数据如下:
     * <ul>
     * <li>考试管理员关联信息（科目不删除）</li>
     * <li>考试人员信息（科目不删除）</li>
     * <li>考试安排信息（科目不删除）</li>
     * <li>试卷信息</li>
     * <li>考试设置信息</li>
     * <li>考试评卷人关联信息</li>
     * <li>考试基本信息</li>
     * </ul>
     *
     * @param examId 考试ID
     */
    void deleteExam(String examId);

    /**
     * 启用考试
     * 具体实现步骤如下：
     * <ul>
     * <li>更新状态</li>
     * <li>动态页面静态化</li>
     * <li>综合考试时，复制科目信息，重新关联最新科目</li>
     * <li>定时任务下发成绩</li>
     * <li>发送消息</li>
     * <li>监控数据生成</li>
     * </ul>
     *
     * @param examId 考试ID
     */
    void enableExam(String examId);

    /**
     * 【启用科目】
     * 检测科目是否绑定试卷模板
     *
     * @param examId 科目Id
     * @return 受影响的行数
     * @since 2016年11月21日19:06:19 author by WuKang@HF
     */
    int enableSubject(String examId);

    /**
     * 【科目复制】
     * 复制科目的基本信息、关联试卷信息、关联的考试设置。
     * 科目设置信息：
     * 1.线下科目设置不复制“消息设置”。
     *
     * @param examId 考试Id
     * @param source 科目复制来源
     * @return 复制后的实体主键，返回值可能为null
     * @throws java.lang.IllegalArgumentException 当examId未空，或者subject不为ture时.
     * @since 2016年11月22日20:06:16
     */
    String copySubject(String examId, Exam.Source source);

    /**
     * 【考试复制】
     *
     * @param examId     考试ID
     * @param copyFields 复制字段
     *                   <ul>
     *                   <li>{@linkplain com.qgutech.pe.module.ems.model.Exam.CopyField#PAPER_SETTING 试卷信息}</li>
     *                   <li>{@linkplain com.qgutech.pe.module.ems.model.Exam.CopyField#EXAM_SETTING 考试设置}</li>
     *                   <li>{@linkplain com.qgutech.pe.module.ems.model.Exam.CopyField#EXAM_USER 考试人员信息}</li>
     *                   <li>{@linkplain com.qgutech.pe.module.ems.model.Exam.CopyField#EXAM_TIME 考试时间}</li>
     *                   </ul>
     * @return 复制后的实体主键
     * @throws java.lang.IllegalArgumentException 当examId未空，或者subject为true时.
     * @since 2016年11月23日09:16:49
     */
    String copyExam(String examId, List<Exam.CopyField> copyFields);

    /**
     * 【根据考试Id集合封装考试信息】
     * map的key为考试id，value为考试信息,具体信息如下：
     * {@linkplain Exam#examName 考试名称}
     * {@linkplain Exam#examType 考试类型}
     * {@linkplain Exam#id 考试创id}
     * {@linkplain Exam#createBy 考试创建人姓名}
     *
     * @param examIds 考试id集合
     * @return 封装的考试map
     * @since 2016年11月25日15:13:53 author by WuKang@HF
     */
    Map<String, Exam> find(List<String> examIds);

    /**
     * 更新考试状态
     *
     * @param examId 考试ID
     * @param status 考试状态
     * @return author by LiYanCheng@HF
     * @since 2016年12月5日15:46:01
     */
    int updateStatus(String examId, Exam.ExamStatus status);

    /**
     * 【停用科目】
     * 同时去除科目与考试的关联
     *
     * @param examId 科目Id
     * @return 受影响的行数
     * @since 2016年12月7日11:13:26 author by WuKang@HF
     */
    int disableSubject(String examId);

    /**
     * 【管理员端，获取待评卷的考试列表】
     * 1、获取待评卷或者是考试管理员可以评卷
     *
     * @param exam      考试查询条件
     *                  <ul>
     *                  <li>{@linkplain Exam#examName 考试编号/考试名称}</li>
     *                  <li>{@linkplain Exam#startTime 考试开始时间}</li>
     *                  <li>{@linkplain Exam#endTime 考试结束时间}</li>
     *                  </ul>
     * @param pageParam 分页查询条件
     * @return 查询后的数据
     * @since 2016年12月26日15:16:39
     */
    Page<Exam> searchWaitExam(Exam exam, PageParam pageParam);

    /**
     * 【管理员端，获取已评卷的考试列表】
     * 1、获取待评卷或者是考试管理员可以评卷
     *
     * @param exam      考试查询条件
     *                  <ul>
     *                  <li>{@linkplain Exam#examName 考试编号/考试名称}</li>
     *                  <li>{@linkplain Exam#startTime 考试开始时间}</li>
     *                  <li>{@linkplain Exam#endTime 考试结束时间}</li>
     *                  </ul>
     * @param pageParam 分页查询条件
     * @return 查询后的数据
     * @since 2016年12月26日15:16:39
     */
    Page<Exam> searchMarked(Exam exam, PageParam pageParam);

    /**
     * 处理考试结束的结果
     *
     * @param arrangeId 批次ID
     * @since 2017年1月13日17:57:00
     */
    void processEndExam(String arrangeId);

    /**
     * 【管理员端或者管理员端，显示我的考试信息】
     *
     * @param userId   学员ID
     * @param fromType 类型
     *                 <ul>
     *                 <li>{@linkplain com.qgutech.pe.base.model.BaseModel.FromType#PC PC端}</li>
     *                 <li>{@linkplain com.qgutech.pe.base.model.BaseModel.FromType#MOBILE 手机端}</li>
     *                 </ul>
     * @return 具体返回考试如下：
     * <ul>
     * <li>未参加的考试</li>
     * <li>补考</li>
     * <li>成绩未发布</li>
     * <li>成绩发布显示一个月</li>
     * </ul>
     * @throws IllegalArgumentException userId is blank
     * @since 2017年3月8日11:50:353
     */
    List<Exam> listAttendExam(String userId, BaseModel.FromType fromType);

    /**
     * 【学员端，进入考试详情界面封装考试相关信息】
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @return 返回字段如下：
     * <ul>
     * <li>{@linkplain com.qgutech.pe.module.ems.model.ExamResult#score 上次考试成绩}</li>
     * <li>{@linkplain com.qgutech.pe.module.ems.model.ExamResult#pass 是否通过}</li>
     * <li>{@linkplain Exam#id 考试ID 包括补考}</li>
     * <li>{@linkplain Exam#examName 考试名称}</li>
     * <li>{@linkplain Exam#startTime 考试开始时间}</li>
     * <li>{@linkplain Exam#endTime 考试结束时间}</li>
     * <li>{@linkplain Exam#passMark 及格分}</li>
     * <li>{@linkplain com.qgutech.pe.module.ems.model.Paper#itemCount 题目总题数}</li>
     * <li>{@linkplain com.qgutech.pe.module.ems.model.Paper#mark 题目总分}</li>
     * <li>{@linkplain com.qgutech.pe.module.ems.vo.Es#elt 考试时长}</li>
     * <li>{@linkplain com.qgutech.pe.module.ems.vo.Es#mt 补考设置}</li>
     * </ul>
     * @since 2017年3月24日11:15:06
     */
    Exam getByUser(String examId, String userId);

    /**
     * 【学员端，查询需要手动补考的考试集合信息】
     *
     * @param examIds 需要补考的考试ID
     * @return key examId value 补考考试
     * @since 2017年4月1日14:43:57
     */
    Map<String, Exam> findMarkExam(List<String> examIds);

    /**
     * 【管理员端，获取管理员是否有编辑考试权限】
     *
     * @param examId 考试ID
     * @param userId 学员ID
     * @return true or false
     */
    Boolean editAuth(String examId, String userId);
}
