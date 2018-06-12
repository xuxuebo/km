<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">成绩</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">查询成绩</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">按考试查看</li>
    </ul>
</div>
<section class="exam-manage-all-wrap">
    <form id="examManageForm">
        <input type="hidden" name="order"/>
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-manage-panel-head">
                    <div class="pe-stand-filter-form">
                        <div class="pe-stand-form-cell">
                            <label class="pe-form-label floatL" for="peMainKeyText">
                                <span class="pe-label-name floatL">关键字:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="考试名称/编号"
                                       name="examName">
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
                                        <span class="iconfont icon-unchecked-checkbox"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" type="checkbox"
                                               name="examTypes" value="COMPREHENSIVE"/>综合
                                    </label>
                                </dd>
                            </dl>
                            <button type="button" id="queryCondition" class="pe-btn pe-btn-blue"
                                    style="margin-left: 20px;">筛选
                            </button>
                        </div>
                    </div>
                </div>
                <div class="pe-stand-table-panel">
                <#--  <div class="pe-stand-table-top-panel">
                      <button type="button" class="pe-btn pe-btn-green create-online-btn">导出当前结果</button>
                      <button type="button" class="pe-btn pe-btn-white offline-btn">导出全部考试</button>
                      <button type="button" class="pe-btn pe-btn-white comprehensive-btn creat-offline-btn">导出答卷人员
                      </button>
                  </div>-->
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
        <%for(var j =0,lenJ = peData.rows.length;j
        <lenJ
                ;j++){%>
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
                <td>
                    <div class="pe-ellipsis <%if(peData.rows[j].examArranges &&(peData.rows[j].examArranges.length>1)){%>edit-arrange<%}%>"
                         title="<%=moment(peData.rows[j].startTime).format('YYYY-MM-DD HH:mm')%>~<%=moment(peData.rows[j].endTime).format('YYYY-MM-DD HH:mm')%>">
                        <%=moment(peData.rows[j].startTime).format('YYYY-MM-DD HH:mm')%>~<%=moment(peData.rows[j].endTime).format('YYYY-MM-DD HH:mm')%>
                        <%if(peData.rows[j].examArranges &&(peData.rows[j].examArranges.length>1)){%>
                    <span class="exam-batch-td">(<span
                            style="color:#199ae2;"><%=peData.rows[j].examArranges.length%></span>)</span>
                        <span class="arrange-arrow iconfont icon-thin-arrow-down "
                              data-id="<%=peData.rows[j].id%>"></span>
                        <%}%>
                    </div>
                </td>
            <#--试卷类型-->
                <%if(peData.rows[j].examType === 'ONLINE'){%>
                <td><div class="pe-ellipsis">线上</div></td>
                <%}else if(peData.rows[j].examType === 'OFFLINE'){%>
                <td><div class="pe-ellipsis">线下</div></td>
                <%}else if(peData.rows[j].examType === 'COMPREHENSIVE'){%>
                <td>综合</td>
                <%}else {%>
                <td></td>
                <%}%>
            <#--状态-->
                <%if(peData.rows[j].examType==='COMPREHENSIVE'){%>
                <td><%=peData.rows[j].examArranges[0].testCount%></td>
                <%}else{%>
                <td><%=peData.rows[j].testCount%></td>
                <%}%>
                <td><%=peData.rows[j].passCount%></td>
                <td><%=peData.rows[j].noPassCount%></td>
                <td><%=peData.rows[j].markingCount%></td>
                <td><%=peData.rows[j].missCount%></td>
                <td><%if (peData.rows[j].status === 'CANCEL') {%>已作废<%} else if(peData.rows[j].markingCount != 0) {%>评卷中<%} else {%>评卷结束<%}%></td>
                <td>
                    <div class="pe-stand-table-btn-group">
                        <%if(peData.rows[j].examType === 'OFFLINE'){%>
                        <button type="button" title="修改导入"
                                class="copy-btn pe-btn pe-icon-btn iconfont icon-import-the-results" <%if (peData.rows[j].status === 'CANCEL') {%>disabled<%}%> data-id="<%=peData.rows[j].id%>">
                        </button>
                        <%} else if(peData.rows[j].examArranges &&(peData.rows[j].examArranges.length <= 1)){%>
                        <@authVerify authCode="VERSION_OF_EXAM_RE_EVALUATION">
                            <button type="button" title="复评" class="copy-btn pe-btn pe-icon-btn iconfont icon-re"
                            <%if ((peData.rows[j].passCount===0 && peData.rows[j].noPassCount ===0) ||
                            peData.rows[j].examType === 'COMPREHENSIVE' || peData.rows[j].status === 'CANCEL')
                            {%>disabled<%}%>
                                data-id="<%=peData.rows[j].examArranges[0].id%>">
                            </button>
                        </@authVerify>
                        <%}%>
                        <button type="button" title="分析" class="copy-btn pe-btn pe-icon-btn iconfont icon-test-analysis" <%if (peData.rows[j].examType === 'OFFLINE' || peData.rows[j].status === 'CANCEL' || peData.rows[j].markingCount != 0 || (peData.rows[j].passCount===0 && peData.rows[j].noPassCount ===0)) {%>disabled<%}%>
                        data-id="<%=peData.rows[j].id%>" data-type="<%=peData.rows[j].examType%>">
                        </button>
                    </div>
                </td>
            </tr>

        <#--展开批次或科目的模板-->
            <%if(peData.rows[j].examArranges &&(peData.rows[j].examArranges.length>1)){%>
            <tr class="batch-tr batch-new-tr">
                <td colspan="10" style="padding:0;overflow:visible;">
                    <div class="exam-manage-batch-wrap">

                        <table class="exam-manage-batch-table">
                            <tr style="height:1px;padding:0;">
                                <th style="width:12%;"></th>
                                <th style="width:15%"></th>
                                <th style="width:30%"></th>
                                <th style="width:5%"></th>
                                <th style="width:5%"></th>
                                <th style="width:5%"></th>
                                <th style="width:5%"></th>
                                <th style="width:5%"></th>
                                <th style="width:5%"></th>
                                <th style="width:8%"></th>
                                <th style="width:5%"></th>
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
                                    <td><div class="pe-ellipsis">科目<%=i+1%></div></td>
                                    <td>
                                        <a class="pe-stand-table-alink pe-dark-font pe-ellipsis exam-batch-td view-exam"
                                           title="<%=peData.rows[j].examArranges[i].subject.examName%>"
                                           data-id="<%=peData.rows[j].examArranges[i].subject.id%>"><%=peData.rows[j].examArranges[i].subject.examName%>
                                        </a>
                                    </td>
                                    <td>
                                        <div class="pe-ellipsis"
                                             title="<%=peData.rows[j].examArranges[i].startTimeStr%><%if(peData.rows[j].examArranges[i].startTimeStr
                                                 ||peData.rows[j].examArranges[i].endTimeStr){%>~<%}%><%=peData.rows[j].examArranges[i].endTimeStr%>">
                                            <%=peData.rows[j].examArranges[i].startTimeStr%>
                                            <%if(peData.rows[j].examArranges[i].startTime||peData.rows[j].examArranges[i].endTime){%>~<%}%><%=peData.rows[j].examArranges[i].endTimeStr%>
                                        </div>
                                    </td>
                                <#--科目类型-->
                                    <%if(peData.rows[j].examArranges[i].subject.examType === 'ONLINE'){%>
                                    <td>线上</td>
                                    <%}else if(peData.rows[j].examArranges[i].subject.examType === 'OFFLINE'){%>
                                    <td>线下</td>
                                    <%}else {%>
                                    <td></td>
                                    <%}%>
                                    <%}else{%>
                                    <td></td>
                                    <td>
                                        <div class="pe-ellipsis" title="<%=peData.rows[j].examArranges[i].batchName%>"><%=peData.rows[j].examArranges[i].batchName%></div>
                                    </td>
                                    <td>
                                        <div class="pe-ellipsis"
                                             title="<%=peData.rows[j].examArranges[i].startTimeStr%><%if(peData.rows[j].examArranges[i].startTimeStr
                                                 ||peData.rows[j].examArranges[i].endTimeStr){%>~<%}%><%=peData.rows[j].examArranges[i].endTimeStr%>">
                                            <%=peData.rows[j].examArranges[i].startTimeStr%>
                                            <%if(peData.rows[j].examArranges[i].startTime||peData.rows[j].examArranges[i].endTime){%>~<%}%><%=peData.rows[j].examArranges[i].endTimeStr%>
                                        </div>
                                    </td>
                                    <td></td>
                                    <%}%>
                                    <td><%=peData.rows[j].examArranges[i].testCount%></td>
                                    <td><%=peData.rows[j].examArranges[i].passCount%></td>
                                    <td><%=peData.rows[j].examArranges[i].noPassCount%></td>
                                    <td><%=peData.rows[j].examArranges[i].markingCount%></td>
                                    <td><%=peData.rows[j].examArranges[i].missCount%></td>
                                    <td><%if (peData.rows[j].examArranges[i].status === 'CANCEL') {%>已作废<%} else if(peData.rows[j].examArranges[i].markingCount != 0) {%>评卷中<%} else {%>评卷结束<%}%></td>
                                    <td>
                                        <div class="pe-stand-table-btn-group">
                                            <%if (peData.rows[j].examType === 'COMPREHENSIVE' && peData.rows[j].examArranges[i].subject.examType === 'OFFLINE') {%>
                                            <button type="button" title="修改导入"
                                                    class="copy-btn pe-btn pe-icon-btn iconfont icon-import-the-results" <%if (peData.rows[j].examArranges[i].status === 'CANCEL' || peData.rows[j].status === 'CANCEL') {%>disabled<%}%>
                                            data-id="<%=peData.rows[j].examArranges[i].exam.id%>">
                                            </button>
                                            <%} else if(peData.rows[j].examType != 'OFFLINE') {%>
                                            <button type="button" title="复评" class="copy-btn pe-btn pe-icon-btn iconfont icon-re" <%if ((peData.rows[j].examArranges[i].passCount===0 && peData.rows[j].examArranges[i].noPassCount ===0) || peData.rows[j].status === 'CANCEL') {%>disabled<%}%>
                                            data-id="<%=peData.rows[j].examArranges[i].id%>">
                                            </button>
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
            {'title': '考试编号', 'width': 12, 'type': ''},
            {'title': '考试名称', 'type': 'examName', 'width': 12},
            {'title': '考试时间', 'width': 34, 'type': '', 'order': true},
            {'title': '类型', 'width': 5, 'type': ''},
            {'title': '应考', 'width': 5, 'type': ''},
            {'title': '通过', 'width': 5, 'type': ''},
            {'title': '未通过', 'width': 5, 'type': ''},
            {'title': '评卷中', 'width': 5, 'type': ''},
            {'title': '缺考', 'width': 5, 'type': ''},
            {'title': '状态', 'width': 8, 'type': ''},
            {'title': '操作', 'width': 5}
        ];

        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/ems/examResult/manage/searchResult',
            formParam: $('#examManageForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'peExamManaTemp',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle //表格头部的数量及名称数组;
        });

        //表格考试时间排序点击事件
        $('.pe-stand-table-wrap').delegate('.level-order-up', 'click', function () {
            $(this).addClass('curOrder');
            $(this).siblings('.level-order-down').removeClass('curOrder');
            var thisType = $(this).parent('.pe-th-wrap').attr('data-type');
            $('input[name="order"]').val('asc');
            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
        });

        $('.pe-stand-table-wrap').delegate('.level-order-down', 'click', function () {
            $(this).addClass('curOrder');
            $(this).siblings('.level-order-up').removeClass('curOrder');
            var thisType = $(this).parent('.pe-th-wrap').attr('data-type');
            $('input[name="order"]').val('desc');
            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
        });

        $('#queryCondition').on('click', function () {
            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
        });

        $('.pe-stand-table-wrap').delegate('.view-exam', 'click', function () {
            var examId = $(this).data('id');
            window.open("${ctx}/ems/examResult/manage/initUserDetail?examId=" + examId,'');
        });

        $('.pe-stand-table-wrap').delegate('.icon-re', 'click', function () {
            var arrangeId = $(this).data('id');
            window.open("${ctx}/ems/examResult/manage/reviewResult?arrangeId=" + arrangeId,'');
        });

        $('.pe-stand-table-wrap').delegate('.icon-import-the-results', 'click', function () {
            var examId = $(this).data('id');
            window.open("${ctx}/ems/examResult/manage/initImportTemplate?optType=UPDATE&id=" + examId,'');
        });

        $('.pe-stand-table-wrap').delegate('.icon-test-analysis', 'click', function () {
            var examId = $(this).data('id');
            window.open("${ctx}/ems/resultReport/manage/initStatisticPage?examId=" + examId,'');
        });
        $('.create-online-btn').on('click', function () {
            location.href = pageContext.rootPath + '/ems/examResult/manage/exportResults?' + $('#examManageForm').serialize();
        });

        /*点击批次弹出批次展示框的事件*/
        $('.pe-stand-table-wrap').delegate('.edit-arrange', 'click', function (e) {
            var e = e || window.event;
            e.stopPropagation();
            var _thisArrow = $(this).find('.arrange-arrow');
            var id = $(this).attr('data-id');
            var thisBatch = $(this).parents('tr').next('.batch-new-tr');
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

    });
</script>