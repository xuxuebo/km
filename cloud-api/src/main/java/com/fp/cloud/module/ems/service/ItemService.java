package com.fp.cloud.module.ems.service;

import com.fp.cloud.base.model.Page;
import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.base.vo.TemplatePreview;
import com.fp.cloud.module.ems.model.Item;
import com.fp.cloud.module.ems.model.ItemBank;
import com.fp.cloud.module.ems.vo.Ic;
import com.fp.cloud.base.model.PageParam;
import com.fp.cloud.module.ems.vo.Io;
import com.fp.cloud.module.ems.vo.Sr;

import java.util.List;
import java.util.Map;

/**
 * 试题管理服务类
 *
 * @since 2016年09月14日11:18:38
 */
public interface ItemService extends BaseService<Item> {
    /**
     * 【试题管理新增操作】
     * <p>在新增试题之前,先检测试题是否重复</p>
     * <p>如果新增的实体的状态为启用，则执行新增并启用的操作</p>
     * <p>该方法用于新增一个新的试题,在新增试题的过程中,会处理以下的流程</p>
     * <p>1.在新增试题的过程中,需要保存试题中题干和选项中涉及的图片存储</p>
     * <p>2.在保存完试题的基本信息后,需要保存试题对应的选项以及关联信息</p>
     * <p>3.如果试题新增过程中添加了知识点的归类,需要保存知识点相关的内容,以及关联信息</p>
     *
     * @param item 试题的对象信息,存储的持久化字段如下:
     *             {@linkplain Item#itemBank 中Id 试题的题库Id}
     *             {@linkplain Item#itemCode 试题的编号}
     *             {@linkplain Item#mark 试题的分数,默认值为1分}
     *             {@linkplain Item#type 试题的类型,具体类型见{@link Item.ItemType }}
     *             {@linkplain Item#level 试题的难度,具体类型见{@link Item.ItemLevel }}
     *             {@linkplain Item#status 试题的难度,具体类型见{@link Item.ItemStatus }}
     *             {@linkplain Item#expireDate 试题的自动失效时间}
     *             {@linkplain Item#languageType 试题的语言属性,具体类型见{@link Item.LanguageType }}
     *             {@linkplain Item#knowledge 试题的知识点}
     *             {@linkplain Item#security 试题的是否绝密;true:绝密,false:通用}
     *             {@linkplain Item#scoreSettingType 不定项选择中的试题的得分设置;1.全部正确才能得分,2.部分正确得到试题部分得分}
     *             {@linkplain Item#scoreRate 对部分正确选项设置的该题目的得分率}
     *             {@linkplain Item#stemOutline 取题干前五十字}
     *             {@linkplain Item#_itemDetail }
     * @return 保存成功后的试题主键Id
     * @throws java.lang.IllegalArgumentException 当Item对象中的持久化字段为空时抛出
     */
    String save(Item item);

    /**
     * 【试题管理单个编辑试题】
     * <p>在更新试题之前,先检测试题是否重复</p>
     * <p>该方法用于在试题管理中对已经新增的试题进行编辑时调用,由于试题已经与试卷独立,所以编辑操作如下:</p>
     * <p>编辑操作,对于试题基本信息部分作更新操作,更新版本信息</p>
     * <p>试题关联的选项先删除,然后再重新插入该题编辑后的选项信息,删除选项时需要处理原试题选项关联图片和视频信息</p>
     * <p>原试题关联知识点不做处理</p>
     * <p>然后保存编辑后试题的知识点关联信息,以及选项的关联信息</p>
     *
     * @param item 编辑后的试题对象,详细参照{@link Item}具体属性
     * @return 执行数量
     * @throws java.lang.IllegalArgumentException 当item对象为空或者{@link Item#id}为空时
     */
    int update(Item item);

    /**
     * 【试题管理中分页查询】
     * <p>该方法主要用于分页查询试题管理首页展示的试题列表详情</p>
     * <p>查询题库中试题需要注意过滤绝密试题</p>
     * <p>当有指定的题库时能明确知道是否具有编辑权限</p>
     * <p>但是如果没有指定题库Id,查询全部试题时需要处理每个试题对应是否具有编辑的权限</p>
     *
     * @param item 查询条件:
     *             <ul>
     *             <li>{@linkplain Item#keyword 查询关键字}</li>
     *             <li>{@linkplain Item#type 试题类型}</li>
     *             <li>{@linkplain Item#level 试题难度}</li>
     *             <li>{@linkplain Item#itemBank 题库ID}</li>
     *             <li>{@linkplain Item#knowledge 知识点的Id集合}</li>
     *             <li>{@linkplain Item#status 试题状态}</li>
     *             <li>{@linkplain Item#security 只查看绝密试题}</li>
     *             <li>{@linkplain Item#createTime 创建的时间}</li>
     *             状态有以下几种:
     *             <ol>
     *             <li>{@linkplain Item.ItemStatus#ENABLE 启用状态}</li>
     *             <li>{@linkplain Item.ItemStatus#DRAFT 草稿状态}</li>
     *             <li>{@linkplain Item.ItemStatus#DISABLE 停用状态}</li>
     *             </ol>
     *             </ul>
     * @param page 分页对象
     * @return 题库中的试题的分页对象, 属性如下:
     * <ul>
     * <li>{@linkplain Item#type 试题类型}</li>
     * <li>{@linkplain Item#level 试题难度}</li>
     * <li>{@linkplain ItemBank#bankName 题库名称}</li>
     * <li>{@linkplain Item#knowledge 知识点名称}</li>
     * <li>{@linkplain Item#status 试题状态}</li>
     * <li>{@linkplain Item#canEdit 试题是可以被编辑}</li>
     * </ul>
     */
    Page<Item> search(Item item, PageParam page);

    /**
     * 【试题管理中导入】
     * <p>在新增试题之前,先检测试题是否重复</p>
     * <p>该方法用于批量的新增试题操作,在试题管理中,批量导入试题时会调用该批量新增的方法</p>
     * <p>保存过程涉及的具体流程见{@link ItemService#save(Item)}方法</p>
     *
     * @param items 试题的对象信息,存储的持久化字段如下:
     *              {@linkplain Item#itemBank 中Id 试题的题库Id}
     *              {@linkplain Item#itemCode 试题的编号}
     *              {@linkplain Item#mark 试题的分数,默认值为1分}
     *              {@linkplain Item#type 试题的类型,具体类型见{@link Item.ItemType }}
     *              {@linkplain Item#level 试题的难度,具体类型见{@link Item.ItemLevel }}
     *              {@linkplain Item#status 试题的难度,具体类型见{@link Item.ItemStatus }}
     *              {@linkplain Item#expireDate 试题的自动失效时间}
     *              {@linkplain Item#languageType 试题的语言属性,具体类型见{@link Item.LanguageType }}
     *              {@linkplain Item#knowledge 试题的知识点}
     *              {@linkplain Item#security 试题的是否绝密;true:绝密,false:通用}
     *              {@linkplain Item#scoreSettingType 不定项选择中的试题的得分设置;1.全部正确才能得分,2.部分正确得到试题部分得分}
     *              {@linkplain Item#scoreRate 对部分正确选项设置的该题目的得分率}
     *              {@linkplain Item#stemOutline 取题干前五十字}
     *              {@linkplain Item#_itemDetail }
     * @return 保存成功的试题的主键Id的集合
     * @throws java.lang.IllegalArgumentException 当items为空时或者{@link Item}对象必填字段为空时
     */
    List<String> batchSave(List<Item> items);

    /**
     * <p>该方法用于根据给定的试题的主键Id,查询对应的试题信息,根据传入参数extra判断是否精确查询</p>
     * <p>精确查询如下:</p>
     * <ol>
     * <li>包括试题的基本属性信息</li>
     * <li>包括试题对应的选项信息</li>
     * <li>包括试题对应的图片存储信息</li>
     * <li>包括试题的创建人对应的姓名和用户名</li>
     * </ol>
     * <p>否则只查询基本的试题信息</p>
     *
     * @param itemId 试题的主键Id
     * @return Item对象
     * <ul>
     * <li>包含基本信息{@link Item}</li>
     * <li>还包括:{@link Io}该试题的选项信息</li>
     * </ul>
     * @throws java.lang.IllegalArgumentException 当itemId为空时
     */
    Item get(String itemId);

    /**
     * 通过试题ID获取选项信息
     *
     * @param itemId 试题ID
     * @return 选项信息
     * @since 2016年11月1日11:45:16
     */
    Ic getIc(String itemId);

    /**
     * 【题库管理中删除题库】
     * <p>该方法在题库管理删除题库时调用,检测该题库下是否包含试题信息</p>
     *
     * @param itemBankId 题库Id
     * @return 布尔类型;true:题库下包含试题,false:题库下不含试题
     */
    boolean checkExistItem(String itemBankId);

    /**
     * <p>该方法用于根据给定试题Id和状态值,更新当前这道试题的状态信息</p>
     * <p>如果是启用时,需要校验试题的必填字段是否有效</p>
     *
     * @param itemId 试题Id
     * @param status 指定的试题状态:
     *               <ul>
     *               <li>{@linkplain Item.ItemStatus#ENABLE 启用}</li>
     *               <li>{@linkplain Item.ItemStatus#DRAFT 草稿}</li>
     *               <li>{@linkplain Item.ItemStatus#DISABLE 停用}</li>
     *               </ul>
     * @return 受影响的行数
     * @throws java.lang.IllegalArgumentException 当itemId为空时或者status为空时
     */
    int updateStatus(String itemId, Item.ItemStatus status);

    /**
     * <p>该方法用于根据给定试题Id和状态值,更新当前这道试题的状态信息</p>
     * <p>如果是启用时,需要校验试题的必填字段是否有效</p>
     *
     * @param itemIds 试题Id集合
     * @param status  指定的试题状态:
     *                <ul>
     *                <li>{@linkplain Item.ItemStatus#ENABLE 启用}</li>
     *                <li>{@linkplain Item.ItemStatus#DRAFT 草稿}</li>
     *                <li>{@linkplain Item.ItemStatus#DISABLE 停用}</li>
     *                </ul>
     * @return 受影响的行数
     * @throws java.lang.IllegalArgumentException 当itemId为空时或者status为空时
     */
    int updateStatus(List<String> itemIds, Item.ItemStatus status);

    /**
     * 通过编号获取试题信息
     *
     * @param itemCode 编号
     * @return 试题信息
     * @since 2016年10月17日17:38:40
     */
    Item getByItemCode(String itemCode);

    /**
     * 【题库管理中查询试题数量统计数据】
     * <p>题库管理中对每个题库的统计信息的查询</p>
     * <p>根据给定的题库Id以及给定的试题的状态类型,查询出每个题库下的各类型的试题数量</p>
     * <p>并根据当前线程中的人员,判断是否具有统计绝密试题的权限</p>
     *
     * @param itemBankIds   需要查询的题库的Id集合
     * @param statusList    试题的状态值
     *                      <ul>
     *                      <li>{@linkplain Item.ItemStatus#ENABLE 启用状态}</li>
     *                      <li>{@linkplain Item.ItemStatus#DRAFT 草稿状态}</li>
     *                      <li>{@linkplain Item.ItemStatus#DISABLE 停用状态}</li>
     *                      </ul>
     * @param itemAttribute 试题的属性
     * @return 封装后的Map集合
     * <ul>
     * <li>Key:题库的Id</li>
     * <li>Value:以试题类型为key，题库下该试题类型的统计信息为value</li>
     * </ul>
     */
    Map<String, Map<Item.ItemType, Long>> count(List<String> itemBankIds, List<Item.ItemStatus> statusList,
                                                String itemAttribute);

    /**
     * 通过知识点和题库获取试题对应的数量
     *
     * @param bankIds      题库ID集合
     * @param knowledgeIds 知识点ID集合
     * @param paperType    模板类型,1:代表简单模板,2:代表复杂模板
     * @param isSecurity   是否绝密
     * @return 数据封装
     * @since 2016年10月20日09:29:03
     */
    Sr countItem(List<String> bankIds, List<String> knowledgeIds, List<String> mustItemIds, int paperType, Boolean isSecurity, String itemAttribute);

    /**
     * 通过知识点和题库获取试题
     *
     * @param bankIds       题库ID集合
     * @param itemAttribute 试题的属性
     * @return 数量
     * @since 2017年3月22日13:08:54
     */

    int countItem(List<String> bankIds, String itemAttribute);

    /**
     * 通过知识点和题型获取试题  练习
     *
     * @param exerciseId   练习ID
     * @param itemTypes    试题类型
     * @param knowledgeIds 知识点ID集合
     * @return item id 集合
     * @since 2017年3月22日13:08:54
     */

    List<Item> findExerciseItem(String exerciseId, List<String> knowledgeIds, String itemTypes);

    /**
     * 通过知识点或者题库ID获取对应的试题集合（针对随机组卷抽提使用）
     *
     * @param bankIds      题库ID集合
     * @param knowledgeIds 知识点ID集合
     * @param itemType     试题类型
     * @param itemLevels   试题等级
     * @param isSecurity   是否绝密
     * @return 试题集合
     * @since 2016年10月21日10:23:23
     */
    Map<Item.ItemLevel, List<Item>> list(List<String> bankIds, List<String> knowledgeIds, Item.ItemType itemType,
                                         List<Item.ItemLevel> itemLevels, Boolean isSecurity, List<String> mustItemIds);

    /**
     * 通过知识点或者题库ID获取对应的试题Id集合（针对随机组卷抽提使用）
     *
     * @param bankIds      题库ID集合
     * @param knowledgeIds 知识点ID集合
     * @param itemType     试题类型
     * @param itemLevels   试题等级
     * @param isSecurity   是否绝密
     * @return 试题集合
     * @since 2016年10月21日10:23:23
     */
    Map<Item.ItemLevel, List<String>> findItemId(List<String> bankIds, List<String> knowledgeIds, Item.ItemType itemType,
                                                 List<Item.ItemLevel> itemLevels, Boolean isSecurity, List<String> mustItemIds);

    /**
     * 通过知识点或者题库ID获取对应的试题集合（针对随机组卷抽提使用）
     *
     * @param bankIds      题库ID集合
     * @param knowledgeIds 知识点ID集合
     * @param itemType     试题类型
     * @param isSecurity   是否绝密
     * @return 试题集合
     * @since 2016年10月21日10:23:23
     */
    List<Item> list(List<String> bankIds, List<String> knowledgeIds, Item.ItemType itemType,
                    Boolean isSecurity, List<String> mustItemIds);

    /**
     * 通过知识点或者题库ID获取对应的试题Id集合（针对随机组卷抽提使用）
     *
     * @param bankIds      题库ID集合
     * @param knowledgeIds 知识点ID集合
     * @param itemType     试题类型
     * @param isSecurity   是否绝密
     * @return 试题集合
     * @since 2016年10月21日10:23:23
     */
    List<String> listItemId(List<String> bankIds, List<String> knowledgeIds, Item.ItemType itemType,
                            Boolean isSecurity, List<String> mustItemIds);

    /**
     * 随机组卷通过题库ID和试题等级、是否绝密获取试题信息
     * 创建练习时通过题库ID，试题属性获取试题信息
     *
     * @param bankId        题库ID
     * @param itemAttribute 试题属性
     * @param isSecurity    是否绝密
     * @return 试题信息
     * @since 2016年10月22日10:33:24
     */
    Map<Item.ItemType, TemplatePreview> findItem(String bankId, String itemAttribute, Boolean isSecurity);

    /**
     * 根据给定的试题的Id集合，查询对应的试题详情
     *
     * @param itemIds 试题Id集合
     * @return Map
     * <ul>
     * <li>key:试题Id</li>
     * <li>value:试题信息对象{@see Item}</li>
     * </ul>
     */
    Map<String, Item> findItemByIds(List<String> itemIds);

    /**
     * 根据给定的试题的Id集合，查询对应的试题详情
     *
     * @param itemIds 试题Id集合
     * @return 试题详情集合
     * @throws java.lang.IllegalArgumentException 当itemId为空时
     */
    List<Item> listItemByIds(List<String> itemIds);

    /**
     * 【导出获取试题详情信息】
     *
     * @param itemIds 考试ID集合
     * @return key itemId value 试题详情
     * @since 2017年7月17日16:34:03
     */
    Map<String, Ic> findIc(List<String> itemIds);

    /**
     * 该方法用于根据给定的试卷模板Id，查询该模板下的待选试题的集合列表
     *
     * @param templateId 试卷模板Id
     * @param pageParam  分页
     * @param item       试题的查询条件
     *                   <ul>
     *                   <li>{@linkplain Item#keyword 查询关键字}</li>
     *                   <li>{@linkplain Item#type 试题类型}</li>
     *                   <li>{@linkplain Item#level 试题难度}</li>
     *                   <li>{@linkplain Item#itemBank 题库ID}</li>
     *                   <li>{@linkplain Item#knowledge 知识点的Id集合}</li>
     *                   <li>{@linkplain Item#status 试题状态}</li>
     *                   <li>{@linkplain Item#security 只查看绝密试题}</li>
     *                   <li>{@linkplain Item#createTime 创建的时间}</li>
     *                   状态有以下几种:
     *                   <ol>
     *                   <li>{@linkplain Item.ItemStatus#ENABLE 启用状态}</li>
     *                   <li>{@linkplain Item.ItemStatus#DRAFT 草稿状态}</li>
     *                   <li>{@linkplain Item.ItemStatus#DISABLE 停用状态}</li>
     *                   </ol>
     *                   </ul>
     * @return 该试卷模板未选中的试题
     */
    Page<Item> searchWaitItemByTemplateId(String templateId, Item item, PageParam pageParam);

    /**
     * 获取练习中试题总数和类型
     *
     * @param exerciseId   练习的Id
     * @param knowledgeIds 知识点集合
     * @return exercise
     */

    Map<Item.ItemType, Integer> findItemTypesAndCount(String exerciseId, List<String> knowledgeIds);

    /**
     * 练习的统计获取试题的信息
     *
     * @param exerciseId 练习的id
     * @param item       筛选条件
     * @param page       分页
     * @return 试题的信息
     */
    Page<Item> searchReportItem(Item item, String exerciseId, PageParam page);

    /**
     * 获取一个练习中试题
     *
     * @param exerciseId 练习的Id
     * @return 试题的数量
     */
    int exerciseItemCount(String exerciseId);
}