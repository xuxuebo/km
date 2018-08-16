package com.qgutech.km.module.km.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.base.vo.Rank;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.Share;

import java.util.List;
import java.util.Map;

/**
 *
 * @author zhaowei@HF
 * @version 1.0.0
 */
public interface KnowledgeService extends BaseService<Knowledge> {

    /**
     * 获取个人云库的文件列表
     * @return
     */
    List<Knowledge> getKnowledgeByCreateBy(String libraryTYpe,String libraryId);

    /**
     * 分享至公共库
     * @return
     */
    int shareToPublic(Share share);

    /**
     * 根据批量id获取批量文件
     * @param knowledgeIdList
     * @return
     */
    List<Knowledge> getKnowledgeByKnowledgeIds(List<String> knowledgeIdList);

    List<Knowledge> getKnowledgeByIds(List<String> knowledgeIdList);

    List<Knowledge> getByLibraryId(String libraryId);

    /**
     * 还原回收站文件或删除文件至回收站
     * @param
     * @param libraryType
     * @return
     */
    int reductionOrDelete(List<String> knowledgeIdList,String libraryType);

    /**
     * 清空我的回收站
     */
    void emptyTrash();

    Page<Knowledge> publicLibraryData(PageParam pageParam, Knowledge knowledge, String libraryId);

    void copyToMyLibrary(String knowledgeIds);

    List<Knowledge> recursionList(List<String> knowledgeIds);

    /**
     * 根据条件分页查询知识信息
     *
     * @param knowledge 条件对象 <ul>
     *                  <li>knowledgeName:知识名称</li>
     *                  <li>libraryId:知识库</li>
     *                  <li>createBy:创建人</li>
     *                  <li>createTime:创建时间</li>
     *                  </ul>
     * @param pageParam 分页对象
     * @return 包含知识的分页对象
     * @throws RuntimeException 当page对象不符合分页数据或者knowledge为null或者libraryId为空时
     * @since TangFD@HF 2018-7-25
     */
    Page<Knowledge> search(Knowledge knowledge, PageParam pageParam);

    /**
     * 根据条件，分页查询部门分享类型的库数据
     *
     * @param knowledge 条件对象， 不可为空<ul>
     *                  <li>{@link Knowledge#knowledgeName}:库名模糊匹配</li>
     *                  <li>{@link Knowledge#referId}:部门/人员 Id，不可为空</li>
     *                  <li>{@link Knowledge#referType}:部门（TYPE_ORG）/人员(TYPE_USER)，不可为空</li>
     *                  <li>{@link Knowledge#includeChild}:referType为部门时有效</li>
     *                  <li>{@link Knowledge#projectLibraryId}:重点项目库Id</li>
     *                  <li>{@link Knowledge#specialtyLibraryId}:专业分类库Id</li>
     *                  <li>{@link Knowledge#tag}:标签Id</li>
     *                  </ul>
     * @param pageParam 分页对象
     * @return 包含库数据的分页对象
     * @throws RuntimeException 当page对象不符合分页数据或者knowledge不符合条件时
     * @since TangFD@HF 2018-7-27
     */
    Page<Knowledge> searchOrgShare(Knowledge knowledge, PageParam pageParam);

    /**
     * 将我的知识分享到我的及上级部门（自动将部门建成库，库的主键即为部门Id）
     *
     * @param share 条件对象 <ul>
     *              <li>{@link Share#libraryIds}:需要分享到的部门Id集合， 不可为空</li>
     *              <li>{@link Share#knowledgeIds}:需要分享的知识Id集合， 不可为空</li>
     *              </ul>
     * @throws RuntimeException 当Share为null，或者libraryIds为空，或者knowledgeIds为空时
     * @since TangFD@HF 2018-7-30
     */
    void shareToOrg(Share share);

    /**
     * 根据上传文件Id集合获取知识Id集合
     *
     * @param fileIds 文件Id集合，不可为空
     * @return 知识Id集合
     * @throws RuntimeException 当fileIds为空时
     * @since TangFD@HF 2018-8-3
     */
    List<String> getIdsByFileIds(List<String> fileIds);

    /**
     * 根据文件夹Id和知识Id集合，删除知识，将知识移到回收站中
     *
     * @param knowledgeIdList 知识Id集合，不可为空
     * @param libraryId       文件夹Id，不可为空
     * @throws RuntimeException 当knowledgeIdList和libraryId为空时
     * @since TangFD@HF 2018-8-8
     */
    void deleteInDir(List<String> knowledgeIdList, String libraryId);

    /**
     * 获取当前公司知识总数量及当日上传数量
     *
     * @return 知识数量 <ul>
     * <li>totalCount:总数量</li>
     * <li>dayCount:当日上传数量</li>
     * </ul>
     * @since TangFD@HF 2018-8-14
     */
    Map<String, String> getKnowledgeTotalAndDayCount();

    /**
     * 知识排行接口
     *
     * @param rankCount 查询排行前多少名
     * @return 排行数据集合 <ul>
     * <li>{@link Rank#userName}:姓名</li>
     * <li>{@link Rank#orgName}:部门名称</li>
     * <li>{@link Rank#count}:上传文件数</li>
     * <li>{@link Rank#rank}:排名</li>
     * </ul>
     * @since TangFD@HF 2018-8-14
     */
    List<Rank> rank(int rankCount);

    /**
     * 根据文件名，获取指定知识库中重复文件的个数（处理重复上传同一个文件，文件名添加标识"XXXX(1)"）
     *
     * @param libraryId     知识库Id，不可为空
     * @param knowledgeName 文件名，不可为空
     * @param knowledgeType 文件类型，不可为空
     * @return 重复文件名的个数
     * @throws RuntimeException 当knowledgeName和libraryId为空时
     * @since TangFD@HF 2018-8-16
     */
    int getSameNameCount(String libraryId, String knowledgeName, String knowledgeType);
}