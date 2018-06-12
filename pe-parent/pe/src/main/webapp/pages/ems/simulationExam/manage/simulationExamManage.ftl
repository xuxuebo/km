<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">模拟考试</li>
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
                            <label class="pe-form-label" for="peMainKeyText">
                                <span class="pe-label-name floatL">创建人:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="姓名/用户名/工号/手机号"
                                       name="createUser">
                            </label>
                        </div>
                        <div class="pe-stand-form-cell">
                            <dl class="over-flow-hide floatL">
                                <dt class="pe-label-name floatL">状&emsp;态:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                        <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examStatus" value="ENABLE"/>启用
                                    </label>
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examStatus" value="DISABLE"/>停用
                                    </label>
                                </dd>
                            </dl>
                            <button type="button"
                                    class="pe-btn pe-btn-blue pe-question-choosen-btn exam-manage-choosen-btn">筛选
                            </button>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="id" value="<%=data.id%>">
                <input type="hidden" name="order" value=""/>
                <input type="hidden" name="sort" value=""/>
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                    <@authVerify authCode="EXAM_MANAGE_ADD_ONLINE">
                        <button type="button" class="pe-btn pe-btn-green create-online-btn">创建模拟考试
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
            <lenI ;i++){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%if(peData.tableTitles[i].order){%>
                    <div class="pe-th-wrap" data-type="publishTime">
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
        <lenJ ;j++){%>
            <tr data-id="<%=peData.rows[j].id%>">
            <#--考试编号-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].mockCode%>"><%=peData.rows[j].mockCode%></div>
                </td>
            <#--考试名称-->
                <td>
                    <a class="pe-stand-table-alink pe-dark-font pe-ellipsis exam-batch-td view-exam"
                       title="<%=peData.rows[j].examName%>"
                       data-id="<%=peData.rows[j].id%>"><%=peData.rows[j].examName%>
                    </a>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].createBy%>"><%=peData.rows[j].createBy%></div>
                </td>
                <%if(peData.rows[j].endTime){%>
                <td>
                    <div class="pe-ellipsis"
                         title="<%=peData.rows[j].startTimeStr%><%if(peData.rows[j].startTimeStr||peData.rows[j].endTimeStr){%>~<%}%><%=peData.rows[j].endTimeStr%>">
                        <%=peData.rows[j].startTimeStr%><%if(peData.rows[j].startTimeStr||peData.rows[j].endTimeStr){%>~<%}%><%=peData.rows[j].endTimeStr%>
                    </div>
                </td>
                <%}else{%>
                <td>不限制</td>
                <%}%>
            <#--状态-->
                <%if(peData.rows[j].status === 'ENABLE'){%>
                <td>启用</td>
                <%}else if(peData.rows[j].status === 'DISABLE'){%>
                <td>停用</td>
                <%}else {%>
                <td></td>
                <%}%>
                <td>
                    <div class="pe-stand-table-btn-group">
                        <button type="button" class="edit-btn pe-icon-btn iconfont icon-edit" title="编辑"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <button type="button" class="stop-btn pe-icon-btn iconfont icon-stop" title="停用"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <button type="button" class="count-btn pe-icon-btn iconfont icon-void" title="统计"
                                data-id="<%=peData.rows[j].id%>"></button>
                    </div>
                </td>
            </tr>

        <#--展开批次或科目的模板-->
            <%if(peData.rows[j].examArranges &&(peData.rows[j].examArranges.length>1)){%>
            <tr class="batch-tr batch-new-tr">
                <td colspan="7" style="padding:0;">
                    <div class="exam-manage-batch-wrap">
                        <table class="exam-manage-batch-table">
                            <thead>
                            <tr style="height:1px;padding:0;">
                                <th style="width:15%;"></th>
                                <th style="width:15%"></th>
                                <th style="width:5%"></th>
                                <th style="width:10%"></th>
                                <th style="width:25%"></th>
                                <th style="width:5%"></th>
                                <th style="width:15%"></th>
                            </tr>
                            </thead>
                            <tbody>
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
        var peTableTitle = [
            {'title': '考试编号', 'width': 15, 'type': ''},
            {'title': '考试名称', 'type': 'examName', 'width': 15},
            {'title': '创建人', 'width': 10, 'type': '', 'name': 'indefinite'},//.name === 'indefinite'
            {'title': '考试时间', 'width': 25, 'type': '', 'order': true},
            {'title': '状态', 'width': 5, 'type': ''},
            {'title': '操作', 'width': 15}
        ];

        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/ems/simulationExam/manage/search',
            formParam: $('#examManageForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'peExamManaTemp',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle //表格头部的数量及名称数组;
        });

        /*点击批次弹出批次展示框的事件*/
        $('.pe-stand-table-wrap').delegate('.edit-arrange', 'click', function (e) {
            var e = e || window.event;
            e.stopPropagation();
            var id = $(this).attr('data-id');
            var thisBatch = $(this).parents('tr').next('.batch-new-tr');
            if (!($(this).parents('tr').next('.batch-new-tr:visible').get(0))) {
                $('.batch-new-tr:visible').prev('tr').eq(0).find('.edit-arrange')
                        .removeClass('icon-thin-arrow-up')
                        .addClass('icon-thin-arrow-down');
            }
            $('.batch-new-tr:visible').prev('tr').eq(0).find('.pe-ellipsis').removeClass('batch-active');
            $('.batch-new-tr:visible').hide();
            if ($(this).hasClass('icon-thin-arrow-down')) {
                $(this).parent('.pe-ellipsis').addClass('batch-active');
                $(this).removeClass('icon-thin-arrow-down').addClass('icon-thin-arrow-up');
                thisBatch.show();
            } else {
                thisBatch.hide();
                $(this).parent('.pe-ellipsis').removeClass('batch-active');
                $(this).removeClass('icon-thin-arrow-up').addClass('icon-thin-arrow-down');
            }

        });
        /*页面监听，关闭批次展开的表格*/
        $('body').click(function (e) {
            var e = e || window.event;
            e.stopPropagation();
            var thisTarget = e.target || e.srcElement;
//            if($('.layui-layer-shade:visible').get(0)){
//                return false;
//            }
            if (!($(thisTarget).hasClass('exam-manage-batch-wrap') || $(thisTarget).parents('.pe-stand-table').get(0) || $(thisTarget).hasClass('exam-batch-td'))) {
                var $newTrs = $('.batch-new-tr');
                if ($newTrs.get(0)) {
                    $newTrs.hide();
                    $.each($newTrs, function (k, o) {
                        $(o).prev('tr').eq(0).find('.pe-ellipsis').removeClass('batch-active');
                        $(o).prev('tr').eq(0).find('.edit-arrange')
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

        $('.exam-manage-choosen-btn').on('click', function () {
            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
        });

        $('.create-online-btn').click(function () {
            location.href = '#url=' + pageContext.rootPath + '/ems/simulationExam/manage/initSimulationExamInfo?examType=ONLINE&nav=examMana';
        });

        $('.offline-btn').click(function () {
            location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initExamInfo?examType=OFFLINE&nav=examMana';
        });

        $('.comprehensive-btn').click(function () {
            location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initExamInfo?examType=COMPREHENSIVE&nav=examMana';
        });


        $('.pe-stand-table-wrap').delegate('.icon-edit', 'click', function () {
            var id = $(this).data('id');
            location.href = '#url=' + pageContext.rootPath + '/ems/simulationExam/manage/initSimulationExamInfo?id=' + id + '&isTransient=f&optType=UPDATE&&nav=examMana';
        });
        //考试统计
        $('.pe-stand-table-wrap').delegate('.count-btn', 'click', function () {
            var id = $(this).data('id');
            /*location.href = '#url=' + pageContext.rootPath + '/ems/simulationExam/manage/mockExamAnalyze?examId=' + id;*/
            window.open(pageContext.rootPath + '/ems/simulationExam/manage/mockExamAnalyze?examId=' + id);

        });


        //考试作废
        $('.pe-stand-table-wrap').delegate('.stop-btn', 'click', function () {
            var id = $(this).data('id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定作废该场考试么？</h3><p class="pe-dialog-content-tip">作废后，考试不可以恢复，请谨慎操作。</p></div>',
                btn2: function () {
                    $.post(pageContext.rootPath + '/ems/simulationExam/manage/cancelExam', {'examId': id}, function (data) {
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
        //编辑科目新页面
        $('.pe-stand-table-wrap').delegate('.subject-edit-btn', 'click', function () {
            var id = $(this).data('id');
            window.open(pageContext.rootPath + '/front/manage/initPage#url=' + pageContext.rootPath
                    + '/ems/exam/manage/initExamInfo?optType=UPDATE&source=ADD&id=' + id + '&nav=examMana');
        });
    })
</script>