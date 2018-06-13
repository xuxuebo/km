package com.fp.cloud.module.im.domain;

public interface ImTemplate {
    String REGISTER_CONFIRM_CODE = "registerConfirmCode";
    String BIND_CONFIRM_CODE = "bindConfirmCode";
    String NOTICE_EXAMUSER_CODE = "noticeExamUserCode";//提醒考生消息模板
    String MARK_UP_EXAM_CODE = "markUpExam";//补考消息模板
    String CANCEL_EXAM_CODE = "cancelExamCode";//取消考试消息模板
    String REMOVE_EXAM_USER_CODE = "removeExamUserCode";//移除学员消息模板
    String BIND_MOBILE_CONFIRM_CODE = "bindMobileConfirmCode";
    String BIND_EMAIL = "bindEmail";//绑定邮箱
    String UPDATE_EXAM_TIME_CODE = "updateExamTimeCode";//修改线上考试的时间；
    String EXAM_USER_VERIFY_CODE = "examUserVerifyCode";
    String UPDATE_COMEXAM_ARRANGE_TIME_CODE = "updateExamArrangeTimeCode";//修改综合考试的时间
    String MANAGER_UPDATE_PASSWORD = "managerUpdatePassword";//管理员端重置密码
    String FORBIDDEN_USER = "forbiddenUser";//冻结用户
    String ENABLE_USER = "enableUser";//激活用户
    String NEW_BUILT_USER = "newBuiltUser";//新建用户
    String New_BUIlT_USER_MOBILE = "newBuiltUserMobile";
    String ENABLE_COMEXAM_CODE = "enableComExamCode";//启用综合考试信息；
    String NOTICE_EXAM_USER_SCORE = "noticeExamUserScore";//发布成绩通知；
    String REGISTER_CORP_CODE = "registerCorpCode";//发布成绩通知；
    String OPEN_TRY_CORP = "openTryCorp";//发布成绩通知；
}
