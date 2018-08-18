package com.qgutech.km.module.km.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.KnowledgeLog;

/**
 * @author TangFD@HF 2018/8/1
 */
public interface KnowledgeLogService extends BaseService<KnowledgeLog> {
    /**
     * 根据条件分页查询知识库动态
     *
     * @param knowledgeLog 条件对象，不可为空 <uL>
     *                     <li>{@link KnowledgeLog#libraryId}:知识库Id， 为空时查全部</li>
     *                     <li>{@link KnowledgeLog#userName}:操作人，模糊匹配</li>
     *                     <li>{@link KnowledgeLog#knowledgeName}:知识名称，模糊匹配</li>
     *                     <li>{@link KnowledgeLog#startTime}:开始时间</li>
     *                     <li>{@link KnowledgeLog#endTime}:结束时间</li>
     *                     </uL>
     * @param pageParam    分页对象
     * @return 包含知识库动态数据的分页对象
     * @throws RuntimeException 当page对象不符合分页数据或者knowledgeLog为null时
     * @since TangFD@HF 2018-8-1
     */
    Page<KnowledgeLog> search(KnowledgeLog knowledgeLog, PageParam pageParam);
}
