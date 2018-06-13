<#assign ctx=request.contextPath/>
<div class="pe-manage-panel pe-manage-default" style="border:none;">
    <form id="waitMakingForm">
        <div class="pe-manage-panel-head">
            <div class="pe-stand-filter-form">
                <div class="simple-form-cell-wrap simaple-form-cell">
                    <div class="pe-stand-form-cell">
                        <label class="pe-form-label floatL" for="peMainKeyText"
                               style="margin-right:20px">
                            <span class="pe-label-name floatL" style="margin-right:5px;">关键字:</span>
                            <input id="peMainKeyText"
                                   class="pe-stand-filter-form-input pe-table-form-text" type="text"
                                   placeholder="考试名称/编号" name="examName">
                        </label>
                        <div class="over-flow-hide floatL" style="margin-right:26px;">
                            <div class="pe-time-wrap floatL">
                                <div data-toggle="datepicker" data-date-timepicker="true" class="control-group input-daterange">
                                    <label class="control-label pe-label-name floatL">考试时间：</label>
                                    <div class="controls pe-date-wrap">
                                        <input type="text" id="pePaperStartTime" name="startTime" class="pe-table-form-text input-medium input-date pe-time-text laydate-icon"><span>-</span>
                                        <input type="text" id="pePaperEndTime" name="endTime" class="pe-table-form-text input-medium input-date pe-time-text laydate-icon">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="pe-choosen-btn-wrap">
                            <button type="button" class="pe-btn pe-btn-blue pe-question-choosen-btn"
                                    style="margin-left: 0;">筛选
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            </div>
    </form>
<#--节点id取值-->
    <div class="pe-stand-table-panel">
        <div class="pe-stand-table-top-panel" style="height: 10px;">
        </div>
        <div class="pe-stand-table-main-panel">
            <div class="pe-stand-table-wrap"></div>
            <div class="pe-stand-table-pagination"></div>
        </div>
    </div>
</div>
<#--渲染表格模板-->
<script type="text/template" id="markedTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%=peData.tableTitles[i].title%>
                </th>
                <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%_.each(peData.rows,function(exam,index){%>
        <tr>
            <td><%=exam.examCode%></td>
            <td title="<%=exam.examName%>"><div class="pe-ellipsis"><%=exam.examName%></div></td>
            <td title="<%=exam.createUser%>"><div class="pe-ellipsis"><%=exam.createUser%></div></td>
            <td><%=moment(exam.startTime).format('YYYY-MM-DD HH:mm')%> ~ <%=moment(exam.endTime).format('YYYY-MM-DD HH:mm')%>
            </td>
            <td><%=exam.paperCount%></td>
            <td><%=exam.markedPaperCount%></td>
            <td><%=exam.myMarkedPaperCount%></td>
            <td><a href="${ctx!}/ems/judge/manage/initViewMarkingPage?examId=<%=exam.id%>" target="_blank" class="start-btn pe-icon-btn iconfont" title="查看详情" style="color: #777;">
                &#xe773;</a></td>
        </tr>
        <%})%>
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
<script type="text/javascript">
    $(function () {
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        var waitManage = {
            init: function () {
                var _this = this;
                _this.bind();
                _this.initData();
            },

            initData: function () {
                var _this = this;
                _this.renderData();
            },

            bind: function () {
                var _this = this;
                $('.pe-question-choosen-btn').on('click', function () {
                    _this.renderData();
                });
            },

            renderData: function () {
                var peTableTitle = [
                    {'title': '考试编号', 'width': 12},
                    {'title': '考试名称', 'width': 17},
                    {'title': '创建人', 'width': 10},
                    {'title': '考试时间', 'width': 24},
                    {'title': '总试卷数', 'width': 8},
                    {'title': '已评卷', 'width': 6},
                    {'title': '我评的', 'width': 7},
                    {'title': '操作', 'width': 8}
                ];

                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/judge/manage/searchMarked',
                    formParam: $('#waitMakingForm').serializeArray(),//表格上方表单的提交参数
                    tempId: 'markedTemp',//表格模板的id
                    title: peTableTitle, //表格头部的数量及名称数组;
                    onLoad: function () {
                    }
                });
            }
        };

        waitManage.init();
    });
</script>