package com.fp.cloud.module.exercise.service;

import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.module.exercise.model.ExerciseResultDetail;
import com.fp.cloud.module.exercise.model.UserExerciseRecord;

/**
 * 练习结果详情
 *
 * @since liuChen 2017年4月1日13:41:29
 */

public interface ExerciseResultDetailService extends BaseService<ExerciseResultDetail> {
    /**
     * 根据用户的答题记录保存或更新练习的详情
     *
     * @param userExerciseRecord 答题记录
     */
    void saveDetail(UserExerciseRecord userExerciseRecord);

    /**
     * 根据练习ID设置ID查找练习的结果详情
     *
     * @param exerciseId        练习的id
     * @param exerciseSettingId 设置的Id
     * @return 查询的结果
     */

    ExerciseResultDetail find(String exerciseId, String exerciseSettingId);

}
