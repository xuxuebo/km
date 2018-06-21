package com.qgutech.km.module.uc.service;

import com.qgutech.km.module.uc.model.Organize;
import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.base.vo.PeTreeNode;

import java.util.List;
import java.util.Map;

/**
 * Organize service
 *
 * @author WuKang@HF
 * @version 1.0.0
 * @since 2016年10月25日17:53:12
 */
public interface OrganizeService extends BaseService<Organize> {

    /**
     * 新增部门：
     * 校验同一层级下部门名称是否重复
     *
     * @param organize 部门实体
     * @return 部门的主键
     * @since 2016年10月25日17:55:07 by WuKang@HF
     */
    String save(Organize organize);

    /**
     * 编辑部门：
     * 1.校验同一层级下部门名称是否重复,
     * 2.parentId变更时修改organizeName、parentId、idPath、showOrder;
     * 不变更时只修改organizeName
     *
     * @param organize 部门实体
     * @return 受影响的行数
     * @since 2016年10月25日17:56:07 by WuKang@HF
     */
    int update(Organize organize);

    /**
     * 删除部门：
     * 部门下有人员时不可以删除
     *
     * @param organizeId 部门主键
     * @return 受影响的行数
     * @since 2016年10月25日17:57:21 by WuKang@HF
     */
    int delete(String organizeId);

    /**
     * 获取根部门
     *
     * @return 根部门
     * @since 2016年11月2日11:32:40 author by WuKang@HF
     */
    Organize getRoot();

    /**
     * 列出指定父部门Id下的所有子部门Id
     *
     * @param parentId 父部门Id
     * @return 子部门Id集合（包括父部门Id）
     * @since 2016年10月28日09:48:53 author by WuKang@HF
     */
    List<String> listOrganizeId(String parentId);

    /**
     * 获取部门树形结构的节点实体集合
     *
     * @return 部门的树形结构的节点实体集合
     * @since 2016年10月28日10:06:55 author by WuKang@HF
     */
    List<PeTreeNode> listTreeNode();

    /**
     * 根据部门的showOrder上移下移
     *
     * @param organizeId 要上移或下移的实体主键，不可为空
     * @param isUp       是否上移
     * @return 受影响的行数
     * @since 2016年10月25日18:54:50 by WuKang@HF
     */
    int moveLevel(String organizeId, boolean isUp);

    /**
     * 获取key为主键，value为部门信息的map
     *
     * @param organizeIds 部门id集合
     * @return key:organizeId，value：部门对象(部门名称、主键)
     * @since 2016年11月20日13:55:04 author by WuKang@HF
     */
    Map<String, Organize> find(List<String> organizeIds);

    /**
     * 获取当前公司所有部门信息
     *
     * @return 部门信息 author by LiYanCheng@HF
     * @since 2016年11月25日14:51:50
     */
    Map<String, Organize> findAll();

    /**
     * 获取当前部门下的人数
     *
     * @param organizeIds 部门id集合
     * @return author by LiYanCheng@HF
     * @since 2016年11月25日15:10:18
     */
    Map<String, Long> findUserCount(List<String> organizeIds);

    /**
     * 【管理员端，获取默认的部门】
     *
     * @return 默认部门信息
     * @since 2017年2月7日11:19:10
     */
    Organize getDefault();

    /**
     * 通过部门名称获取部门namePath
     *
     * @param organizeNames 部门名称集合
     * @return key organizeName value namePath
     * @since 2017年3月28日13:07:12
     */
    Map<String, List<Organize>> findOrganizeName(List<String> organizeNames);

    /**
     * 根据父部门获取子部门中showOrder最大值
     *
     * @param parentId 父部门Id
     * @return 最大showOrder
     * @since 2016年10月28日11:22:14 author by WuKang@HF
     */
    float getMaxShowOrder(String parentId);

    /**
     * 级联保存organize;
     *
     * @param organizes <ul>
     *                  <li>{@linkplain Organize#namePath 部门路径 }</li>
     *                  </ul>
     * @return key 部门路径，部门id;
     * <ul>
     * <li>{@linkplain Organize#id 部门 }</li>
     * <li>{@linkplain Organize#namePath 部门路径 }</li>
     * <li>{@linkplain Organize#showOrder 部门展示位置 }</li>
     * </ul>
     */
    Map<String, Organize> save(List<Organize> organizes);

    /**
     * 同步部门信息（针对elp处理）
     *
     * @param organizes 部门信息集合，具体信息如下：
     *                  <ul>
     *                  <li>{@linkplain Organize#id 部门ID}</li>
     *                  <li>{@linkplain Organize#parentId 父类ID}</li>
     *                  <li>{@linkplain Organize#idPath idPATH}</li>
     *                  <li>{@linkplain Organize#organizeName 部门名称}</li>
     *                  <li>{@linkplain Organize#showOrder 排序}</li>
     *                  </ul>
     * @return 执行数量
     * @since 2017-11-14 09:05:03
     */
    int syncOrganize(List<Organize> organizes);
}
