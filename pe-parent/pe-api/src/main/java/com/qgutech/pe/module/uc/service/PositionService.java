package com.qgutech.pe.module.uc.service;

import com.qgutech.pe.base.model.Category;
import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.uc.model.Position;

import java.util.List;
import java.util.Map;

/**
 * Position service
 *
 * @author WuKang@HF
 * @version 1.0.0
 * @since 2016年10月25日17:53:12
 */
public interface PositionService extends BaseService<Position> {

    /**
     * 新增岗位:
     * 需要验证同一类别下岗位名称是否重复
     *
     * @param position 岗位实体
     * @return 岗位的主键
     * @since 2016年10月25日17:55:07 by WuKang@HF
     */
    String save(Position position);

    /**
     * 编辑岗位：
     * 需要验证同一类别下岗位名称是否重复
     *
     * @param position 岗位实体
     * @return 受影响的行数
     * @since 2016年10月25日17:56:07 by WuKang@HF
     */
    int update(Position position);

    /**
     * 岗位管理根据类别Id查询岗位列表
     *
     * @param position  岗位实体(类别Id，是否包含子类别)
     * @param pageParam 分页对象
     * @return 岗位类别下的岗位分页对象，属性如下:
     * <ul>
     * <li>{@linkplain Position#positionName 岗位名称}</li>
     * </ul>
     * @since 2016年10月25日18:30:19 author by WuKang@HF
     */
    Page<Position> search(Position position, PageParam pageParam);

    /**
     * 通过岗位类别ID获取岗位信息
     *
     * @param categoryIds 岗位ID集合
     * @return author by LiYanCheng@HF
     * @since 2016年11月7日16:12:35
     */
    List<Position> listByCategory(List<String> categoryIds);

    /**
     * 判断岗位类别下是否存在岗位
     *
     * @param categoryIds 岗位类别ID集合
     * @return 类别下是否存在岗位
     * @since 2016年11月17日09:54:04 author by WuKang@HF
     */
    boolean exist(List<String> categoryIds);

    /**
     * 通过岗位名称获取对应的岗位 类别namePath
     *
     * @param positionNames 岗位名称集合
     * @return key是positionName, value position集合
     * @since 2017年3月28日14:23:34
     */
    Map<String, List<Position>> findNamePath(List<String> positionNames);

    /**
     * 级联保存岗位名称和类别
     *
     * @param positions 保存的岗位对象；
     */
    void save(List<Position> positions);

    /**
     * 同步岗位类别
     *
     * @param categories 岗位类别集合，具体字段如下：
     *                   <ul>
     *                   <li>{@linkplain Category#id 类别ID}</li>
     *                   <li>{@linkplain Category#categoryName 类别名称}</li>
     *                   <li>{@linkplain Category#showOrder 排序}</li>
     *                   <li>{@linkplain Category#idPath IdPATH}</li>
     *                   </ul>
     * @return 影响数量
     * @since 2017-11-14 09:42:29
     */
    int syncCategory(List<Category> categories);

    /**
     * 同步岗位
     *
     * @param positions 岗位集合，具体字段如下：
     *                   <ul>
     *                   <li>{@linkplain Position#id ID}</li>
     *                   <li>{@linkplain Position#positionName 名称}</li>
     *                   <li>{@linkplain Position#categoryId 岗位类别ID}</li>
     *                   </ul>
     * @return 影响数量
     * @since 2017-11-14 09:42:29
     */
    int syncPosition(List<Position> positions);
}
