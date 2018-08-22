<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">

</div>
<section class="exam-manage-all-wrap">
    <form id="scoreManageForm">
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                        <button type="button" class="pe-btn pe-btn-green create-exercise-btn">返回</button>
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
<script type="text/template" id="peExerManaTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%if(peData.tableTitles[i].order){%>
                    <div class="pe-th-wrap">
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
            <#-- <td>
                 <div class="pe-ellipsis" title="<%=peData.rows[j].code%>"><%=peData.rows[j].code%>
                 </div>
             </td>-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].name%>"><%=peData.rows[j].name%>
                    </div>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].score%>"><%=peData.rows[j].score%>
                    </div>
                </td>
                <td>
                    <div class="pe-stand-table-btn-group">
                        <button type="button" class="edit-btn pe-icon-btn iconfont icon-edit" title="编辑"
                                data-id="<%=peData.rows[j].id%>"></button>
                    </div>
                </td>
            </tr>
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

<script type="text/template" id="confirmDialogUpdate">
    <div>
        <form id="library_detail_update_form">
            <input type="hidden" name="id" value="<%=data.id%>">
            <input type="hidden" name="code" value="<%=data.code%>">
            <div class="pe-add-question-text">
                <input type="hidden" name="name" value="<%=data.name%>">
                <span class="pe-label-name floatL introduction-info">规则名称:</span>
                <input class="pe-stand-filter-form-input" maxlength="50" type="text" style="color:#ccc;" disabled value="<%=data.name%>">
            </div>
            <div class="pe-add-question-text">
                <span class="pe-label-name floatL introduction-info">规则分值:</span>
                <input class="pe-stand-filter-form-input" max="1000" type="number"
                       placeholder="请输入规则分值" name="score" value="<%=data.score%>">
            </div>
        </form>
        <div class="pe-main-km-text-wrap">
            <div class="pe-km-search-key pe-input-tree-wrap pe-stand-filter-form-input" style="display: none">

            </div>
        </div>
    </div>
</script>

<script>
    $(function () {
        var peTableTitle = [
//            {'title': '规则编号', 'width': 30},
            {'title': '规则名称', 'width': 60},
            {'title': '积分值', 'width': 20},
            {'title': '操作', 'width': 20}
        ];

        var exerciseManage = {
            init: function () {
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/score/manage/search',
                    formParam: $('#scoreManageForm').serializeArray(),
                    tempId: 'peExerManaTemp',
                    showTotalDomId: 'showTotal',
                    title: peTableTitle
                });
                var _this = this;
                _this.bind();
            },

            bind: function () {
                $('.create-exercise-btn').on('click', function () {
                    parent.$('#yunContentBody').html('<iframe style="width:100%;height: 100%;margin-left:0;" src="/km/front/manage/initPage#url=/km/score/manage/initPage"></iframe>');
                });

                $('.pe-stand-table-main-panel').delegate('.edit-btn', 'click', function () {
                    var id = $(this).data("id");
                    var data = {};
                    $.ajax({
                        async: false,//此值要设置为FALSE  默认为TRUE 异步调用
                        type: "POST",
                        url: pageContext.resourcePath + '/score/manage/load',
                        data: {'ruleId': id},
                        dataType: 'json',
                        success: function (result) {
                            data = result;
                        }
                    });
                    PEMO.DIALOG.confirmL({
                        content: _.template($('#confirmDialogUpdate').html())({data: data}),
                        area: ['800px', '240px'],
                        title: '编辑积分规则',
                        btn: ['保存', '取消'],
                        btnAlign: 'l',
                        skin: 'project-introduction-add',
                        success: function () {
                        },
                        btn1: function () {
                            PEBASE.ajaxRequest({
                                //此处要返回给我新的修改过的节点的id，好和旧的的id进行比较从而是否刷新树节点
                                url: pageContext.rootPath + '/score/manage/updateRule',
                                data: $("#library_detail_update_form").serialize(),
                                success: function (data) {
                                    var message;
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '编辑成功',
                                            time: 1000,
                                            end: function () {
                                                layer.closeAll('page');
                                            }
                                        });
                                        $('.pe-stand-table-wrap').peGrid('load', $('#scoreManageForm').serializeArray());
                                        return false;
                                    } else if (data.message == "NAME_EMPTY") {
                                        message = '项目名称不可为空！';
                                    } else if (data.message == "NAME_REPEAT") {
                                        message = '项目名称已存在！';
                                    } else {
                                        message = '编辑失败！';
                                    }

                                    PEMO.DIALOG.alert({
                                        content: message,
                                        btn: ['我知道了'],
                                        yes: function (index) {
                                            layer.close(index);
                                            success();
                                        }
                                    });
                                }
                            });
                        }
                    });
                })

            }
        };
        exerciseManage.init();
    })

</script>
<link rel="stylesheet" href="${resourcePath!}/web-static/proExam/index/css/index.css">