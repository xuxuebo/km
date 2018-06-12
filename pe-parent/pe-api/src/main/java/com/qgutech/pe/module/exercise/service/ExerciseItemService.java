package com.qgutech.pe.module.exercise.service;

import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.Item;
import com.qgutech.pe.module.ems.vo.Ic;
import com.qgutech.pe.module.exercise.model.ExerciseItem;
import com.qgutech.pe.module.exercise.model.UserExerciseRecord;

import java.util.List;

/**
 * 练习与试题关联服务类
 *
 * @since 2017年3月27日14:13:15.
 */
public interface ExerciseItemService extends BaseService<ExerciseItem> {

    /**
     * 该方法用于练习重新开始时，删除练习关联的试题
     *
     * @param exerciseId 练习Id
     * @param userId 用户Id
     * @return 影响的行数
     */
    int deleteByExerciseIdsAndUserId(String exerciseId,String userId);

    /**
     * 练习开始  查找该练习关联表中数据
     *
     * @param exerciseId 练习ID（不可为空）
     * @param itemIds 练习试题id（可以为空）
     * @return 练习试题关联集合
     * @since 2017年4月1日18:09:10
     */
    List<ExerciseItem> listByExerciseId(String exerciseId,List<String>itemIds);

    /**
     * 练习下一题时，获取该题的内容信息
     *
     * @param userExerciseRecord 用户结果详情
     * @return Ic 该题内容
     */
    Ic getIcByRecord(UserExerciseRecord userExerciseRecord);


}
