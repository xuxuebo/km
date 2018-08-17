package com.qgutech.km.module.km.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.Label;
import com.qgutech.km.module.km.model.LabelRel;

import java.util.List;

/**
 * Created by Administrator on 2018/6/25.
 */
public interface LabelService extends BaseService<Label> {

    String saveLabel(Label label);

    boolean checkName(Label label);

    String updateLabel(Label label);

    String deleteLabel(String id);

    Page<Label> listTree(PageParam pageParam);

    void moveShowOrder(String id,boolean isUp);

    Label getRoot();

    /**
     * 保存知识与标签的关联信息
     *
     * @param labelRel，不可为空
     * @return 关联实体主键列表
     * @throws RuntimeException 当labelRel为空，或者knowledgeId为空时
     * @since TangFD@HF 2018-8-7
     */
    List<String> saveLabelRel(LabelRel labelRel);

    /**
     * 查询热门标签列表（依据文件数进行统计）
     *
     * @param hotCount 排行数量
     * @return 标签列表
     * @throws RuntimeException 当labelRel为空，或者knowledgeId为空时
     * @since TangFD@HF 2018-8-17
     */
    List<Label> getHostLabels(int hotCount);
}
