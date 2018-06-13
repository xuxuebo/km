<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
    <#if exam.subject?? && exam.subject>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">科目管理</li>
        <#if exam.examType?? && exam.examType == 'ONLINE'>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑线上科目
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览线上科目
                <#else>
                    创建线上科目
                </#if>
            </li>
        <#else>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑线下科目
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览线下科目
                <#else>
                    创建线下科目
                </#if>
            </li>
        </#if>
    <#else >
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">考试管理</li>
        <#if exam.examType?? && exam.examType == 'ONLINE'>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑线上考试
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览线上考试
                <#else>
                    创建线上考试
                </#if>
            </li>
        <#elseif exam.examType?? && exam.examType == 'OFFLINE'>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑线下考试
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览线下考试
                <#else>
                    创建线下考试
                </#if>
            </li>
        <#else>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑综合考试
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览综合考试
                <#else>
                    创建综合考试
                </#if>
            </li>
        </#if>
    </#if>
    </ul>
</div>

<section class="steps-all-panel exam-add-four-all-wrap">
    <div class="add-exam-top-head">
        <ul class="over-flow-hide step-items-wrap <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-step-state</#if>">
            <li class="add-paper-step-item floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover basic-step-item<#else>step-complete</#if>"><#--#b8ecaa-->
                <div class="add-step-icon-wrap">
               <span class="iconfont icon-step-circle floatL">
                <span class="add-step-number">1</span>
               </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">基本信息</span>
            </li>
            <li class="add-paper-step-item add-paper-step-two floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover paper-step-item<#else>step-complete</#if>">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">2</span>
                    </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">试卷设置</span>
            </li>
        <#if exam.subject?? && exam.subject>
            <li class="add-paper-step-item add-paper-step-three floatL overStep">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                   <span class="add-step-number">3</span>
                 </span>
                </div>
                <span class="add-step-text">考试设置</span>
            </li>
        <#else>
            <li class="add-paper-step-item add-paper-step-two floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover arrange-step-item<#else>step-complete</#if>">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                   <span class="add-step-number">3</span>
                 </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">考试安排</span>
            </li>
            <li class="add-paper-step-item add-paper-step-three floatL overStep">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                   <span class="add-step-number">4</span>
                 </span>
                </div>
                <span class="add-step-text">考试设置</span>
            </li>
        </#if>
        </ul>
    </div>
    <div class="add-exam-main-panel add-exam-step-four-wrap">
    <#--简单设置，默认值显示-->
        <form id="defaultSimpleExamSettingForm">
            <input type="hidden" name="id" value="${(examSetting.id)!}"/>
            <input type="hidden" name="exam.id" value="${(exam.id)!}"/>
            <input type="hidden" value="${(exam.examType)!"ONLINE"}" name="exam.examType">
            <div class="add-exam-item-wrap default-simple-setting-panel">

            </div>
        </form>
        <form id="moreExamSettingForm">
            <input type="hidden" name="id" value="${(examSetting.id)!}"/>
            <input type="hidden" name="exam.id" value="${(exam.id)!}"/>
            <input type="hidden" value="${(exam.examType)!"ONLINE"}" name="exam.examType">
            <div class="add-exam-item-wrap more-setting-panel" style="display:none;">

            </div>
        </form>
    </div>
</section>
<div class="pe-btns-group-wrap default-simple-setting-btns"
     style="text-align:center;">
<#if exam.optType?? && (exam.optType == 'VIEW')  >
<div class="view-exam-group-one">
<#else>
    <#if !(exam.optType?? && exam.optType == 'UPDATE')>
        <button type="button" class="pe-btn pe-btn-purple pe-step-pre-btn">上一步</button>
    </#if>
    <#if (exam.status)?? && (exam.status) == 'DRAFT'>
        <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft">保存为草稿</button>
        <button type="button" class="pe-btn pe-btn-blue
        <#if exam.subject?? && exam.subject>pe-subject-save-and-use<#else >pe-step-save-and-use</#if>">保存并启用
        </button>
    <#else>
        <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft">保存</button>
    </#if>
</#if>
<#if exam.source?? && exam.source == 'ADD'>
    <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
<#else >
    <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
</#if>
<#if exam.optType?? && (exam.optType == 'VIEW') && (exam.status)?? && (exam.status) != 'OVER'>
    <a href="javascript:;" class="pe-view-user-btn i-need-edit-exam"><span
            class="iconfont icon-edit"></span>我要编辑考试信息</a>
</div>
    <div class="view-exam-group-two" style="display: none;">
        <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft">保存</button>
        <#if exam.source?? && exam.source == 'ADD'>
            <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
        <#else >
            <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
        </#if>
    </div>
</#if>
</div>
<input type="hidden" id="itemIds" value=""/>
<#--简单模板-->
<script type="text/template" id="simpleSettingPanel">
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
    <#if exam.subject?? && !exam.subject>
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
        <dt class="floatL user-detail-title">评卷策略:</dt>
        <dd class="user-detail-value">
            <input type="hidden" name="judgeSetting.jt" id="simplejudgeSetting_jt"
                   value="${(examSetting.judgeSetting.jt)!'AUTO_JUDGE'}"/>
        <#if examSetting?? && examSetting.judgeSetting.jt ?? && (examSetting.judgeSetting.jt)! != 'AUTO_JUDGE'>
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
        <dt class="floatL user-detail-title">成绩设置:</dt>
        <dd class="user-detail-value">
            <input type="hidden" name="scoreSetting.st" value="${(examSetting.scoreSetting.st)!'CONVERT'}"/>
        <#if (examSetting.scoreSetting.st)! == 'ORIGINAL'>
            使用原试卷分数<span class="add-paper-tip-text">如果使用多份试卷，每份试卷的分值可能会不一致，请仔细检查</span>
        <#else>
            原试卷题目分数按比例折算成满分
            <input type="text" <#if (exam.status)! =='PROCESS'>readonly</#if>
                   value="${(examSetting.scoreSetting.cm)!"100"}" name="scoreSetting.cm"
                   class="exam-create-num-input">&nbsp;分
        </#if>
        </dd>

        <dt class="floatL user-detail-title">及格条件:</dt>
        <dd class="user-detail-value">得分率不低于
            <input type="text" <#if (exam.status)! =='PROCESS'>readonly</#if>
                   value="${(examSetting.scoreSetting.pr)!"60"}" name="scoreSetting.pr"
                   class="exam-create-num-input">&nbsp;%
        </dd>
    <#if examSetting.scoreSetting.mst??>
        <input type="hidden" name="scoreSetting.mst" value="${(examSetting.scoreSetting.mst)!'LESS_SELECT_NO_SCORE'}"/>
        <dt class="floatL user-detail-title">多选/不定项评分规则:</dt>
        <dd class="user-detail-value">
            <#if examSetting.scoreSetting.mst == 'LESS_SELECT_SCORE_HALF'>
                选对得满分，选错不得分，少选得一半分
            <#elseif examSetting.scoreSetting.mst == 'LESS_SELECT_SCORE_RATE'>
                选对得满分，选错不得分，少选按比例得分
            <#else>
                选对得满分，选错或少选不得分
            </#if>
        </dd>
    </#if>
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
                       class="pe-table-form-text pe-time-text exam-issue-time laydate-icon" style="width: 150px;"
                       type="text" name="scoreSetting.pd" <#if (exam.status)! == 'PROCESS'>disabled</#if>
                       data-toggle="datepicker" data-data-picker="true"
                    <#if (examSetting.scoreSetting.pd)??>
                       value="<%=moment('${(examSetting.scoreSetting.pd)!?datetime}').format('YYYY-MM-DD HH:mm')%>">
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
        <dt class="floatL user-detail-title">防舞弊设置:</dt>
        <dd class="user-detail-value" style="min-height:32px;height:auto;">
        <#if examSetting.preventSetting.sv?? && examSetting.preventSetting.sv>
            <input type="hidden" value="true" name="preventSetting.sv"/>
            <div>进入考试时需要短信验证身份</div>
        </#if>
        <#if examSetting.preventSetting.rc?? && examSetting.preventSetting.rc>
            <input type="hidden" value="true" name="preventSetting.rc"/>
            <div>开启实时摄像抓拍的功能</div>
        </#if>
        <#--<#if examSetting.preventSetting.fs?? && examSetting.preventSetting.fs>-->
        <#--<input type="hidden" value="true" name="preventSetting.fs"/>-->
        <#--<div>启用全屏模式</div>-->
        <#--</#if>-->
        <#if examSetting.preventSetting.cs?? && examSetting.preventSetting.cs>
            <div>
                <input type="hidden" value="true" name="preventSetting.cs"/>
                切屏次数超过<input type="text" <#if (exam.status)! =='PROCESS'>readonly</#if>
                             value="${(examSetting.preventSetting.csN)!'3'}"
                             name="preventSetting.csN"
                             class="exam-create-num-input">次,强制交卷
            </div>
        </#if>
        <#if examSetting.preventSetting.no?? && examSetting.preventSetting.no>
            <div>
                <input type="hidden" value="true" name="preventSetting.no"/>
                <input type="text" value="${(examSetting.preventSetting.noD)!'5'}"
                       name="preventSetting.noD" <#if (exam.status)! =='PROCESS'>readonly</#if>
                       class="exam-create-num-input"/>分钟内，考试页面不操作算为舞弊并强制交卷
            </div>
        </#if>
        <#if examSetting.preventSetting.lt?? && examSetting.preventSetting.lt>
            <input type="hidden" value="true" name="preventSetting.lt"/>
            <div>迟到<input type="text" value="${(examSetting.preventSetting.ltD)!'10'}"
                          name="preventSetting.ltD"
                          class="exam-create-num-input">分钟后禁止参加考试
            </div>
        </#if>
        <#if examSetting.preventSetting.ri?? && examSetting.preventSetting.ri>
            <input type="hidden" value="true" name="preventSetting.ri"/>
            <div>生成试卷时打乱相同题型下的试题的顺序以及试题选项的顺序</div>
        </#if>
        </dd>
    </dl>
    <div style="text-align:left;">
        <button type="button" class="pe-btn pe-btn-purple pe-large-btn exam-more-set-btn"
        <#--<#if exam.optType?? && (exam.optType == 'VIEW')>style="display: none"</#if>-->>更多设置
        </button>
    </div>
</script>
<#--复杂模板-->
<script type="text/template" id="moreSettingPanel">
    <#if exam.subject?? && !exam.subject>
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
        <dt class="floatL user-detail-title">考试时长:</dt>
        <dd class="user-detail-value">
            <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                            <span class="iconfont
                            <#if (examSetting.examSetting.elt)! == ""||(examSetting.examSetting.elt)! == 'NO_LIMIT'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                <input class="pe-form-ele" id="NO_LIMIT_TIME" type="radio" value="NO_LIMIT" name="examSetting.elt"
                       <#if (examSetting.examSetting.elt)! == ""||(examSetting.examSetting.elt)! == 'NO_LIMIT'>checked="checked"</#if>/>
                不限制考试时长 <span class="add-paper-tip-text">考试结束前都可以参加考试，到达考试结束时间，自动交卷</span>
            </label>
            <div class="limit-time-radio-wrap">
                <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                                <span class="iconfont
                                <#if (examSetting.examSetting.elt)! == 'LIMIT'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    限制时长为
                    <input class="pe-form-ele" type="radio" id="LIMIT_TIME" value="LIMIT" name="examSetting.elt"
                           <#if (examSetting.examSetting.elt)! == 'LIMIT'>checked="checked"</#if>/>
                    <input type="text" value="${(examSetting.examSetting.el)!}" id="LIMIT_TIME_TEXT"
                           name="examSetting.el"
                           <#if (exam.status)! =='PROCESS'>readonly</#if>
                           class="exam-create-num-input">&nbsp;分钟
                </label>
            </div>
        </dd>
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
                <label class="pe-checkbox add-paper-tip-text <#if (exam.status)! =='PROCESS'>noClick</#if>"
                       style="margin-left:18px;">
                    <span class="iconfont <#if (examSetting.examSetting.ce)!?string == 'true'>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                    <input class="pe-form-ele" type="checkbox" value="true" name="examSetting.ce"
                           <#if (examSetting.examSetting.ce)!?string == 'true'>checked="checked"</#if>
                           <#if (examSetting.examSetting.at)! != 'EVERY'>disabled="disabled"</#if>/>
                    允许返回修改答案
                </label>
            </div>
        </dd>
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
                    <input class="pe-form-ele" type="radio" value="AUTO_MAKEUP" name="examSetting.mt"
                    <#if (examSetting.examSetting.mt)! == 'AUTO_MAKEUP'> checked="checked"</#if>/>
                    自动安排补考
                </label>&nbsp;&nbsp;补考次数
                <input type="text" name="examSetting.mn" value="${(examSetting.examSetting.mn)!'0'}"
                       <#if (exam.status)! =='PROCESS'>readonly</#if>
                       class="exam-create-num-input"><span class="add-paper-tip-text">补考次数为“0”时，表示不限制补考的次数</span>
            </div>
            <div>
                <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                    <span class="iconfont <#if (examSetting.examSetting.mt)! == 'MANUAL_MAKEUP'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <input class="pe-form-ele" type="radio" value="MANUAL_MAKEUP" name="examSetting.mt"
                    <#if (examSetting.examSetting.mt)! == 'MANUAL_MAKEUP'> checked="checked"</#if>/>
                    手动安排补考<span class="add-paper-tip-text">成绩发布后，管理员手工给未通过或缺考的学员安排补考，补考可以设置新的试卷和考试时间</span>
                </label>
            </div>
        </dd>
    </dl>
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">评卷策略:</dt>
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
                        <label class="pe-radio add-paper-tip-text" for="">
                            <span class="iconfont <#if (examSetting.judgeSetting.jt)! == 'MANUAL_JUDGE_PAPER'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                            <input class="pe-form-ele" type="radio" value="MANUAL_JUDGE_PAPER"
                                   name="judgeSetting.jt" id="MANUAL_JUDGE_PAPER" readonly="readonly"
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
                        <label class="pe-checkbox add-paper-tip-text <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if>">
                            <span class="iconfont <#if (examSetting.judgeSetting.vi)!?string == 'true'>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                            <input class="pe-form-ele" type="checkbox" value="true" name="judgeSetting.vi"
                                   <#if (examSetting.judgeSetting.vi)!?string == 'true'>checked="checked"</#if>
                                   <#if (examSetting.judgeSetting.jt)! == ''|| (examSetting.judgeSetting.jt)! == 'AUTO_JUDGE'>disabled="disabled"</#if>/>
                            允许评卷人查看考生信息
                        </label>
                    </div>
                </div>
            </div>
        </dd>
    </dl>
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">成绩设置:</dt>
        <dd class="user-detail-value">
            <div>
                <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                <#if !(exam.subject?? && exam.subject)>
                    <span class="iconfont <#if (examSetting.scoreSetting.st)! == ''||(examSetting.scoreSetting.st)! == 'CONVERT'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                </#if>
                    <input class="pe-form-ele" value="CONVERT" name="scoreSetting.st"
                           type="<#if exam.subject?? && exam.subject>hidden<#else>radio</#if>"
                           <#if (examSetting.scoreSetting.st)! == ''||(examSetting.scoreSetting.st)! == 'CONVERT'>checked="checked"</#if>/>
                    原试卷题目分数按比例折算成满分
                    <input type="text" value="${(examSetting.scoreSetting.cm)!'100'}" name="scoreSetting.cm"
                           class="exam-create-num-input" <#if (exam.status)! =='PROCESS'>readonly</#if>>分
                </label>
            </div>
        <#if !(exam.subject?? && exam.subject)>
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
                <input id="peExamIssueTime"
                       class="pe-table-form-text pe-time-text exam-issue-time laydate-icon"
                       type="text" name="scoreSetting.pd"
                       <#if (exam.status)! =='PROCESS'>disabled</#if>
                       data-toggle="datepicker" data-data-picker="true"
                <#if (examSetting.scoreSetting.pd)??>
                       value="<%=moment('${(examSetting.scoreSetting.pd)!?datetime}').format('YYYY-MM-DD HH:mm')%>">
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
    </dl>
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">排行榜显示设置:</dt>
        <dd class="user-detail-value sameChange">
            <div style="margin-bottom:5px;">
                <label class="pe-radio  <#if exam.optType?? && (exam.optType == 'VIEW')> add-paper-tip-text noClick</#if>">
                    <span class="iconfont <#if (examSetting.rankSetting.rst)! == ''||(examSetting.rankSetting.rst)! == 'NO_SHOW'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <input class="pe-form-ele" type="radio" value="NO_SHOW" name="rankSetting.rst"
                           <#if (examSetting.rankSetting.rst)! == ''||(examSetting.rankSetting.rst)! == 'NO_SHOW'>checked="checked"</#if>/>
                    不显示考试排名
                </label>
            </div>
            <input type="hidden" name="rankSetting.rsn" value="${(examSetting.rankSetting.rsn)!}">
            <div style="margin-bottom:5px;">
                <label class="pe-radio <#if exam.optType?? && (exam.optType == 'VIEW')>add-paper-tip-text noClick</#if>">
                    <span class="iconfont <#if (examSetting.rankSetting.rst)! == 'SHOW_FIRST'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <input class="pe-form-ele" type="radio" value="SHOW_FIRST" name="rankSetting.rst"
                           <#if (examSetting.rankSetting.rst)! == 'SHOW_FIRST'>checked="checked"</#if>/>
                    显示首次考试的排名
                </label>&nbsp;&nbsp;显示前
                <input type="text" value="${(examSetting.rankSetting.rsn)!}" id="rankSetting_rsn_SHOW_FIRST"
                       class="exam-create-num-input">名的排名情况
                <span class="add-paper-tip-text">不填则显示全部排名</span>
                </label>
            </div>
            <div style="margin-bottom:5px;">
                <label class="pe-radio <#if exam.optType?? && (exam.optType == 'VIEW')>add-paper-tip-text noClick</#if>">
                    <span class="iconfont <#if (examSetting.rankSetting.rst)! == 'SHOW_MAX'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <input class="pe-form-ele" type="radio" value="SHOW_MAX" name="rankSetting.rst"
                           <#if (examSetting.rankSetting.rst)! == 'SHOW_MAX'>checked="checked"</#if>/>
                    显示最高成绩的排名
                </label>&nbsp;&nbsp;显示前
                <input type="text" value="${(examSetting.rankSetting.rsn)!}" id="rankSetting_rsn_SHOW_MAX"
                       class="exam-create-num-input">名的排名情况
                <span class="add-paper-tip-text">不填则显示全部排名</span>
            </div>
        <#-- <div>
             <label class="pe-radio">
                 <span class="iconfont <#if (examSetting.rankSetting.rst)! == 'SHOW_AVERAGE'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                 <input class="pe-form-ele" type="radio" value="SHOW_AVERAGE" name="rankSetting.rst"
                        <#if (examSetting.rankSetting.rst)! == 'SHOW_AVERAGE'>checked="checked"</#if>/>
                 显示平均成绩的排名
             </label>&nbsp;&nbsp;显示前
             <input type="text" value="${(examSetting.rankSetting.rsn)!}"
                    id="rankSetting_rsn_SHOW_AVERAGE"
                    class="exam-create-num-input">名的排名情况
             <span class="add-paper-tip-text">不填则显示全部排名</span>
         </div>-->
        </dd>
        <dt class="floatL user-detail-title">排行榜发布设置:</dt>
        <dd class="user-detail-value sameChange">
            <div>
                <label class="pe-radio  <#if exam.optType?? && (exam.optType == 'VIEW')> add-paper-tip-text noClick</#if>">
                    <span class="iconfont <#if (examSetting.rankSetting.sht)! == 'SHOW_MARK'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <input class="pe-form-ele" type="radio" value="SHOW_MARK" name="rankSetting.sht"
                           <#if (examSetting.rankSetting.sht)! == 'SHOW_MARK'>checked="checked"</#if>/>
                    成绩发布且考试结束后显示考试排名
                </label>
            </div>
            <div>
                <label class="pe-radio <#if exam.optType?? && (exam.optType == 'VIEW')> add-paper-tip-text noClick</#if>">
                    <span class="iconfont <#if ((examSetting.rankSetting.sht)! == 'SHOW_END' || !(examSetting.rankSetting.sht??))>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <input class="pe-form-ele" type="radio" value="SHOW_END" name="rankSetting.sht"
                           <#if ((examSetting.rankSetting.sht)! == 'SHOW_END' || (examSetting.rankSetting.sht??))>checked="checked"</#if>/>
                    成绩发布后显示考试排名
                </label>
            </div>
        </dd>
    </dl>
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">考试权限设置:</dt>
        <dd class="user-detail-value sameChange">
            <div>
                <label class="pe-radio <#if exam.optType?? && (exam.optType == 'VIEW')> add-paper-tip-text noClick</#if>">
                    <span class="iconfont <#if (examSetting.examAuthType)! == 'NO_SEE'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <input class="pe-form-ele" type="radio" value="NO_SEE" name="examAuthType"
                           <#if (examSetting.examAuthType)! == 'NO_SEE'>checked="checked"</#if>/>
                    不允许考生查看答卷
                </label>
            </div>
            <div>
                <label class="pe-radio  <#if exam.optType?? && (exam.optType == 'VIEW')> add-paper-tip-text noClick</#if>">
                    <span class="iconfont <#if (examSetting.examAuthType)! == 'SEE_PAPER_NO_ANSWER'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <input class="pe-form-ele" type="radio" value="SEE_PAPER_NO_ANSWER"
                           name="examAuthType"
                           <#if (examSetting.examAuthType)! == 'SEE_PAPER_NO_ANSWER'>checked="checked"</#if>/>
                    允许考生查看答卷，但不允许查看正确答案
                </label>
            </div>
            <div>
                <label class="pe-radio  <#if exam.optType?? && (exam.optType == 'VIEW')> add-paper-tip-text noClick</#if>">
                    <span class="iconfont <#if (examSetting.examAuthType)! == ''||(examSetting.examAuthType)! == 'JUDGE_AND_SEE_ALL'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <input class="pe-form-ele" type="radio" value="JUDGE_AND_SEE_ALL" name="examAuthType"
                           <#if (examSetting.examAuthType)! == ''||(examSetting.examAuthType)! == 'JUDGE_AND_SEE_ALL'>checked="checked"</#if>/>
                    评卷后允许考生查看答卷和正确答案
                </label>
            </div>
            <div>
                <label class="pe-radio  <#if exam.optType?? && (exam.optType == 'VIEW')> add-paper-tip-text noClick</#if>">
                    <span class="iconfont <#if (examSetting.examAuthType)! == 'SEE_ERROR_NO_ANSWER'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <input class="pe-form-ele" type="radio" value="SEE_ERROR_NO_ANSWER" name="examAuthType"
                           <#if (examSetting.examAuthType)! == 'SEE_ERROR_NO_ANSWER'>checked="checked"</#if>/>
                    只允许考生查看答错的试题，且不显示正确答案
                </label>
            </div>
            <div>
                <label class="pe-radio  <#if exam.optType?? && (exam.optType == 'VIEW')> add-paper-tip-text noClick</#if>">
                    <span class="iconfont <#if (examSetting.examAuthType)! == 'SEE_ERROR_AND_ANSWER'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <input class="pe-form-ele" type="radio" value="SEE_ERROR_AND_ANSWER"
                           name="examAuthType"
                           <#if (examSetting.examAuthType)! == 'SEE_ERROR_AND_ANSWER'>checked="checked"</#if>/>
                    只允许考生查看答错的试题，同时显示正确答案
                </label>
            </div>
        </dd>
    </dl>
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">防舞弊设置:</dt>
        <dd class="user-detail-value">
            <div>
                <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                    <span class="iconfont <#if examSetting.preventSetting.sv?? && examSetting.preventSetting.sv>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                    <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.sv"
                    <#if examSetting.preventSetting.sv?? && examSetting.preventSetting.sv> checked="checked"</#if>/>
                    进入考试时需要短信验证身份
                </label>
            </div>
            <div>
                <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                    <span class="iconfont <#if examSetting.preventSetting.rc?? && examSetting.preventSetting.rc>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                    <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.rc"
                    <#if examSetting.preventSetting.rc?? && examSetting.preventSetting.rc> checked="checked"</#if>/>
                    开启实时摄像抓拍的功能
                </label>
            </div>
        <#--<div>-->
        <#--<label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">-->
        <#--<span class="iconfont <#if (examSetting.preventSetting.fs?? && examSetting.preventSetting.fs) || !(exam.optType??)>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>-->
        <#--<input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.fs"-->
        <#--<#if (examSetting.preventSetting.fs?? && examSetting.preventSetting.fs) || !(exam.optType??)>-->
        <#--checked="checked"</#if>/>-->
        <#--启用全屏模式-->
        <#--</label>-->
        <#--</div>-->
            <div>
                <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                    <span class="iconfont <#if (examSetting.preventSetting.cs?? && examSetting.preventSetting.cs) || !(exam.optType??)>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                    <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.cs"
                    <#if (examSetting.preventSetting.cs?? && examSetting.preventSetting.cs) || !(exam.optType??)>
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
                    <span class="iconfont <#if (examSetting.preventSetting.no?? && examSetting.preventSetting.no) || !(exam.optType??)>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                    <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.no"
                    <#if (examSetting.preventSetting.no?? && examSetting.preventSetting.no) || !(exam.optType??)>
                           checked="checked"</#if>/>
                </label>
                <input type="text" value="${(examSetting.preventSetting.noD)!'5'}"
                       name="preventSetting.noD" <#if (exam.status)! =='PROCESS'>readonly</#if>
                       class="exam-create-num-input"/>分钟内，考试页面不操作算为舞弊并强制交卷
            </div>
            <div>
                <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                    <span class="iconfont <#if examSetting.preventSetting.lt?? && examSetting.preventSetting.lt>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                    <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.lt"
                    <#if examSetting.preventSetting.lt?? && examSetting.preventSetting.lt> checked="checked"</#if>/>
                    迟到
                </label>
                <input type="text" value="${(examSetting.preventSetting.ltD)!'10'}"
                       name="preventSetting.ltD"
                       <#if (exam.status)! =='PROCESS'>readonly</#if>
                       class="exam-create-num-input">分钟后禁止参加考试
            </div>
            <div>
                <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                    <span class="iconfont <#if examSetting.preventSetting.bs?? && examSetting.preventSetting.bs>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                    <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.bs"
                    <#if examSetting.preventSetting.bs?? && examSetting.preventSetting.bs> checked="checked"</#if>/>
                    答卷时间少于
                </label>
                <input type="text" value="${(examSetting.preventSetting.bsD)!'5'}"
                       name="preventSetting.bsD"
                       class="exam-create-num-input">分钟禁止交卷
            </div>
            <div>
                <label class="pe-checkbox <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                    <span class="iconfont <#if examSetting.preventSetting.ri?? && examSetting.preventSetting.ri>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if> "></span>
                    <input class="pe-form-ele" type="checkbox" value="true" name="preventSetting.ri"
                    <#if examSetting.preventSetting.ri?? && examSetting.preventSetting.ri> checked="checked"</#if>/>
                    生成试卷时打乱相同题型下的试题的顺序以及试题选项的顺序
                </label>
            </div>
        </dd>
    </dl>
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap" style="bottom-border:none;">
        <dt class="floatL user-detail-title">考试消息设置:</dt>
        <dd class="user-detail-value sameChange">
        <#assign eMsg = true/><#--考试通知examMessage-->
        <#assign exM = (examSetting.messageSetting.eMsg.M)!false/>
        <#assign exS = (examSetting.messageSetting.eMsg.S)!false/>
        <#assign exE = (examSetting.messageSetting.eMsg.E)!false/>
        <#if  !exM  && !exS  && !exE >
            <#assign eMsg = false/>
        </#if>
        <#assign caMsg = true/><#--考试作废通知cancelMessage-->
        <#assign caM = (examSetting.messageSetting.caMsg.M)!false/>
        <#assign caS = (examSetting.messageSetting.caMsg.S)!false/>
        <#assign caE = (examSetting.messageSetting.caMsg.E)!false/>
        <#if (!caM && !caS  && !caE)>
            <#assign caMsg = false/>
        </#if>
        <#assign reMsg = true/><#--考试移除人员通知removeMessage-->
        <#assign reM = (examSetting.messageSetting.reMsg.M)!false/>
        <#assign reS = (examSetting.messageSetting.reMsg.S)!false/>
        <#assign reE = (examSetting.messageSetting.reMsg.E)!false/>
        <#if  (!reM  && !reS  && !reE )>
            <#assign reMsg = false/>
        </#if>
        <#assign eeMsg = true/><#--考试结束时间变更examEndTimeMessage-->
        <#assign eeM = (examSetting.messageSetting.eeMsg.M)!false/>
        <#assign eeS = (examSetting.messageSetting.eeMsg.S)!false/>
        <#assign eeE = (examSetting.messageSetting.eeMsg.E)!false/>
        <#if  (!eeM  && !eeS  &&! eeE)>
            <#assign eeMsg = false/>
        </#if>
        <#assign pmMsg = true/><#--发布成绩通知publishMarkMessage-->
        <#assign pmM = (examSetting.messageSetting.pmMsg.M)!false/>
        <#assign pmS = (examSetting.messageSetting.pmMsg.S)!false/>
        <#assign pmE = (examSetting.messageSetting.pmMsg.E)!false/>
        <#if (!pmM  && !pmS  && !pmE )>
            <#assign pmMsg = false/>
        </#if>
        <#assign muMsg = true/><#--发布成绩通知publishMarkMessage-->
        <#assign muM = (examSetting.messageSetting.muMsg.M)!false/>
        <#assign muS = (examSetting.messageSetting.muMsg.S)!false/>
        <#assign muE = (examSetting.messageSetting.muMsg.E)!false/>
        <#if  (!muM  && !muS  && !muE )>
            <#assign muMsg = false/>
        </#if>
            <div>
                <div>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if eMsg>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" <#if eMsg>checked="checked"</#if> id="eMsg"/>
                        考试通知
                    </span>
                </div>
                <div style="margin-left:18px;">
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if exM >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if exM >checked="checked"</#if>
                               name="messageSetting.eMsg['M']" id="eMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if exS >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if exS >checked="checked"</#if>
                               name="messageSetting.eMsg['S']" id="eMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if exE >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if exE >checked="checked"</#if>
                               name="messageSetting.eMsg['E']" id="eMsg_E"/>
                        手机短信
                    </span>
                </div>
            </div>
            <div>
                <div>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if caMsg>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" <#if caMsg>checked="checked"</#if> id="caMsg"/>
                        考试作废通知
                    </span>
                </div>
                <div style="margin-left:18px;">
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if caM >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if caM >checked</#if>
                               name="messageSetting.caMsg['M']" id="caMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if caS>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if caS >checked</#if>
                               name="messageSetting.caMsg['S']" id="caMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if caE >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if caE >checked</#if>
                               name="messageSetting.caMsg['E']" id="caMsg_E"/>
                        手机短信
                    </span>
                </div>
            </div>
            <div>
                <div>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if reMsg>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" <#if reMsg>checked="checked"</#if> id="reMsg"/>
                        考试移除人员通知
                    </span>
                </div>
                <div style="margin-left:18px;">
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if reM >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if reM >checked="checked"</#if>
                               name="messageSetting.reMsg['M']" id="reMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if reS >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if reS >checked="checked"</#if>
                               name="messageSetting.reMsg['S']" id="reMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if reE>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if reE>checked="checked"</#if>
                               name="messageSetting.reMsg['E']" id="reMsg_E"/>
                        手机短信
                    </span>
                </div>
            </div>
            <div>
                <div>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if eeMsg>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" <#if eeMsg>checked="checked"</#if> id="eeMsg"/>
                        考试结束时间变更
                    </span>
                </div>
                <div style="margin-left:18px;">
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if eeM>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if eeM >checked="checked"</#if>
                               name="messageSetting.eeMsg['M']" id="eeMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if eeS >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if eeS >checked="checked"</#if>
                               name="messageSetting.eeMsg['S']" id="eeMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if eeE >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if eeE >checked="checked"</#if>
                               name="messageSetting.eeMsg['E']" id="eeMsg_E"/>
                        手机短信
                    </span>
                </div>
            </div>
            <div>
                <div>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if pmMsg>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" <#if pmMsg>checked="checked"</#if> id="pmMsg"/>
                        发布成绩
                    </span>
                </div>
                <div style="margin-left:18px;">
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if pmM>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if pmM >checked="checked"</#if>
                               name="messageSetting.pmMsg['M']" id="pmMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if pmS >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if pmS >checked="checked"</#if>
                               name="messageSetting.pmMsg['S']" id="pmMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if pmE >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if pmE >checked="checked"</#if>
                               name="messageSetting.pmMsg['E']" id="pmMsg_E"/>
                        手机短信
                    </span>
                </div>
            </div>
            <div>
                <div>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if muMsg>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" <#if muMsg>checked="checked"</#if> id="muMsg"/>
                        补考通知
                    </span>
                </div>
                <div style="margin-left:18px;">
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if muM >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if muM >checked="checked"</#if>
                               name="messageSetting.muMsg['M']" id="muMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if muS >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if muS >checked="checked"</#if>
                               name="messageSetting.muMsg['S']" id="muMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox pe-check-by-list">
                        <span class="iconfont <#if muE >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <#if muE >checked="checked"</#if>
                               name="messageSetting.muMsg['E']" id="muMsg_E"/>
                        手机短信
                    </span>
                </div>
            </div>
        </dd>
    </dl>
</script>
<script>
    $(function () {
        if (typeof changeExamManaStorage === 'function') {
            window.removeEventListener("storage", changeExamManaStorage, false);
        }
        var subject = '${((exam.subject)!)?string('true','false')}';
        var formId = "defaultSimpleExamSettingForm";
        var editExamSetting = {
            init: function () {
                $(".default-simple-setting-panel").html(_.template($("#simpleSettingPanel").html())());
                $(".more-setting-panel").html(_.template($("#moreSettingPanel").html())());
                var optType = '${(exam.optType)!}';
                if (optType == 'VIEW') {//预览试卷置灰
                    $('input:not(.laydate-time)').attr('readonly', true);
//                    $('button').attr('disabled', true);
                }

                $('.add-exam-main-panel').delegate('.exam-create-num-input', 'keyup', function () {

                    var name = $(this).attr("name");
                    var inputNum = $(this).val();
                    inputNum = inputNum.replace(/[^0-9]/g, ''); //只能输入数字
                    if (name != 'examSetting.mn') {
                        inputNum = inputNum.replace(/^0/g, "");//验证第一个字符不是0
                    } else {
//                    $('input[name="examSetting.mt"]').prop('checked','checked');
                    }
                    $(this).val(inputNum);
                });

                $('.add-exam-main-panel').delegate('.exam-create-num-input', 'blur', function () {
                    var inputNum = $(this).val();
                    var name = $(this).attr("name");
                    if (!inputNum || parseInt(inputNum) < 0) {
                        if (name == 'examSetting.el' || name == 'rankSetting.rsn') {
                            inputNum = '';
                        }
                        if (name == 'examSetting.mn') {
                            inputNum = '';
                        }
                        if (name == 'scoreSetting.cm') {
                            inputNum = 100;
                        }
                        if (name == 'scoreSetting.pr') {
                            inputNum = 60;
                        }
                        if (name == 'preventSetting.csN') {
                            inputNum = 3;
                        }
                        if (name == 'preventSetting.noD' || name == 'preventSetting.bsD') {
                            inputNum = 5;
                        }
                        if (name == 'preventSetting.ltD') {
                            inputNum = 10;
                        }
                        return $(this).val(inputNum);
                    }
                    if (!/^[0-9]*$/.test(inputNum)) {
                        inputNum = inputNum.replace(/[^0-9]/g, ''); //只能输入数字
                        if (name != 'examSetting.mn') {
                            inputNum = inputNum.replace(/^0/g, ""); //验证第一个字符不是0
                        }
                    }
                    if (parseInt(inputNum) >= 999999) {
                        inputNum = 999999;
                    }
                <#--if (name == 'examSetting.el') {-->
                <#--if (parseInt(inputNum) >= parseInt('${(exam.examTimeLength)!}')) {-->
                <#--inputNum = '${(exam.examTimeLength)!}';-->
                <#--}-->
                <#--}-->
                    if (name == 'examSetting.mn') {
                        if (parseInt(inputNum) < 0) {
                            inputNum = '';
                        }
                    }
                    if (name == 'scoreSetting.pr') {
                        if (parseInt(inputNum) > 100) {
                            inputNum = 100;
                        }
                    }
                    if (name == 'rankSetting.rsn') {
                        if (parseInt(inputNum) < 1) {
                            inputNum = '';
                        }
                    }
                    if (name == 'preventSetting.csN') {
                        if (parseInt(inputNum) < 1) {
                            inputNum = 3;
                        }
                    }
                    if (name == 'preventSetting.noD' || name == 'preventSetting.bsD') {
                        if (parseInt(inputNum) < 1) {
                            inputNum = 5;
                        }
                    }
                    if (name == 'preventSetting.ltD') {
                        if (parseInt(inputNum) < 1) {
                            inputNum = 10;
                        }
                    }
                    return $(this).val(inputNum);
                });
                //我要编辑考试
                $('.i-need-edit-exam').on('click', function () {
                <#if !(exam.status?? && exam.status == 'PROCESS')>
                    $('input:not(.laydate-time)').removeAttr('readonly');
                </#if>
                    $('.sameChange label').removeClass("noClick");
                    $('button').removeAttr('disabled');
                    $('.view-exam-group-one').hide();
                    $('.view-exam-group-two').show();
                    $('.exam-more-set-btn').show();
                    $('.view-exam-group-select-user').show();
                    $('.icon-inputDele').parent().removeClass('not-hover');
                });

                var source = '${(exam.source)!}';
                $('.edit-step-state .basic-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamInfo', params);
                });

                $('.edit-step-state .paper-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper', params);
                });

                $('.edit-step-state .arrange-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage', params);
                });

                $('.add-manager').on('click', function () {
                    PEMO.DIALOG.selectorDialog({
                        title: '选择考试管理员',
                        area: ['870px', '580px'],
                        content: [pageContext.rootPath + '/ems/exam/manage/initSelector?type=EXAM_MANAGER&id=${(exam.id)!}', 'no'],
                        btn: ['关闭'],
                        btn1: function (index) {
                            layer.close(index);
                        }
                    });
                });

                //类别点击筛选事件
                $('.pe-radio.pe-check-by-list').off().click(function () {
                    if ($(this).hasClass('noClick')) {
                        return false;
                    } else {
                        var iconCheck = $(this).find('span.iconfont');
                        var thisRealCheck = $(this).find('input[type="radio"]');
                        if (iconCheck.hasClass('icon-unchecked-radio')) {
                            iconCheck.removeClass('icon-unchecked-radio').addClass('icon-checked-radio peChecked');
                            thisRealCheck.prop('checked', true);
                        }
                        switch (thisRealCheck.attr("id")) {
                            case "AUTO_JUDGE":
                                $("#MANUAL_JUDGE_PAPER").removeProp('checked');
                                $("#MANUAL_JUDGE_PAPER").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE_ITEM").removeProp('checked');
                                $("#MANUAL_JUDGE_ITEM").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE").removeProp('checked');
                                $("#MANUAL_JUDGE").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("input[name='judgeSetting.vi']").removeProp("checked");
                                $("input[name='judgeSetting.vi']").parent().find('span.iconfont').removeClass('icon-checked-checkbox peChecked').addClass('icon-unchecked-checkbox');
                                $("input[name='judgeSetting.vi']").prop("disabled", "disabled");
                                $("input[name='judgeSetting.jt']").prop("disabled", "disabled");
                                $(".MANUAL_JUDGE_PAPER_span").hide();
                                $(".MANUAL_JUDGE_ITEM_span").hide();
                                $('#MANUAL_JUDGE_PAPER').parent().removeClass('pe-check-by-list').addClass('add-paper-tip-text');
                                $('#MANUAL_JUDGE_ITEM').parent().removeClass('pe-check-by-list').addClass('add-paper-tip-text');
                                $('input[name="judgeSetting.vi"]').parent().removeClass('pe-check-by-list').addClass('add-paper-tip-text');
                                break;
                            case "MANUAL_JUDGE_PAPER":
                                $("#AUTO_JUDGE").removeProp('checked');
                                $("#AUTO_JUDGE").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE_ITEM").removeProp('checked');
                                $("#MANUAL_JUDGE_ITEM").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE").prop('checked', 'checked');
                                $("#MANUAL_JUDGE").parent().find('span.iconfont').removeClass('icon-unchecked-radio').addClass('icon-checked-radio peChecked');
                                $("input[name='judgeSetting.vi']").removeProp("disabled");
                                $(".MANUAL_JUDGE_PAPER_span").show();
                                $(".MANUAL_JUDGE_ITEM_span").hide();
                                break;
                            case "MANUAL_JUDGE_ITEM":
                                $("#AUTO_JUDGE").removeProp('checked');
                                $("#AUTO_JUDGE").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE_PAPER").removeProp('checked');
                                $("#MANUAL_JUDGE_PAPER").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE").prop('checked', 'checked');
                                $("#MANUAL_JUDGE").parent().find('span.iconfont').removeClass('icon-unchecked-radio').addClass('icon-checked-radio peChecked');
                                $("input[name='judgeSetting.vi']").removeProp("disabled");
                                $(".MANUAL_JUDGE_PAPER_span").hide();
                                $(".MANUAL_JUDGE_ITEM_span").show();
                                break;
                            case "MANUAL_JUDGE":
                                $("#AUTO_JUDGE").removeProp('checked');
                                $("#AUTO_JUDGE").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE_ITEM").removeProp('checked');
                                $("#MANUAL_JUDGE_ITEM").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE_PAPER").prop('checked', 'checked');
                                $("#MANUAL_JUDGE_PAPER").parent().find('span.iconfont').removeClass('icon-unchecked-radio').addClass('icon-checked-radio peChecked');
                                $("input[name='judgeSetting.vi']").removeProp("disabled");
                                $("input[name='judgeSetting.jt']").removeProp("disabled");
                                $(".MANUAL_JUDGE_PAPER_span").show();
                                $(".MANUAL_JUDGE_ITEM_span").hide();
                                $('#MANUAL_JUDGE_PAPER').parent().removeClass('add-paper-tip-text').addClass('pe-check-by-list');
                                $('#MANUAL_JUDGE_ITEM').parent().removeClass('add-paper-tip-text').addClass('pe-check-by-list');
                                $('input[name="judgeSetting.vi"]').parent().removeClass('add-paper-tip-text').addClass('pe-check-by-list');
                                break;
                            case "EVERY":
                                $("#ALL").removeProp('checked');
                                $("#ALL").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("input[name='examSetting.ce']").removeProp("disabled");
                                $('input[name="examSetting.ce"]').parent().removeClass('add-paper-tip-text').addClass('pe-check-by-list');
                                break;
                            case "ALL":
                                $("#EVERY").removeProp('checked');
                                $("#EVERY").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("input[name='examSetting.ce']").removeProp("checked");
                                $("input[name='examSetting.ce']").parent().find('span.iconfont').removeClass('icon-checked-checkbox peChecked').addClass('icon-unchecked-checkbox');
                                $("input[name='examSetting.ce']").prop("disabled", "disabled");
                                $('input[name="examSetting.ce"]').parent().removeClass('pe-check-by-list').addClass('add-paper-tip-text');
                                break;
                            case "MANUAL":
                                $("#JUDGED_AUTO_PUBLISH").removeProp('checked');
                                $("#JUDGED_AUTO_PUBLISH").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#JUDGED_ALL_AND_EXAM_END").removeProp('checked');
                                $("#JUDGED_ALL_AND_EXAM_END").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("input[name='scoreSetting.tp']").removeProp("disabled");
                                $("input[name='scoreSetting.tp']").parent().removeClass('add-paper-tip-text').addClass('pe-check-by-list');
//                                $("input[name='scoreSetting.pd']").attr('onclick', 'laydate({format:"YYYY-MM-DD hh:mm",istime:true,istoday:false})');
                                break;
                            case "JUDGED_AUTO_PUBLISH":
                                $("#MANUAL").removeProp('checked');
                                $("#MANUAL").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#JUDGED_ALL_AND_EXAM_END").removeProp('checked');
                                $("#JUDGED_ALL_AND_EXAM_END").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("input[name='scoreSetting.tp']").removeProp("checked");
                                $("input[name='scoreSetting.tp']").parent().find('span.iconfont').removeClass('icon-checked-checkbox peChecked').addClass('icon-unchecked-checkbox');
                                $("input[name='scoreSetting.tp']").prop("disabled", "disabled");
                                $("input[name='scoreSetting.tp']").parent().removeClass('pe-check-by-list').addClass('add-paper-tip-text');
//                                $("input[name='scoreSetting.pd']").attr('onclick', '');
                                break;
                            case "JUDGED_ALL_AND_EXAM_END":
                                $("#MANUAL").removeProp('checked');
                                $("#MANUAL").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#JUDGED_AUTO_PUBLISH").removeProp('checked');
                                $("#JUDGED_AUTO_PUBLISH").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("input[name='scoreSetting.tp']").removeProp("checked");
                                $("input[name='scoreSetting.tp']").parent().find('span.iconfont').removeClass('icon-checked-checkbox peChecked').addClass('icon-unchecked-checkbox');
                                $("input[name='scoreSetting.tp']").prop("disabled", "disabled");
                                $("input[name='scoreSetting.tp']").parent().removeClass('pe-check-by-list').addClass('add-paper-tip-text');
//                                $("input[name='scoreSetting.pd']").attr('onclick', '');
                                break;
                            default:
                                break;
                        }
                    }
                });

                $('.pe-checkbox.pe-check-by-list').off().click(function () {
                    if ($(this).hasClass('noClick')) {
                        return false;
                    } else {
                        var iconCheck = $(this).find('span.iconfont');
                        var thisRealCheck = $(this).find('input[type="checkbox"]');
                        if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                            editExamSetting.checkboxChecked(iconCheck, thisRealCheck);
                        } else {
                            editExamSetting.checkboxUnChecked(iconCheck, thisRealCheck);
                        }

                        switch (thisRealCheck.attr("id")) {
                            case "eMsg":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#eMsg_M").parent().find('span.iconfont'), $("#eMsg_M").parent().find('input[type="checkbox"]'));
                                    editExamSetting.checkboxChecked($("#eMsg_S").parent().find('span.iconfont'), $("#eMsg_S").parent().find('input[type="checkbox"]'));
                                } else {
                                    editExamSetting.checkboxUnChecked($("#eMsg_M").parent().find('span.iconfont'), $("#eMsg_M").parent().find('input[type="checkbox"]'));
                                    editExamSetting.checkboxUnChecked($("#eMsg_S").parent().find('span.iconfont'), $("#eMsg_S").parent().find('input[type="checkbox"]'));
                                }
                                editExamSetting.checkboxUnChecked($("#eMsg_E").parent().find('span.iconfont'), $("#eMsg_E").parent().find('input[type="checkbox"]'));
                                break;
                            case "eMsg_M":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#eMsg").parent().find('span.iconfont'), $("#eMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#eMsg_S").prop("checked") && !$("#eMsg_E").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#eMsg").parent().find('span.iconfont'), $("#eMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "eMsg_S":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#eMsg").parent().find('span.iconfont'), $("#eMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#eMsg_M").prop("checked") && !$("#eMsg_E").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#eMsg").parent().find('span.iconfont'), $("#eMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "eMsg_E":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#eMsg").parent().find('span.iconfont'), $("#eMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#eMsg_M").prop("checked") && !$("#eMsg_S").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#eMsg").parent().find('span.iconfont'), $("#eMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "caMsg":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#caMsg_M").parent().find('span.iconfont'), $("#caMsg_M").parent().find('input[type="checkbox"]'));
                                    editExamSetting.checkboxChecked($("#caMsg_S").parent().find('span.iconfont'), $("#caMsg_S").parent().find('input[type="checkbox"]'));
                                } else {
                                    editExamSetting.checkboxUnChecked($("#caMsg_M").parent().find('span.iconfont'), $("#caMsg_M").parent().find('input[type="checkbox"]'));
                                    editExamSetting.checkboxUnChecked($("#caMsg_S").parent().find('span.iconfont'), $("#caMsg_S").parent().find('input[type="checkbox"]'));
                                }
                                editExamSetting.checkboxUnChecked($("#caMsg_E").parent().find('span.iconfont'), $("#caMsg_E").parent().find('input[type="checkbox"]'));
                                break;
                            case "caMsg_M":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#caMsg").parent().find('span.iconfont'), $("#caMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#caMsg_S").prop("checked") && !$("#caMsg_E").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#caMsg").parent().find('span.iconfont'), $("#caMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "caMsg_S":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#caMsg").parent().find('span.iconfont'), $("#caMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#caMsg_M").prop("checked") && !$("#caMsg_E").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#caMsg").parent().find('span.iconfont'), $("#caMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "caMsg_E":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#caMsg").parent().find('span.iconfont'), $("#caMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#caMsg_M").prop("checked") && !$("#caMsg_S").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#caMsg").parent().find('span.iconfont'), $("#caMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "reMsg":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#reMsg_M").parent().find('span.iconfont'), $("#reMsg_M").parent().find('input[type="checkbox"]'));
                                    editExamSetting.checkboxChecked($("#reMsg_S").parent().find('span.iconfont'), $("#reMsg_S").parent().find('input[type="checkbox"]'));
                                } else {
                                    editExamSetting.checkboxUnChecked($("#reMsg_M").parent().find('span.iconfont'), $("#reMsg_M").parent().find('input[type="checkbox"]'));
                                    editExamSetting.checkboxUnChecked($("#reMsg_S").parent().find('span.iconfont'), $("#reMsg_S").parent().find('input[type="checkbox"]'));
                                }
                                editExamSetting.checkboxUnChecked($("#reMsg_E").parent().find('span.iconfont'), $("#reMsg_E").parent().find('input[type="checkbox"]'));
                                break;
                            case "reMsg_M":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#reMsg").parent().find('span.iconfont'), $("#reMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#reMsg_S").prop("checked") && !$("#reMsg_E").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#reMsg").parent().find('span.iconfont'), $("#reMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "reMsg_S":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#reMsg").parent().find('span.iconfont'), $("#reMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#reMsg_M").prop("checked") && !$("#reMsg_E").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#reMsg").parent().find('span.iconfont'), $("#reMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "reMsg_E":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#reMsg").parent().find('span.iconfont'), $("#reMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#reMsg_M").prop("checked") && !$("#reMsg_S").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#reMsg").parent().find('span.iconfont'), $("#reMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "eeMsg":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#eeMsg_M").parent().find('span.iconfont'), $("#eeMsg_M").parent().find('input[type="checkbox"]'));
                                    editExamSetting.checkboxChecked($("#eeMsg_S").parent().find('span.iconfont'), $("#eeMsg_S").parent().find('input[type="checkbox"]'));
                                } else {
                                    editExamSetting.checkboxUnChecked($("#eeMsg_M").parent().find('span.iconfont'), $("#eeMsg_M").parent().find('input[type="checkbox"]'));
                                    editExamSetting.checkboxUnChecked($("#eeMsg_S").parent().find('span.iconfont'), $("#eeMsg_S").parent().find('input[type="checkbox"]'));
                                }
                                editExamSetting.checkboxUnChecked($("#eeMsg_E").parent().find('span.iconfont'), $("#eeMsg_E").parent().find('input[type="checkbox"]'));
                                break;
                            case "eeMsg_M":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#eeMsg").parent().find('span.iconfont'), $("#eeMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#eeMsg_S").prop("checked") && !$("#eeMsg_E").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#eeMsg").parent().find('span.iconfont'), $("#eeMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "eeMsg_S":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#eeMsg").parent().find('span.iconfont'), $("#eeMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#eeMsg_M").prop("checked") && !$("#eeMsg_E").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#eeMsg").parent().find('span.iconfont'), $("#eeMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "eeMsg_E":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#eeMsg").parent().find('span.iconfont'), $("#eeMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#eeMsg_M").prop("checked") && !$("#eeMsg_S").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#eeMsg").parent().find('span.iconfont'), $("#eeMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "pmMsg":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#pmMsg_M").parent().find('span.iconfont'), $("#pmMsg_M").parent().find('input[type="checkbox"]'));
                                    editExamSetting.checkboxChecked($("#pmMsg_S").parent().find('span.iconfont'), $("#pmMsg_S").parent().find('input[type="checkbox"]'));
                                } else {
                                    editExamSetting.checkboxUnChecked($("#pmMsg_M").parent().find('span.iconfont'), $("#pmMsg_M").parent().find('input[type="checkbox"]'));
                                    editExamSetting.checkboxUnChecked($("#pmMsg_S").parent().find('span.iconfont'), $("#pmMsg_S").parent().find('input[type="checkbox"]'));
                                }
                                editExamSetting.checkboxUnChecked($("#pmMsg_E").parent().find('span.iconfont'), $("#pmMsg_E").parent().find('input[type="checkbox"]'));
                                break;
                            case "pmMsg_M":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#pmMsg").parent().find('span.iconfont'), $("#pmMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#eeMsg_S").prop("checked") && !$("#eeMsg_E").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#pmMsg").parent().find('span.iconfont'), $("#pmMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "pmMsg_S":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#pmMsg").parent().find('span.iconfont'), $("#pmMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#eeMsg_M").prop("checked") && !$("#eeMsg_E").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#pmMsg").parent().find('span.iconfont'), $("#pmMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "pmMsg_E":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#pmMsg").parent().find('span.iconfont'), $("#pmMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#eeMsg_M").prop("checked") && !$("#eeMsg_S").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#pmMsg").parent().find('span.iconfont'), $("#pmMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "muMsg":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#muMsg_M").parent().find('span.iconfont'), $("#muMsg_M").parent().find('input[type="checkbox"]'));
                                    editExamSetting.checkboxChecked($("#muMsg_S").parent().find('span.iconfont'), $("#muMsg_S").parent().find('input[type="checkbox"]'));
                                } else {
                                    editExamSetting.checkboxUnChecked($("#muMsg_M").parent().find('span.iconfont'), $("#muMsg_M").parent().find('input[type="checkbox"]'));
                                    editExamSetting.checkboxUnChecked($("#muMsg_S").parent().find('span.iconfont'), $("#muMsg_S").parent().find('input[type="checkbox"]'));
                                }
                                editExamSetting.checkboxUnChecked($("#muMsg_E").parent().find('span.iconfont'), $("#muMsg_E").parent().find('input[type="checkbox"]'));
                                break;
                            case "muMsg_M":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#muMsg").parent().find('span.iconfont'), $("#muMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#muMsg_S").prop("checked") && !$("#muMsg_E").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#muMsg").parent().find('span.iconfont'), $("#muMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "muMsg_S":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#muMsg").parent().find('span.iconfont'), $("#muMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#muMsg_M").prop("checked") && !$("#muMsg_E").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#muMsg").parent().find('span.iconfont'), $("#muMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            case "muMsg_E":
                                if (thisRealCheck.prop("checked")) {
                                    editExamSetting.checkboxChecked($("#muMsg").parent().find('span.iconfont'), $("#muMsg").parent().find('input[type="checkbox"]'));
                                } else if (!$("#muMsg_M").prop("checked") && !$("#muMsg_S").prop("checked")) {
                                    editExamSetting.checkboxUnChecked($("#muMsg").parent().find('span.iconfont'), $("#muMsg").parent().find('input[type="checkbox"]'));
                                }
                                break;
                            default:
                                break;
                        }
                    }
                });

                $('.add-paper-user').on('click', function () {
                    if ($("#MANUAL_JUDGE_PAPER").prop("checked") == true || $("#simplejudgeSetting_jt").val() === 'MANUAL_JUDGE_PAPER') {
                        PEMO.DIALOG.selectorDialog({
                            title: '分配评卷人',
                            area: ['970px', '580px'],
                            content: [pageContext.rootPath + '/ems/exam/manage/initSelector?type=JUDGE_PAPER_USER&id=${(exam.id)!}', 'no'],
                            btn: ['关闭'],
                            btn1: function (index) {
                                layer.close(index);
                            }
                        });
                    }
                });

                $(".exam-more-set-btn").click(function () {
                    formId = "moreExamSettingForm";
                    $(".default-simple-setting-panel").hide();
                    $(".more-setting-panel").show();
                });


                /*面板hover效果事件*/
                $('.user-detail-msg-wrap').hover(
                        function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            $(this).addClass('item-hover');

                        },
                        function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            $(this).removeClass('item-hover');
                        }
                );

                //保存为草稿
                $(".pe-step-save-draft").click(function () {
                    var isSubject = '${(exam.subject?string('true','false'))!}';
                    var firstPageUrl = '#url=' + pageContext.rootPath + '/ems/exam/manage/initPage';
                    if ("true" === isSubject) {
                        firstPageUrl = '#url=' + pageContext.rootPath + '/ems/exam/manage/initSubjectPage';
                    }
                    editExamSetting.submitForm(function (data) {
                        PEMO.DIALOG.tips({
                            content: "保存成功！",
                            time: 1000,
                            end: function () {
                                location.href = firstPageUrl;
                            }
                        });
                    });
                });

                //保存并启用
                $(".pe-step-save-and-use").click(function () {
                    var isVal = editExamSetting.checkParams();
                    if (!isVal) {
                        return false;
                    }

                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/saveEnableExam',
                        data: $('#' + formId).serialize(),
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: "启用成功",
                                    end: function () {
                                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initPage&nav=examMana';
                                    }
                                });
                                return false;
                            }

                            var errorHtml = '<p style="font-size: 14px;">';
                            $.each(data.data, function (i, errMsg) {
                                errorHtml = errorHtml + '<span class="iconfont icon-tree-dot" style="font-size: 12px;margin-left: 3px;"></span>' + errMsg + '<br/>';
                            });

                            errorHtml = errorHtml + '</p>';
                            PEMO.DIALOG.alert({
                                content: errorHtml,
                                btn: ['我知道了'],
                                area: ['500px'],
                                yes: function () {
                                    layer.closeAll();
                                },
                                success: function () {
                                    $('.layui-layer .layui-layer-content').height('auto');
                                }
                            });
                        }
                    });
                });

                //科目的保存并启用
                $(".pe-subject-save-and-use").click(function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/saveEnableSubject',
                        data: $('#' + formId).serialize(),
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: "启用成功！",
                                    time: 1000,
                                    end: function () {
                                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initSubjectPage';
                                    }
                                });

                                return false;
                            }

                            var errorHtml = '<p style="font-size: 14px;">';
                            $.each(data.data, function (i, errMsg) {
                                errorHtml = errorHtml + '<span class="iconfont icon-tree-dot" style="font-size: 12px;margin-left: 3px;"></span>' + errMsg + '<br/>';
                            });

                            errorHtml = errorHtml + '</p>'
                            PEMO.DIALOG.alert({
                                content: errorHtml,
                                btn: ['我知道了'],
                                area: ['500px'],
                                yes: function () {
                                    layer.closeAll();
                                },
                                success: function () {
                                    $('.layui-layer .layui-layer-content').height('auto');
                                }
                            });
                        }
                    });
                });

                //考试管理员删除功能
                $('.add-exam-main-panel').delegate('.icon-inputDele', 'click', function () {
                    var id = '${(exam.id)!}';
                    var userId = [];
                    userId.push($(this).parent().attr('data-id'));
                    var data = {id: id, referIds: JSON.stringify(userId), type: 'EXAM_MANAGER'};
                    var thisSpan = $(this);
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/deleteExamAdmin',
                        data: data,
                        success: function (data) {
                            if (data.success) {
                                thisSpan.parent().remove();
                            }

                            return false;
                        }
                    })
                });

                $('.pe-step-back-btn').on('click', function () {
                    if (subject && subject === 'true') {
                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initSubjectPage&nav=examMana';
                    } else {
                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initPage&nav=examMana';
                    }
                });

                $('.new-page-close-btn').on('click', function () {
                    window.close();
                });

                $('.pe-step-pre-btn').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    var subject = '${(exam.subject)!?string("true","false")}';
                    if (subject === 'true') {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper', params);
                    } else {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage', params);
                    }
                });
            },
            checkboxChecked: function (iconCheck, thisRealCheck) {
                if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                    iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                    thisRealCheck.prop('checked', 'checked');//这里在ie8下目前会报错“意外的调用了方法”,待解决
                }
            },
            checkboxUnChecked: function (iconCheck, thisRealCheck) {
                if (iconCheck.hasClass('icon-checked-checkbox')) {
                    iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                    thisRealCheck.removeProp('checked');
                }
            },
            checkParams: function () {
                var formD = $("#" + formId);
//                var isChecked = "";
//                if (formId === 'moreExamSettingForm') {
                var isChecked = ":checked";
//                }
                /*考试时长*/
                var errors = [];
                var isLimitedSubmited = 0;
                if (formD.find("input[name='examSetting.elt']" + isChecked).val() === 'LIMIT') {
                    isLimitedSubmited = isLimitedSubmited + 1;
                    var timeLen = formD.find("input[name='examSetting.el']").val();
                    if (!timeLen || $.trim(timeLen) === '' || parseInt($.trim(timeLen)) < 1) {
                        errors.push("请设置考试时长");
                    }
                }
                /*自动安排补考   补考次数*/
                if (formD.find("input[name='examSetting.mt']" + isChecked).val() === 'AUTO_MAKEUP') {
                    var makenum = formD.find("input[name='examSetting.mn']").val();
                    if (!makenum || $.trim(makenum) === '' || parseInt($.trim(makenum)) < 0) {
                        formD.find("input[name='examSetting.mn']").val(0);
                    }
                }
                /*原试卷题目分数按比例折算成满分*/
                if (formD.find("input[name='scoreSetting.st']" + isChecked).val() === 'CONVERT') {
                    var cm = formD.find("input[name='scoreSetting.cm']").val();
                    if (!cm || $.trim(cm) === '' || parseInt($.trim(cm)) < 1) {
                        errors.push("请设置 “成绩设置” 的 “原试卷题目分数按比例折算分数”");
                    }
                }
                /*得分率不低于*/
                var pr = formD.find("input[name='scoreSetting.pr']").val();
                if (!pr || $.trim(pr) === '' || parseInt($.trim(pr)) < 1) {
                    errors.push("请设置 “及格条件” 的 “得分率”");
                }
                /*定时发布成绩*/
                if (formD.find("input[name='scoreSetting.spt']" + isChecked).val() === 'MANUAL' && formD.find("input[name='scoreSetting.tp']" + isChecked).val()) {
                    var pd = formD.find("input[name='scoreSetting.pd']").val();
                    if (!pd || $.trim(pd) === '') {
                        errors.push("成绩发布设置,手动定时发布成绩时间不可为空");
                    }
                }
                /*排行榜显示设置 排名*/
                if (formD.find("input[name='rankSetting.rst']" + isChecked).val() !== 'NO_SHOW') {
                    var rst = formD.find("input[name='rankSetting.rst']" + isChecked).val();
                    var rsn = $("#rankSetting_rsn_" + rst).val();
                    if (rsn && parseInt($.trim(rsn)) < 0) {
                        errors.push("请设置 “排行榜显示设置” 的 “显示排名”");
                    }

                    formD.find("input[name='rankSetting.rsn']").val(rsn);
                }
                /*防舞弊设置 切屏次数*/
                if (formD.find("input[name='preventSetting.cs']" + isChecked).val()) {
                    var csN = formD.find("input[name='preventSetting.csN']").val();
                    if (!csN || $.trim(csN) === '' || parseInt($.trim(csN)) < 1) {
                        errors.push("请设置 “防舞弊设置” 的 “切屏次数”");
                    }
                }
                /*防舞弊设置 考试页面不操作*/
                if (formD.find("input[name='preventSetting.no']" + isChecked).val()) {
                    var noD = formD.find("input[name='preventSetting.noD']").val();
                    if (!noD || $.trim(noD) === '' || parseInt($.trim(noD)) < 1) {
                        errors.push("请设置 “防舞弊设置” 的 “考试页面不操作时长”");
                    }
                }
                /*防舞弊设置 迟到*/
                if (formD.find("input[name='preventSetting.lt']" + isChecked).val()) {
                    var ltD = formD.find("input[name='preventSetting.ltD']").val();
                    if (!ltD || $.trim(ltD) === '' || parseInt($.trim(ltD)) < 1) {
                        errors.push("请设置 “防舞弊设置” 的 “迟到时长”");
                    }
                }
                /*防舞弊设置 答卷时间少于*/
                if (formD.find("input[name='preventSetting.bs']" + isChecked).val()) {
                    isLimitedSubmited = isLimitedSubmited + 1;
                    var bsD = formD.find("input[name='preventSetting.bsD']").val();
                    if (!bsD || $.trim(bsD) === '' || parseInt($.trim(bsD)) < 1) {
                        errors.push("请设置 “防舞弊设置” 的 “答卷时间最小时长”");
                    }
                }

                if (isLimitedSubmited == 2) {
                    var bsD = formD.find("input[name='preventSetting.bsD']").val();//考试必须限制时长；
                    var timeLen = formD.find("input[name='examSetting.el']").val();//考试时长
                    if (bsD && timeLen && parseInt($.trim(bsD)) > parseInt($.trim(timeLen))) {
                        errors.push("考试限制时长必须小于考试时长;");
                    }
                }

                if (errors.length > 0) {
                    var errorHtml = '<p style="font-size: 14px;">';
                    $.each(errors, function (i, errMsg) {
                        errorHtml = errorHtml + '<span class="iconfont icon-tree-dot" style="font-size: 12px;margin-left: 3px;"></span>' + errMsg + '<br/>';
                    });

                    errorHtml = errorHtml + '</p>';
                    PEMO.DIALOG.alert({
                        content: errorHtml,
                        btn: ['我知道了'],
                        area: ['500px'],
                        yes: function () {
                            layer.closeAll();
                        },
                        success: function () {
                            $('.layui-layer .layui-layer-content').height('auto');
                        }
                    });

                    return false;
                }

                return true;
            },
            submitForm: function (callback) {
                var isVal = editExamSetting.checkParams();
                if (!isVal) {
                    return false;
                }

                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/manage/saveExamSetting',
                    data: $('#' + formId).serialize(),
                    success: function (data) {
                        if (data.success) {
                            callback(data.data.exam.id);
                            return false;
                        }

                        PEMO.DIALOG.alert({
                            content: data.message,
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });
                    }
                });
            },
            initData: function () {
                window.addEventListener("storage", function (e) {
                    if (e.key.indexOf('EXAM_MANAGER_count_') >= 0 && e.newValue) {
                        $('.' + e.key).html(e.newValue - 1);
                        localStorage.removeItem(e.key);
                    } else if ((e.key.indexOf('JUDGE_PAPER_USER_count_') >= 0 || e.key.indexOf('JUDGE_ITEM_USER_count_') >= 0) && e.newValue) {
                        $('.' + e.key).parent().show();
                        $('.' + e.key).text(e.newValue);
                        localStorage.removeItem(e.key);
                    } else if ((e.key.indexOf('JUDGE_PAPER_USER_name_') >= 0 || e.key.indexOf('JUDGE_ITEM_USER_name_') >= 0) && e.newValue) {
                        $('.' + e.key).parent().show();
                        $('.' + e.key).find('.add-question-bank-item').remove();
                        $('.' + e.key).find('.add-paper-user').before(e.newValue);//有两个的“选择人员”的classname是 add-manager

                        localStorage.removeItem(e.key);
                    } else if (e.key.indexOf('EXAM_MANAGER_name_') >= 0 && e.newValue) {
                        $('.' + e.key).find('.add-question-bank-item').remove();
                        $('.' + e.key).find('.add-manager').before(e.newValue);//有两个的“选择人员”的classname是 add-manager
                        localStorage.removeItem(e.key);
                    }
                });
                PEBASE.peFormEvent('checkbox');
                PEBASE.peFormEvent('radio');
            }
        };

        editExamSetting.init();
        editExamSetting.initData();
    });
</script>