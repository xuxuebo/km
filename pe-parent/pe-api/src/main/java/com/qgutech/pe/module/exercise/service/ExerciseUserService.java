package com.qgutech.pe.module.exercise.service;


import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.exercise.model.ExerciseUser;
import com.qgutech.pe.module.uc.model.User;

import java.util.List;

/**
 * 练习关联人员接口
 *
 * @author LiYanCheng
 * @since 2017-10-31 11:16:35
 */
public interface ExerciseUserService extends BaseService<ExerciseUser> {
    /**
     * 【练习选择待选人员】
     *
     * @param user      查询条件
     *                  <ul>
     *                  <li>{@linkplain User#userName 姓名}</li>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#mobile 手机号}</li>
     *                  <li>{@linkplain User#employeeCode 工号}</li>
     *                  <li>{@linkplain User#positionId 岗位Id}</li>
     *                  <li>{@linkplain com.qgutech.pe.module.uc.model.Organize#id 部门Id}</li>
     *                  </ul>
     * @param pageParam 分页查询对象
     * @return 返回查询的分页数据
     */
    Page<User> searchWaitUser(User user, PageParam pageParam);

    /**
     * 练习保存user
     * 根据练习的transientCreate 判断创建练习
     * 创建练习将user保存在redis 编辑时之间保存到数据库
     *
     * @param referIds         需要保存类型的id
     * @param exerciseUserType 类型
     *                         <ul>
     *                         <li>{@linkplain ExerciseUser.ExerciseUserType#ORGANIZE 部门}</li>
     *                         <li>{@linkplain ExerciseUser.ExerciseUserType#POSITION 岗位}</li>
     *                         <li>{@linkplain ExerciseUser.ExerciseUserType#USER 用户}</li>
     *                         </ul>
     */
    void saveUser(List<String> referIds, ExerciseUser.ExerciseUserType exerciseUserType);


    /**
     * 【练习人员查询】
     *
     * @param user      查询条件
     *                  <ul>
     *                  <li>{@linkplain User#userName 姓名}</li>
     *                  <li>{@linkplain User#loginName 用户名}</li>
     *                  <li>{@linkplain User#mobile 手机号}</li>
     *                  <li>{@linkplain User#employeeCode 工号}</li>
     *                  <li>{@linkplain User#positionId 岗位Id}</li>
     *                  <li>{@linkplain com.qgutech.pe.module.uc.model.Organize#id 部门Id}</li>
     *                  </ul>
     * @param pageParam 分页
     * @return 用户分页数据，封装部门、岗位信息
     */
    Page<User> searchSelectUser(User user, PageParam pageParam);

    /**
     * 获取 我的练习
     *
     * @return 练习Id集合
     */
    List<String> searchMyExerciseDynamic();

    /**
     * 删除练习的用户
     *
     * @param referIds         需删除ID的集合
     * @param exerciseUserType 类型
     *                         <ul>
     *                         <li>{@linkplain ExerciseUser.ExerciseUserType#ORGANIZE 部门}</li>
     *                         <li>{@linkplain ExerciseUser.ExerciseUserType#POSITION 岗位}</li>
     *                         <li>{@linkplain ExerciseUser.ExerciseUserType#USER 用户}</li>
     *                         </ul>
     * @return 删除的行数
     */
    int deleteSelectUser(List<String> referIds, ExerciseUser.ExerciseUserType exerciseUserType);

    /**
     * 查询出指定数量
     *
     * @param exerciseId       练习ID
     * @param exerciseUserType 查询类型(可为空，为空时查全部)
     *                         <ul>
     *                         <li>{@linkplain com.qgutech.pe.module.exercise.model.ExerciseUser.ExerciseUserType#ORGANIZE 组织}</li>
     *                         <li>{@linkplain com.qgutech.pe.module.exercise.model.ExerciseUser.ExerciseUserType#USER 用户}</li>
     *                         </ul>
     * @return 查询出指定ID集合
     */
    List<String> listReferId(String exerciseId, ExerciseUser.ExerciseUserType exerciseUserType);
}
