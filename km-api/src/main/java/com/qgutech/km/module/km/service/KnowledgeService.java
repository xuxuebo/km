package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.Knowledge;

import java.util.List;

/**
 *
 * @author zhaowei@HF
 * @version 1.0.0
 */
public interface KnowledgeService extends BaseService<Knowledge> {

    /**
     * 获取个人云库的文件列表
     * @return
     */
    public List<Knowledge> getKnowledgeByCreateBy();

}