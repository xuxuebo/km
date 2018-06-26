package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.KnowledgeRel;

import java.util.List;

/**
 * Created by Administrator on 2018/6/22.
 */
public interface KnowledgeRelService extends BaseService<KnowledgeRel> {

    List<KnowledgeRel> findByLibraryId(String libraryId);

    List<KnowledgeRel> findByLibraryIdAndKnowledgeIds(String libraryId,List<String> knowledgeIds);
}
