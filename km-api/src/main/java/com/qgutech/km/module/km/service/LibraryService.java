package com.qgutech.km.module.km.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.module.km.model.Library;

import java.util.List;

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

    /**
     * 一级公共库
     * @return
     */
    List<Library> getFirstLevelLibrary();

    List<PeTreeNode> listTree();

    String addFolder(String libraryName,String libraryId);

    Page<Library> search(PageParam pageParam,Library library);

    String saveLibrary(Library library);

    boolean checkName(Library library);

    String updateLibrary(Library library);

}
