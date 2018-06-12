package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.Item;
import com.qgutech.pe.module.ems.model.Paper;
import com.qgutech.pe.module.ems.vo.Ic;

import java.util.List;
import java.util.Map;

/**
 * 试卷服务接口
 *
 * @since 2016年11月17日10:57:12
 */
public interface PaperService extends BaseService<Paper> {

    /**
     * 通过考试ID集合统计考试下面的试卷数量
     *
     * @param examIds 试卷ID
     * @return author by LiYanCheng@HF
     * @since 2016年12月1日20:38:05
     */
    Map<String, Long> countPaper(List<String> examIds);


    /**
     * 通过考试ID统计考试下面的试卷数量
     *
     * @param examId 试卷ID
     * @return author by LiYanCheng@HF
     * @since 2016年12月1日20:38:05
     */
    Long countPaper(String examId);

    /**
     * 【分页展示生成试卷信息】
     * 需要查询的字段如下：
     * <ul>
     * <li>试卷来源</li>
     * <li>试题总量</li>
     * <li>试题分值</li>
     * <li>综合难度</li>
     * </ul>
     *
     * @param examId    考试ID
     * @param pageParam 分页条件
     * @return 数据集合
     */
    Page<Paper> search(String examId, PageParam pageParam);

    /**
     * 【根据考试Id获取考试生成的所有试卷】
     *
     * @param examId 考试Id
     * @return 试卷集合
     * @since 2016年11月22日17:21:21 author by WuKang@HF
     */
    List<Paper> listByExamId(String examId);

    /**
     * 【删除考试或科目关联的试卷】
     *
     * @param examId 考试Id
     * @return 受影响的行数
     * @since 2016年11月22日19:52:41 author by WuKang@HF
     */
    int deleteExam(String examId);

    /**
     * 获取考试生成固定卷模板ID集合
     *
     * @param examId 考试ID
     * @return 模板ID集合 author by LiYanCheng@HF
     * @since 2016年11月22日19:49:43
     */
    List<String> listFixedTemplateId(String examId);

    /**
     * 通过试卷模板生成试卷信息
     *
     * @param paper 试卷信息，必填项如下：
     *              <ul>
     *              <li>{@link Paper#paperTemplate 试卷模板ID}</li>
     *              <li>{@link Paper#exam 考试ID}</li>
     *              <li>{@link Paper#makeCount 试卷生成数量}</li>
     *              </ul>
     * @return 试卷ID author by LiYanCheng@HF
     * @since 2016年11月23日11:25:34
     */
    void generatePaper(Paper paper);

    /**
     * 通过试卷模板生成试卷信息
     *
     * @param paper 试卷信息，必填项如下：
     *              <ul>
     *              <li>{@link Paper#paperTemplate 试卷模板ID}</li>
     *              <li>{@link Paper#mockExam 模拟考试ID}</li>
     *              <li>{@link Paper#makeCount 试卷生成数量}</li>
     *              </ul>
     * @return 试卷ID author by wangxiaolong@HF
     * @since 2016年11月23日11:25:34
     */
    List<String> generateMockExamPaper(Paper paper);






    /**
     * 根据考试ID，获取考试下所有试卷内试题的集合（非重复）
     *
     * @param examId 考试ID
     * @return 考试下所有试卷内试题的集合
     * @since 2016年11月23日11:25:34 chenHuaMei@HF
     */
    List<Item> listPaperItemByExamId(String examId);

    /**
     * 根据考试Id查询考试下生成的试卷,是否存在视频音频文件
     *
     * @param examId 考试ID
     * @return Map
     * <ul>
     * <li>key:试卷Id</li>
     * <li>value:是否有音频视频文件</li>
     * </ul>
     */
    Map<String, Boolean> findVideoOrMusicMark(String examId);

    /**
     * 统一修改试卷分数
     *
     * @param paperId 试卷ID
     * @param itemIds 试题ID集合
     * @param mark    分数
     * @return author by LiYanCheng@HF
     * @since 2016年11月30日18:58:54
     */
    int updatePaperMark(String paperId, List<String> itemIds, Double mark);

    /**
     * 删除试卷对应的试题信息
     *
     * @param paperId 试卷ID
     * @param itemId  试题信息
     * @return author by LiYanCheng@HF
     * @since 2016年11月30日19:55:44
     */
    int deletePaperItem(String paperId, String itemId);

    /**
     * 更新试卷对应的试题信息
     *
     * @param paperId 试卷ID
     * @param ic      试题信息
     * @return author by LiYanCheng@HF
     * @since 2016年12月1日12:27:02
     */
    int updatePaperItem(String paperId, Ic ic);

    /**
     * 移动试题信息
     *
     * @param paperId 试卷ID
     * @param itemId  试题ID
     * @param up      是否上移，默认上移
     * @return author by LiYanCheng@HF
     * @since 2016年12月1日13:33:41
     */
    int movePaperItem(String paperId, String itemId, Boolean up);

    /**
     * 删除试卷信息，启用的考试删除试卷静态页面
     *
     * @param paperId 试卷ID
     * @return author by LiYanCheng@HF
     * @since 2016年12月3日10:45:55
     */
    int deletePaper(String paperId);

    /**
     * 【接口，下发考试获取试卷】
     * <p>1、处理试题图片</p>
     * <p>2、打乱题型</p>
     * <p>3、折合分数</p>
     *
     * @param paperIds 试题ID
     * @return 试卷信息
     * @since 2017年3月15日14:33:43
     */
    List<Paper> list(List<String> paperIds);

    /**
     * 【接口，下发考试获取试卷】
     * <p>1、处理试题图片</p>
     * <p>2、打乱题型</p>
     * <p>3、折合分数</p>
     *
     * @param examId 考试ID
     * @return 试卷信息
     * @since 2017年3月15日14:33:43
     */
    List<Paper> list(String examId);

    /**
     * 【接口，下发考试获取试卷】
     * <p>1、处理试题图片</p>
     * <p>2、打乱题型</p>
     * <p>3、折合分数</p>
     *
     * @param paperId 试卷ID
     * @return 试卷信息
     * @since 2017年3月15日14:33:43
     */
    Paper get(String paperId);

    /**
     * 【计算试卷模板剩余可以生成的试卷数】
     *
     * @param templateId 试卷模板ID
     * @return 剩余试卷数
     * @since 2017年5月16日16:42:09
     */
    Long countPaper(String templateId, String examId);

    /**
     * 考试生成试卷信息
     *
     * @param templateId 试卷模板ID
     * @param examId     考试ID
     * @param count      要生成的数量
     * @since 2017年5月17日09:49:33
     */
    void makePaper(String templateId, String examId, Integer count);

    /**
     * 随机抽取一套试卷
     *
     * @param examId 考试ID
     * @return 试卷信息
     * @since 2017年6月2日09:05:40
     */
    Paper getRandom(String examId);
}
