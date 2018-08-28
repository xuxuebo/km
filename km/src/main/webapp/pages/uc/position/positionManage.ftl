<div class="pe-break-nav-tip-container">
    <#--<ul class="pe-break-nav-ul">-->
        <#--<li class="pe-brak-nav-items">用户</li>-->
        <#--<li class="pe-brak-nav-items iconfont icon-bread-arrow">岗位管理</li>-->
    <#--</ul>-->
</div>
<div class="pe-test-question-manage" xmlns="http://www.w3.org/1999/html">
<#--树状布局开始,可复用,记得调用下面的初始化函数;-->
    <form name="peFormSub" id="peFormSub">
        <div class="pe-manage-content-left floatL">
            <div class="pe-classify-wrap">
                <div class="pe-classify-top over-flow-hide pe-form">
                    <span class="floatL pe-classify-top-text">按岗位类别筛选</span>
                    <button type="button" title="管理类别" class="floatR iconfont icon-set pe-control-tree-btn set-category-btn"></button>
                    <span class="floatR pe-checkbox category-include pe-check-by-list">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                    <#--树状包含子类的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                    <input class="pe-form-ele" checked="checked" type="checkbox"
                           name="category.include" value="true"/><span class="include-subclass">包含子类</span>
                </span>
                </div>
                <div class="pe-classify-tree-wrap">
                    <div class="pe-tree-search-wrap">
                    <#--复用时，保留下面的input单独classname 'pe-tree-form-text'-->
                        <input class="pe-tree-form-text" type="text" placeholder="输入类别名称关键字进行查找">
                        <input type="hidden" name="time" class="pe-time"/>
                    <#--<span class="pe-placeholder">请输入题库名称</span>备用,误删-->
                        <span class="iconfont pe-tree-search-btn icon-search-magnifier"></span>
                    </div>
                    <div class="pe-tree-content-wrap">
                        <div class="pe-tree-main-wrap">
                            <div class="node-search-empty">暂无</div>
                        <#--pe-no-manage-tree为非管理树类添加的样式，是管理类的树，无需此class-->
                            <ul id="peZtreeMain" class="ztree pe-tree-container" data-type="km"></ul>
                        </div>
                    <#--题库管理根据需要是否显示-->
                        <#--<div class="pe-control-tree-btn iconfont icon-set">管理类别</div>-->
                    </div>
                </div>
            </div>
        </div>
    <#--树状布局 结束,可复用-->
    <#--右侧表格主题部分开始-->
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
            <#--节点id取值-->
                <input type="hidden" name="category.id" value="${(category.id)!}"/>
                <input type="hidden" name="category.categoryName" value="${(category.categoryName)!}"/>
            <#--</div>-->
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                        <button type="button" class="pe-btn pe-btn-green pe-category-btn">岗位类别管理</button>
                        <button type="button" class="pe-btn pe-btn-green pe-new-question-btn">新增岗位</button>
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
</div>
<#--右侧表格主题部分结束-->
<#--渲染表格模板-->
<script type="text/template" id="peQuestionTableTep">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
            ;i++){%>
            <th style="width:<%=peData.tableTitles[i].width%>%">
                <%=peData.tableTitles[i].title%>
            </th>
            <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
        <tr data-id="<%=peData.rows[j].id%>">
        <#--岗位名称-->
            <td data-id="<%=peData.rows[j].bankName%>"><%=peData.rows[j].positionName%></td>
            <td>
                <div class="pe-stand-table-btn-group">
                    <button type="button" class="pe-table-edit-btn pe-icon-btn iconfont icon-edit"
                            data-id="<%=peData.rows[j].id%>"></button>
                    <button type="button" class="pe-table-dele-btn pe-icon-btn iconfont icon-delete"
                            data-id="<%=peData.rows[j].id%>"></button>
                </div>
            </td>
        </tr>
        <%}%>
        <%}else{%>
        <tr>
            <td class="pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
                <div class="pe-result-no-date"></div>
                <p class="pe-result-date-warn">暂无数据</p>
            </td>
        </tr>
        <%}%>
        </tbody>
    </table>
</script>
<#--编辑，新增对话框内容模板-->
<script type="text/template" id="confirmDialogTemp">
    <div class="clearF">
        <label class="floatL">
            <span class="pe-label-name floatL"><%=data.firstName%>:</span>
            <input class="pe-stand-filter-form-input" type="text" maxlength="50" placeholder="请输入<%=data.firstName%>"
                   name="<%=data.firstInputName%>" style="overflow: hidden;text-overflow: ellipsis;">
        </label>
        <div class="pe-main-km-text-wrap">
            <span class="pe-label-name floatL"><%=data.treeName%>:</span>
            <div class="pe-km-search-key pe-input-tree-wrap pe-stand-filter-form-input">
                <input class="pe-tree-show-name" value="" name="<%=data.treeInputName%>" style="max-width: 210px;overflow: hidden;text-overflow: ellipsis;"
                       placeholder="请选择类别">
                <input class="pe-tree-show-id" type="hidden" value="" name="<%=data.treeInputId%>">
                <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                <div class="pe-select-tree-wrap pe-input-tree-wrap-drop" style="display:none;">
                    <ul id="peSelelctInputTree" class="ztree pe-tree-container"></ul>
                </div>
            </div>
        </div>
    </div>
</script>
<script>
    $(function () {
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        /*自定义表格头部数量及宽度*/
        var peTableTitle = [
            {'title': '岗位名称', 'width': 75},
            {'title': '操作', 'width': 12}
        ];
        /*表格生成*/
        /*ie9 解决缓存中获取不刷新问题*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/uc/position/manage/search',
            formParam: $('#peFormSub').serializeArray(),//表格上方表单的提交b参数
            tempId: 'peQuestionTableTep',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle //表格头部的数量及名称数组;
        });

        //新增岗位
        $('.pe-new-question-btn').click(function () {
            PEMO.DIALOG.confirmL({
                content: _.template($('#confirmDialogTemp').html())({
                    data: {
                        'firstName': '岗位名称',
                        'firstInputName': 'positionName',
                        'treeName': '岗位类别',
                        'treeInputName': 'categoryName',
                        'treeInputId': 'categoryId'
                    }
                }),
                area: '468px',
                title: '新增岗位',
                btn: ['确定', '取消'],
                btnAlign: 'c',
                btn1: function () {
                    var categoryId = $('input[name="categoryId"]').val();
                    var positionName = $('input[name="positionName"]').val();
                    if (!categoryId) {
                        PEMO.DIALOG.alert({
                            content: '请选择岗位类别',
                             btn: ['我知道了'],
                             yes: function () {
                                layer.closeAll();
                        }
                        });

                        return false;
                    }

                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/uc/position/manage/savePosition',
                        data: {
                            "positionName": positionName,
                            "category.id": categoryId
                        },
                        success: function (data) {
                            if (data.success) {
                                layer.closeAll();
                                PEMO.DIALOG.tips({
                                    content: '岗位新增成功',
                                    time: 1000,
                                    end: function (index) {
                                        /*ie9 解决缓存中获取不刷新问题*/
                                        $('.pe-time').val(new Date().getTime());
                                        $('.pe-stand-table-wrap').peGrid('refresh');
                                        layer.close(index);
                                    }
                                });

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
                },
                btn2: function () {
                    layer.closeAll();
                },
                success: function () {
                    //初始化弹框里面的input类型的树状功能：
                    var settingInputTree = {
                        dataUrl: pageContext.rootPath + '/uc/position/manage/listTree',
                        clickNode: function (treeNode) {
                            if (treeNode.pId == null) {
                                $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(null);
                                $('.pe-input-tree-wrap').find('.pe-tree-show-id').val(null);
                            } else {
                                $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                                $('.pe-input-tree-wrap').find('.pe-tree-show-id').val(treeNode.id);
                            }
                        }
                    };
                    //题库类型输入框类型树状弹框 dom为需要下拉框的那一行div元素 pe-km-input-tree
                    PEBASE.inputTree({
                        dom: '.pe-input-tree-wrap',
                        treeId: 'peSelelctInputTree',
                        treeParam: settingInputTree
                    });
                }
            });
            $('input[name="categoryName"]').val($('input[name="category.categoryName"]').val());
            $('input[name="categoryId"]').val($('input[name="category.id"]').val());
        });

        //编辑题库
        $('.pe-stand-table-wrap').delegate('.pe-table-edit-btn', 'click', function (e) {
            var id = $(this).attr('data-id');
            PEBASE.ajaxRequest({
                url: pageContext.rootPath + '/uc/position/manage/getPosition',
                data: {'positionId': id},
                success: function (data) {
                    $('input[name="positionName"]').val(data.positionName);
                    $('input[name="positionName"]').attr("title",data.positionName);
                    $('input[name="categoryName"]').val(data.category.categoryName);
                    $('input[name="categoryName"]').attr("title",data.category.categoryName);
                    $('input[name="categoryId"]').val(data.category.id);
                }
            });
            PEMO.DIALOG.confirmL({
                content: _.template($('#confirmDialogTemp').html())({
                    data: {
                        'firstName': '岗位名称',
                        'firstInputName': 'positionName',
                        'treeName': '岗位类别',
                        'treeInputName': 'categoryName',
                        'treeInputId': 'categoryId'
                    }
                }),
                title: '编辑岗位',
                btnAlign: 'c',
                btn: ['保存', '取消'],
                btn1: function () {
                    var positionName = $('input[name="positionName"]').val();
                    var categoryId = $('input[name="categoryId"]').val();
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/uc/position/manage/updatePosition',
                        data: {
                            'id': id,
                            'positionName': positionName,
                            'category.id': categoryId
                        },
                        success: function (data) {
                            layer.closeAll();
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '保存成功',
                                    time: 1000,
                                    end: function (index) {
                                        $('.pe-time').val(new Date().getTime());
                                        $('.pe-stand-table-wrap').peGrid('refresh');
                                        layer.close(index);
                                    }
                                });

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
                },
                btn2: function () {
                    layer.closeAll();
                },
                success: function () {
                    //初始化弹框里面的input类型的树状功能：
                    var settingInputTree = {
                        dataUrl: pageContext.rootPath + '/uc/position/manage/listTree',
                        clickNode: function (treeNode) {
                            if (treeNode.pId == null) {
                                $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(null);
                                $('.pe-input-tree-wrap').find('.pe-tree-show-id').val(null);
                            } else {
                                $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                                $('.pe-input-tree-wrap').find('.pe-tree-show-id').val(treeNode.id);
                            }
                        }
                    };
                    //题库类型输入框类型树状弹框 dom为需要下拉框的那一行div元素 pe-km-input-tree
                    PEBASE.inputTree({
                        dom: '.pe-input-tree-wrap',
                        treeId: 'peSelelctInputTree',
                        treeParam: settingInputTree
                    });
                }
            });
        });

        //删除
        $('.pe-stand-table-wrap').delegate('.pe-table-dele-btn', 'click', function (e) {
            var id = $(this).attr('data-id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定要删除这个岗位吗？</h3><p class="pe-dialog-content-tip">删除后不允许恢复，请谨慎操作！</p></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/uc/position/manage/deletePosition',
                        data: {'positionId': id},
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '删除成功',
                                    time: 1000,
                                    end: function () {
                                        $('.pe-time').val(new Date().getTime());
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
                            });
                        }
                    });
                }
            });
        });

        //类别点击筛选事件
        $('.pe-check-by-list').off().click(function () {
            var iconCheck = $(this).find('span.iconfont');
            var thisRealCheck = $(this).find('input[type="checkbox"]');
            if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                thisRealCheck.prop('checked', 'checked');//这里在ie8下目前会报错“意外的调用了方法”,待解决
            } else {
                iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                thisRealCheck.removeProp('checked');
            }
            $('.pe-stand-table-wrap').peGrid('load', $('#peFormSub').serializeArray());
        });

        var settingUrl = {
            dataUrl: pageContext.rootPath + '/uc/position/manage/listTree',
            clickNode: function (treeNode) {
                if (treeNode.pId == null) {
                    $('input[name="category.categoryName"]').val(null);
                    $('input[name="category.id"]').val(null);
                } else {
                    $('input[name="category.categoryName"]').val(treeNode.name);
                    $('input[name="category.id"]').val(treeNode.id);
                }

                $('.pe-stand-table-wrap').peGrid('load', $('#peFormSub').serializeArray());
            },
            optUrl: {
                editUrl: pageContext.rootPath + '/base/category/manage/edit?categoryType=POSITION',
                addUrl: pageContext.rootPath + '/base/category/manage/add?categoryType=POSITION',
                deleUrl: pageContext.rootPath + '/base/category/manage/delete?categoryType=POSITION',
                moveUrl: pageContext.rootPath + '/base/category/manage/moveLevel',
                isNewNode: false
            }
        };
        //初始化左侧树状功能；peZtreeMain为主要树的id
        PEMO.ZTREE.initTree('peZtreeMain', settingUrl);

        $('.pe-category-btn').on('click', function () {
            parent.$('#yunContentBody').html('<iframe style="width:100%;height: 100%;margin-left:0;" src="/km/front/manage/initPage#url=/km/base/category/manage/init"></iframe>');
        });
    });
</script>