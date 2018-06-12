<#assign ctx=request.contextPath/>
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<#--考生状态明细头部-->
<div class="pe-public-top-nav-header">
    <div class="pe-detail-top-head over-flow-hide">
        <h3 class="pre-bank-items-name">${(exam.examName)!}</h3>
        <ul class="bank-items-detail-num-wrap over-flow-hide">
            <li class="item-bank-num floatL item-bank-all-num"><span class="bank-item-nav-link-result" style="cursor: default">应考人数：${(exam.testCount)!''}</span></li>
            <li class="item-bank-num floatL"><span class="bank-item-nav-link-result" style="cursor: default">通过：${(exam.passCount)!}</span></li>
            <li class="item-bank-num floatL"><span class="bank-item-nav-link-result" style="cursor: default">未通过：${(exam.noPassCount)!}</span></li>
            <li class="item-bank-num floatL"><span class="bank-item-nav-link-result" style="cursor: default">缺考：${(exam.missCount)!}</span></li>
            <li class="item-bank-num floatL"><span class="bank-item-nav-link-result" style="cursor: default">评卷中：${(exam.markingCount)!}</span></li>
        </ul>
    </div>
</div>
<div class="exam-manage-all-wrap user-result-detail-wrap">
    <form id="examManageForm" style="margin-bottom:70px;">
        <input type="hidden" name="exam.id" value="${(exam.id)!}">
        <input type="hidden" name="user.organize.id" value="">
        <input type="hidden" name="user.positionId" value="">
        <input type="hidden" name="examType" value="${(exam.examType)!}"/>
        <div class="pe-manage-content-right">
            <div class="result-user-detail">考生明细</div>
            <div class="pe-manage-default">
                <div class="pe-manage-panel-head">
                    <div class="pe-stand-filter-form">
                        <div class="pe-stand-form-cell">
                            <label class="pe-form-label floatL" for="peMainKeyText">
                                <span class="pe-label-name floatL">考生:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="姓名/用户名/工号/手机号"
                                       name="user.keyword">
                            </label>
                            <div class="floatL" style="margin-right:20px;">
                                <span class="pe-label-name floatL" style="margin-right:5px;">部门:</span>
                                <div class="pe-organize-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                                    <input class="pe-tree-show-name show-organize-name" value=""/>
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
                                    <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                                    <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop" style="display:none;">
                                        <ul id="positionTree" class="ztree pe-tree-container"></ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="pe-stand-form-cell">
                            <dl class="over-flow-hide floatL">
                                <dt class="pe-label-name floatL">状&emsp;态:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                        <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examStatuses" value="PASS"/>通过
                                    </label>
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examStatuses" value="NO_PASS"/>未通过
                                    </label>
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-unchecked-checkbox"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" type="checkbox"
                                               name="examStatuses" value="MISS_EXAM"/>缺考
                                    </label>
                                    <label class="floatL pe-checkbox" for="">
                                        <span class="iconfont icon-unchecked-checkbox"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" type="checkbox"
                                               name="examStatuses" value="MARKING"/>评卷中
                                    </label>
                                </dd>
                            </dl>
                            <button type="button" id="queryCondition" class="pe-btn pe-btn-blue"
                                    style="margin-left: 20px;">筛选
                            </button>
                        </div>
                    </div>
                </div>
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                        <button type="button" class="pe-btn pe-btn-green create-online-btn">导出当前结果</button>
                        <#--<button type="button" class="pe-btn pe-btn-white offline-btn">导出全部考试</button>
                        <button type="button" class="pe-btn pe-btn-white comprehensive-btn creat-offline-btn">导出答卷人员
                        </button>-->
                    </div>
                <#--表格包裹的div-->
                    <div class="pe-stand-table-panel">
                        <div class="pe-stand-table-main-panel" style="position:relative;">
                            <div class="pe-scrollTable-wrap reviewMana-scroll-table">
                                <div class="pe-stand-table-wrap" style="padding:0;"></div>
                            </div>
                            <div class="pe-stand-table-pagination"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<#--渲染非固定表格模板-->
<script type="text/template" id="releaseResultTemp">
    <table class="pe-stand-table pe-stand-table-default" style="border-bottom:1px solid #e0e0e0;">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <%if(peData.tableTitles[i].type === 'noFixed'){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%if(peData.tableTitles[i].order){%>
                    <div class="pe-th-wrap pe-ellipsis" data-type="<%=peData.tableTitles[i].type%>">
                        <%=peData.tableTitles[i].title%>
                        <span class="pageSize-arrow level-order-up iconfont icon-pageUp"></span>
                        <span class="pageSize-arrow level-order-down iconfont icon-pageDown"></span>
                    </div>
                    <%}else{%>
                    <div class="pe-ellipsis"><%=peData.tableTitles[i].title%></div>
                    <%}%>
                </th>
                <%}%>
                <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%_.each(peData.rows,function(examResult,index){%>
        <tr>
            <%_.each(peData.tableTitles,function(titleColumn,titleIndex){%>
            <%if(titleColumn.name === 'subject'){%>
            <%if (examResult.exam.subjects[titleIndex-6] && examResult.exam.subjects[titleIndex-6].examResult && ((examResult.exam.subjects[titleIndex-6].examResult.score && examResult.exam.subjects[titleIndex-6].examResult.score >0) || examResult.exam.subjects[titleIndex-6].examResult.score === 0)) {%>
            <td><%=Number(examResult.exam.subjects[titleIndex-6].examResult.score).toFixed(1)%></td>
            <%} else {%>
            <td>--</td>
            <%}}%>
            <%})%>
        </tr>
        <%});%>
        <%}else{%>
        <tr>
            <td class="pe-td pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
                <div class="" style="height:351px;"></div>
                <#--<p class="pe-result-date-warn">暂无数据</p>-->
            </td>
        </tr>
        <%}%>
        </tbody>
    </table>
</script>

<#--渲染表格模板-->
<script type="text/template" id="peExamManaTemp">
    <table class="pe-stand-table pe-stand-table-default user-result-comp-detail">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI ;i++){%>
                <%if(peData.tableTitles[i].name === 'totalScore'){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%if(peData.tableTitles[i].order){%>
                    <div class="pe-th-wrap" data-type="<%=peData.tableTitles[i].type%>">
                        <%=peData.tableTitles[i].title%>
                        <span class="pageSize-arrow level-order-up iconfont icon-pageUp"
                              style="left:44px;"></span>
                        <span class="pageSize-arrow level-order-down iconfont icon-pageDown"
                              style="left:44px;"></span>
                    </div>
                    <%}else{%>
                    <%=peData.tableTitles[i].title%>
                    <%}%>
                </th>
                <%}else if(peData.tableTitles[i].name === 'userName' ||
                peData.tableTitles[i].name === 'employeeCode' || peData.tableTitles[i].name === 'organizeName' ||
                peData.tableTitles[i].name === 'positionName' || peData.tableTitles[i].name === 'userStatus'
                || peData.tableTitles[i].name === 'status'){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%=peData.tableTitles[i].title%>
                </th>
                <%}%>
                <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%_.each(peData.rows,function(examResult,index){%>
        <tr>

            <%_.each(peData.tableTitles,function(titleColumn,titleIndex){%>
            <%if(titleColumn.name === 'userName'){%>
            <td><%=examResult.user.userName%></td>
            <%}else if(titleColumn.name === 'employeeCode'){%>
            <td><%=examResult.user.employeeCode%></td>
            <%}else if(titleColumn.name === 'organizeName'){%>
            <td><%=examResult.user.organize.organizeName%></td>
            <%}else if(titleColumn.name === 'positionName'){%>
            <td><%=examResult.user.positionName%></td>
            <%}else if(titleColumn.name === 'userStatus'){%>
            <td>
                <%if (examResult.user.status === 'ENABLE') {%>
                激活
                <%} else {%>
                冻结
                <%}%>
            </td>
            <%}else if(titleColumn.name === 'status'){%>
            <td>
                <%if (examResult.status === 'MISS_EXAM') {%>
                缺考
                <%} else if(examResult.status === 'MARKING' || examResult.status === 'WAIT_RELEASE') {%>
                评卷中
                <%} else if(examResult.pass) {%>
                通过
                <%}else if(!examResult.pass) {%>
                <span style="color:red;">未通过</span>
                <%}%>
            </td>
            <%}else if(titleColumn.name === 'totalScore'){%>
            <%if (examResult.status === 'MISS_EXAM' || examResult.status === 'MARKING' || examResult.status === 'WAIT_RELEASE') {%>
            <td>--</td>
            <%}else{%>
            <td><%=(examResult.score != null && examResult.score >= 0)?Number(examResult.score).toFixed(1):'--'%></td>
            <%}%>
            <%}%>
            <%});%>
        </tr>
        <%});%>
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
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        var peTableTitle = [
            {'title': '姓名', 'name': 'userName', 'width': 10},
            {'title': '工号', 'name': 'employeeCode', 'width': 10},
            {'title': '部门', 'name': 'organizeName', 'width': 13},
            {'title': '岗位', 'name': 'positionName', 'width': 13},
            {'title': '人员状态', 'name': 'userStatus', 'width': 10},
            {'title': '状态', 'name': 'status', 'width': 10},
            {'title': '成绩', 'name': 'totalScore', 'width': 9}
        ];

        <#list subjects as subject>
            peTableTitle.push({
                'title': '${(subject.examName)!}',
                'name': 'subject',
                'width': 10,
                'type': 'noFixed',
                'order': true
            });
        </#list>

        var examType = $('input[name="examType"]').val();
        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/ems/examResult/manage/searchUserDetail',
            formParam: $('#examManageForm').serializeArray(),//表格上方表单的提交参数
            showTotalDomId: 'showTotal',
            tempId: 'releaseResultTemp',//表格模板的id
            title: peTableTitle, //表格头部的数量及名称数组;
            isTableScroll: true,
            isTableHasFixed: true,
            tableScrollType: 'reviewCompResult',
            fixedTableTempId: ['peExamManaTemp'],
            onLoad: function (t) {
                $('.pe-stand-table-main-panel').append(_.template($('#peExamManaTemp').html())({peData: t.data}));
                if(t.data.rows && t.data.rows.length === 0){
//                    if(!$('.user-manage-empty').get(0)){
//                        var emptyDom =  '<div class="user-manage-empty"><div class="pe-result-no-date"></div>'
//                                +'<p class="pe-result-date-warn" style="text-align:center;">暂无数据</p></div>';
//                        var $emptyDom = $('.pe-stand-table-main-panel .user-manage-empty');
//                        if (!$emptyDom || $emptyDom.length === 0) {
//                            $('.pe-stand-table-main-panel').append(emptyDom);
//                        }
//
//                    }else{
//                        $('.user-manage-empty').show();
//                    }
//                    $('.pe-scrollTable-wrap').hide();
//                    $('.pe-stand-table-pagination').hide();
//                    $('.user-result-comp-detail').hide();
                }else{
                    $('.pe-scrollTable-wrap').mCustomScrollbar('destroy').mCustomScrollbar({
                        axis: "x",
                        theme: "dark-3",
                        scrollbarPosition: "inside",
                        setWidth: '480px',
                        advanced: {updateOnContentResize: true}
                    });

                    $('.pe-scrollTable-wrap').show();
                    $('.pe-stand-table-pagination').show();
                    $('.user-result-comp-detail').show();
                }
            }
        });

        $('#queryCondition').on('click', function () {
            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
        });

        $('.create-online-btn').on('click', function () {
            location.href = pageContext.rootPath + '/ems/examResult/manage/exportExamResult?' + $('#examManageForm').serialize();
        });

        //部门渲染
        var organizeTreeData = {
            dataUrl: pageContext.rootPath + '/uc/user/manage/listTree',
            clickNode: function (treeNode) {
                $('.pe-organize-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                $('input[name="user.organize.id"]').val(treeNode.id);
            },
            width: 218
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

                $('input[name="user.positionId"]').val(treeNode.id);
                $('.show-position-name').val(treeNode.name);
            },
            width: 218
        };
        PEBASE.inputTree({
            dom: '.pe-position-tree-wrap',
            treeId: 'positionTree',
            treeParam: settingInputPositionTree
        });

        $('.pe-stand-table-wrap').delegate('.icon-re', 'click', function () {
            var arrangeId = $(this).data('arrange');
            var userId = $(this).data('user');
            window.open("${ctx}/ems/examResult/manage/reviewResult?arrangeId=" + arrangeId + "&userId=" + userId,'REVIEW_RESULT');
        });

        $('.pe-stand-table-wrap').delegate('.pe-stand-table-alink', 'click', function () {
            var examId = $(this).data('exam');
            var userId = $(this).data('user');
            window.open("${ctx}/ems/examResult/manage/initDetailResult?examId=" + examId + "&userId=" + userId,'DETAIL_RESULT');
        });
    })
</script>
</@p.pageFrame>