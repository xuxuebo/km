<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">

</div>
<section class="exam-manage-all-wrap">
    <form id="labelManageForm">
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                        <button type="button" class="pe-btn pe-btn-green create-exercise-btn">新增标签</button>
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
            <%for(var i =0,lenI = peData.tableTitles.length;i<lenI;i++){%>
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
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
            <tr data-id="<%=peData.rows[j].id%>">
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].labelName%>"><%=peData.rows[j].labelName%>
                    </div>
                </td>

                <td>
                    <div class="pe-stand-table-btn-group">
                        <button type="button" class="edit-btn pe-icon-btn iconfont icon-edit" title="编辑"
                                data-id="<%=peData.rows[j].id%>"
                                data-name="<%=peData.rows[j].labelName%>"></button>
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
<script type="text/template" id="confirmDialogTemp">
    <div class="clearF">
        <label class="floatL">
            <form id="label_detail_form">
                <input type="hidden" name="parentId" value="*">
                <span class="pe-label-name floatL"><%=data.firstName%>:</span>
                <input class="pe-stand-filter-form-input" maxlength="50" type="text"
                       placeholder="请输入<%=data.firstName%>"
                       name="<%=data.firstInputName%>">
            </form>
        </label>
        <div class="pe-main-km-text-wrap">
            <div class="pe-km-search-key pe-input-tree-wrap pe-stand-filter-form-input" style="display: none">

            </div>
        </div>
    </div>
</script>
<script>
    $(function () {
        var peTableTitle = [
            {'title': '标签名称', 'width': 300},
            {'title': '操作', 'width': 100}
        ];
        var exerciseManage = {
            init: function () {
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/km/label/listTree',
//                    formParam: $('#labelManageForm').serializeArray(),
                    tempId: 'peExerManaTemp',
                    showTotalDomId: 'showTotal',
                    title: peTableTitle
                });
                var _this = this;
                _this.bind();
            },

            bind: function () {
                $('.create-exercise-btn').on('click', function () {
                    PEMO.DIALOG.confirmL({
                        content: _.template($('#confirmDialogTemp').html())({
                            data: {
                                'firstName': '标签名称',
                                'firstInputName': 'labelName'
                            }
                        }),
                        area: '468px',
                        btn: ['确定', '取消'],
                        btnAlign: 'l',
                        title: '新增标签',
                        btn1: function () {
                            var labelName = $('input[name="labelName"]').val();
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/km/label/addLabel',
                                data: $("#label_detail_form").serialize(),
                                success: function (data) {
                                    var message;
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '新增成功',
                                            time: 1000,
                                            end: function () {
                                                layer.closeAll('page');
                                            }
                                        });
                                        $('.pe-stand-table-wrap').peGrid('load', $('#labelManageForm').serializeArray());
                                        return false;
                                    } else if (data.message == "NAME_EMPTY") {
                                        message = '标签名称不可为空！';
                                    } else if (data.message == "NAME_REPEAT") {
                                        message = '标签名称已存在！';
                                    } else {
                                        message = '新增失败！';
                                    }

                                    PEMO.DIALOG.alert({
                                        content: message,
                                        btn: ['我知道了'],
                                        yes: function (index) {
                                            layer.close(index);
                                        }
                                    });
                                }
                            });
                        }
                    });
                });

                $('.pe-stand-table-main-panel').delegate('.edit-btn', 'click', function () {
                    var id = $(this).data("id");
                    var name = $(this).data("name");
                    console.log(name);
                    PEMO.DIALOG.confirmL({
                        content: _.template($('#confirmDialogTemp').html())({
                            data: {
                                'firstName': '标签名称',
                                'firstInputName': 'labelName'
                            }
                        }),
                        area: '468px',
                        title: '编辑标签',
                        btn: ['保存', '取消'],
                        btnAlign: 'l',
                        btn1: function () {
                            var labelName = $('input[name="labelName"]').val();
                            PEBASE.ajaxRequest({
                                //此处要返回给我新的修改过的节点的id，好和旧的的id进行比较从而是否刷新树节点
                                url: pageContext.rootPath + '/km/label/updateLabel',
                                data: {
                                    'id': id,
                                    'labelName': labelName,
                                    'parentId': '*'
                                },
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
                                        $('.pe-stand-table-wrap').peGrid('load', $('#labelManageForm').serializeArray());
                                        return false;
                                    } else if (data.message == "NAME_EMPTY") {
                                        message = '标签名称不可为空！';
                                    } else if (data.message == "NAME_REPEAT") {
                                        message = '标签名称已存在！';
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
                    $('input[name="labelName"]').val(name);
                })

            }
        };
        exerciseManage.init();
    })
</script>