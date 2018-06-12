<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
    <#assign ctx=request.contextPath/>
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
                    class="pe-result-online">[<#if exam?? && exam.examType?? && exam.examType =='ONLINE'>线上<#else>
                线下</#if>]</span>${(exam.examName)!}
            </h2>
            <div class="pe-release-btn">
                <button class="pe-btn pe-btn-green">立即发布</button>
                <#--<#if exam.examType!='OFFLINE'>-->
                <#--<button class="pe-btn pe-btn-white">复评成绩</button>-->
                <#--</#if>-->
            </div>
        </div>
        <div class="pe-manage-content-right pe-release-content">
            <div class="pe-manage-panel pe-manage-default">
                <form id="queryForm">
                    <input type="hidden" name="examId" value="${(exam.id)!}"/>
                    <input type="hidden" name="sort"/>
                    <input type="hidden" name="order"/>
                    <div class="pe-manage-panel-head">
                        <p class="pe-release-des">共有<span id="showTotal" class="text-orange">100</span>人评卷完成，可以发布成绩</p>
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
                        <#--<label class="floatL pe-checkbox" for="" style="margin-right:15px;">-->
                        <#--<span class="iconfont icon-checked-checkbox peChecked"></span>-->
                        <#--<input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"-->
                        <#--name="examTypes" value="ONLINE">只显示有异常和违纪情况的考生-->
                        <#--</label>-->
                        </div>
                    </div>
                </form>
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel" style="height: 15px;">
                    </div>
                    <div class="pe-stand-table-main-panel">
                        <div class="pe-stand-table-wrap"></div>
                        <div class="pe-stand-table-pagination"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<#--渲染表格模板-->
<script type="text/template" id="releaseResultTemp">
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
        <%_.each(peData.rows,function(examResult,index){%>
        <tr>
            <%if (peData.tableTitles[0].name === 'ticket') {%>
            <td><%=examResult.user.ticket%></td>
            <%}%>
            <td><%=examResult.user.userName%></td>
            <td><%=examResult.user.employeeCode%></td>
            <td title="<%=examResult.user.organize.organizeName%>"><%=examResult.user.organize.organizeName%></td>
            <td title="<%=examResult.user.positionName%>"><%=examResult.user.positionName%></td>
            <%if(examResult.status === 'MISS_EXAM'){%>
            <td>缺考</td>
            <td>--</td>
            <%} else if(examResult.pass) {%>
            <td>通过</td>
            <%if(examResult.score===0){%>
            <td>0</td>
            <%}else{%>
            <td><%=examResult.score?(Number(examResult.score)).toFixed(1):'--'%></td>
            <%}%>
            <%}else{%>
            <td>未通过</td>
            <%if(examResult.score===0){%>
            <td>0</td>
            <%}else{%>
            <td><%=examResult.score?(Number(examResult.score)).toFixed(1):'--'%></td>
            <%}%>
            <%}%>
            <#if exam.examType == 'ONLINE'>
                <td>
                    <div class="pe-stand-table-btn-group">
                        <a title="复评" class="pe-icon-btn iconfont icon-re" data-arrange="<%=examResult.examArrange.id%>"
                                data-id="<%=examResult.user.id%>"></a>
                        <a class="stop-btn pe-icon-btn iconfont icon-monitor" target="_blank"
                           href="${ctx!}/ems/examMonitor/manage/initDetail?examId=${(exam.id)!}&userId=<%=examResult.user.id%>" title="查看监控"></a>
                    </div>
                </td>
            </#if>
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
        var releaseResult = {
            examId: '${(exam.id)!}',
            init: function () {
                var _this = this;
                _this.bind();
                _this.renderData();
            },

            bind: function () {
                var _this = this;
                //监控
                $('.pe-stand-table-wrap').delegate('.icon-monitor', 'click', function () {
                    var id = $(this).data('id');
                    window.open(pageContext.rootPath + '/ems/examMonitor/manage/initMonitorDetailPage?arrangeId=' + id);
                });

                var $mainPanel = $('.pe-stand-table-main-panel');
                $mainPanel.delegate('.level-order-up', 'click', function () {
                    $(this).addClass('curOrder');
                    $(this).siblings('.level-order-down').removeClass('curOrder');
                    var thisType = $(this).parent('.pe-th-wrap').attr('data-type');
                    $('input[name="sort"]').val(thisType);
                    $('input[name="order"]').val('asc');
                    $('.pe-stand-table-wrap').peGrid('load', $('#queryForm').serializeArray());
                });

                $mainPanel.delegate('.level-order-down', 'click', function () {
                    $(this).addClass('curOrder');
                    $(this).siblings('.level-order-up').removeClass('curOrder');
                    var thisType = $(this).parent('.pe-th-wrap').attr('data-type');
                    $('input[name="sort"]').val(thisType);
                    $('input[name="order"]').val('desc');
                    $('.pe-stand-table-wrap').peGrid('load', $('#queryForm').serializeArray());
                });

                $mainPanel.delegate('.icon-re', 'click', function () {
                    var userId = $(this).data('id');
                    var arrangeId = $(this).data('arrange');
                    location.href = pageContext.rootPath + '/ems/examResult/manage/reviewResult?arrangeId=' + arrangeId + '&userId=' + userId;
                });

                $('.pe-check-by-list').off().click(function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    e.preventDefault();
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
                                                window.opener.location.reload();
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

                $('.pe-btn-white').on('click', function () {
                    location.href = pageContext.rootPath + '/ems/examResult/manage/reviewResult?examId=' + _this.examId;
                });
            },

            renderData: function () {
                <#if exam.examType == 'ONLINE'>
                <#if exam.enableTicket?? && exam.enableTicket>
                    var peTableTitle = [
                        {'title': '准考证号', 'name':'ticket','width': 10},
                        {'title': '姓名', 'width': 10},
                        {'title': '工号', 'width': 20},
                        {'title': '部门', 'width': 15},
                        {'title': '岗位', 'width': 15},
                        {'title': '状态', 'width': 10},
                        {'title': '成绩', 'width': 10, 'type': 'score', 'order': true},
                        {'title': '操作', 'width': 10}
                    ];
                <#else>
                    peTableTitle = [
                        {'title': '姓名', 'width': 10},
                        {'title': '工号', 'width': 20},
                        {'title': '部门', 'width': 20},
                        {'title': '岗位', 'width': 20},
                        {'title': '状态', 'width': 10},
                        {'title': '成绩', 'width': 10, 'type': 'score', 'order': true},
                        {'title': '操作', 'width': 10}
                    ];
                </#if>

                <#else>
                    peTableTitle = [
                        {'title': '姓名', 'width': 20},
                        {'title': '工号', 'width': 20},
                        {'title': '部门', 'width': 20},
                        {'title': '岗位', 'width': 20},
                        {'title': '状态', 'width': 10},
                        {'title': '成绩', 'width': 10, 'type': 'score', 'order': true}
                    ];
                </#if>
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/examResult/manage/searchWaitRelease',
                    formParam: $('#queryForm').serializeArray(),//表格上方表单的提交参数
                    tempId: 'releaseResultTemp',//表格模板的id
                    title: peTableTitle, //表格头部的数量及名称数组;
                    showTotalDomId: 'showTotal',
                    onLoad: function () {
                    }
                });
            }
        };

        releaseResult.init();
    });
</script>
</@p.pageFrame>