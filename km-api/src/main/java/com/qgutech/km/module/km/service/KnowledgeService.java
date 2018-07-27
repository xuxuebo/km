package com.qgutech.km.module.km.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.Share;

import java.util.List;

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
}