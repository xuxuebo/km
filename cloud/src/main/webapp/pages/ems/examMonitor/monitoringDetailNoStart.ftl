<#assign ctx=request.contextPath/>
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header">
    <div class="pe-detail-top-head over-flow-hide">
        <div class="pe-top-nav-container">
            <h2 class="pe-for-grading">监控详情</h2>
            <div class="floatL" style="font-size: 16px;margin-left: 10px;">
            ${(exam.examName)!}<em class="pe-monitor-status">[未开始]</em>
            </div>
        </div>
    </div>
</div>
<#--公用头部-->
<div class="pe-main-wrap" style="margin-top: 20px;">
    <section class="pe-main-content monitor-main-wrap">
        <section class="exam-manage-all-wrap monitor-manage-all-wrap">
            <form id="examManageForm">
                <input type="hidden" name="arrangeId" value="${(examArrange.id)!}"/>
                <input type="hidden" name="examId" value="${(exam.id)}"/>
                <input type="hidden" name="exam.Id" value="${(examArrange.exam.id)!}"/>
                <div class="pe-manage-content-right">
                    <div class="pe-manage-panel pe-manage-default">
                        <div class="pe-manage-panel-head">
                            <div class="pe-stand-filter-form" style="margin-top:12px;">
                                <div class="pe-stand-form-cell">
                                    <label class="pe-form-label floatL" for="peMainKeyText">
                                        <span class="pe-label-name floatL">关键字:</span>
                                        <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                               placeholder="用户名/姓名/手机/邮箱" name="keyword">
                                    </label>
                                <#--部门-->
                                    <div class="pe-form-label floatL" style="margin-right:30px;">
                                        <span class="pe-label-name">
                                            部&emsp;门:
                                        </span>
                                        <div class="pe-stand-filter-form-input  pe-organize-input-tree">
                                            <input class="pe-tree-show-name show-organize-name" name="organizeName"
                                                   type="text"
                                                   maxlength=50 value="${(user.organize.organizeName)!}"/>
                                            <input type="hidden" name="organize.id" value=""/>
                                            <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"
                                                  style="height:36px;line-height:36px;"></span>
                                            <div class="pe-select-tree-wrap pe-input-tree-wrap-drop pe-input-tree-drop-third"
                                                 style="display:none;width:">
                                                <div class="node-search-empty">暂无该关键字相关信息</div>
                                                <ul id="organizeTreeData" class="ztree pe-tree-container floatL"></ul>
                                            </div>
                                        </div>
                                    </div>
                                <#--岗位-->
                                    <div class="clearF">
                                        <span class="pe-label-name floatL">岗&emsp;位:</span>
                                        <div class="pe-position-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                                            <input class="pe-tree-show-name show-position-name" name="positionName"
                                                   value=""/>
                                            <input type="hidden" name="positionId" value=""/>
                                            <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                                            <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop"
                                                 style="display:none;">
                                                <div class="node-search-empty">暂无该关键字相关信息</div>
                                                <ul id="positionTree" class="ztree pe-tree-container"></ul>
                                            </div>
                                        </div>
                                        <button type="button" class="pe-btn pe-btn-blue pe-monitor-choosen-btn"
                                                style="right: 30px;top: 28px;">筛选
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="pe-stand-table-panel">
                        <#if !((exam.subject?? && exam.subject) || (exam.markUpId??))>
                            <div class="pe-stand-table-top-panel">
                                <#if !(exam.enableTicket?? && exam.enableTicket)>
                                    <button type="button" class="pe-btn pe-btn-green create-online-btn add-user">添加考生
                                    </button>
                                </#if>
                                <button type="button" class="pe-btn <#if !(exam.enableTicket?? && exam.enableTicket)>pe-btn-white<#else>pe-btn-green</#if> offline-btn remove-user">移除考生</button>
                                <span class="pe-monitor-icon" title="刷新数据" style="cursor: pointer;padding-top: 14px;padding-left: 10px;">
                                        <i class="iconfont icon-renovate pe-monitor-refresh"></i>
                                    </span>
                                <div class="pe-monitor-end-tip">应到<span class="pe-monitor-num"></span>人，实到<span class="pe-monitor-num"></span>人</div>
                            </div>
                        </#if>
                            <div class="pe-stand-table-main-panel">
                                <div class="pe-stand-table-wrap"></div>
                                <div class="pe-stand-table-pagination"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </section>
    </section>
</div>
<script type="text/template" id="monitorNoStartTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI ;i++){%>
                <%if(peData.tableTitles[i].title === 'checkbox'){%>
                <th style="width:5%">
                    <label class="pe-checkbox pe-paper-all-check">
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheckAll"/>
                    </label>
                </th>
                <%}else{%>
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
                <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%_.each(peData.rows,function(user){%>
        <tr>
            <%_.each(peData.tableTitles,function(tableTitle){%>
                <%if (tableTitle.title === 'checkbox') {%>
                <td><label class="floatL pe-checkbox" for="" data-id="<%=user.id%>">
                    <span class="iconfont icon-unchecked-checkbox"></span>
                    <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheck"/>
                </label>
                </td>
                <%} else if(tableTitle.name === 'organizeName') {%>
                    <td><%=user.organize.organizeName%></td>
                <%} else {%>
                    <td title="<%=user[tableTitle.name]%>"><%=user[tableTitle.name]%></td>
                <%}%>
            <%});%>
        </tr>
        <%});%>
        <%} else {%>
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
<script type="text/javascript">
    $(function () {
        var detailMonitor = {
            init: function () {
                var _this = this;
                _this.initData();
                _this.bind();
                _this.flushUserCount();
            },

            initData: function () {
                //ie9不支持Placeholder问题
//                PEBASE.isPlaceholder();
                //岗位树渲染 pe-post-input-tree
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
                    width: 218,
                    treeSearch: $('input[name="positionName"]')
                };
                PEBASE.inputTree({
                    dom: '.pe-position-tree-wrap',
                    treeId: 'positionTree',
                    treeParam: settingInputPositionTree
                });
                //添加人员数量
                var arrangeId = $("input[name='arrangeId']").val();
                var examId = $("input[name='examId']").val();
                examId = $("input[name='exam.Id']").val();
                $('.add-user').off('click').on('click', function () {
                    PEMO.DIALOG.selectorDialog({
                        title: '按人员添加',
                        area: ['970px', '580px'],
                        content: [pageContext.rootPath + '/ems/exam/manage/initSelectorUserPage?id=' + arrangeId + '&exam.id=' + examId, 'no'],
                        btn: ['关闭'],
                        btn1: function (index) {
                            layer.close(index);
                            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
                            detailMonitor.flushUserCount();
                        }
                    });
                });
                $('.remove-user').off('click').on('click', function () {
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
                    //移除组织学员
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要移除选中学员么？</div>',
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/exam/manage/deleteExamUser',
                                data: {
                                    'id': arrangeId,
                                    'exam.id': examId,
                                    'referIds': JSON.stringify(rows)
                                },
                                success: function (data) {
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '移除成功',
                                            time: 1000,
                                            end: function () {
                                                $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
                                                detailMonitor.flushUserCount();
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
                            detailMonitor.flushUserCount();
                        }
                    });
                });

                //部门渲染
                var organizeTreeData = {
                    dataUrl: pageContext.rootPath + '/uc/user/manage/listTree',
                    clickNode: function (treeNode) {
                        if (treeNode.pId == null) {
                            $('.show-organize-name').val(null);
                        }
                        if (!treeNode.pId) {
                            return false;
                        }

                        $('.pe-organize-input-tree').find('.pe-tree-show-name').val(treeNode.name);
                        $('input[name="organize.id"]').val(treeNode.id);
                    },
                    width: 308,
                    treeSearch: $('input[name="organizeName"]')
                };
                PEBASE.inputTree({
                    dom: '.pe-organize-input-tree',
                    treeId: 'organizeTreeData',
                    treeParam: organizeTreeData
                });

            <#if (exam.subject?? && exam.subject) || (exam.markUpId??)>
                <#if exam.enableTicket?? && exam.enableTicket>
                    var peTableTitle = [
                        {'title': '准考证号', 'name': 'ticket', 'width': 10},
                        {'title': '用户名', 'name': 'loginName', 'width': 15},
                        {'title': '姓名', 'name': 'userName', 'width': 15},
                        {'title': '部门', 'name': 'organizeName', 'width': 15},
                        {'title': '岗位', 'name': 'positionName', 'width': 15},
                        {'title': '手机号', 'name': 'mobile', 'width': 15},
                        {'title': '邮箱', 'name': 'email', 'width': 15}
                    ];
                <#else>
                    peTableTitle = [
                        {'title': '用户名', 'name': 'loginName', 'width': 15},
                        {'title': '姓名', 'name': 'userName', 'width': 15},
                        {'title': '部门', 'name': 'organizeName','width': 20},
                        {'title': '岗位', 'name': 'positionName', 'width': 15},
                        {'title': '手机号', 'name': 'mobile', 'width': 15},
                        {'title': '邮箱', 'name': 'email', 'width': 20}
                    ];
                </#if>

            <#else>
                <#if exam.enableTicket?? && exam.enableTicket>
                    peTableTitle = [
                        {'title': 'checkbox', 'width': 5},
                        {'title': '准考证号', 'name': 'ticket', 'width': 10},
                        {'title': '用户名', 'name': 'loginName', 'width': 15},
                        {'title': '姓名', 'name': 'userName', 'width': 15},
                        {'title': '部门', 'name': 'organizeName', 'width': 15},
                        {'title': '岗位', 'name': 'positionName', 'width': 10},
                        {'title': '手机号', 'name': 'mobile', 'width': 15},
                        {'title': '邮箱', 'name': 'email', 'width': 15}
                    ];
                <#else>
                    peTableTitle = [
                        {'title': 'checkbox', 'width': 5},
                        {'title': '用户名', 'name': 'loginName', 'width': 15},
                        {'title': '姓名', 'name': 'userName', 'width': 15},
                        {'title': '部门', 'name': 'organizeName', 'width': 20},
                        {'title': '岗位', 'name': 'positionName', 'width': 10},
                        {'title': '手机号', 'name': 'mobile', 'width': 15},
                        {'title': '邮箱', 'name': 'email', 'width': 20}
                    ];
                </#if>
            </#if>


                /*表格生成*/
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/examMonitor/manage/searchExamUserNoStart',
                    formParam: $('#examManageForm').serialize(),//表格上方表单的提交参数
                    tempId: 'monitorNoStartTemp',//表格模板的id
                    showTotalDomId: 'showTotal',
                    title: peTableTitle, //表格头部的数量及名称数组;
                    onLoad: function () {
                        PEBASE.peFormEvent('checkbox');
                        PEBASE.peFormEvent('radio');
                    }
                });
            },
            flushUserCount: function(){
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/examMonitor/manage/searchExamUserCount',
                    data: {
                        arrangeId: '${(examArrange.id)!}'
                    },
                    success:function(data){
                        if(data.success){
                            var monitorCount = JSON.parse(data.message);
                            var joinNum = monitorCount["joinNum"];
                            var joinedNum = monitorCount["joinedNum"];
                            $(".pe-monitor-end-tip span:first").html(joinNum);
                            $(".pe-monitor-end-tip span:last").html(joinedNum);
                        }
                    }
                });
            },

            bind: function () {
                $('.pe-monitor-choosen-btn').on('click', function () {
                    var organizeVal = $('.show-organize-name').val();
                    var positionVal = $('.show-position-name').val();
                    if (!positionVal) {
                        $('input[name="positionId"]').val('');
                    }
                    if (!organizeVal) {
                        $('input[name="organize.id"]').val('');
                    }
                    $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
                });

                $(".pe-monitor-refresh").on("click",function(){
                    detailMonitor.initData();
                })
            }
        };

        detailMonitor.init();
    });
</script>
</@p.pageFrame>