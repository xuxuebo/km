<#assign ctx=request.contextPath/>

<section class="exam-manage-all-wrap">
    <form id="examManageForm">
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">

                <input type="hidden" name="subject" value="false">
                <input type="hidden" name="libraryId" value="${libraryId!}">

                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">

                        <button type="button" class="pe-btn pe-btn-green create-online-btn">下载</button>

                        <button type="button" class="pe-btn pe-btn-green offline-btn">复制到我的云库</button>
                    </div>

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
<script type="text/template" id="publicTableTemp">
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
                    <#--<%if(peData.rows[j].examType !== 'ONLINE'){%>-->
                    <#--<button type="button" title="导出试卷" class="pe-btn pe-icon-btn iconfont icon-daochushijuan"></button>-->
                    <#--<button type="button" title="导出答案" class="pe-btn pe-icon-btn iconfont icon-daochudaan"></button>-->
                    <#--<%}%>-->
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



<script>

    $(function () {
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        var peTableTitle = [
            {'title': '文件名', 'width': 15, 'type': ''},
            {'title': '大小', 'type': 'examName', 'width': 15},
            {'title': '上传日期', 'width': 5, 'type': ''},
            {'title': '创建人', 'width': 7, 'type': '', 'name': 'indefinite'},//.name === 'indefinite'
            {'title': '考试时间', 'width': 28, 'type': '', 'order': true},
            {'title': '状态', 'width': 5, 'type': ''},
            {'title': '操作', 'width': 15}
        ];

        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/knowledge/publicLibraryData',
            formParam: $('#examManageForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'publicTableTemp',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle //表格头部的数量及名称数组;
        });


        //复制
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







    })

</script>