<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">用户</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">公司管理</li>
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
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="公司名称/编号" name="corpName">
                            </label>
                            <label class="pe-form-label floatL" for="peMainKeyText">
                                <span class="pe-label-name floatL">创建人:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="姓名/用户名/工号/手机号" name="createBy">
                            </label>
                            <dl class="floatL" style="margin-left: 30px;">
                                <dt class="pe-label-name floatL">状态:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="floatL pe-checkbox pe-uc-state-checkbox" for=""
                                           style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input checked="checked" class="pe-form-ele" type="checkbox" name="statuses"
                                               value="DRAFT"/>草稿
                                    </label>
                                    <label class="floatL pe-checkbox pe-uc-state-checkbox" for=""
                                           style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input checked="checked" class="pe-form-ele" type="checkbox" name="statuses"
                                               value="ENABLE"/>正常
                                    </label>
                                    <label class="floatL pe-checkbox pe-uc-freeze-checkbox" style="margin-right:15px;">
                                        <span class="iconfont icon-unchecked-checkbox"></span>
                                        <input type="checkbox" class="pe-form-ele" name="statuses" value="OVER"/>已到期
                                    </label>
                                    <label class="floatL pe-checkbox pe-uc-freeze-checkbox" for="">
                                        <span class="iconfont icon-unchecked-checkbox"></span>
                                        <input type="checkbox" class="pe-form-ele" name="statuses" value="DISABLE"/>已冻结
                                    </label>
                                </dd>
                            </dl>
                            <button type="button" class="pe-btn pe-btn-blue floatL" id="filterBtn"
                                    style="margin-left: 30px;">筛选
                            </button>
                        </div>
                    </div>
                </div>
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel" style="font-size:0;">
                        <button type="button" class="pe-btn pe-btn-green" id="editCorpBtn">创建公司</button>
                        <button type="button" class="pe-btn pe-btn-primary" id="operaPlat">运营平台</button>
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
            <tr>
                <td>
                    <%=peData.rows[j].corpCode%>
                </td>
                <td>
                    <a class="pe-stand-table-alink pe-dark-font-name pe-ellipsis exam-batch-td view-corp"
                       title="<%=peData.rows[j].corpName%>"
                       data-id="<%=peData.rows[j].id%>" style="cursor: pointer;"><%=peData.rows[j].corpName%>
                    </a>
                </td>
                <td><%=peData.rows[j].createUser?peData.rows[j].createUser.userName:'--'%></td>
                <td><%=peData.rows[j].concurrentNum%></td>
                <td><%=peData.rows[j].registerNum%></td>
                <td><%=peData.rows[j].corpStatus === 'DRAFT'?'--':peData.rows[j].usedNum%></td>
                <td><%=moment(peData.rows[j].createTime).format('YYYY-MM-DD')%></td>
                <td><%=peData.rows[j].endTime?moment(peData.rows[j].endTime).format('YYYY-MM-DD'):'永久'%></td>
                <td><%if(peData.rows[j].fromAppType === 'ELP'){%>时代光华<%}else if(peData.rows[j].fromAppType === 'PE'){%>博易考<%}%></td>
                <%if (peData.rows[j].corpStatus === 'DRAFT') {%>
                <td>草稿</td>
                <%} else if (peData.rows[j].corpStatus === 'DISABLE'){%>
                <td>已冻结</td>
                <%} else if(peData.rows[j].corpStatus === 'OVER') {%>
                <td>已到期</td>
                <%} else {%>
                <td>正常</td>
                <%}%>
                <td>
                    <div class="pe-stand-table-btn-group">
                        <%if(peData.rows[j].corpStatus === 'ENABLE'){%>
                        <button type="button" class="stop-btn pe-icon-btn iconfont icon-stop" title="停用"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}else if(peData.rows[j].corpStatus === 'DRAFT' || peData.rows[j].corpStatus === 'DISABLE'){%>
                        <button type="button" class="start-btn pe-icon-btn iconfont icon-start" title="启用"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}%>
                        <button type="button" class="edit-btn pe-icon-btn iconfont icon-edit" title="编辑"
                                data-id="<%=peData.rows[j].id%>"></button>
                    </div>
                </td>
            </tr>
            <%}} else {%>
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
            {'title': '企业编号', 'width': 8},
            {'title': '企业名称', 'width': 8},
            {'title': '创建人', 'width': 8},
            {'title': '最大并发数', 'width': 8},//.name === 'indefinite'
            {'title': '最大账号注册数', 'width': 8},
            {'title': '已使用账号数', 'width': 8},
            {'title': '创建时间', 'width': 8},
            {'title': '账号到期时间', 'width': 10},
            {'title': '来源', 'width': 8},
            {'title': '状态', 'width': 8},
            {'title': '操作', 'width': 10}
        ];

        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/corp/manage/search',
            formParam: $('#examManageForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'peExamManaTemp',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle //表格头部的数量及名称数组;
        });

        $('#editCorpBtn').on('click', function () {
            location.href = '#url=' + pageContext.rootPath + '/corp/manage/initEditPage?nav=user';
        });

        $('#operaPlat').on('click', function () {
            window.open(pageContext.rootPath + '/bg/manage/initBackGround');
        });

        $('#filterBtn').on('click', function () {
            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
        });

        $('.pe-stand-table-wrap').delegate('.icon-edit', 'click', function () {
            var id = $(this).data('id');
            location.href = '#url=' + pageContext.rootPath + '/corp/manage/initEditPage?corpId=' + id + '&nav=user';
        });

        $('.pe-stand-table-wrap').delegate('.view-corp', 'click', function () {
            var id = $(this).data('id');
            location.href = '#url=' + pageContext.rootPath + '/corp/manage/initViewPage?corpId=' + id + '&nav=user';
        });

        $('.pe-stand-table-wrap').delegate('.icon-start', 'click', function () {
            var id = $(this).data('id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定启用该公司么？</h3></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/corp/manage/enableCorp',
                        data: {corpId: id},
                        success: function (data) {
                            PEMO.DIALOG.tips({
                                content: '启用成功',
                                time: 2000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });

                            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
                        }
                    });
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });
        $('.pe-stand-table-wrap').delegate('.icon-stop', 'click', function () {
            var id = $(this).data('id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定冻结该公司么？</h3></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/corp/manage/disableCorp',
                        data: {corpId: id},
                        success: function (data) {
                            PEMO.DIALOG.tips({
                                content: '冻结成功',
                                time: 2000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });

                            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
                        }
                    });
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });


    });
</script>
