package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.KnowledgeRel;

import java.util.List;

/**
 * Created by Administrator on 2018/6/22.
 */
public interface KnowledgeRelService extends BaseService<KnowledgeRel> {

    List<KnowledgeRel> findByLibraryId(String libraryId);

    List<KnowledgeRel> findByLibraryIdAndKnowledgeIds(String libraryId,List<String> knowledgeIds);

    /**
     * 根据条件查询知识库下的所有知识
     *
     * @param knowledge 条件对象 <ul>
     *                  <li>libraryId:知识库</li>
     *                  <li>createBy:创建人</li>
     *                  <li>createTime:创建时间</li>
     *                  </ul>
     * @return 包含知识库关联信息的分页对象
     * @throws RuntimeException knowledge为null或者libraryId为空时
     * @since TangFD@HF 2018-7-25
     */
    List<KnowledgeRel> findKnowledgeRel(Knowledge knowledge);
}
