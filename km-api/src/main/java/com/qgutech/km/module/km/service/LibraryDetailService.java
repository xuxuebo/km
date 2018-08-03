package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.LibraryDetail;

/**
 * @author TangFD@HF 2018/8/2
 */
public interface LibraryDetailService extends BaseService<LibraryDetail> {

    /**
     * 根据知识库Id获取详细信息
     *
     * @param libraryId 知识库Id，不可为空
     * @return 知识库详细信息实体
     * @throws RuntimeException 当libraryId为空时
     * @since TangFD@HF 2018-8-2
     */
    LibraryDetail getByLibraryId(String libraryId);
}
