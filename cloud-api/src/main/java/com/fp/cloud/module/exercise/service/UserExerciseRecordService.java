package com.fp.cloud.module.exercise.service;

import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.module.exercise.model.UserExerciseRecord;

import java.util.List;

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
