package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.ExamMonitor;
import com.qgutech.pe.module.ems.model.ExamMonitorData;
import com.qgutech.pe.module.sfm.model.PeFile;

import java.util.List;
import java.util.Map;

/**
 * 考试监控数据服务类
 *
 * @version 1.0.0
 * @since 2017年7月19日09:38:26
 */
public interface ExamMonitorDataService extends BaseService<ExamMonitorData> {

    /**
     * 数据保存到监控数据表中
     *
     * @param fileId    文件ID
     * @param arrangeId 安排ID
     * @param dataType  保存类型
     * @param userId    监考老师ID
     * @return 主键
     */
    String save(String fileId, String arrangeId, String userId, ExamMonitorData.DataType dataType);

    /**
     * 视频数据保存到监控数据表中
     *
     * @param fileId          视频ID
     * @param userId          监考老师ID
     * @param examMonitorData 具体字段如下：
     *                        <ul>
     *                        <li>{@linkplain ExamMonitorData#examArrange 安排ID}</li>
     *                        <li>{@linkplain ExamMonitorData#exam 考试ID}</li>
     *                        <li>{@linkplain ExamMonitorData#startTime 考试开始时间}</li>
     *                        <li>{@linkplain ExamMonitorData#duration 考试时长}</li>
     *                        </ul>
     * @return 主键
     */
    String saveVideo(String fileId, String userId, ExamMonitorData examMonitorData);

    /**
     * 获取获取监控信息
     *
     * @param examMonitorData 具体查询字段如下：
     *                        <ul>
     *                        <li>{@linkplain ExamMonitorData#examArrange 批次ID}</li>
     *                        <li>{@linkplain ExamMonitorData#proctorUser 监考员ID}</li>
     *                        <li>{@linkplain ExamMonitorData#dataType 数据类型}</li>
     *                        </ul>
     * @return 监控消息信息集合
     */
    Page<ExamMonitorData> search(ExamMonitorData examMonitorData, PageParam pageParam);

    /**
     * 保存管理员发送的短信信息
     *
     * @param message   信息内容，不可为空
     * @param userId    监考老师，不可为空
     * @param arrangeId 批次ID，不可为空
     * @return 主键
     */
    String saveMessage(String message, String userId, String arrangeId);

    /**
     * 保存监考老师的截屏信息
     *
     * @param fileId    截图文件ID
     * @param comment   备注信息
     * @param arrangeId 安排ID
     * @param userId    监考老师ID
     * @return 主键
     */
    String savePrintImage(String fileId, String comment, String arrangeId, String userId);

    /**
     * 获取录像封面信息
     *
     * @param arrangeIds 批次ID
     * @param userIds    学员ID集合
     * @return key arrangeId+userId value filePath
     * @since 2017年7月28日15:54:58
     */
    Map<String, String> findRecordCover(List<String> arrangeIds, List<String> userIds);

    /**
     * 获取监控数据信息
     *
     * @param arrangeId 批次ID
     * @param userId    学员ID
     * @param dataType  类型
     * @return 监控数据
     */
    List<ExamMonitorData> list(String arrangeId, String userId, ExamMonitorData.DataType dataType);
}
