package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.LabelRel;

import java.util.List;

/**
 * Created by Administrator on 2018/6/25.
 */
public interface LabelRelService extends BaseService<LabelRel> {

    List<LabelRel> getByLabelId(String labelId);

    /**
     * 根据标签Id，创建人Id集合，获取所有的知识Id集合
     *
     * @param labelId 标签Id，不可为空
     * @param userIds 创建人Ids，为空时查找该标签下的所有数据
     * @return 知识Id集合
     * @throws RuntimeException 当labelId为空时
     * @since TangFD@HF 2018-7-27
     */
    List<String> getKnowledgeIdsByLabelIdAndUserIds(String labelId, List<String> userIds);

    /**
     * 根据知识Id删除所有标签关联信息
     *
     * @param knowledgeId 知识Id，不可为空
     * @return 删除的记录数
     * @throws RuntimeException 当knowledgeId为空时
     * @since TangFD@HF 2018-8-7
     */
    int deleteByKnowledgeId(String knowledgeId);
}
