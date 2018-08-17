package com.qgutech.km.module.km.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.base.vo.Rank;
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
     * 根据条件，分页查询不同类型的库数据
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

    /**
     * 部门分享，根据部门,人员数据初始化库数据，将每个部门，人员新建为一个库
     *
     * @param libraryIds  部门,人员Id集合，不可为空
     * @param libraryType 知识库类型，不可为空
     * @throws RuntimeException 当libraryIds，或者libraryType为空时
     * @since TangFD@HF 2018-7-31
     */
    void initLibraryByLibraryIdAndType(List<String> libraryIds, String libraryType);

    /**
     * 重点项目，专业分类 排行接口
     *
     * @param libraryId 知识库Id，不可为空
     * @return 排行数据集合 <ul>
     * <li>{@link Rank#userName}:姓名</li>
     * <li>{@link Rank#orgName}:部门名称</li>
     * <li>{@link Rank#count}:上传文件数</li>
     * <li>{@link Rank#rank}:排名</li>
     * </ul>
     * @throws RuntimeException 当libraryId为空时
     * @since TangFD@HF 2018-7-31
     */
    List<Rank> rank(String libraryId);

    /**
     * 保存知识库和详情信息
     *
     * @param library 知识库信息实体
     * @return 知识库主键Id
     * @throws RuntimeException 当library为空， 或者detail为空时
     * @since TangFD@HF 2018-8-2
     */
    String saveLibraryAndDetail(Library library);

    /**
     * 根据知识库Id获取知识库信息及详细信息
     *
     * @param libraryId 知识库Id，不可为空
     * @return 知识库信息
     * @throws RuntimeException 当libraryId为空时
     * @since TangFD@HF 2018-8-3
     */
    Library getLibraryAndDetail(String libraryId);

    /**
     * 更新知识库及详情信息
     *
     * @param library 知识库及详情信息，不可为空
     * @throws RuntimeException 当library为空， 或者libraryDetail为空时
     * @since TangFD@HF 2018-8-7
     */
    void updateAndDetail(Library library);

    /**
     * 根据知识库名称和知识库类型查找知识库Id
     *
     * @param folderName 知识库名称，不可为空
     * @param type 知识库类型，不可为空
     * @return 知识库Id
     * @throws RuntimeException 当folderName或者type为空时
     * @since TangFD@HF 2018-8-17
     */
    String getIdByNameAndType(String folderName, String type);

    /**
     * 根据库类型查找热门库列表（依据文件数统计）
     *
     * @param libraryType 知识库类型，不可为空
     * @param hotCount    排行数量
     * @return 热门库列表
     * @throws RuntimeException 当folderName或者type为空时
     * @since TangFD@HF 2018-8-17
     */
    List<Library> getHotLibraryByType(String libraryType, int hotCount);
}
