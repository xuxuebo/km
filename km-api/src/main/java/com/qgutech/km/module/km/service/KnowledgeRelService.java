package com.qgutech.km.module.km.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
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

    /**
     * 根据库Id集合，创建人Id集合，获取所有的知识Id集合
     *
     * @param libraryIds 库Id集合， 不可为空
     * @param userIds    创建人Id集合，为空时，查询该库下的所有数据
     * @return 知识Id集合
     * @throws RuntimeException libraryId为空时
     * @since TangFD@HF 2018-7-27
     */
    List<String> getKnowledgeIdsByLibraryIdsAndUserIds(List<String> libraryIds, List<String> userIds);

    /**
     * 分页查询部门分享的知识关联实体
     *
     * @param knowledge 条件对象
     * @param pageParam 分页对象
     * @return 知识Id集合
     * @throws RuntimeException libraryId为空时
     * @since TangFD@HF 2018-7-27
     */
    Page<KnowledgeRel> searchOrgShare(Knowledge knowledge, PageParam pageParam);
}
