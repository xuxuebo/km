<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">

</div>
<section class="exam-manage-all-wrap">
    <form id="exerciseManageForm">
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                        <button type="button" class="pe-btn pe-btn-green create-exercise-btn">新增公共库</button>
                    </div>
                    <input type="hidden" name="library.libraryName" value="${(library.libraryName)!}"/>
                    <input type="hidden" name="library.id" value="${(library.id)!}"/>
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
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].libraryName%>"><%=peData.rows[j].libraryName%>
                    </div>
                </td>

                <td>
                    <div class="pe-stand-table-btn-group">
                        <button type="button" class="edit-btn pe-icon-btn iconfont icon-edit" title="编辑"
                                data-id="<%=peData.rows[j].id%>" data-libraryname="<%=peData.rows[j].libraryName%>"></button>
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
            <span class="pe-label-name floatL"><%=data.firstName%>:</span>
            <input class="pe-stand-filter-form-input" maxlength="50" type="text" placeholder="请输入<%=data.firstName%>"
                   name="<%=data.firstInputName%>">
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
            {'title': '库名', 'width': 300},
            {'title': '操作', 'width': 100}
        ];
        var exerciseManage = {
            init: function () {
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/library/manage/search',
                    formParam: $('#exerciseManageForm').serializeArray(),
                    tempId: 'peExerManaTemp',
                    showTotalDomId: 'showTotal',
                    title: peTableTitle
                });
                var _this = this;
                _this.bind();
            },

            bind: function () {
                $('.create-exercise-btn').on('click',function () {
                    PEMO.DIALOG.confirmL({
                        content: _.template($('#confirmDialogTemp').html())({
                            data: {
                                'firstName': '库名',
                                'firstInputName': 'libraryName'
                            }
                        }),
                        area: '468px',
                        btn: ['确定','取消'],
                        btnAlign:'l',
                        title: '新增公共库',
                        btn1: function () {
                            var libraryName = $('input[name="libraryName"]').val();
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/library/addPublicLibrary',
                                data: {
                                    'libraryName': libraryName
                                },
                                success: function (data) {
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '新增成功',
                                            time: 1000,
                                            end: function () {
                                                layer.closeAll('page');
                                            }
                                        });
                                        $('.pe-stand-table-wrap').peGrid('load', $('#exerciseManageForm').serializeArray());
                                        return false;
                                    }

                                    PEMO.DIALOG.alert({
                                        content: data.message,
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
                    var name = $(this).data("libraryname");
                    console.log(name);
                    PEMO.DIALOG.confirmL({
                        content: _.template($('#confirmDialogTemp').html())({
                            data: {
                                'firstName': '库名',
                                'firstInputName': 'libraryName'
                            }
                        }),
                        area: '468px',
                        title: '编辑库名',
                        btn: ['保存','取消'],
                        btnAlign:'l',
                        btn1: function () {
                            var libraryName = $('input[name="libraryName"]').val();
                            PEBASE.ajaxRequest({
                                //此处要返回给我新的修改过的节点的id，好和旧的的id进行比较从而是否刷新树节点
                                url: pageContext.rootPath + '/library/updateLibrary',
                                data: {
                                    'id': id,
                                    'libraryName': libraryName
                                },
                                success: function (data) {
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '编辑成功',
                                            time: 1000,
                                            end:function(){
                                                layer.closeAll('page');
                                            }
                                        });
                                        $('.pe-stand-table-wrap').peGrid('load', $('#exerciseManageForm').serializeArray());
                                        return false;
                                    }

                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn:['我知道了'],
                                        yes:function(index){
                                            layer.close(index);
                                            success();
                                        }
                                    });
                                }
                            });
                        }
                    });
                    $('input[name="libraryName"]').val(name);
                })

            }
        };
        exerciseManage.init();
    })
</script>