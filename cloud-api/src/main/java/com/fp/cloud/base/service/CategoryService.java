package com.fp.cloud.base.service;


import com.fp.cloud.base.model.Category;
import com.fp.cloud.base.vo.PeTreeNode;

import java.util.List;
import java.util.Map;

/**
 * PositionCategory service
 *
 * @author WuKang@HF
 * @version 1.0.0
 * @since 2016年9月12日14:08:35
 */
public interface CategoryService extends BaseService<Category> {

    /**
     * 【类别管理中的新增】
     * <p>该方法用于类别中的新增操作,会新增一个类别</p>
     * <p>在新增时需要检测类别名称是否重复</p>
     * <p>类别的层级不做限制,设置类别序号为最大序号加一</p>
     *
     * @param category 类别对象,包含一下信息:
     *                 {@linkplain Category#categoryName 类别名称}
     *                 {@linkplain Category#categoryType 类别归属类型}
     *                 类型一下两种:
     *                 <ul>
     *                 <li>{@linkplain Category.CategoryEnumType#ITEM_BANK 题库类别}</li>
     *                 <li>{@linkplain Category.CategoryEnumType#KNOWLEDGE 知识点类别}</li>
     *                 </ul>
     *                 {@linkplain Category#showOrder 同类别的排序}
     *                 {@linkplain Category#parentId 该类别的父类别}
     *                 类别的归属类型
     *                 <ul>
     *                 <li>{@linkplain Category.CategoryEnumType#ITEM_BANK 题库类型}</li>
     *                 <li>{@linkplain Category.CategoryEnumType#KNOWLEDGE 知识点类型}</li>
     *                 <li>{@linkplain Category.CategoryEnumType#POSITION 岗位类型}</li>
     *                 <li>{@linkplain Category.CategoryEnumType#POSITION 试卷类型}</li>
     *                 </ul>
     * @return 返回类别保存成功对应的类别主键Id
     * @throws IllegalArgumentException <ul>
     *                                  <li>1.当category对象为空时</li>
     *                                  <li>2.当类别主键存在时</li>
     *                                  <li>3.当同一类型的类别存在相同的类别名称时</li>
     *                                  <li>4.类别归属类型为空时</li>
     *                                  </ul>
     */
    String save(Category category);

    /**
     * 【类别管理中新增或者编辑】
     * <p>该方法用于检测指定同类型下的类别,判断需要新增或者编辑的类别名称是否重复</p>
     *
     * @param category 新增或者编辑的类别的对象
     *                 需要检测的字段为{@linkplain Category#categoryName 类别名称}
     *                 类别归属类型
     *                 <ul>
     *                 <li>{@linkplain Category.CategoryEnumType#ITEM_BANK 题库类型}</li>
     *                 <li>{@linkplain Category.CategoryEnumType#KNOWLEDGE 知识点类型}</li>
     *                 <li>{@linkplain Category.CategoryEnumType#POSITION 岗位类型}</li>
     *                 <li>{@linkplain Category.CategoryEnumType#POSITION 试卷类型}</li>
     *                 </ul>
     * @return 返回布尔类型;true:重复,false:不重复
     * @throws IllegalArgumentException <ul>
     *                                  <li>1.当category对象为空时</li>
     *                                  <li>2.类别归属类型为空时</li>
     *                                  </ul>
     */
    boolean checkName(Category category);

    /**
     * 【类别编辑时】
     * <p>该方法用于类别编辑时调用,类别编辑只能够编辑类别的名称</p>
     * <p>类别的排序上下移动调用上移或者下移的方法,不调用该方法</p>
     * <p>类别的编辑保存时,需要检测类别的名称是否重复</p>
     *
     * @param category 需要编辑的类别对象,主要保存编辑的类别名称
     *                 {@linkplain Category#categoryName 类别名称}
     * @return 返回受影响的行数, 当类别名称重复时返回0
     */
    int update(Category category);

    /**
     * <p>删除指定类型的类别</p>
     * <p>如果当前类别有关联其他实体则不允许删除</p>
     *
     * @param categoryId 类别Id
     * @param type       类别类型
     * @return 受影响的行数
     * @since 2016年10月20日15:19:51
     */
    int delete(String categoryId, Category.CategoryEnumType type);

    /**
     * 通过父类ID获取子类别ID集合
     *
     * @param parentId 父类ID
     * @param type     类型
     * @return 子类别ID集合
     * @since 2016年10月13日19:02:05
     */
    List<String> listCategoryId(String parentId, Category.CategoryEnumType type);

    /**
     * 通过parentId 获取子类别
     *
     * @param parentId 父类ID
     * @param type     类型
     * @return author by LiYanCheng@HF
     * @since 2016年10月14日13:49:40
     */
    List<Category> list(String parentId, Category.CategoryEnumType type);

    /**
     * 通过 parentId和 查询的关键字 获取子类别
     *
     * @param parentId 父类Id
     * @param keyword  关键字查询
     * @return 子类别集合
     */
    List<Category> list(String parentId, String keyword);

    /**
     * 通过parentId获取子类别
     *
     * @param parentId 父类Id
     * @param sub      是否查询子类别
     * @return 子类别的集合
     */
    List<Category> list(String parentId, String keyword, boolean sub);

    /**
     * 移动类别结点到其他父类别下
     *
     * @param category 类别
     * @return 影响的数量 author by LiYanCheng@HF
     * @since 2016年10月14日13:32:22
     */
    int moveNode(Category category);

    /**
     * 获取指定类型的根类别
     *
     * @param type 类别的类型:
     *             {@linkplain Category.CategoryEnumType#ITEM_BANK 题库}
     *             {@linkplain Category.CategoryEnumType#KNOWLEDGE 知识点}
     *             {@linkplain Category.CategoryEnumType#POSITION 岗位}
     *             {@linkplain Category.CategoryEnumType#PAPER 试卷}
     * @return 指定类型的类别根类别
     */
    Category getRoot(Category.CategoryEnumType type);

    /**
     * 获取所有类别信息
     *
     * @param type 类别的类型:
     *             {@linkplain Category.CategoryEnumType#ITEM_BANK 题库}
     *             {@linkplain Category.CategoryEnumType#KNOWLEDGE 知识点}
     *             {@linkplain Category.CategoryEnumType#POSITION 岗位}
     *             {@linkplain Category.CategoryEnumType#PAPER 试卷}
     * @return 指定类型的类别根类别
     */
    List<Category> list(Category.CategoryEnumType type);

    /**
     * 根据类别类型获取树形结构的节点实体集合
     *
     * @param type 类别类型
     * @return 树邢结构的节点实体集合
     * @since 2016年10月24日18:27:26
     */
    List<PeTreeNode> listTreeNode(Category.CategoryEnumType type);

    /**
     * 实现指定父类别下的上移下移功能
     *
     * @param categoryId 上移或下移的类别id
     * @param isUp       是否上移
     * @return 受影响的行数
     * @since 2016年10月31日16:10:17 author by WuKang@HF
     */
    int moveLevel(String categoryId, boolean isUp);

    /**
     * 查看题库类别是否
     *
     * @param category 题库类别
     *                 <ul>
     *                 该类别包含catagoryName和id,其中catagoryName不能为空
     *                 </ul>
     * @return 返回主键如果不存在则返回空
     */
    String checkCatagoryName(Category category);

    /**
     * 获取固定类别种类所有的namePath,Category对象
     *
     * @param categoryEnumType 类别类型
     * @return namePath,Category对象(有namePath)
     */
    Map<String,Category> listByCategoryType(Category.CategoryEnumType categoryEnumType);

    /**
     * 【管理员端，获取默认类别】
     *
     * @param categoryEnumType 类别类型
     * @return 默认类型信息 author by LiYanCheng@HF
     * @since 2017年2月7日11:26:46
     */
    Category getDefault(Category.CategoryEnumType categoryEnumType);
    /**
     * 获取类别下的最大的showOrder
     * @param categoryIds 需要查询的categoryId,
     * @param categoryEnumType 需要查询的categoryType
     * @return categoryId,showOrder;
     */
    Map<String,Float>getMaxShowOrder(List<String> categoryIds, Category.CategoryEnumType categoryEnumType);

    /**
     * 级联保存类别
     *
     * @param categories
     * @param categoryEnumType
     */
    void save(List<Category> categories,Category.CategoryEnumType categoryEnumType);


}
