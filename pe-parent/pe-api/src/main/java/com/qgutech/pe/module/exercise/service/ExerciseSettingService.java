package com.qgutech.pe.module.exercise.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.exercise.model.ExerciseSetting;
import com.qgutech.pe.module.uc.model.User;

import java.util.List;

/**
 * 练习的设置的试题类
 * Created by liuChen on 2017/3/24.
 */
public interface ExerciseSettingService extends BaseService<ExerciseSetting> {
    /**
     * 【根据练习Id删除考试的练习设置信息】
     *
     * @param exerciseId 练习Id
     * @param userId 用户Id
     * @return 受影响的行数
     * @since 2017年3月27日09:02:24
     */
    int deleteByExerciseIdAndUserId(String exerciseId,String userId);

    /**
     * 【获取本用户的所以练习的设置】
     * @param exerciseId 练习Id
     * @param userId 用户的ID
     *
     * @return 练习的设置
     */

    ExerciseSetting findByUserExercise(String exerciseId,String userId);
}
