package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.base.vo.JsonResult;
import com.qgutech.pe.module.ems.model.Item;
import com.qgutech.pe.module.ems.model.PaperTemplate;
import com.qgutech.pe.module.ems.model.TemplateStrategy;

import java.util.List;
import java.util.Map;

/**
 * 试卷模板 service
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月19日18:39:52
 */
public interface TemplateService extends BaseService<PaperTemplate> {

    /**
     * 新增试卷模板基本信息
     *
     * @param paperTemplate 试卷模板基本信息
     * @return 主键
     * @since 2016年10月19日18:43:40
     */
    String save(PaperTemplate paperTemplate);

    /**
     * 保存随机组卷策略
     *
     * @param paperTemplate      组卷策略基本信息
     * @param templateStrategies 题库知识点
     * @return 执行ID
     * @since 2016年10月20日16:05:39
     */
    String save(PaperTemplate paperTemplate, List<TemplateStrategy> templateStrategies);

    /**
     * 修改试卷模板基本信息
     *
     * @param paperTemplate 试卷模板基本信息
     * @return 主键
     * @since 2016年10月19日18:43:40
     */
    int update(PaperTemplate paperTemplate);

    /**
     * 通过试卷编号获取试卷模板
     *
     * @param paperCode 试卷编号
     * @return 试卷模板信息
     * @since 2016年10月19日18:52:55
     */
    PaperTemplate getByPaperCode(String paperCode);

    /**
     * <p>该方法用于根据给定试卷模板Id集合和状态值,批量更新试卷模板集合的状态信息</p>
     * <p>如果是启用时（启用只单个操作）,需要校验试卷模板的必填字段是否有效</p>
     * <p>如果是停用可以批量操作</p>
     *
     * @param paperTemplateIds 试卷模板Id集合
     * @param status           修改试卷模板状态:
     *                         <ul>
     *                         <li>{@linkplain com.qgutech.pe.module.ems.model.PaperTemplate.PaperStatus#ENABLE 启用}</li>
     *                         <li>{@linkplain com.qgutech.pe.module.ems.model.PaperTemplate.PaperStatus#DISABLE 停用}</li>
     *                         </ul>
     * @return 受影响的行数
     * @throws java.lang.IllegalArgumentException 当paperTemplateIds为空时或者status为空时
     * @since 2016年10月21日15:48:12 author by WuKang@HF
     */
    int batchUpdateStatus(List<String> paperTemplateIds, PaperTemplate.PaperStatus status);

    /**
     * 启用试卷模板信息
     *
     * @param templateId 试卷模板ID
     * @since 2016年11月15日13:54:01 author by LiYanCheng@HF
     */
    void enableTemplate(String templateId);

    /**
     * 检测随机组卷策略的合法性
     *
     * @param templateId 模板ID
     * @since 2016年11月23日09:24:43
     */
    JsonResult<String> checkRandomStrategy(String templateId);

    /**
     * 检测试卷模板信息是否合法
     *
     * @param templateId 模板ID
     * @since 2016年11月23日16:08:04
     */
    void checkTemplate(String templateId);

    /**
     * 判断试卷模板类别下是否存在试卷模板
     *
     * @param categoryIds 类别ID集合
     * @since 2016年10月20日15:55:10 author by WuKang@HF
     */
    boolean exist(List<String> categoryIds);

    /**
     * 根据试卷模板主键集合批量删除试卷模板及关联信息
     *
     * @param paperTempleIds 试卷模板Ids
     * @return 受影响的行数
     * @since 2016年10月20日09:10:01 author by WuKang@HF
     */
    int batchDelete(List<String> paperTempleIds);

    /**
     * 试卷管理分页查询试卷模板的列表详情页
     * 系统管理员显示所有的记录（默认是草稿和启用的）
     * 其他管理员显示本人创建的，和其他人授权给我查看的，被授权的试卷没有管理操作；
     * 按创建日期降序排列，默认显示草稿和启用状态的记录；
     * 绝密试卷增加“密”标识，绝密试卷不可以授权；
     * 草稿和停用状态的试卷也不可以授权；
     * 启用的试卷也可以编辑和删除（试卷和考试弱关联）；
     * 草稿和停用的试卷可以启用、编辑和删除；
     *
     * @param condition 查询条件:
     *                  {@linkplain PaperTemplate#createTime 创建时间}
     *                  {@linkplain PaperTemplate#paperStatus 试卷状态}
     *                  {@linkplain PaperTemplate#createBy 创建人}
     * @param pageParam 分页对象
     * @return 分页查询结果
     */
    Page<PaperTemplate> search(PaperTemplate condition, PageParam pageParam);

    /**
     * 计算随机题每个类型对应的题目数
     *
     * @param templateId 模板ID
     * @return author by LiYanCheng@HF
     * @since 2016年11月12日15:56:32
     */
    Map<Item.ItemType, Long> countRandomItem(String templateId);

    /**
     * 计算试题总数
     *
     * @param templateId 模板ID
     * @return 试题总数
     * @since 2016年11月14日11:35:01
     */
    Long countItem(String templateId);
}
