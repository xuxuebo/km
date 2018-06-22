package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.Library;

/**
 * Created by ChenHuiJin@HF on 2018/6/22.
 */
public interface LibraryService extends BaseService<Library> {

    /**
     * 根据库类型 获取个人的云库或回收站
     * @param libraryType
     * @return
     */
    Library getUserLibraryByLibraryType(String libraryType);

}
