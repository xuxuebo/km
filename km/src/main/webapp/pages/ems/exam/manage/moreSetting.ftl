<div id="moreSettingPanel">

    <form id="moreExamSettingForm">
        <input type="hidden" name="id" value="${(examSetting.id)!}"/>
        <input type="hidden" name="exam.id" value="${(exam.id)!}"/>
        <input type="hidden" value="${(exam.examType)!"ONLINE"}" name="exam.examType">

        <div class="add-exam-item-wrap more-setting-panel">
            <div class="exam-setting-wrap select">
                <div class="exam-setting-wrap-top">
                    <div class="floatL">
                        基础设置
                    </div>
                    <div class="floatR">
                        <a class="iconfont icon-thin-arrow-up fold-setting-btn"></a>
                    </div>
                </div>
                <div class="exam-setting-wrap-content">
                <#if (exam.subject)?? && !exam.subject>
                    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
                        <dt class="floatL user-detail-title">监考员:</dt>
                        <dd class="user-detail-value">
              <span class="exam-has-added-user-num EXAM_MANAGER_name_${(exam.id)!}">
                   <#if (examSetting.examAuthList)??>
                       <#list examSetting.examAuthList as examAuth>
                           <span class="tags add-question-bank-item bank-list " data-id="${(examAuth.user.id)!}"
                                 data-text="${(examAuth.user.userName)!}"><span class="has-item-user-name"
                                                                                title="${(examAuth.user.userName)!}">${(examAuth.user.userName)!}</span>
                               <#if exam.createBy?? && examAuth?? && examAuth.user?? && examAuth.user.id?? && exam.createBy != examAuth.user.id>
                                   <span class="iconfont icon-inputDele"></span>
                               </#if>
                            </span>
                       </#list>
                   </#if>
                  <a href="javascript:;" class="exam-view-user add-manager view-exam-group-select-user"
                     <#if exam.optType?? && (exam.optType == 'VIEW')>style="display:none;" </#if>>选择人员</a>
              </span>
                        </dd>
                    </dl>
                </#if>
                    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
                        <@authVerify authCode="VERSION_OF_EXAM_LENGTH">
                            <dt class="floatL user-detail-title">考试时长:</dt>
                            <dd class="user-detail-value">
                                <label class="pe-radio <#if (exam.status)! =='PROCESS'> noClick</#if> ">
                                <span class="iconfont
                                <#if (examSetting.examSetting.elt)! == ""||(examSetting.examSetting.elt)! == 'NO_LIMIT'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                    <input class="pe-form-ele" id="NO_LIMIT_TIME" type="radio" value="NO_LIMIT"
                                           name="examSetting.elt"
                                           <#if (examSetting.examSetting.elt)! == ""||(examSetting.examSetting.elt)! == 'NO_LIMIT'>checked="checked"</#if>/>
                                    不限制考试时长 <span class="add-paper-tip-text">考试结束前都可以参加考试，到达考试结束时间，自动交卷</span>
                                </label>
                                <div class="limit-time-radio-wrap">
                                    <label class="pe-radio <#if (exam.status)! =='PROCESS'> noClick</#if> ">
                                    <span class="iconfont
                                    <#if (examSetting.examSetting.elt)! == 'LIMIT'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        限制时长为
                                        <input class="pe-form-ele" type="radio" id="LIMIT_TIME" value="LIMIT"
                                               name="examSetting.elt"
                                               <#if (examSetting.examSetting.elt)! == 'LIMIT'>checked="checked"</#if>/>
                                        <input type="text" value="${(examSetting.examSetting.el)!}" id="LIMIT_TIME_TEXT"
                                               name="examSetting.el"
                                               <#if (exam.status)! =='PROCESS'>readonly</#if>
                                               class="exam-create-num-input">&nbsp;分钟
                                    </label>
                                </div>
                            </dd>
                        </@authVerify>
                        <@authVerify authCode="VERSION_OF_EXAM_ANSWER_PATTERN">
                            <dt class="floatL user-detail-title">答题模式:</dt>
                            <dd class="user-detail-value">
                                <label class="pe-radio pe-check-by-list <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> "
                                       for="">
                                    <span class="iconfont <#if (examSetting.examSetting.at)! == ''||(examSetting.examSetting.at)! == 'ALL'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                    <input class="pe-form-ele" type="radio" value="ALL" name="examSetting.at" id="ALL"
                                    <#if (examSetting.examSetting.at)! == ''||(examSetting.examSetting.at)! == 'ALL'>
                                           checked="checked"</#if>/>
                                    整卷模式
                                </label>
                                <div>
                                    <div style="height:24px;">
                                        <label class="pe-radio pe-check-by-list <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> "
                                               for="">
                                            <span class="iconfont <#if (examSetting.examSetting.at)! == 'EVERY'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                            <input class="pe-form-ele" type="radio" value="EVERY" name="examSetting.at"
                                                   id="EVERY"
                                            <#if (examSetting.examSetting.at)! == 'EVERY'> checked="checked"</#if>/>
                                            逐题模式
                                        </label>
                                    </div>
                                    <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>noClick</#if>"
                                           style="margin-left:18px;">
                                        <span class="iconfont <#if (examSetting.examSetting.ce)!?string == 'true'>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true" name="examSetting.ce"
                                               <#if (examSetting.examSetting.ce)!?string == 'true'>checked="checked"</#if>
                                               <#if (examSetting.examSetting.at)! != 'EVERY'>disabled="disabled"</#if>/>
                                        允许返回修改答案
                                    </label>
                                </div>
                            </dd>
                        </@authVerify>
                        <@authVerify authCode="VERSION_OF_EXAM_MAKE_UP">
                            <dt class="floatL user-detail-title">补考设置:</dt>
                            <dd class="user-detail-value">
                                <div>
                                    <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                        <span class="iconfont <#if (examSetting.examSetting.mt)! == ''||(examSetting.examSetting.mt)! == 'NO_MAKEUP'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="NO_MAKEUP" name="examSetting.mt"
                                        <#if (examSetting.examSetting.mt)! == ''|| (examSetting.examSetting.mt)! == 'NO_MAKEUP'>
                                               checked="checked"</#if>/>
                                        不允许补考
                                    </label>
                                </div>
                                <div>
                                    <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                        <span class="iconfont <#if (examSetting.examSetting.mt)! == 'AUTO_MAKEUP'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="AUTO_MAKEUP"
                                               name="examSetting.mt"
                                        <#if (examSetting.examSetting.mt)! == 'AUTO_MAKEUP'> checked="checked"</#if>/>
                                        自动安排补考
                                    </label>&nbsp;&nbsp;补考次数
                                    <input type="text" name="examSetting.mn" value="${(examSetting.examSetting.mn)!'0'}"
                                           <#if (exam.status)! =='PROCESS'>readonly</#if>
                                           class="exam-create-num-input"><span
                                        class="add-paper-tip-text">补考次数为“0”时，表示不限制补考的次数</span>
                                </div>
                                <div>
                                    <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                        <span class="iconfont <#if (examSetting.examSetting.mt)! == 'MANUAL_MAKEUP'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="MANUAL_MAKEUP"
                                               name="examSetting.mt"
                                        <#if (examSetting.examSetting.mt)! == 'MANUAL_MAKEUP'> checked="checked"</#if>/>
                                        手动安排补考<span
                                            class="add-paper-tip-text">成绩发布后，管理员手工给未通过或缺考的学员安排补考，补考可以设置新的试卷和考试时间</span>
                                    </label>
                                </div>
                            </dd>
                        </@authVerify>
                    </dl>
                </div>
            </div>

            <@authVerify authCode="VERSION_OF_EXAM_MARKING_STRATEGY">
                <div class="exam-setting-wrap">
                    <div class="exam-setting-wrap-top">
                        <div class="floatL">
                            评卷策略
                        </div>
                        <div class="floatR">
                            <a class="iconfont icon-thin-arrow-down fold-setting-btn"></a>
                        </div>
                    </div>
                    <div class="exam-setting-wrap-content" style="display: none;">
                        <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
                            <dt class="floatL user-detail-title"></dt>
                            <dd class="user-detail-value">
                                <div>
                <span class="pe-radio pe-check-by-list <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> "
                      for="">
                    <span class="iconfont <#if (examSetting.judgeSetting.jt)! == ''||(examSetting.judgeSetting.jt)! == 'AUTO_JUDGE'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <input class="pe-form-ele" type="radio" value="AUTO_JUDGE" name="judgeSetting.jt"
                           id="AUTO_JUDGE"
                           <#if (examSetting.judgeSetting.jt)! == ''||(examSetting.judgeSetting.jt)! == 'AUTO_JUDGE'>checked="checked"</#if>/>
                    自动评卷<span class="add-paper-tip-text">适合全部为客观题的试卷，系统对客观题自动评卷，若有主观题，则记为0分</span>
                </span>
                                </div>
                                <div>
                                    <div style="height:24px;">
                    <span class="pe-radio pe-check-by-list <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                        <span class="iconfont <#if (examSetting.judgeSetting.jt)! == 'MANUAL_JUDGE_PAPER'||(examSetting.judgeSetting.jt)! == 'MANUAL_JUDGE_ITEM'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                        <input class="pe-form-ele" type="radio" value="MANUAL_JUDGE" id="MANUAL_JUDGE"
                               name="judgeSetting.jt"
                               <#if (examSetting.judgeSetting.jt)! == 'MANUAL_JUDGE_PAPER'||(examSetting.judgeSetting.jt)! == 'MANUAL_JUDGE_ITEM'>checked="checked"</#if>/>
                        人工评卷
                    </span>
                                    </div>
                                    <div style="margin-left:18px;">
                                        <div>
                                            <label class="pe-radio" for="">
                                                <span class="iconfont <#if (examSetting.judgeSetting.jt)! == 'MANUAL_JUDGE_PAPER'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                                <input class="pe-form-ele" type="radio" value="MANUAL_JUDGE_PAPER"
                                                       name="judgeSetting.jt" id="MANUAL_JUDGE_PAPER"
                                                       readonly="readonly"
                                                   <#if (examSetting.judgeSetting.jt)! == 'MANUAL_JUDGE_PAPER'>checked="checked"</#if>/>
                                                按试卷分配评卷人
                                            </label>
                                            <span class="exam-has-added-user-num MANUAL_JUDGE_PAPER_span">
                               <#--<#if (examSetting.judgeSetting.jt)! != 'MANUAL_JUDGE_PAPER' || !(examSetting.judgeUserRels)??></#if>>-->
                                   <span class="JUDGE_PAPER_USER_name_${(exam.id)!}">
                                        <#if (examSetting.typeCountMap['MANUAL_JUDGE_PAPER_USER'])??&&((examSetting.typeCountMap['MANUAL_JUDGE_PAPER_USER'])!>0)&&(examSetting.judgeUserRels)??>
                                            <#list examSetting.judgeUserRels as judgeUser>
                                                <a class="tags  bank-list add-question-bank-item"
                                                   data-id="${(judgeUser.user.id)!}"
                                                   data-text="${(judgeUser.user.userName)!}">
                                                    <span class="has-item-user-name"
                                                          title="${(judgeUser.user.userName)!}">${(judgeUser.user.userName)!}</span>
                                                    <span class="iconfont icon-inputDele"></span>
                                                </a>
                                            </#list>
                                        </#if>
                                       <a href="javascript:;" class="exam-view-user add-paper-user"
                                          style="margin-left:10px;"
                                          data-type="MANUAL_JUDGE_PAPER">选择人员</a>
                                   </span>
                                        </div>
                                        <div>
                                            <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if>">
                                                <span class="iconfont <#if (examSetting.judgeSetting.vi)!?string == 'true'>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                                <input class="pe-form-ele" type="checkbox" value="true"
                                                       name="judgeSetting.vi"
                                                   <#if (examSetting.judgeSetting.vi)!?string == 'true'>checked="checked"</#if>
                                                   <#if (examSetting.judgeSetting.jt)! == ''|| (examSetting.judgeSetting.jt)! == 'AUTO_JUDGE'>disabled="disabled"</#if>/>
                                                允许评卷人查看考生信息
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
            </@authVerify>

            <div class="exam-setting-wrap">
                <div class="exam-setting-wrap-top">
                    <div class="floatL">
                        成绩设置
                    </div>
                    <div class="floatR">
                        <a class="iconfont icon-thin-arrow-down fold-setting-btn"></a>
                    </div>
                </div>
                <div class="exam-setting-wrap-content" style="display: none;">
                    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
                        <dt class="floatL user-detail-title">成绩设置:</dt>
                        <dd class="user-detail-value">
                            <div>
                                <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                <#if !((exam.subject)?? && exam.subject)>
                                    <span class="iconfont <#if (examSetting.scoreSetting.st)! == ''||(examSetting.scoreSetting.st)! == 'CONVERT'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                </#if>
                                    <input class="pe-form-ele" value="CONVERT" name="scoreSetting.st"
                                           type="<#if (exam.subject)?? && exam.subject>hidden<#else>radio</#if>"
                                           <#if (examSetting.scoreSetting.st)! == ''||(examSetting.scoreSetting.st)! == 'CONVERT'>checked="checked"</#if>/>
                                    原试卷题目分数按比例折算成满分
                                    <input type="text" value="${(examSetting.scoreSetting.cm)!'100'}"
                                           name="scoreSetting.cm"
                                           class="exam-create-num-input"
                                           <#if (exam.status)! =='PROCESS'>readonly</#if>>分
                                </label>
                            </div>
                        <#if !((exam.subject)?? && exam.subject)>
                            <div>
                                <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                    <span class="iconfont <#if (examSetting.scoreSetting.st)! == 'ORIGINAL'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                    <input class="pe-form-ele" type="radio" value="ORIGINAL" name="scoreSetting.st"
                                           <#if (examSetting.scoreSetting.st)! == 'ORIGINAL'>checked="checked"</#if>/>
                                    使用原试卷分数<span class="add-paper-tip-text">如果使用多份试卷，每份试卷的分值可能会不一致，请仔细检查</span>
                                </label>
                            </div>
                        </#if>
                        </dd>

                        <dt class="floatL user-detail-title">及格条件:</dt>
                        <dd class="user-detail-value">得分率不低于
                            <input type="text" <#if (exam.status)! =='PROCESS'>readonly</#if>
                                   value="${(examSetting.scoreSetting.pr)!'60'}" name="scoreSetting.pr"
                                   class="exam-create-num-input">&nbsp;%
                        </dd>
                        <@authVerify authCode="VERSION_OF_EXAM_MULTIPLE_RULE">
                            <dt class="floatL user-detail-title">多选/不定项评分规则:</dt>
                            <dd class="user-detail-value">
                                <div>
                                    <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> "
                                           for="">
                                        <span class="iconfont <#if (examSetting.scoreSetting.mst)! == ''||(examSetting.scoreSetting.mst)! == 'LESS_SELECT_NO_SCORE'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="LESS_SELECT_NO_SCORE"
                                               name="scoreSetting.mst"
                                               <#if (examSetting.scoreSetting.mst)! == ''||(examSetting.scoreSetting.mst)! == 'LESS_SELECT_NO_SCORE'>checked="checked"</#if>/>
                                        选对得满分，选错或少选不得分
                                    </label>
                                </div>
                                <div>
                                    <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> "
                                           for="">
                                        <span class="iconfont <#if (examSetting.scoreSetting.mst)! == 'LESS_SELECT_SCORE_HALF'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="LESS_SELECT_SCORE_HALF"
                                               name="scoreSetting.mst"
                                               <#if (examSetting.scoreSetting.mst)! == 'LESS_SELECT_SCORE_HALF'>checked="checked"</#if>/>
                                        选对得满分，选错不得分，少选得一半分
                                    </label>
                                </div>
                                <div>
                                    <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> "
                                           for="">
                                        <span class="iconfont <#if (examSetting.scoreSetting.mst)! == 'LESS_SELECT_SCORE_RATE'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="LESS_SELECT_SCORE_RATE"
                                               name="scoreSetting.mst"
                                               <#if (examSetting.scoreSetting.mst)! == 'LESS_SELECT_SCORE_RATE'>checked="checked"</#if>/>
                                        选对得满分，选错不得分，少选按比例得分
                                    </label>
                                </div>
                            </dd>
                        </@authVerify>
                        <@authVerify authCode="VERSION_OF_EXAM_PUBLISH_RESULT">
                            <dt class="floatL user-detail-title">成绩发布设置:</dt>
                            <dd class="user-detail-value">
                                <div>
                                    <label class="pe-radio pe-check-by-list <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> "
                                           for="">
                                        <span class="iconfont <#if (examSetting.scoreSetting.spt)! == ''||(examSetting.scoreSetting.spt)! == 'JUDGED_AUTO_PUBLISH'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="JUDGED_AUTO_PUBLISH"
                                               name="scoreSetting.spt" id="JUDGED_AUTO_PUBLISH"
                                           <#if (examSetting.scoreSetting.spt)! == ''||(examSetting.scoreSetting.spt)! == 'JUDGED_AUTO_PUBLISH'>checked="checked"</#if>/>
                                        评卷后自动发布成绩
                                    </label>
                                </div>
                                <div>
                                    <div style="height:28px;">
                                        <label class="pe-radio pe-check-by-list <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> "
                                               for="">
                                            <span class="iconfont <#if (examSetting.scoreSetting.spt)! == 'MANUAL'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                            <input class="pe-form-ele" type="radio" value="MANUAL"
                                                   name="scoreSetting.spt" id="MANUAL"
                                               <#if (examSetting.scoreSetting.spt)! == 'MANUAL'>checked="checked"</#if>/>
                                            手动发布
                                        </label>
                                    </div>
                                    <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if>"
                                           style="margin-left:22px;">
                                        <span class="iconfont <#if (examSetting.scoreSetting.spt)! == 'MANUAL' && (examSetting.scoreSetting.tp)!?string =='true'>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true" name="scoreSetting.tp"
                                           <#if (examSetting.scoreSetting.spt)! == 'MANUAL' && (examSetting.scoreSetting.tp)!?string =='true'>checked="checked"</#if>
                                           <#if (examSetting.scoreSetting.spt)! != 'MANUAL'>disabled</#if>/>
                                        定时发布成绩
                                    </label>
                                    <div class="pe-date-wrap">
                                    <input id="peExamIssueTimeDefault"
                                           class="pe-table-form-text pe-time-text exam-issue-time laydate-icon"
                                           style="width: 150px;"
                                           type="text" name="scoreSetting.pd"
                                       <#if (exam.status)! == 'PROCESS'>disabled</#if>
                                           data-toggle="datepicker" data-date-timepicker='true'
                                <#if (examSetting.scoreSetting.pd)??>
                                       value="${(examSetting.scoreSetting.pd?string('yyyy-MM-dd HH:mm'))!}">
                                </#if>
                                    </div>
                                <#--  <span class="add-paper-tip-text">如果没有手动发布成绩，系统会定时自动发布成绩</span>-->
                                </div>
                                <div>
                                    <label class="pe-radio pe-check-by-list <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> "
                                           for="">
                                        <span class="iconfont <#if (examSetting.scoreSetting.spt)! == 'JUDGED_ALL_AND_EXAM_END'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="JUDGED_ALL_AND_EXAM_END"
                                               name="scoreSetting.spt" id="JUDGED_ALL_AND_EXAM_END"
                                           <#if (examSetting.scoreSetting.spt)! == 'JUDGED_ALL_AND_EXAM_END'>checked="checked"</#if>/>
                                        考试结束且完成所有评卷后发布成绩
                                    </label>
                                </div>
                            </dd>
                        </@authVerify>

                        <@authVerify authCode="VERSION_OF_EXAM_AUTH">
                            <dt class="floatL user-detail-title">考试权限设置:</dt>
                            <dd class="user-detail-value sameChange">
                                <div>
                                    <label class="pe-radio">
                                        <span class="iconfont <#if (examSetting.examAuthType)! == 'NO_SEE'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="NO_SEE" name="examAuthType"
                                           <#if (examSetting.examAuthType)! == 'NO_SEE'>checked="checked"</#if>/>
                                        不允许考生查看答卷
                                    </label>
                                </div>
                                <div>
                                    <label class="pe-radio">
                                        <span class="iconfont <#if (examSetting.examAuthType)! == 'SEE_PAPER_NO_ANSWER'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="SEE_PAPER_NO_ANSWER"
                                               name="examAuthType"
                                           <#if (examSetting.examAuthType)! == 'SEE_PAPER_NO_ANSWER'>checked="checked"</#if>/>
                                        允许考生查看答卷，但不允许查看正确答案
                                    </label>
                                </div>
                                <div>
                                    <label class="pe-radio">
                                        <span class="iconfont <#if (examSetting.examAuthType)! == ''||(examSetting.examAuthType)! == 'JUDGE_AND_SEE_ALL'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="JUDGE_AND_SEE_ALL"
                                               name="examAuthType"
                                           <#if (examSetting.examAuthType)! == ''||(examSetting.examAuthType)! == 'JUDGE_AND_SEE_ALL'>checked="checked"</#if>/>
                                        评卷后允许考生查看答卷和正确答案
                                    </label>
                                </div>
                                <div>
                                    <label class="pe-radio">
                                        <span class="iconfont <#if (examSetting.examAuthType)! == 'SEE_ERROR_NO_ANSWER'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="SEE_ERROR_NO_ANSWER"
                                               name="examAuthType"
                                           <#if (examSetting.examAuthType)! == 'SEE_ERROR_NO_ANSWER'>checked="checked"</#if>/>
                                        只允许考生查看答错的试题，且不显示正确答案
                                    </label>
                                </div>
                                <div>
                                    <label class="pe-radio">
                                        <span class="iconfont <#if (examSetting.examAuthType)! == 'SEE_ERROR_AND_ANSWER'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="SEE_ERROR_AND_ANSWER"
                                               name="examAuthType"
                                           <#if (examSetting.examAuthType)! == 'SEE_ERROR_AND_ANSWER'>checked="checked"</#if>/>
                                        只允许考生查看答错的试题，同时显示正确答案
                                    </label>
                                </div>
                            </dd>
                        </@authVerify>

                    </dl>
                </div>
            </div>

            <@authVerify authCode="VERSION_OF_RANK_SHOW">
                <div class="exam-setting-wrap">
                    <div class="exam-setting-wrap-top">
                        <div class="floatL">
                            排行榜设置
                        </div>
                        <div class="floatR">
                            <a class="iconfont icon-thin-arrow-down fold-setting-btn"></a>
                        </div>
                    </div>
                    <div class="exam-setting-wrap-content" style="display: none;">
                        <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
                            <dt class="floatL user-detail-title">排行榜显示设置:</dt>
                            <dd class="user-detail-value sameChange">
                                <div style="margin-bottom:5px;">
                                    <label class="pe-radio">
                                        <span class="iconfont <#if (examSetting.rankSetting.rst)! == ''||(examSetting.rankSetting.rst)! == 'NO_SHOW'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="NO_SHOW" name="rankSetting.rst"
                                           <#if (examSetting.rankSetting.rst)! == ''||(examSetting.rankSetting.rst)! == 'NO_SHOW'>checked="checked"</#if>/>
                                        不显示考试排名
                                    </label>
                                </div>
                                <input type="hidden" name="rankSetting.rsn" value="${(examSetting.rankSetting.rsn)!}">
                                <div style="margin-bottom:5px;">
                                    <label class="pe-radio">
                                        <span class="iconfont <#if (examSetting.rankSetting.rst)! == 'SHOW_FIRST'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="SHOW_FIRST"
                                               name="rankSetting.rst"
                                           <#if (examSetting.rankSetting.rst)! == 'SHOW_FIRST'>checked="checked"</#if>/>
                                        显示首次考试的排名
                                    </label>&nbsp;&nbsp;显示前
                                    <input type="text" value="${(examSetting.rankSetting.rsn)!10}"
                                           id="rankSetting_rsn_SHOW_FIRST"
                                           class="exam-create-num-input">名的排名情况
                                    <span class="add-paper-tip-text">不填则显示全部排名</span>
                                    </label>
                                </div>
                                <div style="margin-bottom:5px;">
                                    <label class="pe-radio">
                                        <span class="iconfont <#if (examSetting.rankSetting.rst)! == 'SHOW_MAX'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="SHOW_MAX" name="rankSetting.rst"
                                           <#if (examSetting.rankSetting.rst)! == 'SHOW_MAX'>checked="checked"</#if>/>
                                        显示最高成绩的排名
                                    </label>&nbsp;&nbsp;显示前
                                    <input type="text" value="${(examSetting.rankSetting.rsn)!10}"
                                           id="rankSetting_rsn_SHOW_MAX"
                                           class="exam-create-num-input">名的排名情况
                                    <span class="add-paper-tip-text">不填则显示全部排名</span>
                                </div>
                            </dd>
                            <dt class="floatL user-detail-title">排行榜发布设置:</dt>
                            <dd class="user-detail-value sameChange">
                                <div>
                                    <label class="pe-radio">
                                        <span class="iconfont <#if (examSetting.rankSetting.sht)! == 'SHOW_MARK'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="SHOW_MARK" name="rankSetting.sht"
                                           <#if (examSetting.rankSetting.sht)! == 'SHOW_MARK'>checked="checked"</#if>/>
                                        成绩发布且考试结束后显示考试排名
                                    </label>
                                </div>
                                <div>
                                    <label class="pe-radio">
                                        <span class="iconfont <#if (!((examSetting.rankSetting.sht)??)||(examSetting.rankSetting.sht)! == 'SHOW_END')>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                        <input class="pe-form-ele" type="radio" value="SHOW_END" name="rankSetting.sht"
                                           <#if (!((examSetting.rankSetting.sht)??)||(examSetting.rankSetting.sht)! == 'SHOW_END')>checked="checked"</#if>/>
                                        成绩发布后显示考试排名
                                    </label>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
            </@authVerify>

            <div class="exam-setting-wrap">
                <div class="exam-setting-wrap-top">
                    <div class="floatL">
                        防舞弊设置
                    </div>
                    <div class="floatR">
                        <a class="iconfont icon-thin-arrow-down fold-setting-btn"></a>
                    </div>
                </div>
                <div class="exam-setting-wrap-content" style="display: none;">
                    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
                    <#--<dt class="floatL user-detail-title">防舞弊设置:</dt>-->
                        <dd class="user-detail-value">
                            <@authVerify authCode="VERSION_OF_MESSAGE_VERIFY">
                                <div>
                                    <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                        <span class="iconfont <#if (examSetting.preventSetting.sv)?? && examSetting.preventSetting.sv>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.sv"
                                    <#if (examSetting.preventSetting.sv)?? && examSetting.preventSetting.sv>
                                           checked="checked"</#if>/>
                                        进入考试时需要短信验证身份
                                    </label>
                                </div>
                            </@authVerify>
                            <@authVerify authCode="VERSION_OF_REAL_TIME_CAPTURE">
                                <div>
                                    <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                        <span class="iconfont <#if (examSetting.preventSetting.rc)?? && examSetting.preventSetting.rc>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.rc"
                                    <#if (examSetting.preventSetting.rc)?? && examSetting.preventSetting.rc>
                                           checked="checked"</#if>/>
                                        开启实时摄像抓拍的功能
                                    </label>
                                </div>
                            </@authVerify>

                            <#if !(exam.subject?? &&exam.subject)>
                            <div>
                                <label class="pe-checkbox <#if (exam.status)! =='PROCESS' || !(examSetting.payApps?? &&examSetting.payApps?contains("REMOTEMONITOR"))>add-paper-tip-text noClick</#if> ">
                                    <span class="iconfont <#if examSetting.preventSetting.om?? && examSetting.preventSetting.om>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.om"
                                    <#if !(examSetting.payApps?? &&examSetting.payApps?contains("REMOTEMONITOR"))>readonly="readonly"</#if>
                                    <#if examSetting.preventSetting.om?? && examSetting.preventSetting.om> checked="checked"</#if>/>
                                    开启远程监控的功能&nbsp;&nbsp;&nbsp;&nbsp;
                                    <#if !(examSetting.payApps?? &&examSetting.payApps?contains("REMOTEMONITOR"))> <span class="add-paper-tip-text" style="color:red;">*该功能需付费开通，如需开通，请联系13855167015</span><#else>
                                    <span class="add-paper-tip-text">目前仅支持Chrome35.0和Firefox30.0以上版本的浏览器</span></#if>

                                </label>
                            </div>
                            </#if>
                            <div>
                                <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                    <span class="iconfont <#if ((examSetting.preventSetting.cs)?? && examSetting.preventSetting.cs)>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.cs"
                                    <#if ((examSetting.preventSetting.cs)?? && examSetting.preventSetting.cs) >
                                           checked="checked"</#if>/>
                                    切屏次数超过
                                </label>
                                <input type="text" <#if (exam.status)! =='PROCESS'>readonly</#if>
                                       value="${(examSetting.preventSetting.csN)!'3'}"
                                       name="preventSetting.csN"
                                       class="exam-create-num-input">次,强制交卷
                            </div>
                            <div>
                                <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                    <span class="iconfont <#if ((examSetting.preventSetting.no)?? && examSetting.preventSetting.no) >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.no"
                                    <#if ((examSetting.preventSetting.no)?? && examSetting.preventSetting.no) >
                                           checked="checked"</#if>/>
                                </label>
                                <input type="text" value="${(examSetting.preventSetting.noD)!'5'}"
                                       name="preventSetting.noD" <#if (exam.status)! =='PROCESS'>readonly</#if>
                                       class="exam-create-num-input"/>分钟内，考试页面不操作算为舞弊并强制交卷
                            </div>
                            <@authVerify authCode="VERSION_OF_LATE_FORBIDDEN">
                                <div>
                                    <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                        <span class="iconfont <#if (examSetting.preventSetting.lt)?? && examSetting.preventSetting.lt>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.lt"
                                    <#if (examSetting.preventSetting.lt)?? && examSetting.preventSetting.lt>
                                           checked="checked"</#if>/>
                                        迟到
                                    </label>
                                    <input type="text" value="${(examSetting.preventSetting.ltD)!'10'}"
                                           name="preventSetting.ltD"
                                       <#if (exam.status)! =='PROCESS'>readonly</#if>
                                           class="exam-create-num-input">分钟后禁止参加考试
                                </div>
                            </@authVerify>

                            <@authVerify authCode="VERSION_OF_FORBIDDEN_SUBMIT">
                                <div>
                                    <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                        <span class="iconfont <#if (examSetting.preventSetting.bs)?? && examSetting.preventSetting.bs>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.bs"
                                                                    <#if (examSetting.preventSetting.bs)?? && examSetting.preventSetting.bs>
                                                                           checked="checked"</#if>/>
                                        答卷时间少于
                                    </label>
                                    <input type="text" value="${(examSetting.preventSetting.bsD)!'5'}"
                                           name="preventSetting.bsD"
                                           class="exam-create-num-input">分钟禁止交卷
                                </div>
                            </@authVerify>
                            <@authVerify authCode="VERSION_OF_ITEM_RANDOM">
                                <div>
                                    <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                        <span class="iconfont <#if (examSetting.preventSetting.ri)?? && examSetting.preventSetting.ri>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if> "></span>
                                        <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.ri"
                                    <#if (examSetting.preventSetting.ri)?? && examSetting.preventSetting.ri>
                                           checked="checked"</#if>/>
                                        生成试卷时打乱相同题型下的试题的顺序以及试题选项的顺序
                                    </label>
                                </div>
                            </@authVerify>

                        </dd>
                    </dl>
                </div>
            </div>

            <@authVerify authCode="VERSION_OF_EXAM_MESSAGE">
                <div class="exam-setting-wrap">
                    <div class="exam-setting-wrap-top">
                        <div class="floatL">
                            考试消息设置
                        </div>
                        <div class="floatR">
                            <a class="iconfont icon-thin-arrow-down fold-setting-btn"></a>
                        </div>
                    </div>
                    <div class="exam-setting-wrap-content" style="display: none;">
                        <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap"
                            style="bottom-border:none;">
                            <dd class="user-detail-value sameChange">
                        <#assign exM = (examSetting.messageSetting.eMsg.M)!false/>
                        <#assign exS = (examSetting.messageSetting.eMsg.S)!false/>
                        <#assign exE = (examSetting.messageSetting.eMsg.E)!false/>
                        <#assign caM = (examSetting.messageSetting.caMsg.M)!false/>
                        <#assign caS = (examSetting.messageSetting.caMsg.S)!false/>
                        <#assign caE = (examSetting.messageSetting.caMsg.E)!false/>
                        <#assign reM = (examSetting.messageSetting.reMsg.M)!false/>
                        <#assign reS = (examSetting.messageSetting.reMsg.S)!false/>
                        <#assign reE = (examSetting.messageSetting.reMsg.E)!false/>
                        <#assign eeM = (examSetting.messageSetting.eeMsg.M)!false/>
                        <#assign eeS = (examSetting.messageSetting.eeMsg.S)!false/>
                        <#assign eeE = (examSetting.messageSetting.eeMsg.E)!false/>
                        <#assign pmM = (examSetting.messageSetting.pmMsg.M)!false/>
                        <#assign pmS = (examSetting.messageSetting.pmMsg.S)!false/>
                        <#assign pmE = (examSetting.messageSetting.pmMsg.E)!false/>
                        <#assign muM = (examSetting.messageSetting.muMsg.M)!false/>
                        <#assign muS = (examSetting.messageSetting.muMsg.S)!false/>
                        <#assign muE = (examSetting.messageSetting.muMsg.E)!false/>
                                <div>
                                    <div>考试通知</div>
                                    <div style="margin-left:18px;">
                                    <span class="pe-checkbox">
                                        <span class="iconfont <#if exM >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if exM >checked="checked"</#if> name="messageSetting.eMsg['M']"/>
                                        站内信
                                    </span>
                                        <span class="pe-checkbox">
                                        <span class="iconfont <#if exS >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if exS >checked="checked"</#if> name="messageSetting.eMsg['S']"/>
                                        电子邮件
                                    </span>
                                        <span class="pe-checkbox">
                                        <span class="iconfont <#if exE >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if exE >checked="checked"</#if> name="messageSetting.eMsg['E']"/>
                                        手机短信
                                    </span>
                                    </div>
                                </div>
                                <div>
                                    <div>考试作废通知</div>
                                    <div style="margin-left:18px;">
                                    <span class="pe-checkbox">
                                        <span class="iconfont <#if caM >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if caM >checked</#if> name="messageSetting.caMsg['M']"/>
                                        站内信
                                    </span>
                                        <span class="pe-checkbox">
                                            <span class="iconfont <#if caS>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                            <input class="pe-form-ele" type="checkbox" value="true"
                                                   <#if caS >checked</#if> name="messageSetting.caMsg['S']"/>
                                            电子邮件
                                        </span>
                                        <span class="pe-checkbox">
                                            <span class="iconfont <#if caE >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                            <input class="pe-form-ele" type="checkbox" value="true"
                                                   <#if caE >checked</#if> name="messageSetting.caMsg['E']"/>
                                            手机短信
                                        </span>
                                    </div>
                                </div>
                                <div>
                                    <div>考试移除人员通知</div>
                                    <div style="margin-left:18px;">
                                    <span class="pe-checkbox">
                                        <span class="iconfont <#if reM >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if reM >checked="checked"</#if> name="messageSetting.reMsg['M']"/>
                                        站内信
                                    </span>
                                        <span class="pe-checkbox">
                                        <span class="iconfont <#if reS >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if reS >checked="checked"</#if> name="messageSetting.reMsg['S']"/>
                                        电子邮件
                                    </span>
                                        <span class="pe-checkbox">
                                            <span class="iconfont <#if reE>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                            <input class="pe-form-ele" type="checkbox" value="true"
                                                   <#if reE>checked="checked"</#if>name="messageSetting.reMsg['E']"/>
                                            手机短信
                                        </span>
                                    </div>
                                </div>
                                <div>
                                    <div>考试结束时间变更</div>
                                    <div style="margin-left:18px;">
                                    <span class="pe-checkbox">
                                        <span class="iconfont <#if eeM>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if eeM >checked="checked"</#if> name="messageSetting.eeMsg['M']"/>
                                        站内信
                                    </span>
                                        <span class="pe-checkbox">
                                        <span class="iconfont <#if eeS >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if eeS >checked="checked"</#if> name="messageSetting.eeMsg['S']"/>
                                        电子邮件
                                    </span>
                                        <span class="pe-checkbox">
                                        <span class="iconfont <#if eeE >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if eeE >checked="checked"</#if>name="messageSetting.eeMsg['E']"/>
                                        手机短信
                                    </span>
                                    </div>
                                </div>
                                <div>
                                    <div>发布成绩</div>
                                    <div style="margin-left:18px;">
                                    <span class="pe-checkbox">
                                        <span class="iconfont <#if pmM>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if pmM >checked="checked"</#if> name="messageSetting.pmMsg['M']"/>
                                        站内信
                                    </span>
                                        <span class="pe-checkbox">
                                        <span class="iconfont <#if pmS >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if pmS >checked="checked"</#if>name="messageSetting.pmMsg['S']"/>
                                        电子邮件
                                    </span>
                                        <span class="pe-checkbox">
                                        <span class="iconfont <#if pmE >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if pmE >checked="checked"</#if>name="messageSetting.pmMsg['E']"/>
                                        手机短信
                                    </span>
                                    </div>
                                </div>
                                <div>
                                    <div>补考通知</div>
                                    <div style="margin-left:18px;">
                                    <span class="pe-checkbox">
                                        <span class="iconfont <#if muM >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if muM >checked="checked"</#if>
                                               name="messageSetting.muMsg['M']"/>
                                        站内信
                                    </span>
                                        <span class="pe-checkbox">
                                        <span class="iconfont <#if muS >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if muS >checked="checked"</#if>name="messageSetting.muMsg['S']"/>
                                        电子邮件
                                    </span>
                                        <span class="pe-checkbox">
                                        <span class="iconfont <#if muE >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" value="true"
                                               <#if muE >checked="checked"</#if>name="messageSetting.muMsg['E']"/>
                                        手机短信
                                    </span>
                                    </div>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
            </@authVerify>


        </div>

    </form>

</div>