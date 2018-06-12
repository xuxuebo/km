package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.MockExamUser;

import java.util.List;

/**
 * 模拟考试人员服务类
 *
 * @since 2017年3月21日09:48:30
 */
public interface MockExamUserService extends BaseService<MockExamUser> {


    /**
     * 批量保存模拟考试的人员信息
     *
     * @param userIds 模拟考试的人员信息
     * @param examId  模拟考试的id
     */
    List<String> saveMockExamUser(List<String> userIds, String examId);

    /**
     * 通过模拟考试的id查询模拟考试的人员信息
     *
     * @param examId 模拟考试的id
     * @return 返回所关联模拟考试的所有人员
     */
    List<MockExamUser> findByMockExamId(String examId);

    /***
     * 删除模拟考试的关联人员
     *
     * @param examId 模拟考试id
     * @return 无返回值
     */
    void deleteByMockExamId(String examId);

    /**
     * 根据examId和referId删除模拟考试人员信息
     *
     * @param examId   模拟考试id
     * @param referIds 考生的id集合
     */
    void deleteMockExamUsers(String examId, List<String> referIds);

}
