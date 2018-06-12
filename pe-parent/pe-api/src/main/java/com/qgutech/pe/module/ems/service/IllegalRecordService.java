package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.IllegalRecord;

/**
 * 违规记录操作接口
 *
 * @author LiYanCheng
 * @since 2017年2月14日17:54:22
 */
public interface IllegalRecordService extends BaseService<IllegalRecord> {

    /**
     * 新增考试违规处理
     *
     * @param illegalRecord 违规处理，具体字段如下：
     *                      <ul>
     *                      <li>{@linkplain IllegalRecord#illegalType 类型}</li>
     *                      <li>{@linkplain IllegalRecord#illegalContent 内容}</li>
     *                      <li>{@linkplain IllegalRecord#examMonitor 监控}</li>
     *                      </ul>
     * @return 主键
     * @since 2017年2月21日16:28:45
     */
    String save(IllegalRecord illegalRecord);
}
