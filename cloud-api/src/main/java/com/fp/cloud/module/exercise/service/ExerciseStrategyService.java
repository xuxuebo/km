package com.fp.cloud.module.exercise.service;

import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.module.ems.model.ItemBank;
import com.fp.cloud.module.ems.model.Knowledge;
import com.fp.cloud.module.exercise.model.ExerciseStrategy;

import java.util.List;


public interface ExerciseStrategyService extends BaseService<ExerciseStrategy> {
    /**
     * 保存练习关联的知识点或题ku
     *
     * @param exerciseId        练习
     * @param exerciseStrategys 知识点 题库 的id 集合
     * @return ID集合
     * @since 2017年3月21日17:49:12  by  liuChen
     */

    List<String> save(String exerciseId, List<ExerciseStrategy> exerciseStrategys);

    /**
     * 通过练习ID获取题库信息
     *
     * @param exerciseId 练习ID
     * @return 题库信息集合
     * @since 2017年3月22日16:18:45
     */
    List<ItemBank> findBank(String exerciseId);

    /**
     * 通过练习ID获取知识点信息
     *
     * @param exerciseId 练习ID
     * @return 知识点信息集合
     * @since 22017年3月22日16:19:52
     */

    List<Knowledge> findKnowledge(String exerciseId);

    /**
     * 通过模板获取题库信息
     *
     * @param exerciseId   练习ID
     * @param strategyType 类型
     * @return 题库信息集合
     * @since 2017年3月22日16:18:45
     */
    List<String> listObjectId(String exerciseId, ExerciseStrategy.StrategyType strategyType);

    /**
     * 获取一个练习下，所有的知识点
     *
     * @param exerciseId 练习的Id
     * @return 知识点的集合
     */
    List<Knowledge> listKnowledge(String exerciseId);
}
