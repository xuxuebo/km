<#assign ctx=request.contextPath/>
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header">
    <div class="pe-detail-top-head over-flow-hide">
        <div class="pe-top-nav-container">
            <h2 class="pe-for-grading">监控详情</h2>
            <div class="floatL" style="font-size: 16px;margin-left: 10px;">
            ${(exam.examName)!}<em class="pe-monitor-status">[已结束]</em>
            </div>
        </div>
    </div>
</div>
<div class="pe-main-wrap">
    <div class="pe-main-content monitor-main-wrap">
        <form id="examManageForm">
            <input type="hidden" name="exam.id" value="${(exam.id)!}"/>
            <input type="hidden" name="examArrange.id" value="${(examArrange.id)!}"/>
            <input type="hidden" name="examArrange.exam.id" value="${(examArrange.exam.id)!}"
            <input type="hidden" name="user.organize.id" value=""/>
            <input type="hidden" name="user.positionId" value=""/>
            <div class="ztj-monitor-detail-wrap" <#if !(exam.examType?? && exam.examType == 'ONLINE' && canMonitor?? && canMonitor)>
                 style="height: 134px;" </#if>>
                <#if exam.examType?? && exam.examType == 'ONLINE' && canMonitor?? && canMonitor>
                    <div class="monitor-camera-panel ztj-m-d-left floatL monitor-video-cla" style="height: 196px;">
                        <#if recordCoverPath??>
                            <img src="${(recordCoverPath)!}" width="280" height="210" class="monitor-view-back-image"/>
                            <div class="monitor-view-min-btn iconfont icon-pe-video" style="font-size: 50px;">
                            </div>
                        <#else>
                            <div class="iconfont icon-did-not-open-the-camera" style="height:100%;font-size: 180px;"><p class="tip" style="font-size: 16px;">您未开启摄像头</p></div>
                        </#if>
                    </div>
                </#if>
                    <div class="ztj-m-d-right <#if exam.examType?? && exam.examType == 'ONLINE' && canMonitor?? && canMonitor>floatR</#if>"
                         <#if !(exam.examType?? && exam.examType == 'ONLINE' && canMonitor?? && canMonitor)>style="width: 1198px;"</#if>>
                <#if exam.examType?? && exam.examType == 'ONLINE' && canMonitor?? && canMonitor>
                    <div class="monitor-tip-panel">
                        <span class="tip-mask-panel"></span>
                        <div class="monitor-states tip-mask-panel">
                            <span class="iconfont icon-tree-dot"></span>摄像监控已结束，可回看监控视频
                        </div>
                    </div>
                </#if>
                <div class="pe-manage-panel-head">
                    <div class="pe-stand-filter-form">
                        <div class="pe-stand-form-cell">
                            <label class="pe-form-label floatL" for="peMainKeyText">
                                <span class="pe-label-name floatL">关键字:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="姓名/用户名/工号/手机号" name="user.keyword">
                            </label>
                            <div class="" style="margin-right:20px;">
                                <span class="pe-label-name floatL" style="margin-right:5px;">部&emsp;门:</span>
                                <div class="pe-organize-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                                    <input class="pe-tree-show-name show-organize-name" value=""
                                           name="organizeName"/>
                                    <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                                    <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop" style="display:none;">
                                        <div class="node-search-empty">暂无该关键字相关信息</div>
                                        <ul id="organizeTree" class="ztree pe-tree-container"></ul>
                                    </div>
                                </div>
                            </div>
                            <button type="button"
                                    class=" floatR pe-btn pe-btn-blue pe-question-choosen-btn exam-manage-choosen-btn floatL">
                                筛选
                            </button>
                        </div>
                        <div class="pe-stand-form-cell">
                            <div class="floatL" style="margin-right:29px;">
                                <span class="pe-label-name floatL">岗&emsp;位:</span>
                                <div class="pe-position-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                                    <input class="pe-tree-show-name show-position-name" value=""
                                           name="positionName"/>
                                    <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                                    <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop" style="display:none;">
                                        <div class="node-search-empty">暂无该关键字相关信息</div>
                                        <ul id="positionTree" class="ztree pe-tree-container"></ul>
                                    </div>
                                </div>
                            </div>
                            <dl class="over-flow-hide">
                                <dt class="pe-label-name floatL">状&emsp;态:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                        <input id="peFormEleStart" class="pe-form-ele" checked="checked"
                                               type="checkbox"
                                               name="answerStatuses" value="NO_ANSWER"/>未作答
                                    </label>
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleDraft" class="pe-form-ele" checked="checked"
                                               type="checkbox"
                                               name="answerStatuses" value="ANSWERING"/>正在作答
                                    </label>
                                    <label class="floatL pe-checkbox" for="">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" checked="checked"
                                               type="checkbox"
                                               name="answerStatuses" value="SUBMIT_EXAM"/>已交卷
                                    </label>
                                </dd>
                            </dl>
                        </div>
                    </div>
                </div>
            </div>
                </div>
        </form>
    </div>
    <div class="pe-manage-panel pe-manage-default pe-ztj-table-wrap">
        <input type="hidden" name="order" value=""/>
        <input type="hidden" name="sort" value=""/>
        <div class="pe-stand-table-panel">
            <div class="pe-stand-table-top-panel">
                <button type="button" class="pe-btn pe-btn-green create-online-btn">导出监控数据</button>
                <div class="pe-monitor-end-tip">应到<span class="pe-monitor-num">1</span>人，实到<span class="pe-monitor-num">1</span>人</div>
            </div>
        <#--表格包裹的div-->
            <div class="pe-stand-table-main-panel">
                <div class="pe-stand-table-wrap"></div>
                <div class="pe-stand-table-pagination"></div>
            </div>
        </div>
    </div>
</div>
<script type="text/template" id="peExamManaTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI ;i++){%>
                <%if(peData.tableTitles[i].title==='checkbox'){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
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
        <%_.each(peData.rows,function(examMonitor){%>
        <tr>
            <%if (peData.tableTitles[0].name === 'ticket') {%>
            <td title="<%=examMonitor.ticket%>"><%=examMonitor.ticket%></td>
            <%}%>
            <td><%=examMonitor.user.loginName%></td>
            <td><%=examMonitor.user.userName%></td>
            <td><%=examMonitor.examTime?moment(examMonitor.examTime).format('YYYY-MM-DD HH:mm:ss'):'--'%></td>
            <td><%=examMonitor.submitTime?moment(examMonitor.submitTime).format('YYYY-MM-DD HH:mm:ss'):'--'%></td>
            <td><%=PEBASE.formatSecond(examMonitor.duration)%></td>
            <td><%=examMonitor.exitTimes%></td>
            <td><%=examMonitor.cutScreenCount%></td>
            <td><%=examMonitor.illegalCount%></td>
            <td>
                <%if (examMonitor.answerStatus != 'NO_ANSWER') {%>
                <div class="pe-stand-table-btn-group">
                    <a title="违纪处理" class="break_rule_btn pe-btn pe-icon-btn iconfont icon-handling-discipline" data-id="<%=examMonitor.id%>">
                    </a>
                    <a class="stop-btn pe-icon-btn iconfont icon-view-detail" target="_blank"
                       href="${ctx!}/ems/examMonitor/manage/initDetail?examId=${(exam.id)!}&userId=<%=examMonitor.user.id%>" title="查看详情"></a>
                </div>
                <%}%>
            </td>
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
<script type="text/template" id="breakRuleTemp">
    <form id="illegalForm" >
        <div style="width: 100%;">
            <ul class="over-flow-hide exam-manage-copy-ul">
                <li class="exam-dialog-copy-li" style="width: 100%;">
                    <label class="pe-radio">
                        <span class="iconfont icon-checked-radio peChecked"></span>
                        <input class="pe-form-ele" type="radio" value="STATUS"
                               checked="checked"
                               name="illegalType"/>
                        考试状态异常
                    </label>
                </li>
                <li class="exam-dialog-copy-li" style="width: 100%;">
                    <label class="pe-radio">
                        <span class="iconfont icon-unchecked-radio"></span>
                        <input class="pe-form-ele" type="radio" value="IDENTITY"
                               name="illegalType"/>
                        考生身份异常
                    </label>
                </li>
                <li class="exam-dialog-copy-li" style="width: 100%;">
                    <label class="pe-radio">
                        <span class="iconfont icon-unchecked-radio"></span>
                        <input class="pe-form-ele" type="radio" value="OTHER"
                               name="illegalType"/>
                        其他
                    </label>
                    <label>
                        <input type="text"
                               style="border: 2px solid #eaeaea;margin-left: 5px;height: 25px;width: 250px;" name="illegalContent"/>
                    </label>
                </li>
            </ul>
        </div>
    </form>
</script>
<script>
    $(function () {
        var detailMonitor = {
            init: function () {
                var _this = this;
                _this.initData();
                _this.bind();
            },

            initData: function () {
                //ie9不支持Placeholder问题
                PEBASE.isPlaceholder();
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
                    width:218,
                    treeSearch:$('input[name="positionName"]')
                };

                PEBASE.inputTree({
                    dom: '.pe-position-tree-wrap',
                    treeId: 'positionTree',
                    treeParam: settingInputPositionTree
                });
                //部门
                var organizeTreeData = {
                    dataUrl: pageContext.rootPath + '/uc/user/manage/listTree',
                    clickNode: function (treeNode) {
                        if (treeNode.pId == null) {
                            $('.show-organize-name').val(null);
                        }
                        if (!treeNode.pId) {
                            return false;
                        }

                        $('.pe-organize-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                        $('input[name="user.organize.id"]').val(treeNode.id);
                    },
                    width:218,
                    treeSearch:$('input[name="organizeName"]')
                };
                PEBASE.inputTree({dom: '.pe-organize-tree-wrap', treeId: 'organizeTree', treeParam: organizeTreeData});
                <#if exam.enableTicket?? && exam.enableTicket>
                    var peTableTitle = [
                        {'title': '准考证号', 'name':'ticket','width': 10},
                        {'title': '用户名', 'width': 10},
                        {'title': '姓名', 'width': 10},
                        {'title': '进入时间', 'width': 15},
                        {'title': '交卷时间', 'width': 15},
                        {'title': '答题时长', 'width': 10},
                        {'title': '退出', 'width': 6},
                        {'title': '切屏', 'width': 7},
                        {'title': '违纪', 'width': 7},
                        {'title': '操作', 'width': 10}
                    ];
                <#else>
                    peTableTitle = [
                        {'title': '用户名', 'width': 10},
                        {'title': '姓名', 'width': 10},
                        {'title': '进入时间', 'width': 18},
                        {'title': '交卷时间', 'width': 18},
                        {'title': '答题时长', 'width': 10},
                        {'title': '退出', 'width': 7},
                        {'title': '切屏', 'width': 7},
                        {'title': '违纪', 'width': 7},
                        {'title': '操作', 'width': 10}
                    ];
                </#if>

                /*表格生成*/
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/examMonitor/manage/search',
                    formParam: $('#examManageForm').serialize(),//表格上方表单的提交参数
                    tempId: 'peExamManaTemp',//表格模板的id
                    showTotalDomId: 'showTotal',
                    title: peTableTitle //表格头部的数量及名称数组;
                });
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
                $('.monitor-video-cla').on('click', function () {
                    window.open(pageContext.rootPath + '/ems/examMonitor/manage/initVideoDetailPage?arrangeId=${(examArrange.id)!}');
                });

                $('.pe-stand-table-wrap').delegate('.break_rule_btn', 'click', function () {
                    var monitorId = $(this).data('id');
                    PEMO.DIALOG.confirmR({
                        content: _.template($('#breakRuleTemp').html())(),
                        title: '违纪处理',
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url :'${ctx!}/ems/examMonitor/manage/saveIllegalRecord?examMonitor.id='+monitorId,
                                data:$('#illegalForm').serialize(),
                                success:function(){
                                    layer.closeAll();
                                    PEMO.DIALOG.tips({
                                        content: '处理成功',
                                        time: 1000,
                                        end: function () {
                                            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
                                        }
                                    });
                                }
                            })
                        },
                        success: function () {
                            PEBASE.peFormEvent('radio');
                        }
                    });
                });
                //导出监控
                $('.create-online-btn').on('click',function(){
                    location.href="${ctx!}/ems/examMonitor/manage/exportMonitor?"+$('#examManageForm').serialize();
                });
                $('.exam-manage-choosen-btn').on('click',function(){
                    var organizeVal = $('.show-organize-name').val();
                    var positionVal = $('.show-position-name').val();
                    if(!organizeVal){
                        $('input[name="user.organize.id"]').val('');
                    }
                    if(!positionVal){
                        $('input[name="user.positionId"]').val('');
                    }

                    $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
                });
            }
        };

        detailMonitor.init();
    });
    //考试作废
</script>
    </@p.pageFrame>