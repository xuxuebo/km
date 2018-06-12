package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.MockExamSetting;

/**
 * 模拟考试设置
 *
 * @since 2017年3月20日14:57:25
 */
public interface MockExamSettingService extends BaseService<MockExamSetting> {
    MockExamSetting getByMockExamId(String examId);

}
