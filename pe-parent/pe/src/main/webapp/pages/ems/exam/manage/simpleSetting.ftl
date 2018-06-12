<div id="simpleSettingPanel">
    <form id="defaultSimpleExamSettingForm">
        <input type="hidden" name="id" value="${(examSetting.id)!}"/>
        <input type="hidden" name="exam.id" value="${(exam.id)!}"/>
        <input type="hidden" value="${(exam.examType)!"ONLINE"}" name="exam.examType">
        <div class="exam-message-container" type="hidden">
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
            <input type="hidden" name="messageSetting.eMsg[M]" value="${exM?string}"/>
            <input type="hidden" name="messageSetting.eMsg[S]" value="${exS?string}"/>
            <input type="hidden" name="messageSetting.eMsg[E]" value="${exE?string}"/>
            <input type="hidden" name="messageSetting.caMsg[M]" value="${caM?string}"/>
            <input type="hidden" name="messageSetting.caMsg[S]" value="${caS?string}"/>
            <input type="hidden" name="messageSetting.caMsg[E]" value="${caE?string}"/>
            <input type="hidden" name="messageSetting.reMsg[M]" value="${reM?string}"/>
            <input type="hidden" name="messageSetting.reMsg[S]" value="${reS?string}"/>
            <input type="hidden" name="messageSetting.reMsg[E]" value="${reE?string}"/>
            <input type="hidden" name="messageSetting.eeMsg[M]" value="${eeM?string}"/>
            <input type="hidden" name="messageSetting.eeMsg[S]" value="${eeS?string}"/>
            <input type="hidden" name="messageSetting.eeMsg[E]" value="${eeE?string}"/>
            <input type="hidden" name="messageSetting.pmMsg[M]" value="${pmM?string}"/>
            <input type="hidden" name="messageSetting.pmMsg[S]" value="${pmS?string}"/>
            <input type="hidden" name="messageSetting.pmMsg[E]" value="${pmE?string}"/>
            <input type="hidden" name="messageSetting.muMsg[M]" value="${muM?string}"/>
            <input type="hidden" name="messageSetting.muMsg[S]" value="${muS?string}"/>
            <input type="hidden" name="messageSetting.muMsg[E]" value="${muS?string}"/>
        </div>
        <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <#if (exam.subject)?? && !exam.subject>
            <dt class="floatL user-detail-title">监考员:</dt>
            <dd class="user-detail-value" style="height:auto;min-height:32px;">
        <span class="exam-has-added-user-num EXAM_MANAGER_name_${(exam.id)!}">
           <#if (examSetting.examAuthList)??>
               <#list examSetting.examAuthList as examAuth>
                   <a class="tags add-question-bank-item bank-list <#if exam.optType?? && (exam.optType == 'VIEW')>not-hover</#if>"
                      data-id="${(examAuth.user.id)!}"
                      data-text="${(examAuth.user.userName)!}"><span class="has-item-user-name"
                                                                     title="${(examAuth.user.userName)!}">${(examAuth.user.userName)!}</span>
                       <#if exam.createBy?? && examAuth?? && examAuth.user?? && examAuth.user.id?? && exam.createBy != examAuth.user.id>
                           <span class="iconfont icon-inputDele"></span>
                       </#if>
                   </a>
               </#list>
           </#if>
            <a href="javascript:;" class="exam-view-user add-manager  view-exam-group-select-user"
               <#if exam.optType?? && (exam.optType == 'VIEW')>style="display:none;" </#if>>选择人员</a>
        </span>
            <#--<span class="iconfont icon-caution-tip"></span>当前已添加<span-->
            <#--class="EXAM_MANAGER_count_${(exam.id)!}">${(examSetting.typeCountMap['EXAM_MANAGER'])!'0'}</span>人-->
            </dd>
        </#if>
            <@authVerify authCode="VERSION_OF_EXAM_LENGTH">
                <dt class="floatL user-detail-title">考试时长:</dt>
                <dd class="user-detail-value">
                    <input type="hidden" name="examSetting.elt"
                           value="${(examSetting.examSetting.elt)!'NO_LIMIT'}"/>
                <#if (examSetting.examSetting.elt)! == 'LIMIT'>
                    限制考试时长<input type="text" value="${(examSetting.examSetting.el)!'0'}" name="examSetting.el"
                                 <#if (exam.status)! =='PROCESS'>readonly</#if>
                                 class="exam-create-num-input" max="999999">&nbsp;分钟
                <#else>
                    不限制考试时长
                </#if>
                </dd>
            </@authVerify>

            <@authVerify authCode="VERSION_OF_EXAM_ANSWER_PATTERN">
                <dt class="floatL user-detail-title">答题模式:</dt>
                <dd class="user-detail-value">
                    <input type="hidden" name="examSetting.at" value="${(examSetting.examSetting.at)!'ALL'}"/>
                <#if (examSetting.examSetting.at)! == 'EVERY'>
                    <div style="height:24px;">
                        逐题模式
                    </div>
                    <label class="pe-checkbox" style="margin-left:30px;">
                        <span class="iconfont <#if (examSetting.examSetting.ce)!?string == 'true'>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true" name="examSetting.ce"
                               <#if (examSetting.examSetting.ce)!?string == 'true'>checked="checked"</#if>/>
                        允许返回修改答案
                    </label>
                <#else>
                    整卷模式
                </#if>
                </dd>
            </@authVerify>
            <@authVerify authCode="VERSION_OF_EXAM_MAKE_UP">
                <dt class="floatL user-detail-title">补考设置:</dt>
                <dd class="user-detail-value">
                    <input type="hidden" name="examSetting.mt" value="${(examSetting.examSetting.mt)!'NO_MAKEUP'}"/>
                <#if (examSetting.examSetting.mt)! == 'AUTO_MAKEUP'>
                    自动安排补考&nbsp;&nbsp;补考次数
                    <input type="text" value="${(examSetting.examSetting.mn)!}" name="examSetting.mn"
                           <#if (exam.status)! =='PROCESS'>readonly</#if>
                           class="exam-create-num-input">
                <#elseif (examSetting.examSetting.mt)! == 'MANUAL_MAKEUP'>
                    手动安排补考
                <#else>
                    不允许补考
                </#if>
                </dd>
            </@authVerify>
            <@authVerify authCode="VERSION_OF_EXAM_MARKING_STRATEGY">
                <dt class="floatL user-detail-title">评卷策略:</dt>
                <dd class="user-detail-value">
                    <input type="hidden" name="judgeSetting.jt" id="simplejudgeSetting_jt"
                           value="${(examSetting.judgeSetting.jt)!'AUTO_JUDGE'}"/>
                <#if examSetting?? && (examSetting.judgeSetting.jt) ?? && (examSetting.judgeSetting.jt)! != 'AUTO_JUDGE'>
                    <#if (examSetting.judgeSetting.jt)! == 'MANUAL_JUDGE_PAPER'>
                        人工评卷，按试卷分配评卷人
                    <span class="exam-has-added-user-num MANUAL_JUDGE_PAPER_span">
                                    <span class="JUDGE_PAPER_USER_name_${(exam.id)!}">
                                        <#if (examSetting.typeCountMap['MANUAL_JUDGE_PAPER_USER'])??&&((examSetting.typeCountMap['MANUAL_JUDGE_PAPER_USER'])!>0)&&(examSetting.judgeUserRels)??>
                                            <#list examSetting.judgeUserRels as judgeUser>
                                                <span class="tags add-question-bank-item bank-list"
                                                      data-id="${(judgeUser.user.id)!}"
                                                      data-text="${(judgeUser.user.userName)!}">
                                                    <span class="has-item-user-name"
                                                          title="${(judgeUser.user.userName)!}">${(judgeUser.user.userName)!}</span>
                                                     <span class="iconfont icon-inputDele"></span>
                                                </span>
                                            </#list>
                                        </#if>
                                        <a href="javascript:;" class="exam-view-user add-paper-user"
                                           style="margin-left:10px;">选择人员</a>
                                    </span>
                                </span>
                    </#if>
                    <#if (examSetting.judgeSetting.vi)!?string == 'true'>
                        允许评卷人查看考生信息
                    </#if>
                <#else>
                    自动评卷<span class="add-paper-tip-text">适合全部为客观题的试卷，系统对客观题自动评卷，若有主观题，则记为0分</span>
                </#if>
                </dd>
            </@authVerify>
            <dt class="floatL user-detail-title">成绩设置:</dt>
            <dd class="user-detail-value">
                <input type="hidden" name="scoreSetting.st" value="${(examSetting.scoreSetting.st)!'CONVERT'}"/>
            <#if (examSetting.scoreSetting.st)! == 'ORIGINAL'>
                使用原试卷分数<span class="add-paper-tip-text">如果使用多份试卷，每份试卷的分值可能会不一致，请仔细检查</span>
            <#else>
                原试卷题目分数按比例折算成满分
                <span class="hide-input-span" style=" font-weight:bold"> ${(examSetting.scoreSetting.cm)!"100"}</span>
                <input type="text" <#if (exam.status)! =='PROCESS'>readonly</#if>
                       value="${(examSetting.scoreSetting.cm)!"100"}" name="scoreSetting.cm"
                       class="exam-create-num-input show-input-text">&nbsp;分
            </#if>
            </dd>

            <dt class="floatL user-detail-title">及格条件:</dt>
            <dd class="user-detail-value">得分率不低于
                <span class="hide-input-span" style=" font-weight:bold"> ${(examSetting.scoreSetting.pr)!"60"}</span>
                <input type="text" <#if (exam.status)! =='PROCESS'>readonly</#if>
                       value="${(examSetting.scoreSetting.pr)!"60"}" name="scoreSetting.pr"
                       class="exam-create-num-input show-input-text">&nbsp;%
            </dd>
            <input type="hidden" name="scoreSetting.mst"
                   value="${(examSetting.scoreSetting.mst)!'LESS_SELECT_NO_SCORE'}"/>
            <@authVerify authCode="VERSION_OF_EXAM_MULTIPLE_RULE">
                <dt class="floatL user-detail-title">多选/不定项评分规则:</dt>
                <dd class="user-detail-value">
                    <#if examSetting.scoreSetting?? && examSetting.scoreSetting.mst ?? && examSetting.scoreSetting.mst == 'LESS_SELECT_SCORE_HALF'>
                        选对得满分，选错不得分，少选得一半分
                    <#elseif examSetting.scoreSetting?? && examSetting.scoreSetting.mst ?? && examSetting.scoreSetting.mst == 'LESS_SELECT_SCORE_RATE'>
                        选对得满分，选错不得分，少选按比例得分
                    <#else>
                        选对得满分，选错或少选不得分
                    </#if>
                </dd>
            </@authVerify>
            <@authVerify authCode="VERSION_OF_EXAM_PUBLISH_RESULT">
                <dt class="floatL user-detail-title">成绩发布设置:</dt>
                <dd class="user-detail-value" style="min-height:32px;height:auto;">
                    <input type="hidden" value="${(examSetting.scoreSetting.spt)!'JUDGED_AUTO_PUBLISH'}"
                           name="scoreSetting.spt"/>
                <#if (examSetting.scoreSetting.spt)! == 'MANUAL'>
                    <div>
                        <div style="height:28px;">
                            手动发布
                        </div>
                        <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>pe-check-by-list</#if>"
                               style="margin-left:22px;">
                            <span class="iconfont <#if (examSetting.scoreSetting.spt)! == 'MANUAL' && (examSetting.scoreSetting.tp)!?string == 'true'>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                            <input class="pe-form-ele" type="checkbox" value="true" name="scoreSetting.tp"
                                   <#if (examSetting.scoreSetting.spt)! == 'MANUAL' && (examSetting.scoreSetting.tp)!?string == 'true'>checked="checked"</#if>
                                   <#if (examSetting.scoreSetting.spt)! != 'MANUAL'>readonly</#if>/>
                            定时发布成绩
                        </label>
                        <div class="pe-date-wrap">
                        <input id="peExamIssueTimeDefault"
                               class="pe-table-form-text pe-time-text exam-issue-time laydate-icon"
                               style="width: 150px;"
                               type="text" name="scoreSetting.pd" <#if (exam.status)! == 'PROCESS'>disabled</#if>
                               data-toggle="datepicker" data-data-picker="true"
                            <#if (examSetting.scoreSetting.pd)??>
                               value="${(examSetting.scoreSetting.pd?string('yyyy-MM-dd HH:mm'))!}">
                            </#if>
                        <#--<span class="iconfont icon-date input-icon"></span>-->
                        </div>
                    <#-- <span class="add-paper-tip-text">如果没有手动发布成绩，系统会定时自动发布成绩</span>-->
                    </div>
                <#elseif (examSetting.scoreSetting.spt)! == 'JUDGED_ALL_AND_EXAM_END'>
                    考试结束且完成所有评卷后发布成绩
                <#else>
                    评卷后自动发布成绩
                </#if>
                </dd>
            </@authVerify>
            <@authVerify authCode="VERSION_OF_RANK_SHOW">
                <dt class="floatL user-detail-title">排行榜显示设置:</dt>
                <dd class="user-detail-value sameChange">
                    <input type="hidden" value="${(examSetting.rankSetting.rst)!'NO_SHOW'}" name="rankSetting.rst"/>
                <#if (examSetting.rankSetting.rst)! == 'SHOW_FIRST'>
                    显示首次考试的排名&nbsp;&nbsp;显示前
                    <input type="text" value="${(examSetting.rankSetting.rsn)!'10'}" name="rankSetting.rsn"
                           class="exam-create-num-input">名的排名情况
                    <span class="add-paper-tip-text">不填则显示全部排名</span>
                <#elseif (examSetting.rankSetting.rst)! == 'SHOW_MAX'>
                    显示最高成绩的排名&nbsp;&nbsp;显示前
                    <input type="text" value="${(examSetting.rankSetting.rsn)!'10'}" name="rankSetting.rsn"
                           class="exam-create-num-input">名的排名情况
                    <span class="add-paper-tip-text">不填则显示全部排名</span>
                <#-- <#elseif (examSetting.rankSetting.rst)! == 'SHOW_AVERAGE'>
                     显示平均成绩的排名&nbsp;&nbsp;显示前
                     <input type="text" value="${(examSetting.rankSetting.rsn)!'10'}" name="rankSetting.rsn"
                            class="exam-create-num-input">名的排名情况
                     <span class="add-paper-tip-text">不填则显示全部排名</span>-->
                <#else>
                    不显示考试排名
                </#if>
                </dd>
            </@authVerify>

            <@authVerify authCode="VERSION_OF_RANK_PUBLISH">
                <#if (examSetting.rankSetting.sht)??>
                    <dt class="floatL user-detail-title">排行榜发布设置:</dt>
                    <dd class="user-detail-value sameChange">
                        <input type="hidden" value="${(examSetting.rankSetting.sht)!}" name="rankSetting.sht"/>
                        <#if (examSetting.rankSetting.sht)! == 'SHOW_MARK'>
                            成绩发布且考试结束后显示考试排名
                        <#elseif (examSetting.rankSetting.sht)! == 'SHOW_END'>
                            成绩发布后显示考试排名
                        </#if>
                    </dd>
                </#if>
            </@authVerify>

            <@authVerify authCode="VERSION_OF_EXAM_AUTH">
                <dt class="floatL user-detail-title">考试权限设置:</dt>
                <dd class="user-detail-value sameChange">
                    <input type="hidden" value="${(examSetting.examAuthType)!'JUDGE_AND_SEE_ALL'}"
                           name="examAuthType"/>
                <#if (examSetting.examAuthType)! == 'NO_SEE'>
                    不允许考生查看答卷
                <#elseif (examSetting.examAuthType)! == 'SEE_PAPER_NO_ANSWER'>
                    允许考生查看答卷，但不允许查看正确答案
                <#elseif (examSetting.examAuthType)! == 'SEE_ERROR_NO_ANSWER'>
                    只允许考生查看答错的试题，且不显示正确答案
                <#elseif (examSetting.examAuthType)! == 'SEE_ERROR_AND_ANSWER'>
                    只允许考生查看答错的试题，同时显示正确答案
                <#else>
                    评卷后允许考生查看答卷和正确答案
                </#if>
                </dd>
            </@authVerify>

        <#if (examSetting.preventSetting.sv)??||(examSetting.preventSetting.rc)??||((examSetting.preventSetting.cs)??&&(examSetting.preventSetting.cs))
        ||((examSetting.preventSetting.no)??&&(examSetting.preventSetting.no))||(examSetting.preventSetting.lt)??||(examSetting.preventSetting.ri)??>
            <dt class="floatL user-detail-title">防舞弊设置:</dt>
            <dd class="user-detail-value" style="min-height:32px;height:auto;">
                <@authVerify authCode="VERSION_OF_MESSAGE_VERIFY">
                    <#if (examSetting.preventSetting.sv)?? && examSetting.preventSetting.sv>
                        <input type="hidden" value="true" name="preventSetting.sv"/>
                        <div>进入考试时需要短信验证身份</div>
                    </#if>
                </@authVerify>
                <@authVerify authCode="VERSION_OF_REAL_TIME_CAPTURE">
                    <#if (examSetting.preventSetting.rc)?? && examSetting.preventSetting.rc>
                        <input type="hidden" value="true" name="preventSetting.rc"/>
                        <div>开启实时摄像抓拍的功能</div>
                    </#if>
                </@authVerify>

                <#if examSetting.preventSetting.om?? && examSetting.preventSetting.om>
                    <input type="hidden" value="true" name="preventSetting.om"/>
                    <div>开启远程监控的功能&nbsp;&nbsp;&nbsp;&nbsp;<span class="add-paper-tip-text">目前仅支持Chrome35.0和Firefox30.0以上版本的浏览器</span></div>
                </#if>
                <#if (examSetting.preventSetting.cs)?? && examSetting.preventSetting.cs>
                    <div>
                        <input type="hidden" value="true" name="preventSetting.cs"/>
                        <span class="hide-input-span"
                              style=" font-weight:bold"> ${(examSetting.preventSetting.csN)!'3'}</span>
                        切屏次数超过<input type="text" <#if (exam.status)! =='PROCESS'>readonly</#if>
                                     value="${(examSetting.preventSetting.csN)!'3'}"
                                     name="preventSetting.csN"
                                     class="exam-create-num-input show-input-text">次,强制交卷
                    </div>
                </#if>
                <#if (examSetting.preventSetting.no)?? && examSetting.preventSetting.no>
                    <div>
                        <input type="hidden" value="true" name="preventSetting.no"/>
                        <span class="hide-input-span"
                              style=" font-weight:bold"> ${(examSetting.preventSetting.noD)!'5'}</span>
                        <input type="text" value="${(examSetting.preventSetting.noD)!'5'}"
                               name="preventSetting.noD" <#if (exam.status)! =='PROCESS'>readonly</#if>
                               class="exam-create-num-input show-input-text"/>分钟内，考试页面不操作算为舞弊并强制交卷
                    </div>
                </#if>
                <@authVerify authCode="VERSION_OF_LATE_FORBIDDEN">
                    <#if (examSetting.preventSetting.lt)?? && examSetting.preventSetting.lt>
                        <input type="hidden" value="true" name="preventSetting.lt"/>
                        <div>迟到<input type="text" value="${(examSetting.preventSetting.ltD)!'10'}"
                                      name="preventSetting.ltD"
                                      class="exam-create-num-input">分钟后禁止参加考试
                        </div>
                    </#if>
                </@authVerify>
                <@authVerify authCode="VERSION_OF_ITEM_RANDOM">
                    <#if (examSetting.preventSetting.ri)?? && examSetting.preventSetting.ri>
                        <input type="hidden" value="true" name="preventSetting.ri"/>
                        <div>生成试卷时打乱相同题型下的试题的顺序以及试题选项的顺序</div>
                    </#if>
                </@authVerify>

            </dd>
        </#if>
        </dl>
        <@authVerify authCode="VERSION_OF_ITEM_RANDOM">
        <div style="text-align:left;">
            <button type="button" class="pe-btn pe-btn-purple pe-large-btn exam-more-set-btn">更多设置</button>
        </div>
        </@authVerify>

    </form>
</div>