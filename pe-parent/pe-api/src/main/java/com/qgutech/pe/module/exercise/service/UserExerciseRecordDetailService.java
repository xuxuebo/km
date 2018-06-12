package com.qgutech.pe.module.exercise.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.exercise.model.UserExerciseRecordDetail;

import java.util.List;

/**
 * 练习答题记录详情接口
 */
public interface UserExerciseRecordDetailService extends BaseService<UserExerciseRecordDetail> {
    /**
     * 删除所有练习答题记录
     *
     * @param exerciseId 练习id
     * @return 受影响行数
     */
    int deleteByExerciseId(String exerciseId);

    /**
     * 单个删除错题集的错题
     * @param exerciseId 练习id
     * @param itemId 试题id
     * @throws IllegalArgumentException exerciseId==null or itemId==null时；
     * @return 受影响行数
     */
    int deleteByExerciseIdAndItemId(String exerciseId,String itemId);

    /**
     * 获取当前用户的错题集信息
     *
     * @param exerciseId 练习id;
     * @throws IllegalArgumentException exerciseId==null
     * @return 返回错题集
     */
    List<UserExerciseRecordDetail> findWrongRecordByExerciseId(String exerciseId);


}
