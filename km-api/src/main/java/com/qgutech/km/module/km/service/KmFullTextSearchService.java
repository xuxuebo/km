/*
 * 文件名:KmFullTextSearchService.java
 * 创建时间:2014-05-19
 * 版本:1.0
 * 版权所有:上海时代光华教育发展有限公司
 */
package com.qgutech.km.module.km.service;




import com.qgutech.km.base.model.Page;
import com.qgutech.km.module.km.model.IndexKnowledge;

import java.util.List;

/**
 * 资料中心（km）全文搜索的服务接口（service）。
 * <p/>
 * 提供的主要服务有：
 * <ul>
 * <li>为单个知识增加索引。</li>
 * <li>批量为知识增加索引。</li>
 * <li>为单个知识更新索引。</li>
 * <li>批量为知识更新索引。</li>
 * <li>根据知识的主键删除知识的索引。</li>
 * <li>为一个公司所有启用和停用的知识重构索引。</li>
 * <li>根据搜索关键字和分页对象，得到符合条件的知识主键的分页对象。
 * 即设置了总记录数（符合条件的知识id总数）和分页数据rows（该页的知识id的列表）的知识id的分页对象。</li>
 * </ul>
 *
 * @author ZhaoJie@HF
 * @version 1.0
 * @since 2014-05-19
 */
public interface KmFullTextSearchService {
    /**
     * 为单个知识增加索引。
     * <ul>
     * <li>当知识不为文档类型的知识时，不需抽取知识的内容，直接为知识增加索引。<li/>
     * <li>当知识为文档类型的知识时，为知识增加索引（不包括知识的内容），再将知识放入redis中。<li/>
     * <ul/>
     *
     * @param indexKnowledge 知识对象。
     * @throws IllegalArgumentException 。<ul> <li>传入的知识对象为null。<li/>
     *                                       <li>传入的知识对象的属性knowledgeId为empty。<li/>
     *                                       <li>传入的知识对象的属性knowledgeName为empty。<li/>
     *                                       <li>传入的知识对象的属性knowledgeType为empty。<li/>
     *                                       <li>传入的知识对象的属性optStatus为empty。<li/>
     *                                       <li>传入的知识对象的属性storedFileId为empty。<li/>
     *                                       <ul/>
     */
    void add(IndexKnowledge indexKnowledge);

    /**
     * 批量为知识增加索引。当知识为平台分配的知识时，知识属性assign必修设置为true。
     * <ul>
     * <li>当知识不为文档类型的知识时，不需抽取知识的内容，直接为知识增加索引。<li/>
     * <li>当知识为文档类型的知识时，为知识增加索引（不包括知识的内容），再将知识放入redis中。<li/>
     * <ul/>
     * <p/>
     * <b>当某一个知识索引增加失败，记录下log（知识增加索引失败的具体原因），接着为下一个知识增加索引。</b>
     *
     * @param indexKnowledgeList 知识对象的列表。
     * @throws IllegalArgumentException 传入的知识列表为empty。
     */
    void add(List<IndexKnowledge> indexKnowledgeList);

    /**
     * 为单个知识更新索引。
     * <ul>
     * <li>当知识不为文档类型的知识或是来自redis时，不需抽取知识的内容，直接为知识更新索引。<li/>
     * <li>当知识为文档类型的知识并且不是来自redis时，需抽取知识的内容，为知识更新索引。<li/>
     * <ul/>
     *
     * @param indexKnowledge 知识对象。
     * @throws IllegalArgumentException <ul/>
     *                                  <li>传入的知识对象为null。<li/>
     *                                  <li>传入的知识对象的属性knowledgeId为empty。<li/>
     *                                  <li>传入的知识对象的属性knowledgeName为empty。<li/>
     *                                  <li>传入的知识对象的属性knowledgeType为empty。<li/>
     *                                  <li>传入的知识对象的属性optStatus为empty。<li/>
     *                                  <li>传入的知识对象的属性storedFileId为empty。<li/>
     *                                  <ul/>
     */
    void update(IndexKnowledge indexKnowledge);

    /**
     * 批量为知识更新索引。
     * <ul>
     * <li>当知识不为文档类型的知识或是来自redis时，不需抽取知识的内容，直接为知识更新索引。<li/>
     * <li>当知识为文档类型的知识并且不是来自redis时，需抽取知识的内容，为知识更新索引。<li/>
     * <ul/>
     * <b>当某一个知识更新索引失败时，记录下log（知识更新索引失败的具体原因），接着为下一个知识更新索引。</b>
     *
     * @param indexKnowledgeList 知识对象的列表。
     * @throws IllegalArgumentException 传入的知识列表为empty。
     */
    void update(List<IndexKnowledge> indexKnowledgeList);

    /**
     * 根据知识的主键删除知识的索引。
     *
     * @param knowledgeId 知识对象的主键。
     * @throws IllegalArgumentException 传入knowledgeId为empty。
     */
    void delete(String knowledgeId);

    /**
     * 为指定知识重构索引。
     * <b>首先，为索引文件备份：<b/>
     * <ul>
     * <li>索引文件存在,将索引文件改名为备份文件名，重新生成索引文件，在索引文件中重构索引。</li>
     * <li>索引文件不存在，生成索引文件，在索引文件中重构索引。</li>
     * </ul>
     * <b>若索引文件备份失败，则抛出RuntimeException。</b>
     * <b>若索引文件备份成功，则进行索引文件重构。<b/>
     * <b>若索引文件重构中遇到任何的异常，索引文件重构失败，删除索引文件，将备份文件重新改为索引文件名，抛出RuntimeException。；
     * 否则，索引文件重构成功，删除备份文件。</b>
     *
     * @param indexKnowledgeList 一个公司所有启用和停用的知识的列表。
     * @throws IllegalArgumentException 传入的知识列表为empty。
     */
    void rebuild(List<IndexKnowledge> indexKnowledgeList);

    /**
     * 根据搜索关键字和分页对象，得到符合条件的知识主键的分页对象。
     * 即设置了总记录数（符合条件的知识id总数）和分页数据rows（该页的知识id的列表）的知识id的分页对象。
     * <p/>
     * 当keyword为empty时，直接返回。
     *
     * @param keyword 关键字。
     * @param page    分页对象。
     * @return 设置了总记录数和分页数据rows的知识id的分页对象。
     */
    Page<String> search(String keyword, Page<String> page);
}
