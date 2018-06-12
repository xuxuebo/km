<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">练习管理</li>
    </ul>
</div>
<section class="exam-manage-all-wrap">
    <form id="exerciseManageForm">
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-manage-panel-head">
                    <div class="pe-stand-filter-form">
                        <div class="pe-stand-form-cell" style="margin-bottom: 0px;">
                            <label class="pe-form-label floatL" for="peMainKeyName">
                                <span class="pe-label-name floatL">关键字:</span>
                                <input id="peMainKeyName" class="pe-stand-filter-form-input" placeholder="练习名字/编号"
                                       maxlength="20" type="text"
                                       name="exerciseKey">
                            </label>
                            <label class="pe-form-label floatL" for="peMainKeyText" style="margin-right: 30px;">
                                <span class="pe-label-name floatL">创建人:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="姓名/用户名/工号/手机号"
                                       name="createUser">
                            </label>
                            <dl>
                                <dt class="pe-label-name floatL ">试题状态:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                        <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="exerciseStatus" value="ENABLE"/>启用
                                    </label>
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-unchecked-checkbox"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" type="checkbox"
                                               name="exerciseStatus"
                                               value="OVER"/>已结束
                                    </label>
                                    <label class="floatL pe-checkbox" for="">
                                        <span class="iconfont icon-unchecked-checkbox"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" type="checkbox"
                                               name="exerciseStatus"
                                               value="DISABLE"/>停用
                                    </label>
                                </dd>
                            </dl>
                            <button type="button" class="pe-btn pe-btn-blue pe-question-choosen-btn"
                                    style="position: absolute;">筛选
                            </button>
                        </div>
                    </div>
                </div>
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                        <button type="button" class="pe-btn pe-btn-green create-exercise-btn">创建练习</button>
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
</section>
<script type="text/template" id="peExerManaTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%if(peData.tableTitles[i].order){%>
                    <div class="pe-th-wrap">
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
        <%for(var j =0,lenJ = peData.rows.length;j
        <lenJ ;j++){%>
            <tr data-id="<%=peData.rows[j].id%>">
            <#--练习编号-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].exerciseCode%>"><%=peData.rows[j].exerciseCode%>
                    </div>
                </td>
            <#--练习名称-->
                <td>
                    <a href="javascript:;" class="pe-stand-table-alink pe-dark-font pe-ellipsis">
                        <div class="pe-ellipsis exam-batch-td view-exam" title="<%=peData.rows[j].exerciseName%>"
                             data-id="<%=peData.rows[j].id%>"><%=peData.rows[j].exerciseName%>
                        </div>
                    </a>
                </td>
            <#--题量-->
                <td>
                    <div class="pe-ellipsis"><%=peData.rows[j].itemCount%></div>
                </td>
            <#--创建人-->
                <td>
                    <div class="pe-ellipsis"><%=peData.rows[j].createBy%></div>
                </td>
            <#--截止时间-->
                <td>
                    <%if(peData.rows[j].endTime==null){%>
                    无限制<%}else{%>
                    <div class="pe-ellipsis"><%=moment(peData.rows[j].endTime).format('YYYY-MM-DD HH:mm')%></div>
                    <%}%>
                </td>
            <#--状态-->

                <%if(peData.rows[j].status==='ENABLE'){%>
                <td>
                    <div class="pe-ellipsis">启用</div>
                </td>
                <%}else if(peData.rows[j].status==='OVER'){%>
                <td>
                    <div class="pe-ellipsis">已结束</div>
                </td>
                <%}else{%>
                <td>
                    <div class="pe-ellipsis">停用</div>
                </td>
                <%}%>
                <td>
                    <div class="pe-stand-table-btn-group">
                        <button type="button" class="edit-btn pe-icon-btn iconfont icon-edit" title="编辑"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%if(peData.rows[j].status === 'DISABLE'){%>
                        <button type="button" class="start-btn pe-icon-btn iconfont icon-start" title="启用"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}else if(peData.rows[j].status === 'ENABLE'){%>
                        <button type="button" class="stop-btn pe-icon-btn iconfont icon-stop" title="停用"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}%>
                        <@authVerify authCode="VERSION_OF_EXERCISE_ANALYSE">
                            <button type="button" title="分析" class="pe-btn pe-icon-btn iconfont icon-test-analysis"
                                    data-id="<%=peData.rows[j].id%>">
                            </button>
                        </@authVerify>

                    </div>
                </td>
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
        var peTableTitle = [
            {'title': '练习编号', 'width': 15},
            {'title': '练习名称', 'width': 20},
            {'title': '题量', 'width': 8},
            {'title': '创建人', 'width': 10, 'name': 'indefinite'},//.name === 'indefinite'
            {'title': '截止时间', 'width': 14},
            {'title': '状态', 'width': 8},
            {'title': '操作', 'width': 15}
        ];
        var exerciseManage = {
            init: function () {
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/exercise/manage/search',
                    formParam: $('#exerciseManageForm').serializeArray(),
                    tempId: 'peExerManaTemp',
                    showTotalDomId: 'showTotal',
                    title: peTableTitle
                });
                var _this = this;
                _this.bind();
            },

            bind: function () {

                $('.pe-question-choosen-btn').on('click', function () {
                    $('.pe-stand-table-wrap').peGrid('load', $('#exerciseManageForm').serializeArray());
                });

                $('.pe-stand-table-main-panel').delegate('.start-btn', 'click', function () {
                    var id = $(this).data("id");
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定启用该练习么？</h3></div>',
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/exercise/manage/updateStatus',
                                data: {id: id, status: 'ENABLE'},
                                success: function (data) {
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '启用成功',
                                            time: 1000,
                                            end: function () {
                                                $('.pe-stand-table-wrap').peGrid('refresh');
                                            }
                                        });
                                        return false;
                                    }

                                    PEMO.DIALOG.alert({
                                        content: data.success,
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

                $('.pe-stand-table-main-panel').delegate('.icon-test-analysis', 'click', function () {
                    var id = $(this).data("id");
                    window.open("${ctx!}/ems/exercise/manage/initStatisticPage?exerciseId=" + id);
                });

                $('.pe-stand-table-main-panel').delegate('.stop-btn', 'click', function () {
                    var id = $(this).data("id");
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定停用该练习么？</h3></div>',
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/exercise/manage/updateStatus',
                                data: {id: id, status: 'DISABLE'},
                                success: function (data) {
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '停用成功',
                                            time: 1000,
                                            end: function () {
                                                $('.pe-stand-table-wrap').peGrid('refresh')
                                            }
                                        });
                                        return false;


                                    }

                                    PEMO.DIALOG.alert({
                                        content: data.success,
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

                $('.create-exercise-btn').on('click', function () {
                    location.href = '#url=' + pageContext.rootPath + '/ems/exercise/manage/initEditPage&nav=examMana';
                });

                $('.pe-stand-table-main-panel').delegate('.view-exam', 'click', function () {
                    var id = $(this).data("id");
                    location.href = '#url=' + pageContext.rootPath + '/ems/exercise/manage/initEditPage?id=' + id +"&optType=VIEW&nav=examMana";
                })
                $('.pe-stand-table-main-panel').delegate('.edit-btn', 'click', function () {
                    var id = $(this).data("id");
                    location.href = '#url=' + pageContext.rootPath + '/ems/exercise/manage/initEditPage?id=' + id +"&optType=UPDATE&nav=examMana";
                })
            }
        };
        exerciseManage.init();
    })
</script>