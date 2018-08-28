package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.KnowledgeRel;
import com.qgutech.km.module.km.model.Share;
import com.qgutech.km.module.km.model.Statistic;

import java.util.Collection;
import java.util.List;
import java.util.Map;

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
     * 根据库Id集合，知识Id集合，获取每个库已经存在的知识映射
     *
     * @param libraryIds   库Id集合， 不可为空
     * @param knowledgeIds 知识Id集合， 不可为空
     * @return 每个库已经存在的知识映射，key：libraryId+&+knowledgeId，value：true
     * @throws RuntimeException libraryIds,knowledgeIds为空时
     * @since TangFD@HF 2018-7-27
     */
    Map<String, Boolean> getLibraryIdKnowledgeIdMap(List<String> libraryIds, List<String> knowledgeIds);

    /**
     * 重点项目，专业分类，上传文件
     *
     * @param share 条件对象 <ul>
     *              <li>{@link Share#libraryIds}:需要添加的知识库Id集合， 不可为空</li>
     *              <li>{@link Share#knowledgeIds}:需要添加的知识Id集合， 不可为空</li>
     *              </ul>
     * @throws RuntimeException 当Share为null，或者libraryIds为空，或者knowledgeIds为空时
     * @since TangFD@HF 2018-8-3
     */
    void addToLibrary(Share share);

    /**
     * 根据知识Id集合和知识库Id删除关联信息
     *
     * @param knowledgeIds 知识Id集合，不可为空
     * @param libraryId    知识库Id，不可为空
     * @throws RuntimeException 当knowledgeIds为空，或者libraryId为空时
     * @since TangFD@HF 2018-8-7
     */
    void deleteByKnowledgeIdsAndLibraryId(List<String> knowledgeIds, String libraryId);

    /**
     * 中心排行
     *
     * @param rankCount 排行前多少名
     * @return 部门排行数据 <ul>
     * <li>{@link Statistic#names :部门名称}</li>
     * <li>{@link Statistic#counts :部门中的知识数}</li>
     * </ul>
     * @since TangFD@HF 2018-8-14
     */
    Statistic orgRank(int rankCount);

    /**
     * 知识库排行
     *
     * @param type      知识库类型，不可为空
     * @param rankCount 排行前多少名
     * @return 知识库排行数据 <ul>
     * <li>{@link Statistic#names :知识库名称}</li>
     * <li>{@link Statistic#valuePairs :知识库中的知识数和名称}</li>
     * </ul>
     * @throws RuntimeException 当type为空时
     * @since TangFD@HF 2018-8-15
     */
    Statistic libraryRank(String type, int rankCount);

    /**
     * 根据知识Id列表，检查当前人是否有权限
     *
     * @param knowledgeIds 知识Id列表，不可为空
     * @return 是否有权限，true:有权限，false：无
     * @throws RuntimeException 当knowledgeIds为空时
     * @since TangFD@HF 2018-8-17
     */
    boolean checkAuth(List<String> knowledgeIds);

    /**
     * 删除部门分享几积分
     *
     * @param relId 知识关联Id，不可为空
     * @throws RuntimeException 当relId为空时
     * @since TangFD@HF 2018-8-17
     */
    void deleteShare(String relId);

    /**
     * 根据知识库Id集合，批量获取每个库对于的知识集合
     *
     * @param libraryIds 知识库Id集合
     * @return 每个库对于的知识集合 key：libraryId，value：List<KnowledgeRel>
     * @throws RuntimeException 当libraryIds为空时
     * @since TangFD@HF 2018-8-28
     */
    Map<String, List<KnowledgeRel>> getByLibraryIds(Collection<String> libraryIds);
}
