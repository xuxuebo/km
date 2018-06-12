package com.qgutech.pe.module.exercise.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.Item;
import com.qgutech.pe.module.exercise.model.ExerciseSetting;
import com.qgutech.pe.module.exercise.model.UserExerciseRecord;

import java.util.List;
import java.util.Map;

/**
 * 学员练习答题记录接口
 */
public interface UserExerciseRecordService extends BaseService<UserExerciseRecord> {

    /**
     * 获取答错错误答题记录
     *
     * @param exerciseId 练习的Id
     * @param settingId  设置的Id
     * @return 记录的集合
     */

    List<UserExerciseRecord> findWrongItem(String exerciseId, String settingId);

    /**
     * 获取答题记录中某题的全部记录
     *
     * @param exerciseId 练习Id
     * @param itemId     试题的Id
     * @return 记录的集合
     */
    List<UserExerciseRecord> getByExerciseIdAndItemId(String exerciseId, String itemId);

    /**
     * @param exerciseId 练习的Id
     * @param itemIds    试题id的集合
     * @return 记录的结果
     */

    List<UserExerciseRecord> findByItemIds(String exerciseId, List<String> itemIds);

    /**
     * 学员端获取一个练习下答题记录
     *
     * @param exerciseId 练习的Id
     * @param userId     用户的Id
     */
    List<UserExerciseRecord> findAlreadyCompletedItem(String exerciseId, String userId);
}
