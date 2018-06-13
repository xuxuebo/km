package com.fp.cloud.module.exercise.service;

import com.fp.cloud.base.model.Page;
import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.module.ems.model.Item;
import com.fp.cloud.module.exercise.model.ExerciseSetting;
import com.fp.cloud.base.model.PageParam;
import com.fp.cloud.module.exercise.model.Exercise;
import com.fp.cloud.module.exercise.model.UserExerciseRecord;

import java.util.List;
import java.util.Map;

/**
 * @author LiYanCheng
 * @since 2017年3月9日09:35:03
 */
public interface ExerciseService extends BaseService<Exercise> {
    /**
     * 【根据条件查询练习列表】
     * 根据练习条件，查询练习结果列表。
     *
     * @param exercise  查询条件练习查询条件：
     *                  <ul>
     *                  <li>{@linkplain  Exercise#exerciseCode 练习的编号 模糊查询}</li>
     *                  <li>{@linkplain  Exercise#exerciseName 练习的名字 模糊查询}</li>
     *                  <li>{@linkplain  Exercise#createBy     练习的创建人 精确查找 }</li>
     *                  </ul>
     * @param pageParam 分页条件
     * @return 分页结果
     */

    Page<Exercise> search(PageParam pageParam, Exercise exercise);

    /**
     * 保存练习
     *
     * @param exercise     练习的实体
     *                     <ul>
     *                     <li>{@linkplain Exercise#id                  主键}</li>
     *                     <li>{@linkplain Exercise#applicationScope   可用范围}</li>
     *                     <li>{@linkplain Exercise#seeAnswer          可见答案}</li>
     *                     <li>{@linkplain Exercise#status              状态}</li>
     *                     <li>{@linkplain Exercise#exerciseCode         编号  }</li>
     *                     <li>{@linkplain Exercise#exerciseName          名字}</li>
     *                     <li>{@linkplain Exercise#endTime               结束时间}</li>
     *                     </ul>
     * @param bankIds      题库ID集合
     * @param knowledgeIds 知识点ID集合
     * @return
     */

    String save(Exercise exercise, List<String> bankIds, List<String> knowledgeIds);


    /**
     * 学员端，首页展示查找我的练习
     *
     * @return 练习的集合
     */

    List<Exercise> searchMyExercise();

    /**
     * 练习重新开始
     *
     * @param exerciseId 练习的id
     *                   删除数据如下:
     *                   <ul>
     *                   <li>删除练习的设置</li>
     *                   <li>删除练习试题的关联</li>
     *                   </ul>
     */

    void renew(String exerciseId);


    /**
     * 进入练习
     * * 具体实现步骤如下：
     * <ul>
     * <li>保存练习的设置</li>
     * <li>保存练习与试题关联</li>
     * <li>获取试题</li>
     * </ul>
     *
     * @param exerciseSetting 练习的设置
     * @param knowledgeId     知识点
     * @param itemType        试题的类型
     */

    void entryExercise(ExerciseSetting exerciseSetting, List<String> knowledgeId, String itemType);

    /**
     * 学员进入练习时获取试题
     *
     * @param exerciseId 练习的id
     * @return exercise
     */

    Exercise personalExercise(String exerciseId);

    /**
     * 提交用户答案
     *
     * @param userExerciseRecord <ul>
     *                           <li>{@linkplain UserExerciseRecord# exerciseSetting.id 练习设置}</li>
     *                           <li>{@linkplain UserExerciseRecord# answer用户答案}</li>
     *                           <li>{@linkplain UserExerciseRecord# item.id 试题id}</li>
     *                           </ul>
     */

    void submitAnswer(UserExerciseRecord userExerciseRecord);

    /**
     * 加工练习的内容
     *
     * @param exerciseId  练习的id
     * @param userItemMap key 试题的类型 value 试题的集合
     */
    Exercise processExercise(String exerciseId, Map<Item.ItemType, List<Item>> userItemMap);

    /**
     * 统计 获取知识点的得分率
     *
     * @param exercise     练习
     * @param knowledgeIds 知识点的集合
     * @return map  key 知识点Id value 得分率
     */
    Map<String, Double> statisticKnowLedge(Exercise exercise, List<String> knowledgeIds);


    /**
     *修改练习成绩详情表表中的hasSubmit状态
     * @param exerciseSetting <ul>
     *                           <li>{@linkplain ExerciseSetting# exerciseSetting.id 练习设置id}</li>
     *                           </ul>
     * @param records 可以为空，学员练习答题记录
     *                <ul>
     *                  <li>{@linkplain UserExerciseRecord#isCorrect 是否正确}</li>
     *                </ul>
     */
    void updateExerciseResult(ExerciseSetting exerciseSetting,List<UserExerciseRecord> records);


    /**
     * 练习整体提交答题记录接口
     *
     *
     * @param exerciseSettingId 练习批次编号
     * @param userAnswers key：itemId,value: userAnswer_sign;
     */
    void saveUserAnswers(String exerciseSettingId,Map<String,String>userAnswers);

    /**
     * 更新练习的“可用范围”、“结束时间”
     * @param exercise exerciseId不可为空；
     */
    void updateExercise(Exercise exercise);
}
