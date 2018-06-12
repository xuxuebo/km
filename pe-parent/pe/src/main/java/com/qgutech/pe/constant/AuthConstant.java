package com.qgutech.pe.constant;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public interface AuthConstant {
    /**
     * 版本权限中的绝密试题功能
     */
    String VERSION_OF_SECRET_ITEM = "VERSION_OF_SECRET_ITEM";

    /**
     * 版本权限中的知识点管理功能
     */
    String VERSION_OF_KNOWLEDGE_POINT = "VERSION_OF_KNOWLEDGE_POINT";

    /**
     * 版本权限中的监控功能
     */
    String VERSION_OF_MONITOR = "VERSION_OF_MONITOR";

    /**
     * 版本权限中的监控待办功能
     */
    String VERSION_OF_TODO_MONITOR = "VERSION_OF_TODO_MONITOR";
    /**
     * 更多设置
     */
    String VERSION_OF_MORE_ACTION = "VERSION_OF_MORE_ACTION";

    /**
     * 版本权限中的试题导出功能
     */
    String VERSION_OF_ITEM_EXPORT = "VERSION_OF_ITEM_EXPORT";

    /**
     * 版本权限中的题库列表授权功能
     */
    String VERSION_OF_ITEM_BANK_AUTHORIZE = "VERSION_OF_ITEM_BANK_AUTHORIZE";

    /**
     * 版本权限中的试卷授权功能
     */
    String VERSION_OF_TEMPLATE_AUTHORIZE = "VERSION_OF_TEMPLATE_AUTHORIZE";

    /**
     * 版本权限中的监考人员设置
     */
    String VERSION_OF_INVIGILATOR_SETTING = "VERSION_OF_INVIGILATOR_SETTING";

    /**
     * 版本权限中的考试人员的导出
     */
    String VERSION_OF_EXAM_USER_EXPORT = "VERSION_OF_EXAM_USER_EXPORT";

    /**
     * 版本权限中的考试时长设置
     */
    String VERSION_OF_EXAM_LENGTH = "VERSION_OF_EXAM_LENGTH";

    /**
     * 版本权限中的考试时长设置
     */
    String VERSION_OF_EXAM_ANSWER_PATTERN = "VERSION_OF_EXAM_ANSWER_PATTERN";

    /**
     * 版本权限中的考试消息设置
     */
    String VERSION_OF_EXAM_MESSAGE = "VERSION_OF_EXAM_MESSAGE";

    /**
     * 版本权限中的考试消息设置
     */
    String VERSION_OF_EXAM_MAKE_UP = "VERSION_OF_EXAM_MAKE_UP";

    /**
     * 版本权限中的考试消息设置
     */
    String VERSION_OF_EXAM_MARKING_STRATEGY = "VERSION_OF_EXAM_MARKING_STRATEGY";

    /**
     * 版本权限中的多选/不定项评分规则
     */
    String VERSION_OF_EXAM_MULTIPLE_RULE = "VERSION_OF_EXAM_MULTIPLE_RULE";

    /**
     * 版本权限中的复评功能
     */
    String VERSION_OF_EXAM_RE_EVALUATION = "VERSION_OF_EXAM_RE_EVALUATION";

    /**
     * 版本权限中的弱项分析
     */
    String VERSION_OF_RESULT_ANALYSE = "VERSION_OF_RESULT_ANALYSE";

    /**
     * 版本权限中的发布成绩设置
     */
    String VERSION_OF_EXAM_PUBLISH_RESULT = "VERSION_OF_EXAM_PUBLISH_RESULT";

    /**
     * 版本权限中的考试权限设置，如考试后能否看答卷
     */
    String VERSION_OF_EXAM_AUTH = "VERSION_OF_EXAM_AUTH";

    /**
     * 版本权限中的排行榜显示功能
     */
    String VERSION_OF_RANK_SHOW = "VERSION_OF_RANK_SHOW";

    /**
     * 版本权限中的排行榜发布功能
     */
    String VERSION_OF_RANK_PUBLISH = "VERSION_OF_RANK_PUBLISH";

    /**
     * 版本权限中的进入考试的短信验证功能
     */
    String VERSION_OF_MESSAGE_VERIFY = "VERSION_OF_MESSAGE_VERIFY";

    /**
     * 版本权限中的考试实时抓拍功能
     */
    String VERSION_OF_REAL_TIME_CAPTURE = "VERSION_OF_REAL_TIME_CAPTURE";

    /**
     * 版本权限中禁止迟到参加考试
     */
    String VERSION_OF_LATE_FORBIDDEN = "VERSION_OF_LATE_FORBIDDEN";

    /**
     * 版本权限中少于多少分钟禁止交卷
     */
    String VERSION_OF_FORBIDDEN_SUBMIT = "VERSION_OF_FORBIDDEN_SUBMIT";

    /**
     * 版本权限中试题乱序
     */
    String VERSION_OF_ITEM_RANDOM = "VERSION_OF_ITEM_RANDOM";

    /**
     * 版本权限中练习管理的分析功能
     */
    String VERSION_OF_EXERCISE_ANALYSE = "VERSION_OF_EXERCISE_ANALYSE";

    /**
     * 版本权限中评卷管理
     */
    String VERSION_OF_MARKING_MANAGE = "VERSION_OF_MARKING_MANAGE";

    /**
     * 版本权限中发布成绩按钮
     */
    String VERSION_OF_PUBLISH_RESULT_BTN = "VERSION_OF_PUBLISH_RESULT_BTN";

    /**
     * 版本权限中用户批量导入
     */
    String VERSION_OF_USER_EXPORT = "VERSION_OF_USER_EXPORT";

    /**
     * 版本权限中角色管理
     */
    String VERSION_OF_ROLE_MANAGE = "VERSION_OF_ROLE_MANAGE";

    /**
     * 版本权限中学员端排行榜
     */
    String VERSION_USER_OF_RANK = "VERSION_USER_OF_RANK";

    /**
     * 版本权限中学员端成绩分析
     */
    String VERSION_USER_OF_RESULT_ANALYSE = "VERSION_USER_OF_RESULT_ANALYSE";

    List<String> FREE_VERSION_L = new ArrayList<>(0);
    List<String> ENTERPRISE_VERSION_L = new ArrayList<>(Arrays.asList(
            VERSION_OF_SECRET_ITEM,
            VERSION_OF_KNOWLEDGE_POINT,
            VERSION_OF_MONITOR,
            VERSION_OF_TODO_MONITOR,
            VERSION_OF_ITEM_EXPORT,
            VERSION_OF_ITEM_BANK_AUTHORIZE,
            VERSION_OF_TEMPLATE_AUTHORIZE,
            VERSION_OF_INVIGILATOR_SETTING,
            VERSION_OF_EXAM_USER_EXPORT,
            VERSION_OF_EXAM_LENGTH,
            VERSION_OF_EXAM_ANSWER_PATTERN,
            VERSION_OF_EXAM_MESSAGE,
            VERSION_OF_EXAM_MAKE_UP,
            VERSION_OF_EXAM_MARKING_STRATEGY,
            VERSION_OF_EXAM_MULTIPLE_RULE,
            VERSION_OF_EXAM_RE_EVALUATION,
            VERSION_OF_RESULT_ANALYSE,
            VERSION_OF_EXAM_PUBLISH_RESULT,
            VERSION_OF_EXAM_AUTH,
            VERSION_OF_RANK_SHOW,
            VERSION_OF_RANK_PUBLISH,
            VERSION_OF_MESSAGE_VERIFY,
            VERSION_OF_REAL_TIME_CAPTURE,
            VERSION_OF_LATE_FORBIDDEN,
            VERSION_OF_FORBIDDEN_SUBMIT,
            VERSION_OF_ITEM_RANDOM,
            VERSION_OF_EXERCISE_ANALYSE,
            VERSION_OF_MARKING_MANAGE,
            VERSION_OF_PUBLISH_RESULT_BTN,
            VERSION_OF_USER_EXPORT,
            VERSION_OF_ROLE_MANAGE,
            VERSION_USER_OF_RANK,
            VERSION_USER_OF_RESULT_ANALYSE,
            VERSION_OF_MORE_ACTION
    ));
}
