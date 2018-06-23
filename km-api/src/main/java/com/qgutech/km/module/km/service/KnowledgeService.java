package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.Share;

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
    List<Knowledge> getKnowledgeByCreateBy(String libraryTYpe);

    /**
     * 分享至公共库
     * @return
     */
    int shareToPublic(Share share);

    /**
     * 根据批量id获取批量文件
     * @param knowledgeIdList
     * @return
     */
    List<Knowledge> getKnowledgeByKnowledgeIds(List<String> knowledgeIdList);

    List<Knowledge> getByLibraryId(String libraryId);

}