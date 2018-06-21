<div class="pe-manage-panel pe-manage-default">
    <form id="allDetailForm">
        <#--<input type="hidden" name="organize.id">-->
        <#--<input type="hidden" name="positionId">-->
        <input type="hidden" name="exam.id" value="${(examId)!}">
        <div class="pe-manage-panel-head">
            <div class="pe-stand-filter-form">
                <div class="pe-stand-form-cell">
                    <label class="pe-form-label floatL" style="margin-right:30px;">
                        <span class="pe-label-name floatL">考生:</span>
                        <input id="peMainKeyText" class="pe-stand-filter-form-input"
                               type="text" placeholder="姓名/用户名/工号/手机号" name="keyword">
                    </label>
                    <div class="floatL" style="margin-right:20px;">
                        <span class="pe-label-name floatL" style="margin-right:5px;">部门:</span>
                        <div class="pe-organize-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                            <input class="pe-tree-show-name show-organize-name" value=""/>
                            <input type="hidden" name="organize.id">
                            <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                            <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop" style="display:none;">
                                <ul id="organizeTree" class="ztree pe-tree-container"></ul>
                            </div>
                        </div>
                    </div>
                    <div style="margin-right:20px;">
                        <span class="pe-label-name floatL" style="margin-right:5px;">岗位:</span>
                        <div class="pe-position-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                            <input class="pe-tree-show-name show-position-name" value=""/>
                            <input type="hidden" name="positionId">
                            <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                            <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop" style="display:none;">
                                <ul id="positionTree" class="ztree pe-tree-container"></ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="pe-stand-form-cell">
                    <dl class="floatL" style="margin-right:75px;">
                        <dt class="pe-label-name floatL">状态:</dt>
                        <dd class="pe-stand-filter-label-wrap">
                            <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                            <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                <input id="peFormEleStart" class="pe-form-ele" checked="checked"
                                       type="checkbox" name="passStatus" value="true"/>通过
                            </label>
                            <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <input id="peFormEleDraft" class="pe-form-ele" checked="checked"
                                       type="checkbox" name="passStatus" value="false"/>未通过
                            </label>
                        </dd>
                    </dl>
                    <dl class="" style="margin-right:20px;">
                        <dt class="pe-label-name floatL">人员状态:</dt>
                        <dd class="pe-stand-filter-label-wrap">
                            <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                            <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                <input id="peFormEleStart" class="pe-form-ele" checked="checked"
                                       type="checkbox" name="userStatusList" value="ENABLE"/>激活
                            </label>
                            <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-unchecked-checkbox"></span>
                                <input id="peFormEleDraft" class="pe-form-ele"
                                       type="checkbox" name="userStatusList" value="FORBIDDEN"/>冻结
                            </label>
                        </dd>
                    </dl>
                    <button type="button" class="pe-btn pe-btn-blue pe-question-choosen-btn" style="position:absolute;right:40px;">筛选</button>
                </div>
            </div>
        </div>
    </form>
<#--节点id取值-->
    <div class="pe-stand-table-panel">
        <#--<div class="pe-stand-table-top-panel">-->
            <#--<button type="button" class="pe-btn pe-btn-green pe-new-question-btn">导出全部人员</button>-->
            <#--<button type="button" class="pe-btn pe-btn-primary pe-question-load-btn">导出筛选结果</button>-->
        <#--</div>-->
        <div class="pe-stand-table-main-panel">
            <div class="pe-stand-table-wrap"></div>
            <div class="pe-stand-table-pagination"></div>
        </div>
    </div>
</div>
<#--渲染表格模板-->
<script type="text/template" id="detailDetailTableTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%=peData.tableTitles[i].title%>
                </th>
                <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%_.each(peData.rows,function(examResult,index){%>
        <tr>
            <%if (peData.tableTitles[0].name === 'ticket') {%>
            <td title="<%=examResult.user.ticket%>"><%=examResult.user.ticket%></td>
            <%}%>
            <td title="<%=examResult.user.userName%>"><%=examResult.user.userName%></td>
            <td title="<%=examResult.user.loginName%>"><%=examResult.user.loginName%></td>
            <td title="<%=examResult.user.employeeCode%>"><%=examResult.user.employeeCode%></td>
            <td title="<%=examResult.user.organize.organizeName%>"><%=examResult.user.organize.organizeName%></td>
            <td title="<%=examResult.user.positionName%>"><%=examResult.user.positionName%></td>
            <%if(examResult.user.status === 'ENABLE'){%>
            <td>激活</td>
            <%}else if(examResult.user.status === 'FORBIDDEN'){%>
            <td>冻结</td>
            <%}%>
            <%if(examResult.status === 'MISS_EXAM'){%>
            <td>缺考</td>
            <td>--</td>
            <%} else if(examResult.pass) {%>
            <td>通过</td>
            <td><%=(Number(examResult.score)).toFixed(1)%></td>
            <%}else{%>
            <td>未通过</td>
            <td><%=(Number(examResult.score)).toFixed(1)%></td>
            <%}%>
        </tr>
        <%})%>
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
<script type="text/javascript">
    $(function () {
        var detailExam = {
            init: function () {
                this.initData();
                this.bind();
            },

            bind: function () {
                var _this = this;
                $('.pe-btn-blue').on('click', function () {
                    _this.renderData();
                });
            },

            initData: function () {
                var _this = this;
                //ie9不支持Placeholder问题
                PEBASE.isPlaceholder();
                //部门
                var organizeTreeData = {
                    dataUrl: pageContext.rootPath + '/uc/user/manage/listTree',
                    clickNode: function (treeNode) {
//                        if (!treeNode.pId) {
//                            $('.show-organize-name').val(null);
//                            return false;
//                        }

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

                _this.renderData();
            },

            renderData: function () {
                <#if enableTicket?? && enableTicket>
                    var peTableTitle = [
                        {'title': '准考证号', 'name':'ticket','width': 10},
                        {'title': '姓名', 'width': 10},
                        {'title': '用户名', 'width': 10},
                        {'title': '工号', 'width': 15},
                        {'title': '部门', 'width': 15},
                        {'title': '岗位', 'width': 20},
                        {'title': '人员状态', 'width': 10},
                        {'title': '状态', 'width': 10},
                        {'title': '成绩', 'width': 10}
                    ];
                <#else>
                    peTableTitle = [
                        {'title': '姓名', 'width': 10},
                        {'title': '用户名', 'width': 10},
                        {'title': '工号', 'width': 15},
                        {'title': '部门', 'width': 15},
                        {'title': '岗位', 'width': 20},
                        {'title': '人员状态', 'width': 10},
                        {'title': '状态', 'width': 10},
                        {'title': '成绩', 'width': 10}
                    ];
                </#if>

                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/examResult/manage/searchWaitReleaseResult',
                    formParam: $('#allDetailForm').serializeArray(),//表格上方表单的提交参数
                    tempId: 'detailDetailTableTemp',//表格模板的id
                    title: peTableTitle
                });
            }
        };

        detailExam.init();
    });
</script>