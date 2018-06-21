<#--面包屑提示及提示语区域-->
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">试题</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">题库管理</li>
    </ul>
</div>
<form name="peFormSub" id="peFormSub">
    <div class="pe-manage-content pe-bank-manage-all-wrap">
    <#--树状布局开始,可复用,记得调用下面的初始化函数;-->
        <div class="pe-manage-content-left floatL">
            <div class="pe-classify-wrap">
                <div class="pe-classify-top over-flow-hide pe-form">
                    <span class="floatL pe-classify-top-text">按题库类别筛选</span>
                    <button type="button" title="管理类别" class="floatR iconfont icon-set pe-control-tree-btn set-category-btn"></button>
                    <span class="floatR pe-checkbox category-include pe-check-by-list">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                    <#--树状包含子类的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                        <input name="category.include" class="pe-form-ele" value="true" type="checkbox"
                               checked="checked"/><span class="include-subclass">包含子类</span>
                    </span>
                </div>
                <div class="pe-classify-tree-wrap">
                    <div class="pe-tree-search-wrap">
                    <#--复用时，保留下面的input单独classname 'pe-tree-form-text'-->
                        <input class="pe-tree-form-text" type="text" autocomplete="off" placeholder="输入类别名称关键字进行查找">
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
            <#--头部筛选区域-->
                <div class="pe-manage-panel-head">
                    <div class="pe-stand-filter-form">
                        <div class="pe-stand-form-cell">
                            <label class="pe-form-label floatL" for="peMainKeyName">
                                <span class="pe-label-name floatL">题库名称:</span>
                                <input id="peMainKeyName" autocomplete="off" class="pe-stand-filter-form-input"
                                       maxlength="20" type="text"
                                       name="bankName">
                            </label>
                            <label class="pe-form-label" for="peMainKeyText" style="">
                                <span class="pe-label-name floatL">创建人:</span>
                                <input id="peMainKeyText" autocomplete="off" class="pe-stand-filter-form-input"
                                       type="text" placeholder="姓名/用户名/工号/手机号"
                                       name="createBy">
                            </label>
                        </div>
                        <div class="pe-stand-form-cell">
                            <dl>
                                <dt class="pe-label-name floatL">试题状态:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                        <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="itemStatus" value="ENABLE"/>启用
                                    </label>
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="itemStatus" value="DRAFT"/>草稿
                                    </label>
                                    <label class="floatL pe-checkbox" for="">
                                        <span class="iconfont icon-unchecked-checkbox"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" type="checkbox" name="itemStatus"
                                               value="DISABLE"/>停用
                                    </label>
                                </dd>
                            </dl>
                        </div>
                        <button type="button" class="pe-btn pe-btn-blue floatL pe-question-choosen-btn">筛选</button>
                    <#--节点id取值-->
                        <input type="hidden" name="category.id" value="${(category.id)!}"/>
                        <input type="hidden" name="category.categoryName" value="${(category.categoryName)!}"/>
                    <#--节点类型取值-->
                    <#--<input type="hidden" name="category.include" value="true"/>-->
                    </div>
                </div>
            <#--表格上部按钮及表格区域-->
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                    <@authVerify authCode="ITEM_BANK_MANAGE_ADD"><button type="button" class="pe-btn pe-btn-green pe-new-item-bank">新增题库</button></@authVerify>
                    </div>
                    <div class="pe-stand-table-main-panel">
                        <input type="hidden" name="itemAttribute" value="ALL">
                        <input type="hidden" name="order" value=""/>
                        <input type="hidden" name="sort" value=""/>
                        <div class="pe-stand-table-wrap" id="peCategoryContWrap"></div>
                        <div class="pe-stand-table-pagination"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<#--右侧表格主题部分结束-->
<#--渲染表格模板-->
<script type="text/template" id="peQuestionTableTep">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
            ;i++){%>
            <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                <%if(peData.tableTitles[i].order){%>
                <div class="pe-th-wrap" data-type="<%=peData.tableTitles[i].type%>">
                    <%=peData.tableTitles[i].title%>
                    <%if(peData.tableTitles[i].name === 'indefinite'){%>
                    <span class="pageSize-arrow level-order-up iconfont icon-pageUp"
                          style="position:absolute;left:72px;"></span>
                    <span class="pageSize-arrow level-order-down iconfont icon-pageDown"
                          style="position:absolute;left:72px;"></span>
                    <%}else if(peData.tableTitles[i].name === 'allNumber'){%>
                    <span class="pageSize-arrow level-order-up iconfont icon-pageUp"
                          style="position:absolute;left:60px;"></span>
                    <span class="pageSize-arrow level-order-down iconfont icon-pageDown"
                          style="position:absolute;left:60px;"></span>
                    <%}else{%>
                    <span class="pageSize-arrow level-order-up iconfont icon-pageUp" style="position:absolute;"></span>
                    <span class="pageSize-arrow level-order-down iconfont icon-pageDown"
                          style="position:absolute;"></span>
                    <%}%>
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
        <#--题库名称-->
            <td>
                <div class="pe-ellipsis" title="<%=peData.rows[j].bankName%>"><%=peData.rows[j].bankName%></div>
            </td>
        <#--单选数量-->
            <td><%=peData.rows[j].singleNumber%></td>
        <#--多选数量-->
            <td><%=peData.rows[j].multiNumber%></td>
        <#--不定向选择数量-->
            <td><%=peData.rows[j].indefiniteNumber%></td>
        <#--判断数量-->
            <td><%=peData.rows[j].judgmentNumber%></td>
        <#--填空数量-->
            <td><%=peData.rows[j].fillNumber%></td>
        <#--问答数量-->
            <td><%=peData.rows[j].questionsNumber%></td>
        <#--试题总数-->
            <td><%=peData.rows[j].allNumber%></td>
            <td>
                <div class="pe-stand-table-btn-group">
                    <%if(peData.rows[j].canEdit){%>
                    <button type="button" title="编辑" class="pe-icon-btn iconfont icon-edit edit"
                            data-id="<%=peData.rows[j].id%>"></button>
                    <@authVerify authCode="VERSION_OF_ITEM_BANK_AUTHORIZE">
                        <button type="button" title="授权" class="pe-icon-btn iconfont icon-pe-accredit auth"
                                data-id="<%=peData.rows[j].id%>"></button>
                    </@authVerify>
                    <button type="button" title="删除" class="pe-icon-btn iconfont icon-delete dele"
                            data-id="<%=peData.rows[j].id%>"></button>
                    <%}%>
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
    <form id="updateBankForm">
        <div class="clearF">
            <div class="validate-form-cell" style="margin-left:68px;">
                <em class="error" style="display: none;"></em>
            </div>
            <label class="floatL">
                <span class="pe-label-name floatL">题库名称:</span>
                <input class="pe-stand-filter-form-input pe-bank-tree-name" autocomplete="off" type="text"
                       placeholder="请输入题库名称"
                       name="itemBankName" maxlength="50">
            </label>
            <div class="pe-main-km-text-wrap clearF">
                <span class="pe-label-name floatL ">题库类别:</span>
                <div class="pe-km-search-key pe-input-tree-wrap pe-stand-filter-form-input">
                    <input class="pe-tree-show-name" value="" type="text" autocomplete="off" name="itemCategoryName"
                           placeholder="请选择类别" style="width:204px;">
                    <input class="pe-tree-show-id" type="hidden" value="" name="itemCategoryId">
                    <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                    <div class="pe-select-tree-wrap pe-input-tree-wrap-drop" style="display:none;">
                        <ul id="peSelelctInputTree" class="ztree pe-tree-container"></ul>
                    </div>
                </div>
            </div>
        </div>
    </form>
</script>
<script>
    function checkBank(itemBankName, categoryId, bankId) {
        var $error = $('.validate-form-cell').find('.error').eq(0);
        var $bankName = $('input[name="itemBankName"]');
        var $categoryId = $('input[name="itemCategoryName"]').parent();
        if (itemBankName === undefined || itemBankName === '') {
            $error.show().text('请输入题库名称');
            $bankName.addClass('error');
            $categoryId.removeClass('error');
            return false;
        } else if (categoryId === undefined || categoryId === '') {
            $error.show().text('请选择题库类别');
            $categoryId.addClass('error');
            $bankName.removeClass('error');
            return false;
        }

        var hasName = false;
        PEBASE.ajaxRequest({
            url: pageContext.rootPath + '/ems/itemBank/manage/checkNameExist',
            data: {
                "bankName": itemBankName,
                "category.id": categoryId,
                "id": bankId
            },
            async: false,
            success: function (data) {
                if (!data.success) {
                    var $error = $('.validate-form-cell').find('em.error').eq(0).show().html(data.message);
                    hasName = true;
                }
            }
        });
        if (hasName) {
            $bankName.addClass('error');
            $categoryId.removeClass('error');
            return false;
        } else {
            $error.text('');
            $bankName.removeClass('error');
            return true;
        }

    }

    $(function () {
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        /*自定义表格头部数量及宽度*/
        var peTableTitle = [
            {'title': '题库名称', 'width': 20, 'type': ''},
            {'title': '单选', 'width': 8, 'type': 'SINGLE_SELECTION', 'order': true},
            {'title': '多选', 'width': 8, 'type': 'MULTI_SELECTION', 'order': true},
            {'title': '不定项选择', 'width': 12, 'type': 'INDEFINITE_SELECTION', 'order': true, 'name': 'indefinite'},//.name === 'indefinite'
            {'title': '判断', 'width': 8, 'type': 'JUDGMENT', 'order': true},
            {'title': '填空', 'width': 8, 'type': 'FILL', 'order': true},
            {'title': '问答', 'width': 8, 'type': 'QUESTIONS', 'order': true},
            {'title': '试题总数', 'width': 10, 'type': 'ALL', 'name': 'allNumber', 'order': true},
            {'title': '操作', 'width': 10}
        ];
        /*表格生成*/
        $('#peCategoryContWrap').peGrid({
            url: pageContext.rootPath + '/ems/itemBank/manage/search',
            formParam: $('#peFormSub').serializeArray(),//表格上方表单的提交参数
            tempId: 'peQuestionTableTep',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle //表格头部的数量及名称数组;
        });

        //新增题库
        $('.pe-new-item-bank').click(function () {
            PEMO.DIALOG.confirmL({
                content: _.template($('#confirmDialogTemp').html())(),
                area: '468px',
                title: '新建题库',
                btn: ['确定', '取消'],
                btnAlign: 'l',
                skin: 'pe-layer-confirm pe-bank-manage-layer pe-layer-has-tree',
                btn1: function () {
                    var categoryName = $('input[name="itemCategoryName"]').val();
                    var itemBankName = $('input[name="itemBankName"]').val();
                    var $itemBankName = $('input[name="itemBankName"]');
                    var $error = $('.validate-form-cell').find('.error').eq(0);
                    var $categoryId = $('input[name="itemCategoryId"]');
                    var $categoryName = $('input[name="itemCategoryName"]');
                    var categoryId = $('input[name="itemCategoryId"]').val();

                    /*在这之前进行远程服务器校验*/
                    if (!itemBankName) {
                        $error.show().text('请输入题库名称');
//                        $bankName.addClass('error');
                        $itemBankName.removeClass('error');
                        return;
                    }
                    if (!categoryId) {
                        $error.show().text('请选择题库类别');
                        $categoryName.addClass("error");
                        return;
                    }
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/itemBank/manage/saveBank',
                        data: {
                            "bankName": itemBankName,
                            "category.id": categoryId
                        },
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '新增成功',
                                    time: 1000,
                                    end: function () {
                                        $('#peCategoryContWrap').peGrid('refresh');
                                        layer.closeAll('page');
                                    }
                                });
                                return false;
                            }

                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function (shiIndex) {
                                    layer.close(shiIndex);
                                }
                            })
                        }
                    });

                },
                btn2: function () {
                    layer.closeAll();
                },
                success: function () {
                    //初始化弹框里面的input类型的树状功能;
                    var settingInputTree = {
                        dataUrl: pageContext.rootPath + '/ems/itemBank/manage/listTree',
                        clickNode: function (treeNode) {
                            var $thisLayer = $('.layui-layer');
                            if (treeNode.pId == null) {
                                $thisLayer.find('.pe-tree-show-name').val(null);
                                $thisLayer.find('.pe-tree-show-id').val(null);
                            } else {
                                $thisLayer.find('.pe-tree-show-name').val(treeNode.name);
                                $thisLayer.find('.pe-tree-show-id').val(treeNode.id);
                            }

                        },
                        treeSearch: $('input[name="itemCategoryName"]')
                    };

                    $('input[name="itemCategoryName"]').val($('input[name="category.categoryName"]').val());
                    $('input[name="itemCategoryId"]').val($('input[name="category.id"]').val());
                    //题库类型输入框类型树状弹框 dom为需要下拉框的那一行div元素 pe-km-input-tree
                    PEBASE.inputTree({
                        dom: '.pe-input-tree-wrap',
                        treeId: 'peSelelctInputTree',
                        treeParam: settingInputTree
                    });
                }
            });

        });

        //编辑题库
        $('#peCategoryContWrap').delegate('.edit', 'click', function (e) {
            var id = $(this).attr('data-id');
            $.post(pageContext.rootPath + '/ems/itemBank/manage/get', {'bankId': id}, function (data) {
                $('input[name="itemBankName"]').val(data.bankName);
                $('input[name="itemCategoryName"]').val(data.category.categoryName);
                $('input[name="itemCategoryId"]').val(data.category.id);
                return false;
            }, 'json');
            PEMO.DIALOG.confirmL({
                content: _.template($('#confirmDialogTemp').html())(),
                title: '编辑题库',
                btnAlign: 'l',
                skin: 'pe-layer-confirm pe-bank-manage-layer pe-layer-has-tree',
                btn: ['保存', '取消'],
                btn1: function () {
                    var itemBankName = $('input[name="itemBankName"]').val(),
                            categoryName = $('input[name="itemCategoryName"]').val(),
                            categoryId = $('input[name="itemCategoryId"]').val();
                    //校验编辑题库内容
                    var isError = checkBank(itemBankName, categoryId, id);
                    if (!isError) {
                        return false;
                    }
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/itemBank/manage/updateBank',
                        data: {
                            'id': id,
                            'bankName': itemBankName,
                            'category.id': categoryId
                        },
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '编辑成功',
                                    time: 2000,
                                    end: function () {
                                        $('#peCategoryContWrap').peGrid('refresh');
                                        layer.closeAll('page');
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
                success: function () {
                    //初始化弹框里面的input类型的树状功能：
                    var settingInputTree = {
                        dataUrl: pageContext.rootPath + '/ems/itemBank/manage/listTree',
                        clickNode: function (treeNode) {
                            if (treeNode.pId == null) {
                                $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(null);
                                $('.pe-input-tree-wrap').find('.pe-tree-show-id').val(null);
                            } else {
                                $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                                $('.pe-input-tree-wrap').find('.pe-tree-show-id').val(treeNode.id);
                            }
                        },
                        treeSearch: $('input[name="itemCategoryName"]')
                    };
                    $('input[name="itemCategoryName"]').val($('input[name="category.categoryName"]').val());
                    $('input[name="itemCategoryId"]').val($('input[name="category.id"]').val());
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
        $('#peCategoryContWrap').delegate('.dele', 'click', function (e) {
            var id = $(this).attr('data-id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定删除这个题库？</h3><p class="pe-dialog-content-tip">删除后不允许恢复，请谨慎操作！</p></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/itemBank/manage/deleteBank',
                        data: {'itemBankId': id},
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '删除成功',
                                    time: 1000,
                                    end: function () {
                                        $('#peCategoryContWrap').peGrid('refresh');
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

        $('#peCategoryContWrap').delegate('.auth', 'click', function (e) {
            var id = $(this).attr('data-id');
            PEMO.DIALOG.selectorDialog({
                title: '题库授权',
                area: ['900px', '585px'],
                content: [pageContext.rootPath + '/ems/itemBank/manage/authorize?bankId=' + id, 'no']
            });
        });

        //表格难度排序点击事件
        $('#peCategoryContWrap').delegate('.level-order-up', 'click', function () {
            $(this).addClass('curOrder');
            $(this).siblings('.level-order-down').removeClass('curOrder');
            var thisType = $(this).parent('.pe-th-wrap').attr('data-type');
            $('input[name="sort"]').val(thisType);
            $('input[name="order"]').val('asc');
            $('#peCategoryContWrap').peGrid('load', $('#peFormSub').serializeArray());
        });

        $('#peCategoryContWrap').delegate('.level-order-down', 'click', function () {
            $(this).addClass('curOrder');
            $(this).siblings('.level-order-up').removeClass('curOrder');
            var thisType = $(this).parent('.pe-th-wrap').attr('data-type');
            $('input[name="sort"]').val(thisType);
            $('input[name="order"]').val('desc');
            $('#peCategoryContWrap').peGrid('load', $('#peFormSub').serializeArray());
        });

        //筛选
        $('.pe-question-choosen-btn').on('click', function () {
            $('#peCategoryContWrap').peGrid('load', $('#peFormSub').serializeArray());
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
            $('#peCategoryContWrap').peGrid('load', $('#peFormSub').serializeArray());
        });

        var settingUrl = {
            dataUrl: pageContext.rootPath + '/ems/itemBank/manage/listTree',
            clickNode: function (treeNode) {
                if (treeNode.pId == null) {
                    $('input[name="category.categoryName"]').val(null);
                    $('input[name="category.id"]').val(null);
                } else {
                    $('input[name="category.categoryName"]').val(treeNode.name);
                    $('input[name="category.id"]').val(treeNode.id);
                }

                $('#peCategoryContWrap').peGrid('load', $('#peFormSub').serializeArray());
            },
            optUrl: {
                editUrl: pageContext.rootPath + '/base/category/manage/edit?categoryType=ITEM_BANK',
                addUrl: pageContext.rootPath + '/base/category/manage/add?categoryType=ITEM_BANK',
                deleUrl: pageContext.rootPath + '/base/category/manage/delete?categoryType=ITEM_BANK',
                moveUrl: pageContext.rootPath + '/base/category/manage/moveLevel',
                isNewNode: false
            }
        };
        //初始化左侧树状功能；peZtreeMain为主要树的id
        PEMO.ZTREE.initTree('peZtreeMain', settingUrl);
//            PEBASE.peSelect($('.pe-question-select'), null, $('input[name="peQuestionType"]'));
//            PEBASE.peSelect($('.pe-diff-select'), null, $('input[name="peQuestionDifficulty"]'));


    });
</script>