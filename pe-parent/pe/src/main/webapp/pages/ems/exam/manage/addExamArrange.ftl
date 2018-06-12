<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
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
    </ul>
</div>
<form id="examArrangeForm" class="validate" action="javascript:;">
    <section class="steps-all-panel">
        <div class="add-exam-top-head">
            <ul class="over-flow-hide step-items-wrap <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-step-state</#if>">
                <li class="add-paper-step-item floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover basic-step-item<#else>step-complete</#if>"
                    style="text-align:left;"><#--#b8ecaa-->
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
                <li class="add-paper-step-item add-paper-step-two  overStep  floatL">
                    <div class="add-step-icon-wrap">
                        <div class="add-step-line add-step-two-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">3</span>
                     </span>
                        <div class="add-step-line"></div>
                    </div>
                    <span class="add-step-text">考试安排</span>
                </li>
                <li class="add-paper-step-item add-paper-step-three floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover setting-step-item</#if>">
                    <div class="add-step-icon-wrap">
                        <div class="add-step-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">4</span>
                     </span>
                    </div>
                    <span class="add-step-text">考试设置</span>
                </li>
            </ul>
        </div>
        <div class="add-exam-main-panel add-exam-step-three-wrap">
            <div class="arrange-items-wrap">

            </div>
        <#if exam.status == 'DRAFT'>
            <div class="many-batch-add-btn" style="display:none;">
                <button type="button" class="pe-add-paper-add-btn"><span
                        class="iconfont icon-new-add"></span>添加批次
                </button>
            </div>
        </#if>
        </div>
    </section>
    <div class="pe-btns-group-wrap" style="text-align:center;">
    <#if exam.status == 'DRAFT' || exam.status == 'NO_START' || exam.status == 'PROCESS' || exam.status == 'OVER'>
        <#if exam.optType?? && exam.optType == 'VIEW' && canEdit?? && canEdit>
            <div class="view-exam-group-one">
                <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-basic" style="display:none;">保存
                </button>
                <#if exam.source?? && exam.source == 'ADD'>
                    <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
                <#else >
                    <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
                </#if>
                <#if exam.status !='OVER'>
                    <a href="javascript:;" class="pe-view-user-btn i-need-edit-exam"><span
                            class="iconfont icon-edit"></span>我要编辑考试信息
                    </a>
                </#if>
            </div>
        <#else>
            <#if exam.optType?? && exam.optType == 'UPDATE'>
                <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-basic">保存</button>
            <#else>
                <button type="button" class="pe-btn pe-btn-purple pe-step-pre-btn">上一步</button>
                <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-next">下一步</button>
            </#if>
            <#if exam.source?? && exam.source == 'ADD'>
                <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
            <#else>
                <button type="button" class="pe-btn pe-btn-white pe-large-btn pe-step-back-btn">返回</button>
            </#if>
        </#if>
    </#if>
    </div>
</form>
<#--预览单批次模板-->
<script type="text/template" id="previewSingleExamArrange">
    <%if (examArrange && !examArrange.startTime && !examArrange.endTime){%>
    暂无
    <%} else {%>
    <div class="add-exam-item-wrap  preview-single-batch-wrap">
        <div class="pe-stand-form-cell">
            <div class="pe-time-wrap">
                <span class="pe-label-name floatL">考试开始时间:</span>
                <div class="pe-date-wrap">
                    <%=examArrange.startTime?moment(examArrange.startTime).format('YYYY-MM-DD HH:mm'):"暂无"%>
                </div>
            </div>
        </div>
        <div class="pe-stand-form-cell">
            <div class="pe-time-wrap">
                <span class="pe-label-name floatL">考试结束时间:</span>
                <div class="pe-date-wrap">
                    <%=examArrange.endTime?moment(examArrange.endTime).format('YYYY-MM-DD HH:mm'):"暂无"%>
                </div>
            </div>
        </div>
        <div class="pe-stand-form-cell">
            <label class="pe-form-label" style="margin-right:0;">
                <span class="pe-label-name floatL">考生设置:</span>
                <div class="exam-add-user-wrap">
                    <%var userCount = examArrange.typeCountMap?(examArrange.typeCountMap['USER']?examArrange.typeCountMap['USER']:0):0;%>
                    <%var orgCount = examArrange.typeCountMap?(examArrange.typeCountMap['ORGANIZE']?examArrange.typeCountMap['ORGANIZE']:0):0;%>
                                <span class="exam-has-added-user-num">
                                    <%if (userCount >0) {%>
                                        <a href="${ctx!}/ems/exam/manage/initUserPage?id=<%=examArrange.id%>&optType=<%=optType%>"
                                           target="_blank"><%=userCount%></a>人
                                    <%}%>
                                    <%if (userCount >0 && orgCount >0) {%>
                                    +
                                    <%}%>
                                    <%if (orgCount >0) {%>
                                        <a href="${ctx!}/ems/exam/manage/initAddOrganize?id=<%=examArrange.id%>&optType=<%=optType%>"
                                           target="_blank"><%=orgCount%></a>个组织
                                    <%}%>
                                    <%if (userCount <= 0 && orgCount <= 0) {%>
                                    --
                                    <%}%>
                                </span>
                </div>
            </label>
        </div>
        <#if exam.examType == 'ONLINE'>
            <@authVerify authCode="VERSION_OF_INVIGILATOR_SETTING">
            <div class="pe-stand-form-cell">
                <label class="pe-form-label" style="margin-right:0;">
                    <span class="pe-label-name floatL">监考员设置:</span>
                    <div class="exam-add-user-wrap" style="width: auto;">
                        <div id="arrangeMonitor<%=examArrange.id%>" style="float: left;" data-index="0">
                            <%if (examArrange.monitorUsers && examArrange.monitorUsers.length >0 ) {%>
                            <%_.each(examArrange.monitorUsers,function(monitorUser,index){%>
                            <div class="pe-paper-item paper-bank-item" style="padding: 0;">
                                <%if (index!=0) {%>
                                、
                                <%}%>
                                <%=monitorUser.userName%>
                            </div>
                            <%});%>
                            <%} else {%>
                            --
                            <%}%>
                        </div>
                    </div>
                </label>
            </div>
            </@authVerify>
        </#if>
    </div>
    <%}%>
</script>
<#--编辑单批次模板-->
<script type="text/template" id="editSingleExamArrange">
    <div class="arrange-item single-batch-model">
        <input type="hidden" name="examArranges[0].id" value="<%=examArrange.id%>"/>
        <input type="hidden" name="examArranges[0].batchName" value="<%=examArrange.batchName%>"/>
    <#if exam?? && exam.status?? && exam.status == 'DRAFT'>
        <div class="add-many-batch-btn show-many-batch-btn">
            <span class="iconfont icon-set-more-batch"></span>&nbsp;安排多批次考试
        </div>
    </#if>
    <div class="add-exam-item-wrap" style="border: 0;">
        <div class="pe-stand-form-cell">
            <div class="pe-time-wrap">
                <span class="pe-label-name floatL"><span style="color:#f00;">*</span>考试开始时间:</span>
                <div class="pe-date-wrap">
                <#if exam?? && exam.status?? && (exam.status == 'NO_START' || exam.status == 'DRAFT')>
                    <input id="peExamDialogStartTime" data-suiindex = 'single'
                           class="pe-table-form-text pe-time-text sui-date-picker pe-start-time laydate-icon"
                           type="text" name="examArranges[0].startTime"   data-toggle='datepicker' data-date-timepicker='true'
                           value="<%=examArrange.startTime?moment(examArrange.startTime).format('YYYY-MM-DD HH:mm'):''%>" readonly="readonly">
                <#else>
                    <input name="examArranges[0].startTime" value="<%=examArrange.startTime?moment(examArrange.startTime).format('YYYY-MM-DD HH:mm'):''%>" type="hidden"/>
                    <p style="width: 341px;text-align: left;">
                        <%=examArrange.startTime?moment(examArrange.startTime).format('YYYY-MM-DD HH:mm'):"暂无"%>
                    </p>
                </#if>
                </div>
            </div>
        </div>
        <div class="pe-stand-form-cell">
            <div class="pe-time-wrap">
                <span class="pe-label-name floatL"><span style="color:#f00;">*</span>考试结束时间:</span>
                <div class="pe-date-wrap">
                <#if exam?? && exam.status?? && (exam.status == 'NO_START' || exam.status == 'DRAFT' || exam.status == 'PROCESS')>
                    <input id="peExamDialogEndTime" data-suiindex = 'single'
                           class="pe-table-form-text sui-date-picker pe-time-text pe-end-time laydate-icon"
                           type="text" name="examArranges[0].endTime"  data-toggle='datepicker' data-date-timepicker='true'
                           value="<%=examArrange.endTime?moment(examArrange.endTime).format('YYYY-MM-DD HH:mm'):''%>" readonly="readonly">
                    <#--<span class="iconfont icon-date input-icon"></span>-->
                <#else>
                    <input name="examArranges[0].endTime" value="<%=examArrange.endTime?moment(examArrange.endTime).format('YYYY-MM-DD HH:mm'):''%>" type="hidden"/>
                    <p style="width: 341px;text-align: left;"><%=examArrange.endTime?moment(examArrange.endTime).format('YYYY-MM-DD HH:mm'):"暂无"%></p>
                </#if>
                </div>
            </div>
        </div>
        <div class="pe-stand-form-cell" style="margin-bottom: 0;">
            <label class="pe-form-label" style="margin-right:0;">
                <span class="pe-label-name floatL">考生设置:</span>
                <div class="exam-add-user-wrap">
                    <%var userCount = examArrange.typeCountMap?(examArrange.typeCountMap['USER']?examArrange.typeCountMap['USER']:0):0;%>
                    <%var orgCount = examArrange.typeCountMap?(examArrange.typeCountMap['ORGANIZE']?examArrange.typeCountMap['ORGANIZE']:0):0;%>
                        <span class="exam-has-added-user-num" <%if (userCount <= 0 && orgCount <= 0) {%>style="display:none;"<%}%>>
                          <span <%if (userCount <= 0) {%> style="display:none;" <%}%>>
                           <a id="USER_<%=examArrange.id%>"
                           <#if exam.status == 'NO_START' || exam.status == 'DRAFT' || exam.status == 'PROCESS'>
                              href="${ctx!}/ems/exam/manage/initUserPage?id=<%=examArrange.id%>"
                              target="_blank"
                           </#if>><%=userCount%></a>人
                         </span>

                        <span class="count-link" <%if (userCount <=0 || orgCount <=0) {%>
                        style="display:none;" <%}%>>+</span>
                        <span <%if (orgCount <= 0) {%> style="display:none;" <%}%>>
                        <a id="ORGANIZE_<%=examArrange.id%>"
                        <#if exam.status == 'NO_START' || exam.status == 'DRAFT' || exam.status == 'PROCESS'>
                           href="${ctx!}/ems/exam/manage/initAddOrganize?id=<%=examArrange.id%>"
                           target="_blank"
                        </#if>><%=orgCount%></a>个组织
                        </span>
                        </span>
                    <#if exam.status == 'DRAFT'>
                        <a data-id="<%=examArrange.id%>" href="javascript:;"
                           class="exam-add-new-user arrange-add" <%if (userCount <= 0 && orgCount <=0) {%>style="margin-left:0;"<%}%>>添加考生</a>
                    </#if>
                    </div>
                </label>
            </div>
            <#if exam.examType == 'ONLINE'>
                <@authVerify authCode="VERSION_OF_INVIGILATOR_SETTING">
                <div class="pe-stand-form-cell">
                    <label class="pe-form-label" style="margin-right:0;">
                        <span class="pe-label-name floatL">监考员设置:</span>
                        <div class="exam-add-user-wrap" style="width: auto;">
                            <div id="arrangeMonitor<%=examArrange.id%>" style="float: left;" data-index="0">
                                <%if (examArrange.monitorUsers && examArrange.monitorUsers.length >0 ) {%>
                                <%_.each(examArrange.monitorUsers,function(monitorUser){%>
                                <div class="pe-paper-item paper-bank-item" style="padding: 0;">
                                    <a class="add-question-bank-item bank-list" data-id="<%=monitorUser.id%>"
                                       title="<%=monitorUser.userName%>" data-login="<%=monitorUser.loginName%>">
                                        <span class="paper-random-bank"><%=monitorUser.userName%></span>
                                        <span class="iconfont icon-inputDele ">
                                        <input type="hidden" name="examArranges[0].monitorUserIds" value="<%=monitorUser.id%>"/>
                                    </span>
                                    </a>
                                </div>
                                <%});%>
                                <%}%>
                            </div>
                            <div class="pe-paper-item paper-bank-item" style="padding: 0;">
                                <a data-id="<%=examArrange.id%>" href="javascript:;"
                                   class="exam-add-new-user exam-add-monitor-user">添加监考员</a>
                            </div>
                        </div>
                    </label>
                </div>
                </@authVerify>
            </#if>
        </div>
    </div>
</script>
<#--预览多批次模板-->
<script type="text/template" id="previewExamArrange">
    <%_.each(examArranges,function(examArrange,index){%>
    <div class="arrange-item preview-many-batchs-wrap">
        <div class="add-exam-item-wrap">
            <div class="pe-stand-form-cell many-batchs-top-name">
                <span class="iconfont icon-batch"></span>
                <%=examArrange.batchName%>
            </div>
            <div class="pe-stand-form-cell">
                <div class="pe-time-wrap">
                    <span class="pe-label-name floatL">考试开始时间:</span>
                    <div class="pe-date-wrap">
                        <%=examArrange.startTime?moment(examArrange.startTime).format('YYYY-MM-DD HH:mm'):"暂无"%>
                    </div>
                </div>
            </div>
            <div class="pe-stand-form-cell">
                <div class="pe-time-wrap">
                    <span class="pe-label-name floatL">考试结束时间:</span>
                    <div class="pe-date-wrap">
                        <%=examArrange.endTime?moment(examArrange.endTime).format('YYYY-MM-DD HH:mm'):"暂无"%>
                    </div>
                </div>
            </div>
            <div class="pe-stand-form-cell">
                <label class="pe-form-label" style="margin-right:0;">
                    <span class="pe-label-name floatL">考生设置:</span>
                    <div class="exam-add-user-wrap">
                                <span class="exam-has-added-user-num">
                                    <%var userCount = examArrange.typeCountMap?(examArrange.typeCountMap['USER']?examArrange.typeCountMap['USER']:0):0;%>
                    <%var orgCount = examArrange.typeCountMap?(examArrange.typeCountMap['ORGANIZE']?examArrange.typeCountMap['ORGANIZE']:0):0;%>
                                    <%if (userCount > 0) {%>
                                        <a href="${ctx!}/ems/exam/manage/initUserPage?id=<%=examArrange.id%>&optType=<%=optType%>"
                                           target="_blank"><%=userCount%></a>人
                                    <%}%>
                                    <%if (userCount >0 && orgCount >0) {%>
                                    +
                                    <%}%>
                                    <%if (orgCount >0) {%>
                                        <a href="${ctx!}/ems/exam/manage/initAddOrganize?id=<%=examArrange.id%>&optType=<%=optType%>"
                                           target="_blank"><%=orgCount%></a>个组织
                                    <%}%>
                                    <%if (userCount <= 0 && orgCount <= 0) {%>
                                    --
                                    <%}%>
                                </span>
                    </div>
                </label>
            </div>
            <#if exam.examType == 'ONLINE'>
                <@authVerify authCode="VERSION_OF_INVIGILATOR_SETTING">
                <div class="pe-stand-form-cell">
                    <label class="pe-form-label" style="margin-right:0;">
                        <span class="pe-label-name floatL">监考员设置:</span>
                        <div class="exam-add-user-wrap" style="width: auto;">
                            <div id="arrangeMonitor<%=examArrange.id%>" style="float: left;" data-index="0">
                                <%if (examArrange.monitorUsers && examArrange.monitorUsers.length >0 ) {%>
                                <%_.each(examArrange.monitorUsers,function(monitorUser,index){%>
                                <div class="pe-paper-item paper-bank-item" style="padding: 0;">
                                    <%if (index!=0) {%>
                                    、
                                    <%}%>
                                    <%=monitorUser.userName%>
                                </div>
                                <%});%>
                                <%} else {%>
                                --
                                <%}%>
                            </div>
                        </div>
                    </label>
                </div>
                </@authVerify>
            </#if>
        </div>
    </div>
    <%});%>
</script>
<#--我要编辑批次考试模板及初始化有批次考试-->
<script type="text/template" id="editExamArrange">
    <%_.each(examArranges,function(examArrange,index){%>
    <div class="arrange-item">
        <input type="hidden" name="examArranges[<%=index%>].id" value="<%=examArrange.id%>"/>
    <#if exam.status == 'DRAFT'>
        <a class="arrange-remove-batch-btn" style="margin:6px;">
                                    <span class="iconfont icon-dialog-close-btn delete-batch"
                                          data-id="<%=examArrange.id%>"></span>
                    </a>
                </#if>
                <div class="add-exam-item-wrap">
                    <div class="pe-stand-form-cell">
                        <div class="pe-time-wrap">
                                        <span class="pe-label-name floatL"><span
                                                style="color:#f00;">*</span>批次名称:</span>
                    <div class="pe-date-wrap">
                    <#if exam.status == 'DRAFT'>
                        <input class="pe-table-form-text pe-batch-text pe-start-time"
                               type="text" name="examArranges[<%=index%>].batchName"
                               value="<%=examArrange.batchName%>" maxlength="50">
                    <#else>
                        <%if (examArrange.arrangeStatus === 'NO_START' || examArrange.arrangeStatus === 'PROCESS') {%>
                        <input name="examArranges[<%=index%>].batchName" value="<%=examArrange.batchName%>"
                               type="hidden"/>
                        <%}%>
                        <p style="width: 341px;text-align: left;"><%=examArrange.batchName%></p>
                    </#if>

                            </div>
                        </div>
                    </div>
                    <div class="pe-stand-form-cell">
                        <div class="pe-time-wrap">
                                        <span class="pe-label-name floatL"><span
                                                style="color:#f00;">*</span>考试开始时间:</span>
                            <div class="pe-date-wrap">
                                <%if ('${(exam.status)!}' === 'PROCESS') {%>
                                    <%if (examArrange.arrangeStatus === 'NO_START') {%>
                                        <input id="peExamDialogStartTime<%=index%>" data-suiindex = '<%=index%>'
                                               class="pe-table-form-text pe-time-text  sui-date-picker  pe-start-time laydate-icon"
                                               type="text" name="examArranges[<%=index%>].startTime"  data-toggle='datepicker' data-date-timepicker='true'
                                               value="<%=examArrange.startTime?moment(examArrange.startTime).format('YYYY-MM-DD HH:mm'):''%>" readonly="readonly">
                                    <%} else {%>
                                        <input name="examArranges[<%=index%>].startTime" value="<%=examArrange.startTime?moment(examArrange.startTime).format('YYYY-MM-DD HH:mm'):''%>" type="hidden"/>
                                        <p style="width: 341px;text-align: left;"><%=examArrange.startTime?moment(examArrange.startTime).format('YYYY-MM-DD HH:mm'):''%></p>
                                    <%}%>
                                <%} else {%>
                                <#if exam?? && exam.status?? && (exam.status == 'NO_START' || exam.status == 'DRAFT')>
                                    <input id="peExamDialogStartTime<%=index%>" data-suiindex = '<%=index%>'
                                           class="pe-table-form-text sui-date-picker pe-time-text pe-start-time laydate-icon"
                                           type="text" name="examArranges[<%=index%>].startTime"  data-toggle='datepicker' data-date-timepicker='true'
                                           value="<%=examArrange.startTime?moment(examArrange.startTime).format('YYYY-MM-DD HH:mm'):''%>" readonly="readonly">
                                <#else>
                                    <input name="examArranges[<%=index%>].startTime" value="<%=examArrange.startTime?moment(examArrange.startTime).format('YYYY-MM-DD HH:mm'):''%>" type="hidden"/>
                                    <p style="width: 341px;text-align: left;"><%=examArrange.startTime?moment(examArrange.startTime).format('YYYY-MM-DD HH:mm'):''%></p>
                                </#if>
                                <%}%>
                            </div>
                        </div>
                    </div>
                    <div class="pe-stand-form-cell">
                        <div class="pe-time-wrap">
                                        <span class="pe-label-name floatL"><span
                                                style="color:#f00;">*</span>考试结束时间:</span>
                            <div class="pe-date-wrap">
                                <%if ('${(exam.status)!}' === 'PROCESS') {%>
                                    <%if (examArrange.arrangeStatus === 'NO_START' || examArrange.arrangeStatus === 'PROCESS') {%>
                                    <input id="peExamDialogEndTime<%=index%>" data-suiindex = '<%=index%>'
                                           class="pe-table-form-text  sui-date-picker pe-time-text pe-end-time laydate-icon"
                                           type="text" name="examArranges[<%=index%>].endTime"  data-toggle='datepicker' data-date-timepicker='true'
                                           value="<%=examArrange.endTime?moment(examArrange.endTime).format('YYYY-MM-DD HH:mm'):''%>" readonly="readonly">
                                    <%} else {%>
                                    <input name="examArranges[<%=index%>].endTime" value="<%=examArrange.endTime?moment(examArrange.endTime).format('YYYY-MM-DD HH:mm'):''%>" type="hidden"/>
                                    <p style="width: 341px;text-align: left;"><%=examArrange.endTime?moment(examArrange.endTime).format('YYYY-MM-DD HH:mm'):''%></p>
                                    <%}%>
                                <%} else {%>
                                <#if exam?? && exam.status?? && (exam.status == 'NO_START' || exam.status == 'DRAFT')>
                                    <input id="peExamDialogEndTime<%=index%>" data-suiindex = '<%=index%>'
                                           class="pe-table-form-text  sui-date-picker pe-time-text pe-end-time laydate-icon"
                                           type="text" name="examArranges[<%=index%>].endTime"  data-toggle='datepicker' data-date-timepicker='true'
                                           value="<%=examArrange.endTime?moment(examArrange.endTime).format('YYYY-MM-DD HH:mm'):''%>" readonly="readonly">
                                <#else>
                                    <p style="width: 341px;text-align: left;"><%=examArrange.endTime?moment(examArrange.endTime).format('YYYY-MM-DD HH:mm'):''%></p>
                                </#if>
                                <%}%>
                            </div>
                        </div>
                    </div>
                    <div class="pe-stand-form-cell">
                        <label class="pe-form-label" style="margin-right:0;">
                            <span class="pe-label-name floatL">考生设置:</span>
                            <div class="exam-add-user-wrap">
                                <%var userCount = examArrange.typeCountMap?(examArrange.typeCountMap['USER']?examArrange.typeCountMap['USER']:0):0;%>
                                <%var orgCount = examArrange.typeCountMap?(examArrange.typeCountMap['ORGANIZE']?examArrange.typeCountMap['ORGANIZE']:0):0;%>
                                <span class="exam-has-added-user-num"  <%if (userCount <= 0 && orgCount <= 0) {%>style="display:none;"<%}%>>
                                    <span <%if (userCount <=0) {%> style="display:none;" <%}%>>
                                      <a id="USER_<%=examArrange.id%>"
                                        <#if exam.status == 'NO_START' || exam.status == 'DRAFT' || exam.status == 'PROCESS'>
                                            href="${ctx!}/ems/exam/manage/initUserPage?id=<%=examArrange.id%>"
                                            target="_blank"
                                         </#if>
                                      ><%=userCount%></a>人
                                    </span>
                                    <span class="count-link" <%if (userCount <=0 || orgCount <= 0) {%> style="display:none;" <%}%>>+</span>
                                    <span <%if (orgCount <=0) {%> style="display:none;" <%}%>>
                                       <a id="ORGANIZE_<%=examArrange.id%>"
                                              <#if exam.status == 'NO_START' || exam.status == 'DRAFT' || exam.status == 'PROCESS'>
                                                   href="${ctx!}/ems/exam/manage/initAddOrganize?id=<%=examArrange.id%>"
                                                   target="_blank"
                                              </#if>
                                            ><%=orgCount%></a>个组织
                                    </span>
                                </span>
                                <#if exam.status == 'DRAFT'>
                                    <a data-id="<%=examArrange.id%>" href="javascript:;"
                                       class="exam-add-new-user arrange-add">添加考生</a>
                                </#if>
                            </div>
                        </label>
                    </div>
                    <#if exam.examType == 'ONLINE'>
                        <@authVerify authCode="VERSION_OF_INVIGILATOR_SETTING">
                        <div class="pe-stand-form-cell">
                            <label class="pe-form-label" style="margin-right:0;">
                                <span class="pe-label-name floatL">监考员设置:</span>
                                <div class="exam-add-user-wrap" style="width: auto;">
                                    <div id="arrangeMonitor<%=examArrange.id%>" style="float: left;"
                                         data-index="<%=index%>">
                                        <%if (examArrange.monitorUsers && examArrange.monitorUsers.length >0 ) {%>
                                        <%_.each(examArrange.monitorUsers,function(monitorUser){%>
                                        <div class="pe-paper-item paper-bank-item" style="padding: 0;">
                                            <a class="add-question-bank-item bank-list" data-id="<%=monitorUser.id%>"
                                               title="<%=monitorUser.userName%>"
                                               data-login="<%=monitorUser.loginName%>">
                                                <span class="paper-random-bank"><%=monitorUser.userName%></span>
                                                <%if (examArrange.status === 'DRAFT' || examArrange.status ===
                                                'NO_START' || examArrange.status === 'PROCESS') {%>
                                                <span class="iconfont icon-inputDele ">
                                                <input type="hidden" name="examArranges[<%=index%>].monitorUserIds" value="<%=monitorUser.id%>"/>
                                            </span>
                                                <%}%>
                                            </a>
                                        </div>
                                        <%});%>
                                        <%}%>
                                    </div>
                                    <%if (examArrange.arrangeStatus === 'DRAFT' || examArrange.arrangeStatus ===
                                    'NO_START' || examArrange.arrangeStatus === 'PROCESS') {%>
                                    <div class="pe-paper-item paper-bank-item" style="padding: 0;">
                                        <a data-id="<%=examArrange.id%>" href="javascript:;"
                                           class="exam-add-new-user exam-add-monitor-user">添加监考员</a>
                                    </div>
                                    <%}%>
                                </div>
                            </label>
                        </div>
                        </@authVerify>
                    </#if>
                </div>
            </div>
    <%});%>
</script>
<script type="text/template" id="monitorTemplate">
    <%_.each(data,function(user){%>
    <div class="pe-paper-item paper-bank-item" style="padding: 0;">
        <a class="add-question-bank-item bank-list" data-id="<%=user.id%>" title="<%=user.userName%>" data-login="<%=user.loginName%>">
            <span class="paper-random-bank"><%=user.userName%></span>
            <span class="iconfont icon-inputDele ">
                <input type="hidden" name="examArranges[<%=index%>].monitorUserIds" value="<%=user.id%>"/>
            </span>
        </a>
    </div>
    <%});%>
</script>
<#--点击我要安排更多批次,及新增批次模板-->
<script type="text/template" id="manyBatchTemp">
    <div class="arrange-item many-batchs-arrange-item">
        <input type="hidden" name="examArranges[<%=index%>].id" value="<%=examArrange.id%>"/>
        <a href="javascript:;" class="arrange-remove-batch-btn">
            <span class="iconfont icon-dialog-close-btn delete-batch" data-id="<%=examArrange.id%>"></span>
        </a>
        <div class="add-exam-item-wrap">
            <div class="pe-stand-form-cell">
                <div class="pe-time-wrap">
                    <span class="pe-label-name floatL"><span style="color:#f00;">*</span>批次名称:</span>
                    <div class="pe-date-wrap">
                        <input class="pe-table-form-text pe-batch-text pe-start-time"
                               type="text" name="examArranges[<%=index%>].batchName"
                               value="<%=examArrange.batchName%>">
                    </div>
                </div>
            </div>
            <div class="pe-stand-form-cell">
                <div class="pe-time-wrap">
                    <span class="pe-label-name floatL"><span style="color:#f00;">*</span>考试开始时间:</span>
                    <div class="pe-date-wrap">
                        <input id="peExamDialogStartTime<%=index%>" data-suiindex = '<%=index%>'
                               class="pe-table-form-text  sui-date-picker  pe-time-text pe-start-time laydate-icon"
                               type="text" name="examArranges[<%=index%>].startTime"  data-toggle='datepicker' data-date-timepicker='true'
                               value="<%=examArrange.startTime?moment(examArrange.startTime).format('YYYY-MM-DD HH:mm'):''%>" readonly="readonly">
                    </div>
                </div>
            </div>
            <div class="pe-stand-form-cell">
                <div class="pe-time-wrap">
                    <span class="pe-label-name floatL"><span style="color:#f00;">*</span>考试结束时间:</span>
                    <div class="pe-date-wrap">
                        <input id="peExamDialogEndTime<%=index%>" data-suiindex = '<%=index%>'
                               class="pe-table-form-text  sui-date-picker pe-time-text pe-end-time laydate-icon"
                               type="text" name="examArranges[<%=index%>].endTime"  data-toggle='datepicker' data-date-timepicker='true'
                               value="<%=examArrange.endTime?moment(examArrange.endTime).format('YYYY-MM-DD HH:mm'):''%>" readonly="readonly">
                    </div>
                </div>
            </div>
            <div class="pe-stand-form-cell">
                <label class="pe-form-label" style="margin-right:0;">
                    <span class="pe-label-name floatL">考试设置:</span>
                    <div class="exam-add-user-wrap">
                        <%var userCount = examArrange.typeCountMap?(examArrange.typeCountMap['USER']?examArrange.typeCountMap['USER']:0):0;%>
                        <%var orgCount = examArrange.typeCountMap?(examArrange.typeCountMap['ORGANIZE']?examArrange.typeCountMap['ORGANIZE']:0):0;%>
                        <span class="exam-has-added-user-num" <%if (userCount <= 0 && orgCount <= 0) {%>style="display:none;"<%}%>>
                        <span <%if (userCount <=0) {%> style="display:none;" <%}%>>
                        <a id="USER_<%=examArrange.id%>"
                           href="${ctx!}/ems/exam/manage/initUserPage?id=<%=examArrange.id%>"
                           target="_blank"><%=userCount%></a>人
                        </span>
                        <span class="count-link" <%if (userCount <=0 || orgCount <= 0) {%> style="display:none;" <%}%>>+</span>
                        <span <%if (orgCount <=0) {%> style="display:none;" <%}%>>
                        <a id="ORGANIZE_<%=examArrange.id%>"
                           href="${ctx!}/ems/exam/manage/initAddOrganize?id=<%=examArrange.id%>"
                           target="_blank"><%=orgCount%></a>个组织
                        </span>
                        </span>
                    <#if exam.status == 'DRAFT'>
                        <a data-id="<%=examArrange.id%>" href="javascript:;" class="exam-add-new-user arrange-add">添加考生</a>
                    </#if>
                    </div>
                </label>
            </div>
            <#if exam.examType == 'ONLINE'>
                <@authVerify authCode="VERSION_OF_INVIGILATOR_SETTING">
                <div class="pe-stand-form-cell">
                    <label class="pe-form-label" style="margin-right:0;">
                        <span class="pe-label-name floatL">监考员设置:</span>
                        <div class="exam-add-user-wrap" style="width: auto;">
                            <div id="arrangeMonitor<%=examArrange.id%>" style="float: left;" data-index="<%=index%>">
                                <%if (examArrange.monitorUsers && examArrange.monitorUsers.length >0 ) {%>
                                <%_.each(examArrange.monitorUsers,function(monitorUser){%>
                                <div class="pe-paper-item paper-bank-item" style="padding: 0;">
                                    <a class="add-question-bank-item bank-list" data-id="<%=monitorUser.id%>"
                                       title="<%=monitorUser.userName%>" data-login="<%=monitorUser.loginName%>">
                                        <span class="paper-random-bank"><%=monitorUser.userName%></span>
                                        <span class="iconfont icon-inputDele ">
                                        <input type="hidden" name="examArranges[<%=index%>]].monitorUserIds" value="<%=monitorUser.id%>"/>
                                    </span>
                                    </a>
                                </div>
                                <%});%>
                                <%}%>
                            </div>
                            <div class="pe-paper-item paper-bank-item" style="padding: 0;">
                                <a data-id="<%=examArrange.id%>" href="javascript:;"
                                   class="exam-add-new-user exam-add-monitor-user">添加监考员</a>
                            </div>
                        </div>
                    </label>
                </div>
                </@authVerify>
            </#if>
        </div>
    </div>
</script>
<script>
    //sumbit提交时校验时间
    $(function () {
        var optType = '${(exam.optType)!}';
        var source = '${(exam.source)!}';
        var editArrange = {
            validateObj: {},
            examId : '${(exam.id)!}',
            checkTime: function (startDom, endDom) {
                var $endDom = $(endDom);
                var $startDom = $(startDom);
                if ($endDom.get(0)) {
                    var endTime = moment($(endDom).val()).valueOf();
                } else {
                    endTime = '';
                }
                if ($startDom.get(0)) {
                    var startTime = moment($(startDom).val()).valueOf();
                } else {
                    startTime = '';
                }

                var nowTime = new Date().getTime();//选择日期点击时的当前时间
                if (startTime && startTime < nowTime) {
                    if (!$startDom.siblings('.error').get(0)) {
                        $startDom.addClass('error').after('<em id="' + $startDom.attr("name") + '-error" class="error">开始时间不能小于当前时间哦</em>')
                    } else {
                        $startDom.addClass('error');
                        $startDom.siblings('.error').show().html('开始时间不能小于当前时间哦');
                    }
                    return false;

                } else if (endTime && endTime < nowTime) {
                    if (!$endDom.siblings('.error').get(0)) {
                        $endDom.addClass('error').after('<em id="' + $endDom.attr("name") + '-error" class="error">结束时间不能小于当前时间哦</em>');
                    } else {
                        $endDom.addClass('error');
                        $endDom.siblings('.error').show().html('结束时间不能小于当前时间哦');
                    }
                    return false;
                } else if (startTime && endTime && startTime > endTime) {
                    if (!$startDom.siblings('.error').get(0)) {
                        $startDom.addClass('error').after('<em id="' + $startDom.attr("name") + '-error" class="error">开始时间不能大于结束时间哦</em>')
                    } else {
                        $startDom.addClass('error');
                        $startDom.siblings('.error').show().html('开始时间不能大于结束时间哦');
                    }
                    return false;
                } else {
                    if ($endDom.siblings('.error').get(0)) {
                        $endDom.siblings('.error').html('').hide();
                    }
                    $endDom.removeClass('error');

                    if ($startDom.siblings('.error').get(0)) {
                        $startDom.siblings('.error').html('').hide();
                    }
                    $startDom.removeClass('error');
                    return true;
                }

            },
            getInputName: function (dom) {
                var itemInputs = $(dom).find('input[type="text"]');
                var itemNames = [];
                for (var j = 0, len = itemInputs.length; j < len; j++) {
                    itemNames.push($(itemInputs[j]).attr('name'))
                }
                editArrange.validateObj = editArrange.produceValidateObj(itemNames);
            },
            produceValidateObj: function (names) {
                var thisValidateObj = {
                    errorElement: 'em',
                    rules: {},
                    messages: {}
                };
                for (var i = 0; i < names.length; i++) {
                    thisValidateObj.rules[names[i]] = 'required';
                    var batchNameReg = /batchName/i;
                    var startTimeReg = /startTime/i;
                    var endTimeReg = /endTime/i;
                    if (batchNameReg.test(names[i])) {
                        thisValidateObj.messages[names[i]] = '批次名称不能为空哦';
                    } else if (startTimeReg.test(names[i])) {
                        thisValidateObj.messages[names[i]] = '开始时间不能为空哦';
                    } else {
                        thisValidateObj.messages[names[i]] = '结束时间不能为空哦';
                    }
                }

                return thisValidateObj;
            },
            validateFunc: function () {
                /*校验默认设置对象，这里有对表单验证通过后所执行的一些方法*/
                var defaultValidate = {
                    errorElement: 'em',
                    ignore: "",
                    submitHandler: function (form) {

                    }
                };
                var formValidate = $.extend(defaultValidate, editArrange.validateObj);
                /*校验*/
                if ($.data($('#examArrangeForm').get(0), "validator")) {
                    /*对validate不对新增的input进行校验的问题处理*/
                    $('#examArrangeForm').data('validator', '');
                }
                $("#examArrangeForm").validate(formValidate);
            },
            submitForm: function (callback) {
                var hasErrorCount = 0;
                var $arrange = $('.arrange-item');
                var batchLength = $arrange.length;
                $arrange.each(function (index, ele) {
                    $(ele).find('input[name^="examArranges"]').each(function (cIndex, cEle) {
                        var nameValue = $(this).attr('name');
                        var pointIndex = nameValue.indexOf(".");
                        nameValue = "examArranges[" + index + "]" + nameValue.substr(pointIndex);
                        $(this).attr('name', nameValue);

                    });

                    if (batchLength === 1) {
                        index = '';
                    }

                    var startDom = '#peExamDialogStartTime' + index;
                    var endDom = '#peExamDialogEndTime' + index;
                    if (!editArrange.checkTime(startDom, endDom)) {
                        hasErrorCount++;
                    }
                });

                if (hasErrorCount) {
                    return false;
                }

                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/manage/updateArrange',
                    data: $('#examArrangeForm').serialize(),
                    success: function (data) {
                        if (data.success) {
                            callback(data);
                            return false;
                        }

                        PEMO.DIALOG.alert({
                            content: data.message
                        });
                    }
                });
            },
            init: function () {
                var _this = this;
                _this.initData();
                _this.bind();
            },

            listExamArrange:function (callback) {
                PEBASE.ajaxRequest({
                    url : pageContext.rootPath + '/ems/exam/manage/listExamArrange',
                    data:{examId:editArrange.examId},
                    success:function (data) {
                        if(callback){
                            callback(data);
                        }
                    }
                })
            },

            initData: function () {
                var _this = this;
                _this.listExamArrange(function (examArranges) {
                    if (optType === 'VIEW') {
                        if (examArranges.length === 1) {
                            $('.arrange-items-wrap').html(_.template($('#previewSingleExamArrange').html())({
                                examArrange: examArranges[0],
                                optType: optType
                            }));
                        } else {
                            $('.arrange-items-wrap').html(_.template($('#previewExamArrange').html())({
                                examArranges: examArranges,
                                optType: optType
                            }));
                        }

                    } else {
                        if (examArranges.length === 1) {
                            $('.arrange-items-wrap').html(_.template($('#editSingleExamArrange').html())({examArrange: examArranges[0]})).addClass('edit-single-batch');
                            $('.many-batch-add-btn').hide();
                        } else {
                            $('.arrange-items-wrap').html(_.template($('#editExamArrange').html())({examArranges: examArranges}));
                            $('.many-batch-add-btn').show();
                        }

                    }
                });

                /*设置检验规则对象*/
                editArrange.getInputName('.arrange-items-wrap');
                editArrange.validateFunc();
            },

            bind: function () {
                var $window = $(window);
                /*自定义了时间插件消失的 “事件”,在sui_datepicker.js里面会触发这个事件;*/
                $window.bind("datePickerHide", function (e,t) {
                    if(t){
                        var _thisInput = $(t.element[0]);
                        var startDomName = '',endDomName = '';
                        if(_thisInput.attr('data-suiindex') === 'single'){
                            startDomName = '#peExamDialogStartTime';
                            endDomName = '#peExamDialogEndTime';
                        }else{
                            var thisArrangeIndex = _thisInput.attr('data-suiindex');
                            startDomName = '#peExamDialogStartTime' + thisArrangeIndex;
                            endDomName = '#peExamDialogEndTime' + thisArrangeIndex;
                        }
                        if(_thisInput.hasClass('pe-start-time')){
                            startTimeValidate(startDomName,endDomName,_thisInput.val());
                        }else if(_thisInput.hasClass('pe-end-time')){
                            endTimeValidate(startDomName,endDomName,_thisInput.val());
                        }
                    }
                })
                $('.add-exam-step-three-wrap').delegate('.arrange-add', 'click', function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    var _thisExamId = $(this).attr('data-id');
                    window.open("${ctx!}/ems/exam/manage/initUserPage?id=" + _thisExamId, "EXAN_ADD_USER", '');
                });

                $('.add-exam-step-three-wrap').delegate('.exam-add-monitor-user', 'click', function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    var arrangeId = $(this).data('id');
                    var selectorDom = $('#arrangeMonitor' + arrangeId);
                    var examArrangeIndex = $(this).data('index');
                    PEMO.DIALOG.selectorDialog({
                        title: '选择监考员',
                        area: ['870px', '580px'],
                        btn: ['确定', '取消'],
                        content: [pageContext.rootPath + '/ems/exam/manage/initSelectorMonitor?arrangeId='+arrangeId, 'no'],
                        yes: function (index) {
                            var users = [];
                            layer.getChildFrame('.pe-selector-selected').find('tbody tr').each(function (i, e) {
                                users.push({id: $(e).data('id'), userName: $(e).data('name'),loginName:$(e).data('login')});
                            });

                            selectorDom.html(_.template($('#monitorTemplate').html())({data: users,index:examArrangeIndex}));
                            layer.close(index);
                        }
                    });
                });

                $('.add-exam-step-three-wrap').delegate('.icon-inputDele', 'click', function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    $(this).parents('.pe-paper-item').remove();
                });

                $('.pe-table-form-text').keyup(function (e) {
                    var e = e || window.event;
                    return false;
                });

                $('#examArrangeForm').delegate('.delete-batch', 'click', function () {
                    if ($('.arrange-item').length === 1) {
                        PEMO.DIALOG.alert({
                            content: '至少保留一个批次',
                            btn: ['我知道了'],
                            yes: function (shiIndex) {
                                layer.close(shiIndex);
                            }
                        });

                        return false;
                    }

                    var arrangeId = $(this).data('id');
                    var $arrangeItem = $(this).parents('.arrange-item');
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定删除该批次么？</h3></div>',
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/exam/manage/deleteArrange',
                                data: {arrangeId: arrangeId},
                                success: function (data) {
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '删除成功',
                                            time: 1000,
                                            end: function () {
                                                $arrangeItem.remove();
                                            }
                                        });
                                        return false;
                                    }
                                }
                            });
                        },
                        btn1: function () {
                            layer.closeAll();
                        }
                    });
                });

                $('.new-page-close-btn').on('click', function () {
                    window.close();
                });


                $('.add-exam-step-three-wrap').delegate('.arrange-item:not(".single-batch-model")', 'mouseenter', function () {
                    $(this).find('.arrange-remove-batch-btn').show();
                    $(this).addClass('item-hover');
                });

                $('.add-exam-step-three-wrap').delegate('.arrange-item:not(".single-batch-model")', 'mouseleave', function () {
                    $(this).find('.arrange-remove-batch-btn').hide();
                    $(this).removeClass('item-hover');
                });

                $('.arrange-items-wrap').delegate('.show-many-batch-btn', 'click', function () {
                    $('.arrange-items-wrap').removeClass('edit-single-batch');
                    $('.many-batch-add-btn').show();
                    var id = $('input[name="examArranges[0].id"]').val();
                    var data = {
                        id: id,
                        'batchName': $('input[name="examArranges[0].batchName"]').val(),
                        'startTime': $('input[name="examArranges[0].startTime"]').val(),
                        'endTime': $('input[name="examArranges[0].endTime"]').val()
                    };

                    var typeCountMap = {'USER':$('#USER_' + id).text(),"ORGANIZE":$('#ORGANIZE_' + id).text()};
                    data.typeCountMap = typeCountMap;
                    var users = [];
                    data.monitorUsers = users;
                    $('.add-question-bank-item').each(function (i, e) {
                        users.push({id:$(this).data('id'),loginName:$(this).data('login'),userName:$(this).attr('title')});
                    });

                    $('.arrange-items-wrap').html('');
                    var index = $('.add-exam-item-wrap').length;
                    $('.arrange-items-wrap').append(_.template($('#manyBatchTemp').html())({
                        index: index,
                        'examArrange': data
                    }));
                    editArrange.addBatch();
                    /*设置检验规则对象*/
                    editArrange.getInputName('.arrange-items-wrap');
                    editArrange.validateFunc();
                });

                /*添加批次TODO,此处还未完善*/
                $('.pe-add-paper-add-btn').click(function () {
                    var $arranges = $(".arrange-item");
                    if ($arranges.length >= 10) {
                        PEMO.DIALOG.tips({
                            content: '一场考试最多只能添加10个批次！',
                            time: 2000
                        });
                        return false;
                    }
                    editArrange.addBatch();
                });

                //我要编辑考试
                $('.i-need-edit-exam').on('click', function () {
                    var $this = $(this);
                    editArrange.listExamArrange(function (examArranges) {
                        if (examArranges.length === 0) {
                            editArrange.addBatch();
                            return false;
                        }

                        if (examArranges.length === 1) {
                            $('.arrange-items-wrap').html(_.template($('#editSingleExamArrange').html())({examArrange: examArranges[0]})).addClass('edit-single-batch');
                            $('.many-batch-add-btn').hide();
                        } else {
                            $('.arrange-items-wrap').html(_.template($('#editExamArrange').html())({examArranges: examArranges}));
                            $('.many-batch-add-btn').show();
                        }

                        $this.hide();
                        $('.save-basic').show();
                        /*设置检验规则对象*/
                        editArrange.getInputName('.arrange-items-wrap');
                        editArrange.validateFunc();
                    });
                });

                $('.edit-step-state .basic-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamInfo', params);
                });

                $('.edit-step-state .paper-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper', params);
                });

                $('.edit-step-state .setting-step-item').on('click', function () {
                    var examTye = '${(exam.examType)!}';
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    if (examTye === 'OFFLINE') {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initOfflineExamSetting', params);
                    } else if (examTye === 'ONLINE') {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamSetting', params);
                    } else if (examTye == 'COMPREHENSIVE') {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initComprehensiveSetting', params);
                    }
                });

                $('.save-next').on('click', function () {
                    var isVal = $("#examArrangeForm").valid();
                    if (!isVal) {
                        return false;
                    }
                    editArrange.submitForm(function () {
                        var examTye = '${(exam.examType)!}';
                        if (examTye === 'OFFLINE') {
                            var params = {id: '${(exam.id)!}', optType: optType, source: source};
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initOfflineExamSetting', params);
                        } else if (examTye === 'ONLINE') {
                            var params = {id: '${(exam.id)!}', optType: optType, source: source};
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamSetting', params);
                        }
                    });
                });

                $('.pe-step-back-btn').on('click', function () {
                  //  history.back(-1);
                    location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initPage&nav=examMana';
                });

                //上一步
                $(".pe-step-pre-btn").on('click', function () {
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper?id=${(exam.id)!}');
                });

                $('.save-basic').on('click', function () {
                    var isVal = $("#examArrangeForm").valid();
                    if (!isVal) {
                        return false;
                    }

                    editArrange.submitForm(function () {
                        PEMO.DIALOG.tips({
                            content: '编辑成功',
                            end: function () {
                                if (optType === 'VIEW') {
                                    editArrange.renderData();
                                }
                            }
                        });
                    });
                });
            },

            renderData: function () {
                editArrange.listExamArrange(function (examArranges) {
                    if (examArranges.length === 1) {
                        $('.arrange-items-wrap').html(_.template($('#previewSingleExamArrange').html())({
                            examArrange: examArranges[0],
                            optType: optType
                        }));
                    } else {
                        $('.arrange-items-wrap').html(_.template($('#previewExamArrange').html())({
                            examArranges: examArranges,
                            optType: optType
                        }));
                    }

                    $('.save-basic').hide();
                    $('.i-need-edit-exam').show();
                });
            },

            addBatch: function () {
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/manage/saveBatch',
                    data: {'examId': '${(exam.id)!}'},
                    async: false,
                    success: function (data) {
                        if (!data.success) {
                            PEMO.DIALOG.tips({
                                content: data.message
                            });

                            return false;
                        }

                        var index = $('.add-exam-item-wrap').length;
                        $('.arrange-items-wrap').append(_.template($('#manyBatchTemp').html())({
                            index: index,
                            'examArrange': data.data
                        }));
                    }
                });
                /*设置检验规则对象*/
                editArrange.getInputName('.arrange-items-wrap');
                editArrange.validateFunc();
            }
        };

        editArrange.init();
    });

    function countUser(arrangeId, referType) {
        var $this = $('#' + referType + '_' + arrangeId);
        if ($this.parents().is(':hidden')) {
            $this.parents().show();
        }

        PEBASE.ajaxRequest({
            url: pageContext.rootPath + '/ems/exam/manage/countExamUser',
            data: {examId: '${(exam.id)!}', arrangeId: arrangeId, referType: referType},
            success: function (data) {
                if (!$('#USER_' + arrangeId).parents().is(':hidden') && !$('#ORGANIZE_' + arrangeId).parents().is(':hidden')) {
                    $this.parents('span').siblings('.count-link').show();
                }

                $this.text(data);
            }
        });
    }

    /*输出时间对象函数*/
    var dateObjArry = [];
    /*开始时间选择判断*/
    function startTimeValidate(startDom,endDom,chooseTime){
        var $starDom = $(startDom);
        var nowTime = new Date().getTime();//选择日期点击时的当前时间
        var endTime = moment($(endDom).val()).valueOf();
        var chooseTime = moment(chooseTime).valueOf();//当前日历插件选择的时间

        /*小于当前时间校验*/
        if(chooseTime < nowTime) {
            if(!$starDom.siblings('.error').get(0)){
                $starDom.addClass('error').after('<em id="' + $starDom.attr("name") + '-error" class="error">开始时间不能小于当前时间哦</em>');
            }else{
                $starDom.addClass('error');
                $starDom.siblings('.error').show().html('开始时间不能小于当前时间哦');
            }
            $starDom.val('');
            return false;
        }else if(endTime && chooseTime > endTime){
            /*大于结束时间校验*/
            if(!$starDom.siblings('.error').get(0)){
                $starDom.addClass('error').after('<em id="' + $starDom.attr("name") + '-error" class="error">开始时间不能大于结束时间哦</em>');
            }else{
                $starDom.addClass('error');
                $starDom.siblings('.error').show().html('开始时间不能大于结束时间哦');
            }
            $starDom.val('');
        }else if(chooseTime === endTime){
            /*大于结束时间校验*/
            if(!$starDom.siblings('.error').get(0)){
                $starDom.addClass('error').after('<em id="' + $starDom.attr("name") + '-error" class="error">开始时间不能等于结束时间哦</em>');
            }else{
                $starDom.addClass('error');
                $starDom.siblings('.error').show().html('开始时间不能等于结束时间哦');
            }
            $starDom.val('');
        }else{
            if($starDom.siblings('.error').get(0)){
                $starDom.siblings('.error').html('').hide();
            }
            $starDom.removeClass('error');
        }

    }
    /*结束时间判断*/
    function endTimeValidate(startDom,endDom,chooseTime){
        var $endDom = $(endDom);
        var nowTime = new Date().getTime();//选择日期点击时的当前时间
        if($(startDom).get(0)){
            var startTime = moment($(startDom).val()).valueOf();
        }else{
            var startTime = ''
        }
        var endTime = moment($(endDom).val()).valueOf();
        var chooseTime = moment(chooseTime).valueOf();//当前日历插件选择的时间
        if(startTime && (chooseTime < startTime)) {
            if(!$endDom.siblings('.error').get(0)){
                $endDom.addClass('error').after('<em id="' + $endDom.attr("name") + '-error" class="error">结束时间不能小于开始时间哦</em>')
            }else{
                $endDom.addClass('error');
                $endDom.siblings('.error').show().html('结束时间不能小于开始时间哦');
            }
            $endDom.val('');
            return false;

        }else if(chooseTime < nowTime){
            if(!$endDom.siblings('.error').get(0)){
                $endDom.addClass('error').after('<em id="' + $endDom.attr("name") + '-error" class="error">结束时间不能小于当前时间哦</em>');
            }else{
                $endDom.addClass('error');
                $endDom.siblings('.error').show().html('结束时间不能小于当前时间哦');
            }
            $endDom.val('');
            return false;
        }else if(startTime === chooseTime) {
            if(!$endDom.siblings('.error').get(0)){
                $endDom.addClass('error').after('<em id="' + $endDom.attr("name") + '-error" class="error">结束时间不能等于开始时间哦</em>')
            }else{
                $endDom.addClass('error');
                $endDom.siblings('.error').show().html('结束时间不能等于开始时间哦');
            }
            $endDom.val('');
            return false;
        }else{
            if($endDom.siblings('.error').get(0)){
                $endDom.siblings('.error').html('').hide();
            }
            $endDom.removeClass('error');
        }
    }
</script>
</section>