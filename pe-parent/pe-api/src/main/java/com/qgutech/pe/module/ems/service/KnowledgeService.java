package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.Knowledge;

import java.util.List;
import java.util.Map;

/**
 * 知识点的实体服务类
 *
 * @author Created by zhangyang on 2016/10/12.
 */
public interface KnowledgeService extends BaseService<Knowledge> {
    /**
     * 【知识点管理】
     * <p>知识点管理中新增一个知识点时,调用该方法</p>
     * <p>在新增过程中需要:</p>
     * <ol>
     * <li>1.检测知识点是否重复</li>
     * <li>2.知识点名称是否超过10字符</li>
     * </ol>
     *
     * @param knowledge 知识点的对象,主要包含一下属性:
     *                  {@linkplain Knowledge#knowledgeName 知识点名称}
     * @return 保存成功后知识点的主键Id
     */
    String save(Knowledge knowledge);

    /**
     * 【知识点管理】
     * <p>该方法用于更新知识点的信息,主要更新知识点名称和类别</p>
     * <p>在编辑过程中需要:</p>
     * <ol>
     * <li>1.检测知识点是否重复</li>
     * <li>2.知识点名称是否超过10字符</li>
     * </ol>
     *
     * @param knowledge 知识点的对象,更新操作主要包含以下属性:
     *                  <ul>
     *                  <li>{@linkplain Knowledge#knowledgeName 知识点名称}</li>
     *                  <li>{@linkplain Knowledge#category}中的主键Id</li>
     *                  </ul>
     * @return 受影响的行数
     */
    int update(Knowledge knowledge);

    /**
     * 【新增或者编辑知识点】
     * <p>在新增或者编辑知识点时调用该方法,用于检测知识点的名称是否重复或者知识点名称超过10个字符</p>
     * <p>同时检测指定的知识点的类别是否存在</p>
     *
     * @param knowledge 知识点对象,检测属性如下:
     *                  <ul>
     *                  <li>{@linkplain Knowledge#knowledgeName 知识点名称}</li>
     *                  <li>{@linkplain Knowledge#category}中的主键Id</li>
     *                  </ul>
     * @return 返回布尔类型;true:知识点名称重复或者类别不存在,false:知识点名称不重复
     */
    boolean checkName(Knowledge knowledge);

    /**
     * 【删除知识点】
     * 根据知识点id删除知识点，
     * 并删除知识点关联信息
     *
     * @param knowledgeId 知识点id
     * @return 受影响的行数
     * @since 2016年12月14日20:02:13 author by WuKang@HF
     */
    int delete(String knowledgeId);

    /**
     * 【知识点管理中查询分页】
     * <p>该分页方法用于查询知识点管理中详细的知识点名称的信息,分页查询</p>
     * <p>注意查询是在指定的类别下做分页查询,默认查询的是全部类别下的知识点</p>
     * <p>可以指定分页查询的条件,做模糊查询</p>
     * <p>分页查询的排序按照最后一次编辑时间倒叙展示</p>
     * <p>需要判断该类别是否是知识点的类别</p>
     *
     * @param condition   查询条件,主要是知识点的名称
     *                    {@linkplain Knowledge#knowledgeName 知识点名称}
     * @param categoryIds 类别Id集合,类别可以多选,如果单个操作使用Collections.singletonList()
     * @param page        分页对象
     * @return 查询的分页结果
     */
    Page<Knowledge> search(Knowledge condition, List<String> categoryIds, PageParam page);

    /**
     * 判断知识点类别下是否存在知识点
     *
     * @param categoryIds 知识点类别ID集合
     * @since 2016年10月20日15:55:17
     */
    boolean exist(List<String> categoryIds);

    /**
     * 通过知识点id获取知识点信息
     *
     * @param knowledgeIds 知识点id集合
     * @return author by LiYanCheng@HF
     * @since 2016年10月17日16:36:24
     */
    Map<String, Knowledge> find(List<String> knowledgeIds);

    /**
     * 通过知识点id获取知识点信息
     *
     * @param knowledgeNames 知识点名称集合
     * @return author by LiYanCheng@HF
     * @since 2016年10月17日16:36:24
     */
    Map<String, Knowledge> findByName(List<String> knowledgeNames);

    /**
     * 通过知识点id获取知识点信息
     *
     * @param knowledgeIds 知识点id集合
     * @return author by LiYanCheng@HF
     * @since 2016年10月17日16:36:24
     */
    List<Knowledge> list(List<String> knowledgeIds);

    /**
     * 获取类别下所有分类包含子类别
     *
     * @param categoryId 类别ID
     * @return 知识点集合 author by LiYanCheng@HF
     * @since 2016年11月1日19:36:25
     */
    List<Knowledge> listByCategory(String categoryId);

    /**
     * 批量获取知识点信息 通过类别集合
     *
     * @param categoryIds 类别ID集合
     * @return 类别ID 对应的知识点集合
     * @since 2016年11月4日16:06:46
     */
    Map<String, List<Knowledge>> findByCategory(List<String> categoryIds);
}
