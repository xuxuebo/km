package com.fp.cloud.module.ems.service;

import com.fp.cloud.base.model.Page;
import com.fp.cloud.base.model.PageParam;
import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.module.ems.model.ItemBank;

import java.util.List;
import java.util.Map;

/**
 * 试题库服务类
 *
 * @since 2016年09月14日11:26:11
 */
public interface ItemBankService extends BaseService<ItemBank> {
    /**
     * 该方法用于判断题库名称是否存在
     *
     * @param itemBank 题库对象,包含一下属性:
     *                 <ul>
     *                 <li>{@linkplain ItemBank#bankName 题库名称}</li>
     *                 <li>{@linkplain ItemBank#id} 题库id，可以为空</li>
     *                 </ul>
     * @return 是否存在
     * @since 2016年10月31日15:41:12 author by WuKang@HF
     */
    boolean checkBankName(ItemBank itemBank);

    /**
     * 批量查看题库是否存在
     *
     * @param bankNames 题库名称集合
     * @return 执行结果
     * @since 2016年10月19日13:28:27
     */
    Map<String, ItemBank> checkBankName(List<String> bankNames);

    /**
     * 【题库管理新增】
     * <p>该方法用于题库管理中新增一个新的题库</p>
     * <p>新增题库时需要检测题库名称是否重复,调用{@link ItemBankService#checkBankName(ItemBank)}</p>
     * <p>检测类别是否是题库的类型</p>
     * <p>新增题库时,题库中所有类型的题目默认为0</p>
     *
     * @param itemBank 题库对象,包含一下属性:
     *                 <ul>
     *                 <li>{@linkplain ItemBank#bankName 题库名称}</li>
     *                 <li>{@linkplain ItemBank#category}中的Id</li>
     *                 </ul>
     * @return 返回新增成功后的题库主键Id
     * @throws java.lang.IllegalArgumentException <ul>
     *                                            <li>当题库名称重复</li>
     *                                            <li>当题库的保存类别不属于题库类型时</li>
     *                                            </ul>
     */
    String save(ItemBank itemBank);

    /**
     * 【题库管理中编辑题库】
     * <p>该方法用于题库管理中编辑时,保存编辑后的题库信息</p>
     * <p>编辑时需要检测题库名称是否重复,调用{@link ItemBankService#checkBankName(ItemBank)}</p>
     * <p>检测类别是否属于题库的类型</p>
     *
     * @param itemBank 题库对象,包含一下属性:
     *                 <ul>
     *                 <li>{@linkplain ItemBank#bankName 题库名称}</li>
     *                 <li>{@linkplain ItemBank#category}中的Id</li>
     *                 </ul>
     * @return 受影响的行数
     * @throws java.lang.IllegalArgumentException <ul>
     *                                            <li>当题库名称重复</li>
     *                                            <li>当题库的保存类别不属于题库类型时</li>
     *                                            </ul>
     */
    int update(ItemBank itemBank);

    /**
     * 【题库管理中删除题库】
     * <p>该方法用于题库管理删除某一个题库是调用</p>
     * <p>删除时检测题库的试题,调用{@link ItemService#checkExistItem(String)}检测</p>
     * <p>不可删除的条件:</p>
     * <ol>
     * <li>1.题库下包含试题时</li>
     * </ol>
     *
     * @param itemBankId 题库的主键Id
     * @return 受影响的行数
     */
    int delete(String itemBankId);

    /**
     * 该方法用于题库管理中展示列表,当点击具体的某个题库类别时加载该类别下的所有题库信息,做分页展示
     * 展示题库信息包含以下属性:
     * <ol>
     * <li>{@linkplain ItemBank#bankName 题库名称}</li>
     * <li>{@linkplain ItemBank#singleNumber 单选题数}</li>
     * <li>{@linkplain ItemBank#multiNumber 多选题数}</li>
     * <li>{@linkplain ItemBank#indefiniteNumber 不定项选择题数}</li>
     * <li>{@linkplain ItemBank#judgmentNumber 判断题数}</li>
     * <li>{@linkplain ItemBank#fillNumber 填空题数}</li>
     * <li>{@linkplain ItemBank#questionsNumber 问答题数}</li>
     * </ol>
     * 分页查询过程:
     * <ol>
     * <li>1. 先分页查询出该指定类别下的所有题库信息,此时不包括统计信息,默认为0,统计字段不做持久化处理。查询时需要注意,查询的题库由自己创建或者别人授权</li>
     * <li>2. 然后根据上一步查询出来的题库列表,查询授权信息表,判断对该题库是否具有编辑权限</li>
     * <li>3. 根据查询出来的题库信息,结合传入的试题筛选状态,查询每个题库下试题数量的统计信息</li>
     * <li>4. 上一步筛选过程中需要过滤掉非本人创建的绝密试题</li>
     * </ol>
     * 查询题库下面的试题统计信息做批量处理,调用方法
     *
     * @param itemBank  题库信息(类别Id，是否包含子类别)
     * @param pageParam 分页对象
     * @return 封装完成后的分页结果
     * @throws java.lang.IllegalArgumentException <ul>
     *                                            <li>1.当categoryId为空时</li>
     *                                            <li>2.当statusList为空时</li>
     *                                            </ul>
     */
    Page<ItemBank> search(ItemBank itemBank, PageParam pageParam);

    /**
     * 判断题库类别下是否存在题库
     *
     * @param categoryIds 题库类别ID集合
     * @return 类别下是否存在题库
     * @since 2016年10月13日19:08:52
     */
    boolean exist(List<String> categoryIds);

    /**
     * 列出所有对自己有权限的题库ID集合
     *
     * @return 题库ID集合 author by LiYanCheng@HF
     * @since 2016年10月17日14:22:42
     */
    List<String> listAuthBankId();

    /**
     * 获取有权限的题库ID
     *
     * @param bankIds 题库ID集合
     * @return author by LiYanCheng@HF
     * @since 2016年11月15日09:41:513
     */
    Map<String, Boolean> findAuthBankId(List<String> bankIds);

    /**
     * 列出类别下所有对自己有权限的题库ID集合
     *
     * @param categoryId 类别Id
     * @return 题库ID集合 author by LiYanCheng@HF
     * @since 2016年10月17日14:22:42
     */
    List<String> listAuthBankId(String categoryId);

    /**
     * 根据类别集合列出所有类别下所有对自己有权限的题库ID集合
     *
     * @param categoryIds 类别Id集合
     * @return 题库ID集合
     * @since 2016年10月17日14:22:42
     */
    List<String> listAuthBankId(List<String> categoryIds);

    /**
     * 根据类别集合列出所有类别下所有对自己有权限的题库ID集合
     *
     * @param categoryIds 类别Id集合
     * @return 题库ID集合
     * @since 2016年10月17日14:22:42
     */
    Map<String, List<ItemBank>> findAuthItemBank(List<String> categoryIds);


    /**
     * 根据类别集合列出所有类别下所有对自己有编辑权限的题库ID集合
     *
     * @param categoryIds 类别Id集合
     * @return 题库ID集合
     * @since 2016年10月17日14:22:42
     */
    List<ItemBank> listEditItemBank(List<String> categoryIds);

    /**
     * 列出类别集合下所有对自己有编辑权限或者无编辑权限的题库ID集合
     *
     * @param categoryIds 类别Id集合
     * @param canEdit     能否编辑
     * @return 题库ID集合
     * @since 2016年10月17日17:45:50
     */
    List<String> listAuthBankId(List<String> categoryIds, boolean canEdit);

    /**
     * 通过题库Id获取对应的题库信息
     *
     * @param bankIds 题库ID集合
     * @return author by LiYanCheng@HF
     * @since 2016年10月17日17:03:34
     */
    Map<String, ItemBank> find(List<String> bankIds, String... fields);

    /**
     * 通过类别ID集合获取题库信息
     *
     * @param categoryIds 题库类别ID集合
     * @return 题库信息
     * @since 2016年10月17日18:11:06
     */
    Map<String, List<ItemBank>> findByCategory(List<String> categoryIds);

    /**
     * 通过题库id获取题库集合
     *
     * @param bankIds 题库ID集合
     * @return 题库集合
     * @since 2016年10月20日15:37:28
     */
    List<ItemBank> list(List<String> bankIds, String... fields);
}