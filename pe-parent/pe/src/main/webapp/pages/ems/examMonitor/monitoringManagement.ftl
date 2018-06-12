<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">监控</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">考试监控</li>
    </ul>
</div>
<section class="exam-manage-all-wrap">
    <form id="examManageForm">
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-manage-panel-head">
                    <div class="pe-stand-filter-form">
                        <div class="pe-stand-form-cell" style="overflow: hidden;">
                            <label class="pe-form-label floatL" for="peMainKeyText">
                                <span class="pe-label-name floatL">关键字:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text" placeholder="考试名称/编号" name="examKey">
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
                        <div class="pe-stand-form-cell" style="overflow: hidden;">
                            <label class="pe-form-label floatL" for="peMainKeyText">
                                <span class="pe-label-name floatL">创建人:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text" placeholder="姓名/用户名/工号/手机号" name="createUser">
                            </label>
                            <dl class="floatL">
                                <dt class="pe-label-name floatL">&emsp;状&emsp;态:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox" name="examStatus" value="NO_START">未开始
                                    </label>
                                    <label class="floatL pe-checkbox" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" checked="checked" type="checkbox" name="examStatus" value="PROCESS">考试中
                                    </label>
                                    <label class="floatL pe-checkbox" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" type="checkbox" checked="checked" name="examStatus" value="OVER">已结束
                                    </label>
                                </dd>
                            </dl>
                            <button type="button" class="pe-btn pe-btn-blue floatL pe-monitor-choosen-btn">筛选</button>
                        </div>
                    </div>
                </div>
                <div class="pe-stand-table-panel">
                    <input type="hidden" name="order" value=""/>
                    <input type="hidden" name="sort" value=""/>
                    <div class="pe-stand-table-main-panel">
                        <div class="pe-stand-table-wrap"></div>
                        <div class="pe-stand-table-pagination"></div>
                    </div>
                    <#--<div class="pe-stand-table-main-panel" style="margin-top: 30px;">
                        <div class="pe-stand-table-wrap"></div>
                        <div class="pe-stand-table-pagination"></div>
                    </div>-->
                </div>
            </div>
        </div>
    </form>
</section>
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
                    <a class="pe-stand-table-alink pe-dark-font-name pe-ellipsis exam-batch-td view-exam"
                       title="<%=peData.rows[j].examName%>"
                       data-id="<%=peData.rows[j].id%>"><%=peData.rows[j].examName%>
                    </a>
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
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].createBy%>"><%=peData.rows[j].createBy%></div>
                </td>
                <td>
                    <div class="pe-ellipsis  <%if(peData.rows[j].examArranges &&(peData.rows[j].examArranges.length>1)){%>edit-arrange<%}%>"
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
                <td>
                    <%if(peData.rows[j].examType === 'COMPREHENSIVE') {%>
                    --
                    <%} else {%>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].joinNums%>"><%=peData.rows[j].joinNums%></div>
                    <%}%>
                </td>
                <td>
                    <%if(peData.rows[j].examType === 'COMPREHENSIVE') {%>
                    --
                    <%} else {%>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].joinedNums%>"><%=peData.rows[j].joinedNums%>
                    <%}%>
                </td>
            <#--状态-->
                <%if(peData.rows[j].status === 'NO_START'){%>
                <td>未开始</td>
                <%}else if(peData.rows[j].status === 'PROCESS'){%>
                <td>考试中</td>
                <%}else if(peData.rows[j].status === 'OVER'){%>
                <td>已结束</td>
                <%}else {%>
                <td></td>
                <%}%>
                <td>
                    <%if(peData.rows[j].examType != 'OFFLINE'){%>
                    <div class="pe-stand-table-btn-group">
                        <%if (peData.rows[j].examType === 'ONLINE' && peData.rows[j].canMonitor) {%>
                            <button type="button" title="总监控" class="pe-btn pe-icon-btn iconfont icon-master-control"
                                    data-id="<%=peData.rows[j].id%>">
                            </button>
                        <%}%>
                        <%if(peData.rows[j].examArranges.length === 1 && (peData.rows[j].examArranges[0].isAdmin||peData.rows[j].examArranges[0].canMonitor)&& ( peData.rows[j].status === 'NO_START' || peData.rows[j].status === 'PROCESS' || peData.rows[j].status === 'OVER')){%>
                        <button type="button" title="监控" class="pe-btn pe-icon-btn iconfont icon-monitor"
                                data-id="<%=peData.rows[j].examArranges[0].id%>">
                        </button>
                        <%}%>
                    </div>
                    <%}%>
                </td>
            </tr>

        <#--展开批次或科目的模板-->
            <%if(peData.rows[j].examArranges &&(peData.rows[j].examArranges.length>1)){%>
            <tr class="batch-tr batch-new-tr">
                <td colspan="9" style="padding:0;overflow:visible;">
                    <div class="exam-manage-batch-wrap">
                        <table class="exam-manage-batch-table">
                            <thead>
                            <tr style="height:1px;padding:0;">
                                <th style="width:12%"></th>
                                <th style="width:13%"></th>
                                <th style="width:5%"></th>
                                <th style="width:10%"></th>
                                <th style="width:32%"></th>
                                <th style="width:6%"></th>
                                <th style="width:6%"></th>
                                <th style="width:8%"></th>
                                <th style="width:8%"></th>
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
                                        <div class="pe-ellipsis" title="<%=peData.rows[j].examArranges[i].subject.examName%>">
                                            <%=peData.rows[j].examArranges[i].subject.examName%>
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
                                    <td title="<%=peData.rows[j].examArranges[i].subject.createBy%>"><div class="pe-ellipsis"><%=peData.rows[j].examArranges[i].subject.createBy%></div></td>
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
                                <td> <%=peData.rows[j].examArranges[i].testCount%></td>
                                <td><%=peData.rows[j].examArranges[i].joinedCount%></td>
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
                                        <%if (!peData.rows[j].examArranges[i].subject || peData.rows[j].examArranges[i].subject.examType != 'OFFLINE'){ %>
                                        <div class="pe-stand-table-btn-group">
                                            <%if((peData.rows[j].examArranges[i].arrangeStatus ===
                                            'PROCESS'||peData.rows[j].examArranges[i].arrangeStatus === 'NO_START' ||
                                            peData.rows[j].examArranges[i].arrangeStatus === 'OVER') && peData.rows[j].examArranges[i].canMonitor){%>
                                            <button type="button" title="监控"
                                                    class="pe-btn pe-icon-btn iconfont icon-monitor"
                                                    data-id="<%=peData.rows[j].examArranges[i].id%>">
                                            </button>
                                            <%}%>
                                        </div>
                                        <%}%>
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
    /*开始时间选择判断*/
    function startTimeValidate(startDom, endDom, chooseTime) {
        var $starDom = $(startDom);
        var nowTime = new Date().getTime();//选择日期点击时的当前时间
        var endTime = moment($(endDom).val()).valueOf();
        var chooseTime = moment(chooseTime).valueOf();//当前日历插件选择的时间

        /*小于当前时间校验*/
        if (chooseTime < nowTime) {
            $starDom.addClass('error');
            $('.validate-form-cell').find('em.error').eq(0).show().html('开始时间不能小于当前时间');
            $starDom.val('');
            return false;
        } else if (endTime && chooseTime > endTime) {
            /*大于结束时间校验*/
            $starDom.addClass('error');
            $('.validate-form-cell').find('em.error').eq(0).show().html('开始时间不能大于结束时间');
            $starDom.val('');
        } else if (chooseTime === endTime) {
            /*等于结束时间校验*/
            $starDom.addClass('error');
            $('.validate-form-cell').find('em.error').eq(0).show().html('开始时间不能等于结束时间');
            $starDom.val('');
        } else {
            if ($('.validate-form-cell').find('em.error').get(0)) {
                $('.validate-form-cell').find('em.error').html('').hide();
            }
            $starDom.removeClass('error');
        }

    }
    /*结束时间判断*/
    function endTimeValidate(startDom, endDom, chooseTime) {
        var $endDom = $(endDom);
        var nowTime = new Date().getTime();//选择日期点击时的当前时间
        if($(startDom).get(0)){
            var startTime = moment($(startDom).val()).valueOf();
        }else{
            var startTime = '';
        }
        var endTime = moment($(endDom).val()).valueOf();
        var chooseTime = moment(chooseTime).valueOf();//当前日历插件选择的时间

        if (startTime && (chooseTime < startTime)) {
            $endDom.addClass('error');
            $('.validate-form-cell').find('em.error').eq(0).show().html('结束时间不能小于开始时间');
            $endDom.val('');
            return false;

        } else if (chooseTime < nowTime) {
            $endDom.addClass('error');
            $('.validate-form-cell').find('em.error').eq(0).show().html('结束时间不能小于当前时间');
            $endDom.val('');
            return false;
        } else if (chooseTime === startTime) {
            /*等于开始时间校验*/
            $endDom.addClass('error');
            $('.validate-form-cell').find('em.error').eq(0).show().html('结束时间不能等于开始时间');
            $endDom.val('');
        } else {
            if ($('.validate-form-cell').find('em.error').get(0)) {
                $('.validate-form-cell').find('.error').html('').hide();
            }
            $endDom.removeClass('error');
        }
    }
    $(function () {
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        var peTableTitle = [
            {'title': '考试编号', 'width': 12, 'type': ''},
            {'title': '考试名称', 'type': 'examName', 'width': 13},
            {'title': '类型', 'width': 5, 'type': ''},
            {'title': '创建人', 'width': 10, 'type': '', 'name': 'indefinite'},//.name === 'indefinite'
            {'title': '考试时间', 'width': 32, 'type': '', 'order': true},
            {'title': '应到人数', 'width': 6, 'type': ''},
            {'title': '实到人数', 'width': 6, 'type': ''},
            {'title': '状态', 'width': 8, 'type': ''},
            {'title': '操作', 'width': 8}
        ];

        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/ems/examMonitor/manage/searchExam',
            formParam: $('#examManageForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'peExamManaTemp',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle //表格头部的数量及名称数组;
        });

        //监控
        $('.pe-stand-table-wrap').delegate('.icon-monitor', 'click', function () {
            var id = $(this).data('id');
            window.open(pageContext.rootPath + '/ems/examMonitor/manage/initMonitorDetailPage?arrangeId=' + id,"newWindow"+id);
        });

        //监控
        $('.pe-stand-table-wrap').delegate('.icon-master-control', 'click', function () {
            var id = $(this).data('id');
            window.open(pageContext.rootPath + '/ems/examMonitor/manage/initConsoleMonitorPage?examId=' + id,"newTime"+id);
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
        $('body').click(function (e) {
            var e = e || window.event;
            e.stopPropagation();
            var thisTarget = e.target || e.srcElement;
            if (!($(thisTarget).hasClass('exam-manage-batch-wrap') || $(thisTarget).parents('.pe-stand-table').get(0) || $(thisTarget).hasClass('exam-batch-td'))) {
                var $newTrs = $('.batch-new-tr');
                if ($newTrs.get(0)) {
                    $newTrs.hide();
                    $.each($newTrs, function (k, o) {
                        $(o).prev('tr').eq(0).find('.pe-ellipsis').removeClass('batch-active');
                        $(o).prev('tr').eq(0).find('.arrange-arrow')
                                .removeClass('icon-thin-arrow-up')
                                .addClass('icon-thin-arrow-down');
                    });
                }
            }
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

//        var start = {
//            elem: '#peExamStartTime',
//            format: 'YYYY-MM-DD hh:mm',
//            istime: true,
//            istoday: false,
//            choose: function (datas) {
//                end.min = datas; //开始日选好后，重置结束日的最小日期
//                end.start = datas;//将结束日的初始值设定为开始日
//            }
//        };
//        var end = {
//            elem: '#peExamEndTime',
//            format: 'YYYY-MM-DD hh:mm',
//            istime: true,
//            istoday: false,
//            choose: function (datas) {
//                start.max = datas; //结束日选好后，重置开始日的最大日期
//            }
//        };
//        laydate(start);
//        laydate(end);

        $('.pe-monitor-choosen-btn').on('click', function () {
            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
        });



    })
</script>
