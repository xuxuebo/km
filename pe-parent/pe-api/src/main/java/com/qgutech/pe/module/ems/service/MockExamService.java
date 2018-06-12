package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.Exam;
import com.qgutech.pe.module.ems.model.MockExam;
import com.qgutech.pe.module.ems.vo.Ua;
import com.qgutech.pe.module.uc.model.User;

import java.util.List;
import java.util.Map;

/**
 * 模拟考试服务类
 *
 * @author xiaolong
 * @since 2017-03-09 10:46:09
 */
public interface MockExamService extends BaseService<MockExam> {
    /**
     * 查询redis 获取模拟考试已经选择的考生人员信息
     *
     * @param examId 模拟考试id
     * @return 返回要参加模拟考试的人员信息
     * @author wangxiaolong
     */
    List<User> search(String examId);

    /**
     * 【学员端，学员可以参加的模拟考试】
     * 列表显示的数据为：
     * 学员可以参加的所有模拟考试，包括指定参加的模拟考试，和公共的模拟考试
     * 以考试开始时间排序，离当前时间最近的考试开始时间排最前面；
     *
     * @return 所有可以参加的模拟考试
     */
    List<MockExam> searchMyMockExamDynamic();

    /**
     * 生成试卷进入试卷页面
     *
     * @param exam 模拟考试id
     */
    void processMockExamPaper(MockExam exam);


    /**
     * 【考试选择待选人员】
     * <p>该方法用于查询一场考试下某个批次的待选人员的分页信息</p>
     *
     * @param examId      考试ID
     * @param isTransient 是否是第一次，t是第一次，f 不是第一次
     * @param user        查询条件
     *                    <ul>
     *                    <li>{@linkplain User#userName 姓名}</li>
     *                    <li>{@linkplain User#loginName 用户名}</li>
     *                    <li>{@linkplain User#mobile 手机号}</li>
     *                    <li>{@linkplain User#employeeCode 工号}</li>
     *                    <li>{@linkplain User#positionId 岗位Id}</li>
     *                    <li>{@linkplain com.qgutech.pe.module.uc.model.Organize#id 部门Id}</li>
     *                    </ul>
     * @param pageParam   分页查询对象
     * @return 返回查询的分页数据
     */
    Page<User> searchWaitUser(String examId, String isTransient, User user, PageParam pageParam);

    /**
     * 【考试人员】
     * <p>查询一场模拟考试下的考试人员</p>
     *
     * @param exam      examId 考试id,isTransient是否是第一创建模拟考试，t是，f不是
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
    Page<User> searchSelectUser(MockExam exam, User user, PageParam pageParam);

    /**
     * 【保存模拟考试基本信息】
     * 新增模拟考试
     *
     * @param exam 考试基本信息
     * @return 主键
     * @since 2017年3月20日14:55:17 wxl
     */
    String saveMockExam(MockExam exam);


    /**
     * 【根据条件查询考试列表】
     * 根据考试条件，查询考试结果列表。
     * 考试查询条件：
     * {@linkplain Exam#examName 考试名称，迷糊匹配}
     * {@linkplain Exam#examCode 考试编号，迷糊匹配}
     * {@linkplain Exam#examStatus 考试状态(多选)}
     * {@linkplain Exam#createUser 考试创建人，模糊：
     * {@linkplain User#userName 姓名}、{@linkplain User#loginName 用户名}、{@linkplain User#employeeCode 工号}、{@linkplain User#mobile 手机号}}
     *
     * @param examCondition 考试筛选条件
     * @param pageParam     分页
     * @return 考试查询结果
     */
    Page<MockExam> searchExam(MockExam examCondition, PageParam pageParam);

    /**
     * 修改模拟考试的状态
     *
     * @param examId 模拟考试id
     * @return 修改记录的条数
     */
    int updateMockExamStatus(String examId, MockExam.ExamStatus status);

    /**
     * 修改模拟考试以及其设置
     * <p>
     * 主要修改usableRange 和endTime 和answerlimit;这个三个属性
     *
     * @param exam 考试信息
     * @return 修改记录的条数
     */
    int updateMockExam(MockExam exam);


    /**
     * @param examId    模拟考试id
     * @param answerMap <>
     *                  answerMap<ItemId,Ua> 学员答题记录
     *                  </>
     */
    void submitMockExamResult(String examId, Map<String, Ua> answerMap);

    /**
     * 缓存模拟考试答题记录
     *
     * @param examId
     * @param answerMap
     */
    void saveTransientMockResult(String examId, Map<String, Ua> answerMap);
}
