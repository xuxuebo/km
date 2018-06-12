<#--考生状态明细头部-->
<div class="exam-manage-all-wrap my-result-detail-wrap user-main-right-panel">
    <form id="examManageForm">
        <div class="">
            <div class="pe-manage-panel-head blue-shadow" style="background-color: #fff;">
                <div class="pe-stand-filter-form">
                    <div class="pe-stand-form-cell" style="margin-bottom:4px;">
                        <dl class="over-flow-hide floatL" style="margin-right:26px;">
                            <dt class="pe-label-name floatL">考试状态:</dt>
                            <dd class="pe-stand-filter-label-wrap">
                                <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                    <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                           name="examStatuses" value="PASS"/>通过
                                </label>
                                <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                    <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                           name="examStatuses" value="NO_PASS"/>未通过
                                </label>
                                <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                    <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <input id="peFormEleStop" class="pe-form-ele" checked="checked" type="checkbox"
                                           name="examStatuses" value="MISS_EXAM"/>缺考
                                </label>
                                <#--<label class="floatL pe-checkbox" for="" style="margin-right:15px;">-->
                                    <#--<span class="iconfont icon-unchecked-checkbox"></span>-->
                                    <#--<input id="peFormEleStop" class="pe-form-ele" type="checkbox"-->
                                           <#--name="examStatuses" value="MARKING"/>评卷中-->
                                <#--</label>-->
                            </dd>
                        </dl>
                        <dl class="over-flow-hide" style="margin-left: 35px;">
                            <dt class="pe-label-name floatL">考试类型:</dt>
                            <dd class="pe-stand-filter-label-wrap">
                                <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                    <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                    <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                           name="exam.examTypes" value="ONLINE"/>线上
                                </label>
                                <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                    <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                           name="exam.examTypes" value="OFFLINE"/>线下
                                </label>
                                <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                    <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                           name="exam.examTypes" value="COMPREHENSIVE"/>综合
                                </label>
                            </dd>
                        </dl>
                    </div>
                    <div class="pe-stand-form-cell">
                        <div class="over-flow-hide floatL">
                            <div class="pe-time-wrap floatL">
                                <div data-toggle="datepicker" data-date-timepicker="true" class="control-group input-daterange">
                                    <label class="control-label pe-label-name floatL">考试时间：</label>
                                    <div class="controls pe-date-wrap">
                                        <input type="text" name="exam.startTime" class="pe-table-form-text input-medium input-date pe-time-text laydate-icon"><span>-</span>
                                        <input type="text" name="exam.endTime" class="pe-table-form-text input-medium input-date pe-time-text pe laydate-icon">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button type="button" id="queryCondition" class="pe-btn pe-btn-blue pe-choice-btn">筛选
                        </button>
                    </div>
                </div>
            </div>
            <div class="pe-stand-table-top-panel" style="background-color: #edf0f4;height: 0;padding:10px;">
            </div>
        <#--表格包裹的div-->
            <div class="pe-stand-table-main-panel blue-shadow">
                <div class="pe-stand-table-wrap"></div>
                <div class="pe-stand-table-pagination"></div>
            </div>
        </div>
    </form>
</div>

<#--渲染表格模板-->
<script type="text/template" id="peExamManaTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%_.each(peData.tableTitles,function(tableTitle){%>
                <th style="width:<%=tableTitle.width?tableTitle.width+'%':'auto'%>">
                    <%if(tableTitle.order){%>
                    <div class="pe-th-wrap" data-type="startTime">
                        <%=tableTitle.title%>
                        <span class="pageSize-arrow level-order-up iconfont icon-pageUp"
                              style="position:absolute;"></span>
                    <span class="pageSize-arrow level-order-down iconfont icon-pageDown"
                          style="position:absolute;"></span>
                    </div>
                    <%}else{%>
                    <%=tableTitle.title%>
                    <%}%>
                </th>
            <%});%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%_.each(peData.rows,function(exam){%>
            <tr data-id="<%=exam.id%>">
            <#--考试名称-->
                <td>
                    <span title="<%=exam.examName%>"><%=exam.examName%></span>
                </td>
                <td>
                    <div class="pe-ellipsis <%if(exam.examArranges &&(exam.examArranges.length>1)){%>edit-arrange<%}%>" <%if(exam.examArranges &&(exam.examArranges.length>1)){%>style="cursor:pointer;"<%}else{%>style="cursor:default;"<%}%>
                         title="<%=moment(exam.startTime).format('YYYY-MM-DD HH:mm')%>~<%=moment(exam.endTime).format('YYYY-MM-DD HH:mm')%>">
                        <%=moment(exam.startTime).format('YYYY-MM-DD HH:mm')%>~<%=moment(exam.endTime).format('YYYY-MM-DD HH:mm')%>
                        <%if(exam.examArranges &&(exam.examArranges.length>1)){%>
                        <span class="exam-batch-td">(<span
                            style="color:#199ae2;"><%=exam.examArranges.length%></span>)</span>
                        <span class="arrange-arrow iconfont icon-thin-arrow-down "
                              data-id="<%=exam.id%>"></span>
                        <%}%>
                    </div>
                </td>
            <#--试卷类型-->
                <%if(exam.examType === 'ONLINE'){%>
                <td><div class="pe-ellipsis">线上</div></td>
                <%}else if(exam.examType === 'OFFLINE'){%>
                <td><div class="pe-ellipsis">线下</div></td>
                <%}else if(exam.examType === 'COMPREHENSIVE'){%>
                <td>综合</td>
                <%}else {%>
                <td></td>
                <%}%>
            <#--状态-->
                <td>
                    <%if (exam.examResult.status === 'MISS_EXAM') {%>
                    --
                    <%}else{%>
                    <%=(exam.examResult.score || exam.examResult.score===0)?parseFloat(exam.examResult.score.toFixed(1),10):'--'%>
                    <%}%>
                </td>
                <td>
                    <%if (exam.examResult.status === 'MISS_EXAM') {%>
                        缺考
                    <%} else if(exam.examResult.pass) {%>
                        <span style="color: #65cc4a;">通过</span>
                    <%} else if(!exam.examResult.pass) {%>
                        <span style="color: red;" title="未通过">未通过</span>
                    <%}%>
                </td>
                <td>
                    <div class="pe-stand-table-btn-group">
                        <%if (exam.examType === 'ONLINE' && exam.examResult.status != 'MISS_EXAM' && exam.examSetting.examAuthType != 'NO_SEE'){%>
                        <button type="button" title="答卷" class="copy-btn pe-btn pe-icon-btn iconfont icon-my-examination" data-id="<%=exam.id%>">
                        </button>
                        <%}%>
                        <%if (exam.examType === 'ONLINE' && exam.examResult.status === 'RELEASE') {%>
                        <@authVerify authCode="VERSION_USER_OF_RESULT_ANALYSE">
                            <button type="button" title="分析" class="pe-btn pe-icon-btn iconfont icon-test-analysis"
                                    data-id="<%=exam.id%>">
                            </button>
                        </@authVerify>

                        <%}%>
                        <%if (exam.examType === 'ONLINE' && exam.examSetting && exam.examSetting.rankSetting && exam.examSetting.rankSetting.rst != 'NO_SHOW') {%>
                        <@authVerify authCode="VERSION_USER_OF_RANK">
                            <button type="button" title="排行榜"
                                    class="pe-btn pe-icon-btn iconfont rank-link icon-ranking-list"
                                    data-id="<%=exam.id%>">
                            </button>
                        </@authVerify>

                        <%}%>
                    </div>
                </td>
            </tr>

        <#--展开批次或科目的模板-->
            <%if(exam.examArranges &&(exam.examArranges.length>1)){%>
            <tr class="batch-tr batch-new-tr">
                <td colspan="11" style="padding:0;overflow:visible;">
                    <div class="exam-manage-batch-wrap" style="width: 100%;">
                        <table class="exam-manage-batch-table">
                            <thead>
                            <tr style="height:1px;padding:0;">
                                <th style="width:22%"></th>
                                <th style="width:40%"></th>
                                <th style="width:10%"></th>
                                <th style="width:10%"></th>
                                <th style="width:8%"></th>
                                <th style="width:10%"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <%for(var i=0,len=exam.examArranges.length;i<len;i++){%>
                                <%if(i === 0){%>
                                <tr class="batch-tr batch-first-tr arrange-tr-<%=exam.id%>">
                                    <%}else if(i === (exam.examArranges.length -1)){%>
                                <tr class="batch-last-tr arrange-tr-<%=exam.id%>">
                                    <%}else{%>
                                <tr class="batch-tr arrange-tr-<%=exam.id%>">
                                    <%}%>
                                    <%if (exam.examType ==='COMPREHENSIVE'){%>
                                    <td>
                                        <%=exam.examArranges[i].subject.examName%>
                                    </td>
                                    <td>
                                        <div class="pe-ellipsis"
                                             title="<%=exam.examArranges[i].startTimeStr%><%if(exam.examArranges[i].startTimeStr
                                                 ||exam.examArranges[i].endTimeStr){%>~<%}%><%=exam.examArranges[i].endTimeStr%>">
                                            <%=exam.examArranges[i].startTimeStr%>
                                            <%if(exam.examArranges[i].startTime||exam.examArranges[i].endTime){%>~<%}%><%=exam.examArranges[i].endTimeStr%>
                                        </div>
                                    </td>
                                <#--科目类型-->
                                    <%if(exam.examArranges[i].subject.examType === 'ONLINE'){%>
                                    <td>线上</td>
                                    <%}else if(exam.examArranges[i].subject.examType === 'OFFLINE'){%>
                                    <td>线下</td>
                                    <%}else {%>
                                    <td></td>
                                    <%}%>
                                    <%}else{%>
                                    <td>
                                        <div class="pe-ellipsis" title="<%=exam.examArranges[i].batchName%>"> <%=exam.examArranges[i].batchName%></div>
                                    </td>
                                    <td>
                                        <div class="pe-ellipsis"
                                             title="<%=exam.examArranges[i].startTimeStr%><%if(exam.examArranges[i].startTimeStr
                                                 ||exam.examArranges[i].endTimeStr){%>~<%}%><%=exam.examArranges[i].endTimeStr%>">
                                            <%=exam.examArranges[i].startTimeStr%>
                                            <%if(exam.examArranges[i].startTime||exam.examArranges[i].endTime){%>~<%}%><%=exam.examArranges[i].endTimeStr%>
                                        </div>
                                    </td>
                                    <td></td>
                                    <%}%>
                                    <td>
                                        <%if (exam.examArranges[i].subject.examResult.status === 'MISS_EXAM') {%>
                                        --
                                        <%} else {%>
                                        <%=exam.examArranges[i].subject.examResult.score>100?100:(Number(exam.examArranges[i].subject.examResult.score)).toFixed(1)%>
                                        <%}%>
                                    </td>
                                    <td>
                                        <%if (exam.examArranges[i].subject.examResult.status === 'MISS_EXAM') {%>
                                        缺考
                                        <%} else if(exam.examArranges[i].subject.examResult.pass) {%>
                                        <span style="color: #65cc4a;">通过</span>
                                        <%} else if(!exam.examArranges[i].subject.examResult.pass) {%>
                                        <span style="color: red;">未通过</span>
                                        <%}%>
                                    </td>
                                    <td>
                                        <div class="pe-stand-table-btn-group">
                                            <%if (exam.examArranges[i].subject.examType === 'ONLINE' && exam.examArranges[i].subject.examResult.status != 'MISS_EXAM' && exam.examArranges[i].subject.examSetting && exam.examArranges[i].subject.examSetting.examAuthType != 'NO_SEE') {%>
                                            <button type="button" title="答卷"
                                                    class="copy-btn pe-btn pe-icon-btn iconfont icon-my-examination" data-id="<%=exam.examArranges[i].subject.id%>">
                                            </button>
                                            <%}%>
                                            <%if (exam.examArranges[i].subject.examType === 'ONLINE' && exam.examArranges[i].subject.examResult.status === 'RELEASE') {%>
                                            <@authVerify authCode="VERSION_USER_OF_RESULT_ANALYSE">
                                                <button type="button" title="分析"
                                                        class="pe-btn pe-icon-btn iconfont icon-test-analysis"
                                                        data-id="<%=exam.examArranges[i].subject.id%>">
                                                </button>
                                            </@authVerify>

                                            <%}%>
                                            <%if (exam.examArranges[i].subject.examType === 'ONLINE' && exam.examArranges[i].subject.examSetting
                                            && exam.examArranges[i].subject.examSetting.rankSetting && exam.examArranges[i].subject.examSetting.rankSetting.rst != 'NO_SHOW') {%>
                                            <@authVerify authCode="VERSION_USER_OF_RANK">
                                                <button type="button" title="排行榜"
                                                        class="pe-btn pe-icon-btn iconfont rank-link icon-ranking-list"
                                                        data-id="<%=exam.examArranges[i].subject.id%>">
                                                </button>
                                            </@authVerify>

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
            <%});%>
            <%}else{%>
            <tr>
                <td class="pe-td pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
                    <div class="pe-result-no-date"></div>
                    <p class="pe-result-date-warn">暂无历史考试</p>
                </td>
            </tr>
            <%}%>
        </tbody>
    </table>
</script>
<script>

    $(function () {
        userControl.examResult.init();
    })
</script>