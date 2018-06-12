package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.base.vo.ResultReport;
import com.qgutech.pe.module.ems.model.MockExam;
import com.qgutech.pe.module.ems.model.MockExamResult;

/**
 * 模拟考试成绩管理
 *
 * @author wangxiaolong
 * @since 2017年3月24日14:21:05
 */
public interface MockExamResultService extends BaseService<MockExamResult> {
    /**
     * 获取该模拟考试的考试成绩分析
     *
     * @param exam 模拟考试id不为空
     * @return ResultReport
     */
    ResultReport getResultReport(MockExam exam);

    /**
     * 管理员端获取模拟考试详细信息
     *
     * @param exam 模拟考试id userName 考生姓名
     * @return page
     */
    Page<MockExamResult> getResultReportDetails(PageParam pageParam, MockExam exam);

}
