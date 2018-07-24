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


    /**
     * 根据库类型检查库名是否已存在（相同类型下不可重复）
     *
     * @param libraryId   更新时库类Id
     * @param libraryName 库名
     * @param libraryType 库类型
     * @return true:库名已存在，false:库名不存在
     * @throws RuntimeException 当libraryName或者libraryType为空时
     * @since TangFD@HF 2018-7-24
     */
    boolean checkName(String libraryId, String libraryName, String libraryType);

    /**
     * 新增专业分类
     *
     * @param library 分类试题
     * @return 实体主键
     * @throws RuntimeException 当library或者libraryId或者libraryName或者libraryType或者idPath为空时
     * @since TangFD@HF 2018-7-24
     */
    String insert(Library library);

    /**
     * 根据条件，分页查询不同类型的库数据（包含库的详情数据）
     *
     * @param page    分页对象
     * @param library 条件对象 <ul>
     *                <li>libraryName:库名模糊匹配</li>
     *                <li>libraryType:库类型</li>
     *                <li>parentId:上级库Id</li>
     *                </ul>
     * @return 包含库数据的分页对象
     * @throws RuntimeException 当page对象不符合分页数据或者library为null或者libraryType为空时
     * @since TangFD@HF 2018-7-24
     */
    Page<Library> searchLibrary(PageParam page, Library library);
}
