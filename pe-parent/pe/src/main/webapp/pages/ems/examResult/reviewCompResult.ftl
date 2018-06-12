<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<#--公用头部-->
<header class="pe-public-top-nav-header" data-id="">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="pe-result-detail floatL">发布成绩<span class="pe-release-tip">只能发布评卷完成的试卷</span></li>
        </ul>
    </div>
</header>
<div class="pe-main-wrap">
    <div class="pe-main-content">
        <div class="pe-release-top">
            <h2 class="pe-release-title"><span
                    class="pe-result-online">[综合]</span>${(exam.examName)!}
            </h2>
            <div class="pe-release-btn">
                <button class="pe-btn pe-btn-green">立即发布</button>
            </div>
        </div>
        <div class="pe-manage-content-right pe-release-content">
            <div class="pe-manage-panel pe-manage-default">
                <form id="queryForm">
                    <input type="hidden" name="examId" value="${(exam.id)!}"/>
                    <input type="hidden" name="sort"/>
                    <input type="hidden" name="order"/>
                    <div class="pe-manage-panel-head">
                        <p class="pe-viewing-warn" style="display:block;padding-top:0;">所有科目都已评卷完成，可以发布成绩</p>
                        <div class="pe-stand-filter-label-wrap">
                            <label class="floatL pe-checkbox pe-check-by-list" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <input class="pe-form-ele" checked="checked" type="checkbox"
                                       name="passStatus" value="true">通过
                            </label>
                            <label class="floatL pe-checkbox pe-check-by-list" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <input class="pe-form-ele" checked="checked" type="checkbox"
                                       name="passStatus" value="false">未通过
                            </label>
                        <#--<label class="floatL pe-checkbox" for="" style="margin-left:45px;">-->
                        <#--<span class="iconfont icon-unchecked-checkbox"></span>-->
                        <#--<input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"-->
                        <#--name="examTypes" value="ONLINE">只显示有异常和违纪情况的考生-->
                        <#--</label>-->
                        </div>
                    </div>
                </form>
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel" style="height: 15px;">
                    </div>
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
</div>
<#--渲染非固定表格模板-->
<script type="text/template" id="releaseResultTemp">
    <table class="pe-stand-table pe-stand-table-default">
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
                <div class="pe-result-no-date4" style="height:350px;"></div>
                <#--<p class="pe-result-date-warn">暂无数据</p>-->
            </td>
        </tr>
        <%}%>
        </tbody>
    </table>
</script>
<#--渲染左边固定表格模板-->
<script type="text/template" id="releaseLeftFixedResultTemp">
    <table class="pe-stand-table pe-stand-table-default reviewResult-left-fixed-table  pe-fixed-table-panel" style="width:684px;">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
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
                peData.tableTitles[i].name === 'positionName'
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
            <%}else if(titleColumn.name === 'status'){%>
            <td><%if (examResult.pass) {%>通过<%} else {%><span style="color:red;">未通过</span><%}%></td>
            <%}else if(titleColumn.name === 'totalScore'){%>
            <%if (examResult.score && examResult.score === -1) {%>
            <td>--</td>
            <%} else {%>
            <td><%=Number(examResult.score).toFixed(1)%></td>
            <%}%>
            <%}%>
            <%})%>
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
<#--渲染右边固定表格模板-->
<#--<script type="text/template" id="releaseRightFixedResultTemp">
    <table class="pe-stand-table pe-stand-table-default reviewResult-right-fixed-table pe-fixed-table-panel">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <%if(peData.tableTitles[i].name === 'opt'){%>
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
            <%if(titleColumn.name === 'opt'){%>
            <td>
                <div class="pe-stand-table-btn-group">
                    <button type="button" title="监控" class="pe-icon-btn iconfont icon-monitor"></button>
                </div>
            </td>
            <%}%>
            <%})%>
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
</script>-->
<script>
    $(function () {
        var releaseResult = {
            examId: '${(exam.id)!}',
            init: function () {
                var _this = this;
                _this.bind();
                _this.renderData();
            },

            bind: function () {
                var _this = this;
                //类别点击筛选事件
                $('.pe-check-by-list').off().click(function () {
                    var iconCheck = $(this).find('span.iconfont');
                    var thisRealCheck = $(this).find('input[type="checkbox"]');
                    if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                        iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                        thisRealCheck.prop('checked', 'checked');
                    } else {
                        iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisRealCheck.removeProp('checked');
                    }
                    $('.pe-stand-table-wrap').peGrid('load', $('#queryForm').serializeArray());
                });

                $('.pe-btn-green').on('click', function () {
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确认发布成绩吗？</h3><p class="pe-dialog-content-tip">发布后，这些考生就可以查看自己的成绩。</p></div>',
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/examResult/manage/publishResult',
                                data: {'examId': _this.examId},
                                success: function (data) {
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '发布成功',
                                            time: 1000,
                                            end: function () {
                                                localStorage.setItem("EXAM_RESULT_RELEASE", _this.examId);
                                                window.close();
                                            }
                                        });
                                        return false;
                                    }
                                }
                            });
                        },
                        btn1: function () {
                            layer.closeAll();
                        }
                    });
                });
            },

            renderData: function () {
                var peTableTitle = [
                    {'title': '姓名', 'name': 'userName', 'width': 20},
                    {'title': '工号', 'name': 'employeeCode', 'width': 20},
                    {'title': '部门', 'name': 'organizeName', 'width': 20},
                    {'title': '岗位', 'name': 'positionName', 'width': 20},
                    {'title': '状态', 'name': 'status', 'width': 10},
                    {'title': '总成绩', 'name': 'totalScore', 'width': 10}
                ];

                <#list subjectNames as subjectName>
                    peTableTitle.push({
                        'title': '${(subjectName)!}',
                        'name': 'subject',
                        'width': 10,
                        'type': 'noFixed',
                        'order': true
                    });
                </#list>

                peTableTitle.push({'title': '操作', 'name': 'opt', 'width': 10});
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/examResult/manage/searchWaitRelease',
                    formParam: $('#queryForm').serializeArray(),//表格上方表单的提交参数
                    tempId: 'releaseResultTemp',//表格模板的id
                    title: peTableTitle, //表格头部的数量及名称数组;
                    isTableScroll: true,
                    isTableHasFixed: true,
                    tableScrollType: 'reviewCompResult',
                    fixedTableTempId: ['releaseLeftFixedResultTemp'],
                    onLoad: function (t) {
                        $('.pe-stand-table-main-panel').append(_.template($('#releaseLeftFixedResultTemp').html())({peData: t.data}));
//                        $('.pe-stand-table-main-panel').append(_.template($('#releaseRightFixedResultTemp').html())({peData: t.data}));
                        if(t.data.rows && t.data.rows.length === 0){
                            var emptyDom =  '<div class="reviewResult-manage-empty"><div class="pe-result-no-date"></div>'
                                    +'<p class="pe-result-date-warn" style="text-align:center;">暂无数据</p></div>';
//                            $('.pe-stand-table-main-panel').append(emptyDom);
//                            $('.pe-scrollTable-wrap').hide();
                            $('.pe-stand-table-pagination').hide();
                            $('.reviewResult-left-fixed-table').css('borderRightColor','transparent');
//                            $('.reviewResult-left-fixed-table').hide();
                        }else{
                            $('.reviewResult-left-fixed-table').css('borderRightColor','#f5f5f5');
                            $('.pe-scrollTable-wrap').mCustomScrollbar('destroy').mCustomScrollbar({
                                axis: "x",
                                theme: "dark-3",
                                scrollbarPosition: "inside",
                                setWidth: '480px',
                                advanced: {updateOnContentResize: true}
                            });
                            $('.reviewResult-manage-empty').hide();
                            $('.pe-scrollTable-wrap').show();
                            $('.pe-stand-table-pagination').show();
                            $('.reviewResult-left-fixed-table').show();
                        }
                    }
                });
            }
        };

        releaseResult.init();
    });
</script>
</@p.pageFrame>