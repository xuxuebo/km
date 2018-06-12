package com.qgutech.pe.module.uc.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.uc.model.Position;
import com.qgutech.pe.module.uc.model.UserPosition;

import java.util.List;
import java.util.Map;

/**
 * 用户岗位关联 service
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月27日19:53:25
 */
public interface UserPositionService extends BaseService<UserPosition> {

    /**
     * 通过用户ID封装岗位信息集合
     *
     * @param userIds 用户ID集合
     * @return 岗位信息 MAP
     * @since 2016年10月27日19:55:23
     */
    Map<String, List<Position>> findByUserId(List<String> userIds);

    /**
     * 通过用户获取岗位信息
     *
     * @param userId 用户ID
     * @return 岗位集合 author by LiYanCheng@HF
     * @since 2016年11月7日18:14:43
     */
    List<Position> listByUserId(String userId);

    /**
     * 通过用户ID集合删除岗位信息
     *
     * @param userIds 用户ID集合
     * @return 执行数量
     * @since 2016年10月29日11:03:24
     */
    int deleteByUserId(List<String> userIds);

    /**
     * 根据用户Id获取以“，”间隔的岗位
     *
     * @param userId 用户Id
     * @return 以“，”间隔的岗位字符串
     * @since 2016年11月20日17:26:52 author by WuKang@HF
     */
    String getPositionByUserId(String userId);

    /**
     * 通过岗位id删除岗位信息
     *
     * @param positionId 岗位id
     * @return 返回执行的条数
     * @since 2017-01-04 17:19:50 author by WangXiaolong
     */
    int deleteByPositionId(String positionId);
}
