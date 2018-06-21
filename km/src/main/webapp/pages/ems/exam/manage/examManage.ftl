<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">考试管理</li>
    </ul>
</div>
<section class="exam-manage-all-wrap">
    <form id="examManageForm">
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-manage-panel-head">
                    <div class="pe-stand-filter-form">
                        <div class="pe-stand-form-cell">
                            <label class="pe-form-label floatL" for="peMainKeyText">
                                <span class="pe-label-name floatL">关键字:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="考试名称/编号"
                                       name="examKey">
                            </label>
                            <div class="over-flow-hide floatL" style="margin-right:26px;">
                                <div class="pe-time-wrap floatL">
                                    <div data-toggle="datepicker" data-date-timepicker="true" class="control-group input-daterange">
                                        <label class="control-label pe-label-name floatL">考试时间：</label>
                                        <div class="controls pe-date-wrap">
                                            <input type="text" id="peExamStartTime" name="startTime" class="pe-table-form-text input-medium input-date pe-time-text laydate-icon"><span>-</span>
                                            <input type="text" id="peExamEndTime" name="endTime" class="pe-table-form-text input-medium input-date pe-time-text pe laydate-icon">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <label class="pe-form-label" for="peMainKeyText">
                                <span class="pe-label-name floatL">创建人:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="姓名/用户名/工号/手机号"
                                       name="createUser">
                            </label>
                        </div>
                        <div class="pe-stand-form-cell">
                            <dl class="over-flow-hide floatL">
                                <dt class="pe-label-name floatL">类&emsp;型:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                        <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examTypes" value="ONLINE"/>线上
                                    </label>
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examTypes" value="OFFLINE"/>线下
                                    </label>
                                    <label class="floatL pe-checkbox" for="">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examTypes" value="COMPREHENSIVE"/>综合
                                    </label>
                                </dd>
                            </dl>
                            <dl class="floatL" style="margin-left:112px;">
                                <dt class="pe-label-name floatL">&emsp;状&emsp;态:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                        <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examStatus" value="DRAFT"/>草稿
                                    </label>
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examStatus" value="NO_START"/>未开始
                                    </label>
                                    <label class="floatL pe-checkbox" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examStatus" value="PROCESS"/>考试中
                                    </label>
                                    <label class="floatL pe-checkbox" style="margin-right:15px;">
                                        <span class="iconfont icon-unchecked-checkbox"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" type="checkbox"
                                               name="examStatus" value="OVER"/>已结束
                                    </label>
                                    <label class="floatL pe-checkbox" for="">
                                        <span class="iconfont icon-unchecked-checkbox"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" type="checkbox"
                                               name="examStatus" value="CANCEL"/>已作废
                                    </label>
                                </dd>
                            </dl>
                            <button type="button"
                                    class="pe-btn pe-btn-blue pe-question-choosen-btn exam-manage-choosen-btn">筛选
                            </button>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="subject" value="false">
                <input type="hidden" name="id" value="<%=data.id%>">
                <input type="hidden" name="order" value=""/>
                <input type="hidden" name="sort" value=""/>
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                    <@authVerify authCode="EXAM_MANAGE_ADD_ONLINE">
                        <button type="button" class="pe-btn pe-btn-green create-online-btn">创建线上考试
                        </button></@authVerify>
                    <@authVerify authCode="EXAM_MANAGE_ADD_OFFLINE">
                        <button type="button" class="pe-btn pe-btn-white offline-btn">创建线下考试</button></@authVerify>
                    <@authVerify authCode="EXAM_MANAGE_ADD_COMPLINE">
                        <button type="button" class="pe-btn pe-btn-white comprehensive-btn creat-offline-btn">创建综合考试
                        </button></@authVerify>
                    </div>
                <#--表格包裹的div-->
                    <div class="pe-stand-table-main-panel">
                        <div class="pe-stand-table-wrap"></div>
                        <div class="pe-stand-table-pagination"></div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</section>
<#--渲染表格模板-->
<script type="text/template" id="peExamManaTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%if(peData.tableTitles[i].order){%>
                    <div class="pe-th-wrap" data-type="startTime">
                        <%=peData.tableTitles[i].title%>
                        <span class="pageSize-arrow level-order-up iconfont icon-pageUp"
                              style="position:absolute;"></span>
                    <span class="pageSize-arrow level-order-down iconfont icon-pageDown"
                          style="position:absolute;"></span>
                    </div>
                    <%}else{%>
                    <%=peData.tableTitles[i].title%>
                    <%}%>
                </th>
                <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
            <tr data-id="<%=peData.rows[j].id%>">
            <#--考试编号-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].examCode%>"><%=peData.rows[j].examCode%></div>
                </td>
            <#--考试名称-->
                <td>
                    <a class="pe-stand-table-alink pe-dark-font pe-ellipsis exam-batch-td view-exam"
                       title="<%=peData.rows[j].examName%>"
                       data-id="<%=peData.rows[j].id%>"><%=peData.rows[j].examName%>
                    </a>
                </td>
            <#--试卷类型-->
                <%if(peData.rows[j].examType === 'ONLINE'){%>
                <td>
                    <div class="pe-ellipsis">线上</div>
                </td>
                <%}else if(peData.rows[j].examType === 'OFFLINE'){%>
                <td>
                    <div class="pe-ellipsis">线下</div>
                </td>
                <%}else if(peData.rows[j].examType === 'COMPREHENSIVE'){%>
                <td>综合</td>
                <%}else {%>
                <td></td>
                <%}%>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].createBy%>"><%=peData.rows[j].createBy%></div>
                </td>
                <td>
                    <div class="pe-ellipsis <%if(peData.rows[j].examArranges &&(peData.rows[j].examArranges.length>1)){%>edit-arrange<%}%>"
                         title="<%=peData.rows[j].startTimeStr%><%if(peData.rows[j].startTimeStr||peData.rows[j].endTimeStr){%>~<%}%><%=peData.rows[j].endTimeStr%>">
                        <%=peData.rows[j].startTimeStr%><%if(peData.rows[j].startTimeStr||peData.rows[j].endTimeStr){%>~<%}%><%=peData.rows[j].endTimeStr%>
                        <%if(peData.rows[j].examArranges &&(peData.rows[j].examArranges.length>1)){%>
                    <span class="exam-batch-td">(<span
                            style="color:#199ae2;"><%=peData.rows[j].examArranges.length%></span>)</span>
                        <span class="arrange-arrow iconfont icon-thin-arrow-down "
                              data-id="<%=peData.rows[j].id%>"></span>
                        <%}%>
                    </div>
                </td>
            <#--状态-->
                <%if(peData.rows[j].status === 'DRAFT'){%>
                <td>草稿</td>
                <%}else if(peData.rows[j].status === 'NO_START'){%>
                <td>未开始</td>
                <%}else if(peData.rows[j].status === 'PROCESS'){%>
                <td>考试中</td>
                <%}else if(peData.rows[j].status === 'CANCEL'){%>
                <td>已作废</td>
                <%}else if(peData.rows[j].status === 'OVER'){%>
                <td>已结束</td>
                <%}else {%>
                <td></td>
                <%}%>
                <td>
                    <div class="pe-stand-table-btn-group">
                        <%if(peData.rows[j].examArranges && peData.rows[j].examArranges.length === 1){%>
                        <%if(peData.rows[j].status != 'DRAFT'&&peData.rows[j].status != 'CANCEL' && peData.rows[j].examType === 'ONLINE' && peData.rows[j].examArranges[0].canMonitor){%>
                        <button type="button" title="监控" class="pe-btn pe-icon-btn iconfont icon-monitor"
                                data-id="<%=peData.rows[j].examArranges[0].id%>">
                        </button>
                        <%}%>
                        <%}%>
                        <%if (peData.rows[j].canEdit) {%>
                        <%if(peData.rows[j].status === 'DRAFT'){%>
                        <button type="button" class="start-btn pe-icon-btn iconfont icon-start" title="启用"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}%>
                        <%if( peData.rows[j].status === 'PROCESS' ||peData.rows[j].status === 'DRAFT'
                        || peData.rows[j].status === 'NO_START'){%>
                        <button type="button" class="edit-btn pe-icon-btn iconfont icon-edit" title="编辑"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}%>
                        <%if(peData.rows[j].status === 'NO_START' || peData.rows[j].status === 'PROCESS'){%>
                        <button type="button" class="stop-btn pe-icon-btn iconfont icon-void" title="作废"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}%>
                        <%if(peData.rows[j].status === 'DRAFT'){%>
                        <button type="button" class="dele-btn pe-icon-btn iconfont icon-delete" title="删除"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}%>
                        <%if (peData.rows[j].status === 'OVER' && peData.rows[j].needMarkUp) {%>
                        <button type="button" class="pe-icon-btn iconfont icon-makeup" title="补考"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}%>
                        <%if (!peData.rows[j].markUpId) {%>
                        <button type="button" title="复制" class="copy-btn pe-btn pe-icon-btn iconfont icon-copy"
                                data-id="<%=peData.rows[j].id%>" data-type="<%=peData.rows[j].examType%>">
                        </button>
                        <%}%>
                        <%}%>
                    </div>
                </td>
            </tr>

        <#--展开批次或科目的模板-->
            <%if(peData.rows[j].examArranges &&(peData.rows[j].examArranges.length>1)){%>
            <tr class="batch-tr batch-new-tr">
                <td colspan="7" style="padding:0;overflow:visible;">
                    <div class="exam-manage-batch-wrap">
                        <table class="exam-manage-batch-table">
                            <thead>
                            <tr style="height:1px;padding:0;">
                                <th style="width:15%;"></th>
                                <th style="width:15%"></th>
                                <th style="width:5%"></th>
                                <th style="width:7%"></th>
                                <th style="width:30%"></th>
                                <th style="width:5%"></th>
                                <th style="width:13%"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <%for(var i=0,len=peData.rows[j].examArranges.length;i
                            <len
                                    ;i++){%>
                                <%if(i === 0){%>
                                <tr class="batch-tr batch-first-tr arrange-tr-<%=peData.rows[j].id%>">
                                    <%}else if(i === (peData.rows[j].examArranges.length -1)){%>
                                <tr class="batch-last-tr arrange-tr-<%=peData.rows[j].id%>">
                                    <%}else{%>
                                <tr class="batch-tr arrange-tr-<%=peData.rows[j].id%>">
                                    <%}%>
                                    <%if (peData.rows[j].examType ==='COMPREHENSIVE'){%>
                                    <td>科目<%=i+1%></td>

                                    <%if (peData.rows[j].examArranges[i].subject){%>
                                    <td>
                                        <a href="javascript:;"
                                           class="pe-stand-table-alink pe-dark-font pe-ellipsis exam-batch-td view-exam"
                                           title="<%=peData.rows[j].examArranges[i].subject.examName%>"
                                           data-id="<%=peData.rows[j].examArranges[i].subject.id%>">
                                            <%=peData.rows[j].examArranges[i].subject.examName%>
                                        </a>
                                    </td>
                                <#--科目类型-->
                                    <%if(peData.rows[j].examArranges[i].subject.examType === 'ONLINE'){%>
                                    <td>线上</td>
                                    <%}else if(peData.rows[j].examArranges[i].subject.examType === 'OFFLINE'){%>
                                    <td>线下</td>
                                    <%}else {%>
                                    <td></td>
                                    <%}%>
                                    <td><%=peData.rows[j].examArranges[i].subject.createBy%></td>
                                    <%}else{%>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <%}%>
                                    <%}else{%>
                                    <td>
                                        <div class="pe-ellipsis" title="<%=peData.rows[j].examArranges[i].batchName%>">
                                            <%=peData.rows[j].examArranges[i].batchName%>
                                        </div>
                                    </td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <%}%>
                                    <td>
                                        <div class="pe-ellipsis"
                                             title="<%=peData.rows[j].examArranges[i].startTimeStr%><%if(peData.rows[j].examArranges[i].startTimeStr
                                             ||peData.rows[j].examArranges[i].endTimeStr){%>~<%}%><%=peData.rows[j].examArranges[i].endTimeStr%>">
                                            <%=peData.rows[j].examArranges[i].startTimeStr%>
                                            <%if(peData.rows[j].examArranges[i].startTime||peData.rows[j].examArranges[i].endTime){%>~<%}%><%=peData.rows[j].examArranges[i].endTimeStr%>
                                        </div>
                                    </td>
                                <#--状态-->
                                    <%if(peData.rows[j].examArranges[i].arrangeStatus === 'DRAFT' ){%>
                                    <td>- -</td>
                                    <%}else if(peData.rows[j].examArranges[i].arrangeStatus === 'NO_START'){%>
                                    <td>未开始</td>
                                    <%}else if(peData.rows[j].examArranges[i].arrangeStatus === 'PROCESS'){%>
                                    <td>考试中</td>
                                    <%}else if(peData.rows[j].examArranges[i].arrangeStatus === 'CANCEL'){%>
                                    <td>已作废</td>
                                    <%}else if(peData.rows[j].examArranges[i].arrangeStatus === 'OVER'){%>
                                    <td>已结束</td>
                                    <%}else {%>
                                    <td></td>
                                    <%}%>
                                    <td>
                                        <div class="pe-stand-table-btn-group">
                                            <%if(peData.rows[j].examArranges[i].arrangeStatus != 'DRAFT' && peData.rows[j].examArranges[i].canMonitor && peData.rows[j].examArranges[i].arrangeStatus != 'CANCEL' && (peData.rows[j].examType === 'ONLINE' || (peData.rows[j].examType === 'COMPREHENSIVE' && peData.rows[j].examArranges[i].subject.examType === 'ONLINE'))){%>
                                            <button type="button" title="监控"
                                                    class="pe-btn pe-icon-btn iconfont icon-monitor"
                                                    data-id="<%=peData.rows[j].examArranges[i].id%>">
                                            </button>
                                            <%}%>
                                            <%if (peData.rows[j].canEdit) {%>
                                            <%if(peData.rows[j].examType ==='COMPREHENSIVE' &&
                                            peData.rows[j].examArranges[i].subject){%>
                                            <%if(peData.rows[j].examArranges[i].arrangeStatus === 'NO_START' ||
                                            peData.rows[j].examArranges[i].arrangeStatus === 'DRAFT'
                                            || peData.rows[j].examArranges[i].arrangeStatus === 'PROCESS'){%>
                                            <button type="button"
                                                    class="subject-edit-btn pe-icon-btn iconfont icon-edit"
                                                    title="编辑"
                                                    data-id="<%=peData.rows[j].examArranges[i].subject.id%>"></button>
                                            <%}%>
                                            <%}else{%>
                                            <%if(peData.rows[j].examArranges[i].arrangeStatus === 'DRAFT' ||
                                            peData.rows[j].examArranges[i].arrangeStatus === 'NO_START'||
                                            peData.rows[j].examArranges[i].arrangeStatus === 'PROCESS'){%>
                                            <button type="button" class="batch-edit-btn pe-icon-btn iconfont icon-edit"
                                                    title="编辑"
                                                    data-id="<%=peData.rows[j].examArranges[i].id%>"
                                                    data-status="<%=peData.rows[j].examArranges[i].arrangeStatus%>"></button>
                                            <%}%>
                                            <%}%>

                                            <%if(peData.rows[j].examArranges[i].arrangeStatus === 'NO_START' ||
                                            peData.rows[j].examArranges[i].arrangeStatus === 'PROCESS'){%>
                                            <button type="button"
                                                    class="stop-arrange-btn pe-icon-btn iconfont icon-void"
                                                    title="作废"
                                                    data-id="<%=peData.rows[j].examArranges[i].id%>"
                                                    data-type=<%if(peData.rows[j].examType !='COMPREHENSIVE' ){%>
                                                "BATCH"<%}else{%>"SUBJECT"<%}%>>
                                            </button>
                                            <%}%>
                                            <%if (peData.rows[j].examType ==='COMPREHENSIVE' &&
                                            peData.rows[j].examArranges[i].arrangeStatus === 'OVER' &&
                                            peData.rows[j].examArranges[i].subject.needMarkUp) {%>
                                            <button type="button" class="pe-icon-btn iconfont icon-makeup" title="补考"
                                                    data-id="<%=peData.rows[j].examArranges[i].subject.id%>"
                                                    data-type=<%if(peData.rows[j].examType !='COMPREHENSIVE' ){%>
                                                "BATCH"<%}else{%>"SUBJECT"<%}%>>
                                            </button>
                                            <%}%>
                                            <%if(peData.rows[j].examArranges[i].arrangeStatus === 'DRAFT'){%>
                                            <%if (peData.rows[j].examType !='COMPREHENSIVE' ||
                                            peData.rows[j].examArranges.length >=3){%>
                                            <button type="button"
                                                    class="dele-arrange-btn pe-icon-btn iconfont icon-delete"
                                                    title="删除"
                                                    data-id="<%=peData.rows[j].examArranges[i].id%>" data-type=
                                                            <%if(peData.rows[j].examType !='COMPREHENSIVE' ){%>
                                                "BATCH"<%}else{%>"SUBJECT"<%}%> >
                                            </button>
                                            <%}%>
                                            <%}%>
                                            <%}%>
                                        </div>
                                    </td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                </td>
            </tr>
            <%}%>

            <%}%>
            <%}else{%>
            <tr>
                <td class="pe-td pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
                    <div class="pe-result-no-date"></div>
                    <p class="pe-result-date-warn">暂无数据</p>
                </td>
            </tr>
            <%}%>
        </tbody>
    </table>
</script>

<#--移除角色的弹框模板-->
<script type="text/template" id="copyExamTemp">
    <form id="examTmpForm">
        <h3 style="margin-bottom:10px;" style="font-size:16px;color:#444;margin-top:10px;">请选择需要复制的考试信息:</h3>
        <div style="width: 100%;">
            <ul class="over-flow-hide exam-manage-copy-ul">
                <%if (data.type === "COMPREHENSIVE"){%>
                <li class="floatL exam-dialog-copy-li">
                    <label class="floatL pe-checkbox" for="">
                        <span class="iconfont icon-checked-checkbox peChecked" style="color:#8cccf0;"></span>
                        <input class="pe-form-ele" type="checkbox" checked="checked" disabled="disabled"/>科目设置
                    </label>
                </li>
                <%}else{%>
                <li class="floatL exam-dialog-copy-li">
                    <label class="floatL pe-checkbox">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input name="copyFields" class="pe-form-ele" type="checkbox" checked="checked"
                               value="PAPER_SETTING"/>试卷设置
                    </label>
                </li>
                <%}%>
                <li class="floatL exam-dialog-copy-li">
                    <label class="floatL pe-checkbox" for="">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input name="copyFields" class="pe-form-ele" type="checkbox" checked="checked"
                               value="EXAM_USER"/>考试人员
                    </label>
                </li>
                <li class="floatL exam-dialog-copy-li">
                    <label class="floatL pe-checkbox">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input name="copyFields" class="pe-form-ele" type="checkbox" checked="checked"
                               value="EXAM_SETTING"/>考试设置
                    </label>
                </li>
                <li class="floatL exam-dialog-copy-li">
                    <span class="floatL pe-checkbox" for="">
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <input name="copyFields" class="pe-form-ele" type="checkbox" value="EXAM_TIME"/>考试时间
                    </span>
                </li>
            </ul>
        </div>
    </form>
</script>
<#--考试管理编辑弹框模板-->
<script type="text/template" id="examEditDialogTemp">
    <form id="updateBatchForm">
        <input type="hidden" name="id" value="<%=examArrange.id%>">
        <input type="hidden" class="exam-id-input" name="exam.id" value="<%=examArrange.exam.id%>">
        <input type="hidden" name="arrangeStatus" value="<%=status%>">
        <div class="validate-form-cell" style="height:20px;position: static;">
            <em class="error"></em>
        </div>
        <div class="pe-stand-form-cell" style="margin-bottom:0;">
            <label class="pe-form-label dialog-form-label" for="peMainKeyText">
                <span class="pe-label-name floatL"><span style="color:#f00;">*</span>批次名称:</span>
                <%if(status && status ==='PROCESS'){%>
                <span style="line-height: 32px"><%=examArrange.batchName%></span>
                <%}else{%>
                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                       value="<%=examArrange.batchName%>" name="batchName">
                <%}%>
                <div class="validate-form-cell error-batch-name" style="height:20px;position: static;">
                    <em class="error"></em>
                </div>
            </label>
        </div>
        <div class="pe-stand-form-cell" style="margin-bottom:0;">
            <div class="pe-time-wrap dialog-form-label">
                <span class="pe-label-name floatL"><span style="color:#f00;">*</span>开始时间:</span>
                <div class="pe-date-wrap">
                    <%if(status && status ==='PROCESS'){%>
                    <span class="process-start-time"><%=moment(examArrange.startTime).format('YYYY-MM-DD HH:mm')%></span>
                    <%}else{%>
                    <input id="peExamDialogStartTime"
                           class="pe-table-form-text pe-time-text pe-start-time laydate-icon"
                    <%if(examArrange.startTime){%>
                    value="<%=moment(examArrange.startTime).format('YYYY-MM-DD HH:mm')%>"
                    <%}%>
                    type="text" name="startTime" readonly="readonly"style="width:204px;">
                    <%}%>
                </div>
            </div>
            <div class="validate-form-cell error-start-time" style="height:20px;position: static;">
                <em class="error"></em>
            </div>
        </div>
        <div class="pe-stand-form-cell" style="margin-bottom:0;">
            <div class="pe-time-wrap dialog-form-label">
                <span class="pe-label-name floatL"><span style="color:#f00;">*</span>结束时间:</span>
                <div class="pe-date-wrap">
                    <input id="peExamDialogEndTime"
                           class="pe-table-form-text pe-time-text pe-start-time laydate-icon"
                    <%if(examArrange.startTime){%>
                    value="<%=moment(examArrange.endTime).format('YYYY-MM-DD HH:mm')%>"
                    <%}%>
                           type="text" name="endTime" readonly="readonly" style="width:204px;">
                <#--<span class="iconfont icon-date input-icon"></span>-->
                </div>
            </div>
            <div class="validate-form-cell error-end-time" style="height:20px;position: static;">
                <em class="error"></em>
            </div>
        </div>
        <%if(status && status ==='DRAFT'){%>
        <div class="pe-stand-form-cell" style="margin-bottom:15px;">
            <label class="pe-form-label" for="peMainKeyText">
                <span class="pe-label-name floatL">&nbsp;考试设置:</span>
                <a href="javascript:void(0);" data-id="<%=examArrange.id%>"
                   class="exam-add-new-user arrange-user-cla">添加考生</a>
            </label>
        </div>
        <%}%>
        <div class="pe-stand-form-cell">
        <span class="exam-has-added-user-num" style="margin-left: 74px;">
                 <span class="arrange-add-user">
                    已添加考生
                  <a id="USER_<%=examArrange.id%>" href="${ctx!}/ems/exam/manage/initUserPage?id=<%=examArrange.id%>"
                     target="_blank"><%=examArrange.typeCountMap&&examArrange.typeCountMap.USER?examArrange.typeCountMap.USER:'0'%></a>人
                 </span>
               <%if (!examArrange.exam.enableTicket) {%>
                    +
                  <span class="arrange-add-org">
                    已添加组织
                  <a id="ORGANIZE_<%=examArrange.id%>"
                     href="${ctx!}/ems/exam/manage/initAddOrganize?id=<%=examArrange.id%>" target="_blank"><%=examArrange.typeCountMap&&examArrange.typeCountMap.ORGANIZE?examArrange.typeCountMap.ORGANIZE:'0'%></a>个
                   </span>
               <%}%>
        </span>
        </div>
    </form>
</script>
<script>
    /*开始时间选择判断*/
    function startTimeValidate(startDom, endDom, chooseTime) {
        var $starDom = $(startDom);
        var nowTime = new Date('${(nowTime?string('yyyy/MM/dd HH:mm'))!}').getTime();//选择日期点击时的当前时间
        var endTime = moment($(endDom).val()).valueOf();
        var chooseTime = moment(chooseTime).valueOf();//当前日历插件选择的时间

        /*小于当前时间校验*/
        if (chooseTime < nowTime) {
            $starDom.addClass('error');
            $('.error-start-time').find('em.error').eq(0).show().html('开始时间不能小于当前时间');
            $starDom.val('');
            return false;
        } else if (endTime && chooseTime > endTime) {
            /*大于结束时间校验*/
            $starDom.addClass('error');
            $('.error-start-time').find('em.error').eq(0).show().html('开始时间不能大于结束时间');
            $starDom.val('');
        } else if (chooseTime === endTime) {
            /*等于结束时间校验*/
            $starDom.addClass('error');
            $('.error-start-time').find('em.error').eq(0).show().html('开始时间不能等于结束时间');
            $starDom.val('');
        } else {
            if ($('.error-start-time').find('em.error').get(0)) {
                $('.error-start-time').find('em.error').html('').hide();
            }
            $starDom.removeClass('error');
        }

    }
    /*结束时间判断*/
    function endTimeValidate(startDom, endDom, chooseTime) {
        var $endDom = $(endDom);
        //    var nowTime = new Date().getTime();//选择日期点击时的当前时间
        var nowTime = moment('${(nowTime?string('yyyy-MM-dd HH:mm'))!}').valueOf();
        if($(startDom).get(0)){
            var startTime = moment($(startDom).val()).valueOf();
        }else{
            var startTime = '';
        }
        var endTime = moment($(endDom).val()).valueOf();
        var chooseTime = moment(chooseTime).valueOf();//当前日历插件选择的时间

        if (startTime && (chooseTime < startTime)) {
            $endDom.addClass('error');
            $('.error-end-time').find('em.error').eq(0).show().html('结束时间不能小于开始时间');
            $endDom.val('');
            return false;

        } else if (chooseTime < nowTime) {
            $endDom.addClass('error');
            $('.error-end-time').find('em.error').eq(0).show().html('结束时间不能小于当前时间');
            $endDom.val('');
            return false;
        } else if (chooseTime === startTime) {
            /*等于开始时间校验*/
            $endDom.addClass('error');
            $('.error-end-time').find('em.error').eq(0).show().html('结束时间不能等于开始时间');
            $endDom.val('');
        } else {
            if ($('.error-end-time').find('em.error').get(0)) {
                $('.error-end-time').find('.error').html('').hide();
            }
            $endDom.removeClass('error');
        }
    }

    /*监听storage发生的处理函数*/
    function countUser(arrangeId, referType) {
        PEBASE.ajaxRequest({
            url: pageContext.rootPath + '/ems/exam/manage/countExamUser',
            data: {arrangeId: arrangeId, referType: referType},
            success: function (data) {
                $('#' + referType + '_' + arrangeId).text(data);
            }
        });
    }

    $(function () {
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        var peTableTitle = [
            {'title': '考试编号', 'width': 15, 'type': ''},
            {'title': '考试名称', 'type': 'examName', 'width': 15},
            {'title': '类型', 'width': 5, 'type': ''},
            {'title': '创建人', 'width': 7, 'type': '', 'name': 'indefinite'},//.name === 'indefinite'
            {'title': '考试时间', 'width': 28, 'type': '', 'order': true},
            {'title': '状态', 'width': 5, 'type': ''},
            {'title': '操作', 'width': 15}
        ];

        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/ems/exam/manage/search',
            formParam: $('#examManageForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'peExamManaTemp',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle //表格头部的数量及名称数组;
        });

        /*点击批次弹出批次展示框的事件*/
        $('.pe-stand-table-wrap').delegate('.edit-arrange', 'click', function (e) {
            var e = e || window.event;
            e.stopPropagation();
            var _thisArrow = $(this).find('.arrange-arrow');
            var id = _thisArrow.attr('data-id');
            var thisBatch = _thisArrow.parents('tr').next('.batch-new-tr');
            if (!(_thisArrow.parents('tr').next('.batch-new-tr:visible').get(0))) {
                $('.batch-new-tr:visible').prev('tr').eq(0).find('.arrange-arrow')
                        .removeClass('icon-thin-arrow-up')
                        .addClass('icon-thin-arrow-down');
            }
            $('.batch-new-tr:visible').prev('tr').eq(0).find('.pe-ellipsis').removeClass('batch-active');
            $('.batch-new-tr:visible').hide();
            if (_thisArrow.hasClass('icon-thin-arrow-down')) {
                _thisArrow.parent('.pe-ellipsis').addClass('batch-active');
                _thisArrow.removeClass('icon-thin-arrow-down').addClass('icon-thin-arrow-up');
                thisBatch.show();
            } else {
                thisBatch.hide();
                _thisArrow.parent('.pe-ellipsis').removeClass('batch-active');
                _thisArrow.removeClass('icon-thin-arrow-up').addClass('icon-thin-arrow-down');
            }

        });

        //手动补考
        $('.pe-stand-table-wrap').delegate('.icon-makeup', 'click', function (e) {
            var e = e || window.event;
            e.stopPropagation();
            var id = $(this).attr('data-id');
            location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initExamInfo?markUpId=' + id + '&nav=examMana';
        });

        /*页面监听，关闭批次展开的表格*/
        //监控
        $('.pe-stand-table-wrap').delegate('.icon-monitor', 'click', function () {
            var id = $(this).data('id');
            window.open(pageContext.rootPath + '/ems/examMonitor/manage/initMonitorDetailPage?arrangeId=' + id,"newWindow"+id);
        });
        //表格考试时间排序点击事件
        $('.pe-stand-table-wrap').delegate('.level-order-up', 'click', function () {
            $(this).addClass('curOrder');
            $(this).siblings('.level-order-down').removeClass('curOrder');
            var thisType = $(this).parent('.pe-th-wrap').attr('data-type');
            $('input[name="sort"]').val(thisType);
            $('input[name="order"]').val('asc');
            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
        });

        $('.pe-stand-table-wrap').delegate('.level-order-down', 'click', function () {
            $(this).addClass('curOrder');
            $(this).siblings('.level-order-up').removeClass('curOrder');
            var thisType = $(this).parent('.pe-th-wrap').attr('data-type');
            $('input[name="sort"]').val(thisType);
            $('input[name="order"]').val('desc');
            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
        });


        $('.exam-manage-choosen-btn').on('click', function () {
            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
        });

        $('.create-online-btn').click(function () {
            location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initExamInfo?examType=ONLINE&nav=examMana';
        });

        $('.offline-btn').click(function () {
            location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initExamInfo?examType=OFFLINE&nav=examMana';
        });

        $('.comprehensive-btn').click(function () {
            location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initExamInfo?examType=COMPREHENSIVE&nav=examMana';
        });

        //发布考试
        $('.pe-stand-table-wrap').delegate('.start-btn', 'click', function () {
            var examId = $(this).data('id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定启用该考试吗？</h3><p class="pe-dialog-content-tip">启用后，考试不可以删除。 </p></div>',
                btn2: function () {
                    $.post(pageContext.rootPath + '/ems/exam/manage/releaseExam', {'id': examId}, function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '启用成功',
                                time: 1000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
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

                    }, 'json');
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });

        //编辑批次信息
        $('.pe-stand-table-wrap').delegate('.batch-edit-btn', 'click', function () {
            var thisBatch = $(this);
            var arrangeId = thisBatch.attr('data-id');
            PEBASE.ajaxRequest({
                url: pageContext.rootPath + '/ems/exam/manage/getExamArrange',
                data: {arrangeId: arrangeId},
                success: function (data) {
                    var examStatus = thisBatch.attr('data-status');
                    //赋值
                    $("#updateBatchForm input[name='id'] ").val("arrangeId");
                    if (data.success) {
                        PEMO.DIALOG.confirmL({
                            content: _.template($('#examEditDialogTemp').html())({
                                examArrange: data.data,
                                status: examStatus
                            }),
                            area: '500px',
                            skin: 'pe-layer-confirm pe-exam-manage-time-dialog',
                            title: '编辑批次信息',
                            btn: ['确定', '取消'],
                            btnAlign: 'l',
                            btn1: function () {
                                if ($("#updateBatchForm").valid()) {
                                    PEBASE.ajaxRequest({
                                        url: pageContext.rootPath + '/ems/exam/manage/updateSingleArrange',
                                        data: $('#updateBatchForm').serialize(),
                                        success: function (data) {
                                            if (data.success) {
                                                PEMO.DIALOG.tips({
                                                    content: '编辑成功',
                                                    time: 1000,
                                                    end: function () {
                                                        $('.pe-stand-table-wrap').peGrid('refresh');
                                                        layer.closeAll('page');
                                                    }
                                                });
                                                return false;
                                            }

                                            PEMO.DIALOG.alert({
                                                content: data.message,
                                                btn: ['我知道了'],
                                                yes: function (shiIndex) {
                                                    layer.close(shiIndex);
                                                }
                                            })
                                        }
                                    });
                                } else {
                                    return false;
                                }
                            },
                            btn2: function () {
                                layer.closeAll();
                            },
                            success: function () {
                                $('#peExamDialogStartTime').datepicker({
                                    timepicker:true,
                                    autoclose: false
                                }).off('hide').on('hide',function(t,d){
                                    startTimeValidate('#peExamDialogStartTime','#peExamDialogEndTime',this.value);
                                });

                                $('#peExamDialogEndTime').datepicker({
                                    timepicker:true,
                                    autoclose: false
                                }).on('hide',function(){
//                                    console.log('thisValue',this.value);
                                    endTimeValidate('#peExamDialogStartTime','#peExamDialogEndTime',this.value)
                                });

                                $('.arrange-user-cla').on('click', function () {
                                    var _thisExamId = $(this).attr('data-id');
                                    window.open("${ctx!}/ems/exam/manage/initUserPage?id=" + _thisExamId, "EXAN_ADD_USER", '');
                                });

                                /*弹框里的表单校验*/
                                var isValidate = $("#updateBatchForm").validate({
                                    errorElement: 'em',
                                    errorPlacement: function (error, element) {
                                        var idName = $(error).attr('id');
                                        var startTimeReg = /peExamDialogStartTime/ig;
                                        var endTimeReg = /peExamDialogEndTime/ig;
                                        if(startTimeReg.test(idName)){
                                            var $erStarDom = $('.error-start-time');
                                            if($erStarDom.find('.error').get(0)){
                                                $erStarDom.html('');
                                            }
                                            error.appendTo($erStarDom);
                                        }else if(endTimeReg.test(idName)){
                                            var $erEndDom = $('.error-end-time');
                                            if($erEndDom.find('.error').get(0)){
                                                $erEndDom.html('');
                                            }
                                            error.appendTo($erEndDom);
                                        }
                                    },
                                    rules: {
                                        'batchName': 'required',
                                        'startTime': 'required',
                                        'endTime': 'required'
                                    },
                                    messages: {
                                        'batchName': '批次名称必填',
                                        'startTime': '开始时间不能为空',
                                        'endTime': '结束时间不能为空'
                                    },
                                    submitHandler: function (form) {

                                    }
                                });
                            }
                        })
                    }
                }
            });

        });

        $('.pe-stand-table-wrap').delegate('.edit-btn', 'click', function () {
            var id = $(this).data('id');
            location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initExamInfo?id=' + id + '&optType=UPDATE&nav=examMana';
        });

        $('.pe-stand-table-wrap').delegate('.view-exam', 'click', function () {
            var id = $(this).data('id');
            window.open(pageContext.rootPath + '/front/manage/initPage#url=' + pageContext.rootPath
                    + '/ems/exam/manage/initExamInfo?subject=true&optType=VIEW&source=ADD&id=' + id + '&nav=examMana', '');
        });

        $('.pe-stand-table-wrap').delegate('.dele-btn', 'click', function () {
            var id = $(this).data('id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定删除该考试吗？</h3><p class="pe-dialog-content-tip">删除后，考试不可以恢复，请谨慎操作。 </p></div>',
                btn2: function () {
                    $.post(pageContext.rootPath + '/ems/exam/manage/deleteExam', {'id': id}, function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '删除成功',
                                time: 1000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });

                            return false;
                        }


                        PEMO.DIALOG.alert({
                            content: data.message,
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        })
                    }, 'json');
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });

        $('.pe-stand-table-wrap').delegate('.copy-btn', 'click', function () {
            var id = $(this).attr('data-id');
            var type = $(this).attr('data-type');
            var data = {
                'type': type,
                'id': id
            };
            PEMO.DIALOG.confirmR({
                content: _.template($('#copyExamTemp').html())({data: data}),
                title: '复制考试',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/copyExam?id=' + id,
                        data: $('#examTmpForm').serializeArray(),
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '复制成功',
                                    time: 1000,
                                    end: function () {
                                        $('.pe-stand-table-wrap').peGrid('refresh');
                                    }
                                });

                                return false;
                            }

                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function () {
                                    layer.closeAll();
                                }
                            })
                        }
                    })
                },
                btn1: function () {
                    layer.closeAll();
                },
                success: function () {
                    PEBASE.peFormEvent('checkbox');
                }
            })
        });

        //考试作废
        $('.pe-stand-table-wrap').delegate('.stop-btn', 'click', function () {
            var id = $(this).data('id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定作废该场考试么？</h3><p class="pe-dialog-content-tip">作废后，考试不可以恢复，请谨慎操作。</p></div>',
                btn2: function () {
                    $.post(pageContext.rootPath + '/ems/exam/manage/cancelExam', {'id': id}, function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '作废成功',
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });

                            return false;
                        }


                        PEMO.DIALOG.alert({
                            content: data.message,
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        })
                    }, 'json');
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });

        //批次或科目删除按钮
        $('.pe-stand-table-wrap').delegate('.dele-arrange-btn', 'click', function () {
            var id = $(this).data('id');
            var type = $(this).data('type');
            var text;
            if (type === 'BATCH') {
                text = '确定删除该批次的考试么？';
            } else {
                text = '确定删除这个科目么？';
            }

            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">' + text + '</h3><p class="pe-dialog-content-tip">删除后不能再次恢复，请谨慎操作。 </p></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/deleteArrange',
                        data: {'arrangeId': id},
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '删除成功',
                                    time: 1000,
                                    end: function () {
                                        $('.pe-stand-table-wrap').peGrid('refresh');
                                    }
                                });

                                return false;
                            }

                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function () {
                                    layer.closeAll();
                                }
                            })
                        }
                    });
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });

        //批次或科目作废按钮
        $('.pe-stand-table-wrap').delegate('.stop-arrange-btn', 'click', function () {
            var id = $(this).data('id');
            var type = $(this).data('type');
            var text;
            if (type === 'BATCH') {
                text = '确定作废该批次的考试么？？';
            } else {
                text = '确定作废该科目的考试么？';
            }

            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">' + text + '</h3><p class="pe-dialog-content-tip">作废后，不可以恢复，请谨慎操作。 </p></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/cancelArrange',
                        data: {'arrangeId': id},
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '作废成功',
                                    time: 1000,
                                    end: function () {
                                        $('.pe-stand-table-wrap').peGrid('refresh');
                                    }
                                });

                                return false;
                            }

                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function () {
                                    layer.closeAll();
                                }
                            })
                        }
                    });
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });

        //编辑科目新页面
        $('.pe-stand-table-wrap').delegate('.subject-edit-btn', 'click', function () {
            var id = $(this).data('id');
            window.open(pageContext.rootPath + '/front/manage/initPage#url=' + pageContext.rootPath
                    + '/ems/exam/manage/initExamInfo?subject=true&optType=UPDATE&source=ADD&id=' + id + '&nav=examMana', '');
        });

        if (typeof changeExamManaStorage === 'function') {
            window.removeEventListener("storage", changeExamManaStorage, false);
        }


    })

</script>