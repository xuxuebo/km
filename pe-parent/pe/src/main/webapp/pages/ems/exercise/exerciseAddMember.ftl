<#assign ctx=request.contextPath/>
<#--todo开发开始做这个页面的跳转时记得把下面的import和p.pageFrame删除-->
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header">
    <h3 class="paper-add-accredit-title">添加考生</h3>
</div>
<section class="exam-add-member-all-wrap">
    <div class="pe-manage-content-right" style="margin:0;">
        <div class="pe-manage-panel pe-manage-default" style="border:none;">
            <form id="userForm">
                <input type="hidden" name="id" value="${(exerciseId)!}"/>
                <div class="pe-manage-panel-head">
                    <div class="pe-stand-filter-form">
                        <div class="pe-stand-form-cell" style="margin: 10px 0;">
                            <label class="pe-form-label floatL" for="peMainKeyText" style="margin-right:20px">
                                <span class="pe-label-name floatL" style="margin-right:5px;">关键字:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input pe-table-form-text"
                                       type="text" placeholder="姓名/用户名/工号/手机号"
                                       name="keyword">
                            </label>
                            <div id="" class="floatL" style="margin-right:20px;">
                                <span class="pe-label-name floatL" style="margin-right:5px;">岗位:</span>
                                <div class="pe-position-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                                    <input class="pe-tree-show-name show-position-name" value=""/>
                                    <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                                    <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop" style="display:none;">
                                        <ul id="positionTree" class="ztree pe-tree-container"></ul>
                                    </div>
                                </div>
                            </div>
                            <div id="" class="floatL" style="margin-right:20px;">
                                <span class="pe-label-name floatL" style="margin-right:5px;">部门:</span>
                                <div class="pe-organize-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                                    <input class="pe-tree-show-name show-organize-name" value=""/>
                                    <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                                    <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop" style="display:none;">
                                        <ul id="organizeTree" class="ztree pe-tree-container"></ul>
                                    </div>
                                </div>
                            </div>
                            <div class="pe-choosen-btn-wrap">
                                <button type="button" class="pe-btn pe-btn-blue pe-question-choosen-btn"
                                        style="width: 89px">筛选
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <div class="pe-stand-table-panel" style="border: 0;">
                <div class="pe-stand-table-top-panel" style="padding-left: 0;">
                    <button type="button" class="pe-btn pe-btn-green add-user">添加</button>
                    <button type="button" class="pe-btn pe-btn-primary remove-user">移除</button>
                </div>
            <#--表格包裹的div-->
                <div class="pe-stand-table-main-panel">
                    <div class="pe-stand-table-wrap"></div>
                    <div class="pe-stand-table-pagination"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="exam-add-members-btns">
        <button type="button" class="pe-btn pe-btn-blue pe-large-btn pe-view-question-close-btn">关闭</button>
    </div>
</section>
<#--渲染表格模板-->
<script type="text/template" id="examAddMemberTemp">
    <table class="pe-stand-table pe-stand-table-default checkbox-table">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <%if(peData.tableTitles[i].title === 'checkbox'){%>
                <th style="width:<%=peData.tableTitles[i].width%>%">
                    <label class="pe-checkbox pe-paper-all-check">
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheckAll"/>
                    </label>
                </th>
                <%}else{%>
                <th style="width:<%=peData.tableTitles[i].width%>%">
                    <%=peData.tableTitles[i].title%>
                </th>
                <%}%>
                <%}%>
        </tr>
        </thead>
        <tbody>
        <#--<tr class="pe-stand-bg"></tr>-->
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j
        <lenJ ;j++){%>
            <tr data-index="<%=j%>">
                <td>

                    <label class="pe-checkbox pe-paper-check" data-id="<%=peData.rows[j].id%>">
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheck"/>
                    </label>
                </td>
            <#--姓名类-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].userName%>"><%=peData.rows[j].userName%></div>
                </td>
            <#--用户名类别-->
                <td>
                    <a class="pe-stand-table-alink pe-dark-font pe-ellipsis" title="<%=peData.rows[j].loginName%>"
                       href="javascript:;"
                       target="_blank"><%=peData.rows[j].loginName%></a>
                </td>
            <#--工号类别-->
                <td><%=peData.rows[j].employeeCode%></td>
            <#--手机号-->
                <td><%=peData.rows[j].mobile%></td>
            <#--部门-->
                <td title="<%=peData.rows[j].organize.organizeName%>"><%=peData.rows[j].organize.organizeName%></td>
            <#--岗位-->
                <td title="<%=peData.rows[j].positionName%>"><%=peData.rows[j].positionName%></td>
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

<script>
    $(function () {
        var exerciseId = '${(exerciseId)!}';
        var batchUserManage = {
            initData: function () {
                /*自定义表格头部数量及宽度*/
                var peTableTitle = [
                    {'title': 'checkbox', 'width': 4},
                    {'title': '姓名', 'width': 10},
                    {'title': '用户名', 'width': 10},
                    {'title': '工号', 'width': 10},
                    {'title': '手机号', 'width': 16},
                    {'title': '部门', 'width': 15},
                    {'title': '岗位', 'width': 35}
                ];
                /*表格生成*/

                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/exercise/manage/searchSelectUser',
                    formParam: $('#userForm').serializeArray(),//表格上方表单的提交参数
                    tempId: 'examAddMemberTemp',//表格模板的id
                    showTotalDomId: 'showTotal',
                    title: peTableTitle //表格头部的数量及名称数组;
                });


                //部门渲染
                var organizeTreeData = {
                    dataUrl: pageContext.rootPath + '/uc/user/manage/listTree',
                    clickNode: function (treeNode) {
                        if (!treeNode.pId) {
                            return false;
                        }

                        $('.pe-organize-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                        $('input[name="organize.id"]').val(treeNode.id);
                    }
                };
                PEBASE.inputTree({dom: '.pe-organize-tree-wrap', treeId: 'organizeTree', treeParam: organizeTreeData});
                //岗位
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
                    }
                };
                PEBASE.inputTree({
                    dom: '.pe-position-tree-wrap',
                    treeId: 'positionTree',
                    treeParam: settingInputPositionTree
                });
            },

            init: function () {
                /*关闭按钮事件*/
                $('.pe-view-question-close-btn').on('click', function () {
                    window.close();
                });

                $('.pe-question-choosen-btn').on('click', function () {
                    $('.pe-stand-table-wrap').peGrid('load', $('#userForm').serializeArray());
                });

                $('.add-user').on('click', function () {
                    PEMO.DIALOG.selectorDialog({
                        title: '按人员添加',
                        area: ['970px', '580px'],
                        content: [pageContext.rootPath + '/ems/exercise/manage/initSelectorUserPage', 'no'],
                        btn: ['关闭'],
                        btn1: function (index) {
                            layer.close(index);
                            $('.pe-stand-table-wrap').peGrid('load', $('#userForm').serializeArray());
                            refreshCount(exerciseId);
                        }
                    });
                });

                $('.remove-user').on('click', function () {
                    var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                    if (!rows || rows.length <= 0) {
                        PEMO.DIALOG.alert({
                            content: '请至少先选择一个学员！',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });

                        return false;
                    }

                    console.log(rows);
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要移除选中学员么？</div>',
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/exercise/manage/deleteExerciseUser',
                                data: {
                                    referIds: JSON.stringify(rows),
                                    exerciseUserType: 'USER'
                                },
                                success: function (data) {
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '移除成功',
                                            time: 1000,
                                            end: function () {
                                                $('.pe-stand-table-wrap').peGrid('load', $('#userForm').serializeArray());
                                                refreshCount(exerciseId);
                                            }
                                        });
                                        return false;
                                    } else {
                                        PEMO.DIALOG.tips({
                                            content: data.message,
                                            time: 2000
                                        });
                                    }
                                }
                            });
                        },
                        btn1: function () {
                            layer.closeAll();
                        }
                    });
                });
            }
        };

        batchUserManage.init();
        batchUserManage.initData();
    });

    function refreshCount(exerciseId) {
        window.opener.countUser(exerciseId);
    }
</script>
</@p.pageFrame>