<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">用户</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">角色管理</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">按人员查看</li>
    </ul>
    <a href="javascript:;" style="float: right" class="role-view-user-btn pe-view-role-btn"><span
            class="iconfont icon-member"></span>按角色查看
    </a>
</div>
<section class="pe-large-panel user-result-detail-wrap">
    <div class="pe-mask-listen"></div>
    <form id="viewRoleForm">
        <div class="pe-manage-content-right role-view-by-person-panel">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-manage-panel-head">
                    <div class="pe-stand-filter-form"></div>
                <#--节点id取值-->
                </div>
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel" style="font-size:0;"></div>
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
<script type="text/template" id="paperAccreditUser">
    <table class="pe-stand-table pe-stand-table-default checkbox-table">
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
            <#--姓名-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].userName%>">
                        <%=peData.rows[j].userName%>
                    </div>
                </td>
            <#--用户名-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].loginName%>">
                        <%=peData.rows[j].loginName%>
                    </div>
                </td>
            <#--工号-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].employeeCode%>">
                        <%=peData.rows[j].employeeCode%>
                    </div>
                </td>
            <#--手机号-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].mobile%>">
                        <%=peData.rows[j].mobile%>
                    </div>
                </td>
            <#--部门-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].organize.organizeName%>">
                        <%=peData.rows[j].organize.organizeName%>
                    </div>
                </td>
            <#--岗位-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].positionName%>">
                        <%=peData.rows[j].positionName%>
                    </div>
                </td>
            <#--状态-->
                <td>
                    <div class="pe-ellipsis" title="">
                        <%if(peData.rows[j].status == "ENABLE"){%>
                        激活
                        <%}else if(peData.rows[j].status == "FORBIDDEN"){%>
                        冻结
                        <%}else{%>
                        删除
                        <%}%>
                    </div>
                </td>
            <#--所属角色-->
                <td>
                    <%var roleNames = ''; if(peData.rows[j].roles && peData.rows[j].roles.length !== 0){%>
                    <%for(var t=0,rLength=peData.rows[j].roles.length;t
                    <rLength
                    ;t++){ roleNames += peData.rows[j].roles[t].roleName%>
                    <%if(t != (rLength -1)){ roleNames += ','}}}%>
                    <div class="pe-ellipsis" title="<%=roleNames%>">
                        <%=roleNames%>
                    </div>
                </td>
            <#--操作-->
                <td>
                    <div class="pe-stand-table-btn-group">
                        <div class="pe-ellipsis" title="">
                            <button type="button" class="pe-icon-btn iconfont icon-delete deleteUser" title="移除"
                                    data-id="<%=peData.rows[j].id%>"></button>
                        </div>
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
<#--移除角色的弹框模板-->
<script type="text/template" id="deleRoleTemp">
    <form id="roleTmpForm">
        <h3 style="margin-bottom:10px;" style="font-size:16px;color:#444;margin-top:10px;">请选择需要移除的角色:</h3>
        <div style="width: 100%;">
            <ul class="over-flow-hide">
                <%for(var i=0;i
                <data.length
                        ;i++){%>
                    <li class="floatL" style="width: 50%;color:#666;margin-bottom:3px;font-size:13px;">
                        <label class="floatL pe-checkbox" title="<%=data[i].roleName%>" style="">
                            <span style="vertical-align:middle;" class="iconfont icon-unchecked-checkbox"></span>
                            <input name="roleIds" class="pe-form-ele" type="checkbox" checked
                                   value="<%=data[i].id%>" title="<%=data[i].roleName%>"/><span
                                style="vertical-align:middle;display:inline-block;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;width:120px;"><%=data[i].roleName%></span>
                        </label>
                    </li>
                    <%}%>
            </ul>
        </div>
    </form>
</script>
<#--简单筛选的模板-->
<script type="text/template" id="simpleTemp">
    <form id="simpleTempForm">
        <div class="simple-form-cell-wrap simaple-form-cell">
            <div class="pe-stand-form-cell">
                <label class="pe-form-label floatL" for="peMainKeyText" style="">
                    <span class="pe-label-name floatL">关键字:</span>
                    <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                           placeholder="用户名/姓名/手机号/工号"
                           name="keyword">
                </label>
                <dl class="floatL">
                    <dt class="pe-label-name floatL">人员状态:</dt>
                    <dd class="pe-stand-filter-label-wrap">
                        <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                            <span class="iconfont icon-checked-checkbox peChecked"></span>
                            <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                   name="userStatusList[0]" value="ENABLE"/>激活
                        </label>
                        <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                            <span class="iconfont icon-checked-checkbox peChecked"></span>
                            <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                   name="userStatusList[1]" value="FORBIDDEN"/>冻结
                        </label>
                    </dd>
                </dl>
                <div class="pe-choosen-btn-wrap">
                    <button type="button" class="pe-btn pe-btn-blue pe-question-choose-btn">筛选</button>
                    <a href="javascript:;" class="choosen-advace-opt-type" style="margin-left:">高级筛选</a>
                </div>
            </div>
        </div>
    </form>
</script>
<#--高级筛选的模板-->
<script type="text/template" id="advaceTemp">
    <form id="advaceTempForm">
        <div class="simple-form-cell-wrap advace-form-cell">
            <div class="pe-stand-form-cell">
            <#--高级岗位-->
                <div class="floatL" style="margin-right:26px;">
                    <span class="pe-label-name floatL">岗位:</span>
                    <div class="pe-position-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                        <input class="pe-tree-show-name show-position-name" value="<%=positionName?positionName:''%>"/>
                        <input type="hidden" name="positionId" value=""/>
                        <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                        <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop" style="display:none;">
                            <ul id="positionTree" class="ztree pe-tree-container"></ul>
                        </div>
                    </div>
                </div>
                <label class="pe-form-label floatL" for="peMainKeyText" style="margin-right:26px;">
                    <span class="pe-label-name floatL">姓名:</span>
                    <input id="peMainKeyText" class="pe-stand-filter-form-input pe-table-form-text"
                           type="text" placeholder="姓名"
                           name="userName">
                </label>
                <label class="pe-form-label">
                    <span class="pe-label-name floatL">用&nbsp;&nbsp;户&nbsp;&nbsp;名:</span>
                    <input id="peMainKeyText" class="pe-stand-filter-form-input pe-table-form-text"
                           type="text" placeholder="用户名"
                           name="loginName">
                </label>
            </div>
            <div class="pe-stand-form-cell">
                <label class="pe-form-label floatL" for="peMainKeyText">
                    <span class="pe-label-name floatL">手机:</span>
                    <input id="peMainKeyText" class="pe-stand-filter-form-input pe-table-form-text"
                           type="text" placeholder="手机号"
                           name="mobile">
                </label>
                <label class="pe-form-label floatL" for="peMainKeyText" style="margin-right:26px;">
                    <span class="pe-label-name">工号:</span>
                    <input id="peMainKeyText" class="pe-stand-filter-form-input pe-table-form-text"
                           type="text" placeholder="工号"
                           name="employeeCode">
                </label>
                <label class="pe-form-label" for="peMainKeyText">
                    <span class="pe-label-name">所属角色:</span>
                    <div class="pe-input-tree-content  pe-role-input-tree pe-stand-filter-form-input">
                        <label class="input-tree-choosen-label" style="max-width:240px;">
                            <input class="pe-tree-show-name" value="" name="" style="width:2px;"></input>
                        </label>

                        <input type="hidden" name="roleClassify" value=""/>
                        <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                        <span class="iconfont icon-inputDele role-input-tree-dele input-icon"
                              style="display:none;"></span>
                        <div class="pe-select-tree-wrap pe-input-tree-wrap-drop"
                             style="display:none;">
                            <ul id="roleTreeData" class="ztree pe-tree-container floatL"></ul>
                        </div>
                    </div>
                </label>
            </div>
            <div class="pe-stand-form-cell">
                <label class="pe-form-label floatL">
                    <span class="pe-label-name">部门:</span>
                    <div class="pe-input-tree-content  pe-organize-input-tree pe-stand-filter-form-input">
                        <input class="pe-tree-show-name" readonly="readonly" value=""/>
                        <input type="hidden" name="organize.id" value=""/>
                        <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                        <div class="pe-select-tree-wrap pe-input-tree-wrap-drop"
                             style="display:none;width:">
                            <ul id="organizeTree" class="ztree pe-tree-container floatL"></ul>
                        </div>
                    </div>
                </label>
                <div class="pe-form-label pe-form-select floatL" style="margin-right:0;">
                    <span class="pe-label-name floatL">状态:</span>
                    <select class="select-status dropdown" name="userStatusList">
                        <%if (!status || status.length>1) {%>
                        <option value="" selected>全部</option>
                        <%} else {%>
                        <option value="">全部</option>
                        <%}%>
                        <%if (status && status.length ==1 && _.contains(status,'ENABLE')) {%>
                        <option value="ENABLE" selected>启用</option>
                        <%} else {%>
                        <option value="ENABLE">启用</option>
                        <%}%>
                        <%if (status && status.length ==1 && _.contains(status,'FORBIDDEN')) {%>
                        <option value="FORBIDDEN" selected>冻结</option>
                        <%} else {%>
                        <option value="FORBIDDEN">冻结</option>
                        <%}%>
                    </select>
                </div>
                <div class="pe-choosen-btn-wrap" style="margin-left: 243px;">
                    <button type="button" class="pe-btn pe-btn-blue pe-question-choose-btn">筛选</button>
                    <a href="javascript:;" class="choosen-simaple-opt-type">简单筛选</a>
                </div>
            </div>
        </div>
    </form>
</script>
<script type="text/javascript">
    $(function () {
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        //初始化简单筛选html
        $('.pe-stand-filter-form').html(_.template($('#simpleTemp').html())());
        /*自定义表格头部数量及宽度*/
        var peTableTitle = [
            {'title': '姓名', 'width': 10},
            {'title': '用户名', 'width': 10},
            {'title': '工号', 'width': 10},
            {'title': '手机号', 'width': 10},
            {'title': '部门', 'width': 15},
            {'title': '岗位', 'width': 15},
            {'title': '状态', 'width': 5},
            {'title': '所属角色', 'width': 12},
            {'title': '操作', 'width': 8}
        ];
        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/uc/role/manage/searchByUser',
            tempId: 'paperAccreditUser',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle
        });//peGrid结束

        $('.pe-stand-table-wrap').delegate('.deleteUser', 'click', function () {
            var userId = $(this).attr("data-id");
            var data = {
                'userId': userId
            };

            PEBASE.ajaxRequest({
                url: pageContext.rootPath + '/uc/role/manage/listRolesByUserId',
                data: data,
                success: function (data) {
                    if (!data || data.length <= 0) {
                        PEMO.DIALOG.alert({
                            content:'您没有操作权限'
                        });

                        return false;
                    }

                    PEMO.DIALOG.confirmR({
                        content: _.template($('#deleRoleTemp').html())({data: data}),
                        area: '468px',
                        title: '移除角色权限',
                        skin: 'pe-layer-confirmA dele-role-dialog',
                        btn2: function () {
                            if ($('#roleTmpForm').find('input[name="roleIds"]:checked').length === 0) {
                                layer.closeAll();
                                return false;
                            }

                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/uc/role/manage/deleteRolesByUserId?id=' + userId,
                                data: $('#roleTmpForm').serializeArray(),
                                success: function (aData) {
                                    if (aData.success || aData.success === 'true') {
                                        PEMO.DIALOG.tips({
                                            content: '修改成功',
                                            time: 1000,
                                            end: function () {
                                                $('.pe-stand-table-wrap').peGrid('refresh');
                                            }
                                        });
                                    } else {
                                        PEMO.DIALOG.tips({
                                            content: '修改失败',
                                            time: 1000
                                        });
                                    }
                                }
                            });
                        },
                        btn1: function () {
                            layer.closeAll();
                        },
                        success: function () {
                            PEBASE.peFormEvent('checkbox');
                        }
                    });
                }
            });
        });

        /*按角色查看*/
        $('.pe-view-role-btn').click(function () {
            location.href = '#url=' + pageContext.rootPath + '/uc/role/manage/initPage' + "&nav=user";
        });

        /*切换高级模板*/
        $('.pe-stand-filter-form').delegate('.choosen-advace-opt-type', 'click', function () {
            $('.pe-stand-filter-form').html(_.template($('#advaceTemp').html())({'positionName': '', 'status': ''}));
            roleManage.initPositionTree({positionName: '', status: 'ENABLE'});
            roleManage.initOrganizeTree();
            PEBASE.inputTree({dom: '.pe-role-input-tree', treeId: 'roleTreeData', treeParam: roleTreeData});
            PEBASE.peSelect($('.select-status'), null, null);
            //“所属角色”的input框里的删除按钮
            $('.role-input-tree-dele').click(function (e) {
                var e = e || window.event;
                e.stopPropagation();
                e.preventDefault();
                $(this).siblings('.input-tree-choosen-label').find('.search-tree-text').remove();
                var roleTree = $.fn.zTree.getZTreeObj('roleTreeData');
                var checkNodeArr = roleTree.getCheckedNodes(true);
                for (var j = 0, len = checkNodeArr.length; j < len; j++) {
                    roleTree.checkNode(checkNodeArr[j], false, true);
                }
                $(this).hide().siblings('.icon-class-tree').show();
                $('input[name="roleClassify"]').val('');
            });
        });


        /*切换简单模板*/
        $('.pe-stand-filter-form').delegate('.choosen-simaple-opt-type', 'click', function () {
            $('.pe-stand-filter-form').html(_.template($('#simpleTemp').html())({'positionName': '', 'status': ''}));
            //PEBASE.peSelect($('.select-status'), null, null);
        });

        /*筛选*/
        $('.pe-stand-filter-form').delegate('.pe-question-choose-btn', 'click', function () {
            $('.pe-stand-table-wrap').peGrid('load', $('#viewRoleForm').serializeArray());
        });

        var roleManage = {
            initPositionTree: function (data) {
                $('.pe-stand-filter-form').html(_.template($('#advaceTemp').html())(data));
                //查询条件岗位类别树
                var settingInputPositionTree = {
                    dataUrl: pageContext.rootPath + '/uc/position/manage/listPositionTree',
                    clickNode: function (treeNode) {
                        if (treeNode.pId == null) {
                            $('.show-position-name').val(null);
                        }

                        if (!treeNode || treeNode.isParent) {
                            return false;
                        }

                        $('input[name="positionId"]').val(treeNode.id);
                        $('.show-position-name').val(treeNode.name);
                    },
                    width: 250
                };
                PEBASE.inputTree({
                    dom: '.pe-position-tree-wrap',
                    treeId: 'positionTree',
                    treeParam: settingInputPositionTree
                });
            },
            initOrganizeTree: function () {
                //部门渲染
                var organizeTreeData = {
                    dataUrl: pageContext.rootPath + '/uc/user/manage/listTree',
                    clickNode: function (treeNode) {
                        $('.pe-organize-input-tree').find('.pe-tree-show-name').val(treeNode.name);
//                        if (!treeNode.pId) {
//                            $('.show-organize-name').val(null);
//                            return false;
//                        }
                        $('input[name="organize.id"]').val(treeNode.id);
                    },
                    width: 250
                };
                PEBASE.inputTree({
                    dom: '.pe-organize-input-tree',
                    treeId: 'organizeTree',
                    treeParam: organizeTreeData
                });
            }

        }


        var roleTreeData = {
            isCheckbox: true,
            isNoIcoIcon: true,
            dataUrl: pageContext.rootPath + '/uc/user/manage/listRoleTree',
            clickNode: function (treeNode) {
            },
            //checkbox点击事件,通过treeNode的checked或者checkedClass是否为true来判断是否选中或取消了
            checkboxFuc: function (zTree, treeNode) {
                var thisLabel = $('.pe-role-input-tree .input-tree-choosen-label');
                var idDom;
                thisLabel.find('span').each(function (index, ele) {
                    if ($(ele).data('id') === treeNode.id) {
                        idDom = ele;
                        return false;
                    }
                });
                if (treeNode.checked && !idDom) {
                    if (thisLabel.find('.search-tree-text').get(0)) {

                        var checkedText = $('.pe-role-input-tree .search-tree-text');
                        var beforeScrollLeft = checkedText.outerWidth() * checkedText.length;
                        thisLabel.find('.search-tree-text').last().after('<span class="search-tree-text" title="' + treeNode.name + '" data-id="' + treeNode.id + '">' + treeNode.name + '<input type="hidden" name="roleIds" value="' + treeNode.id + '"/>' + '</span>');
                        $('.pe-role-input-tree .input-tree-choosen-label').scrollLeft(beforeScrollLeft + $('.pe-role-input-tree .search-tree-text').outerWidth());
                        thisLabel.find('.pe-tree-show-name').insertAfter(thisLabel.find('.search-tree-text').last()).focus();
                    } else {
                        thisLabel.find('.pe-tree-show-name').before('<span class="search-tree-text" title="' + treeNode.name + '" data-id="' + treeNode.id + '">' + treeNode.name + '<input type="hidden" name="roleIds" value="' + treeNode.id + '"/>' + '</span>');
                    }
                    thisLabel.find('.search-tree-text').last().data('node', treeNode);
                } else {
                    thisLabel.find(idDom).remove();
                }
            },
            width: 250,
            isPeers: true
        };
    });
</script>
