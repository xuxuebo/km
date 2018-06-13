<#import "../../../noNavTop.ftl" as p>
<@p.pageFrame>
<#--公用头部-->
<header class="pe-public-top-nav-header" data-id="">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="pe-result-detail floatL">成绩分析报告</li>
        </ul>
    </div>
</header>
<div class="pe-main-wrap">
    <div class="pe-main-content">
        <div class="result-analyze-head">
            <div class="analyze-head-name">模拟考试
            </div>
        </div>
        <input hidden name="exam.id" value="${(mockExam.id)!}"/>
        <div class="pe-manage-panel pe-manage-default">
            <div class="pe-no-nav-main-wrap" style="width:1166px;">
                <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                    <h2 class="pe-question-head-text">成绩总揽</h2>
                </div>
                <div class="result-pandect">
                    <form id="overviewForm">
                    </form>
                    <div class="analyze-category-wrap">
                        <table class="pe-stand-table result-analyze-table">
                            <thead>
                            <tr>
                                <th>
                                    <div class="result-cell">满分</div>
                                    <div class="result-cell">及格线</div>
                                    <div class="result-cell">及格率</div>
                                </th>
                                <th>
                                    <div class="result-cell">最高分</div>
                                    <div class="result-cell">最低分</div>
                                    <div class="result-cell">平均分</div>
                                </th>
                            </tr>
                            </thead>
                            <tbody class="result-overview-show">

                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                    <h2 class="pe-question-head-text">成绩分布统计</h2>
                </div>
            <#--饼状图-->
                <div>
                    <form id="resultDetaiForm">
                        <div class="pe-tree-search-wrap">
                            <input class="pe-tree-form-text" type="text" placeholder="用户名/姓名/工号/手机号" name="userName"/>
                            <span class="iconfont pe-tree-search-btn icon-search-magnifier"></span>
                            <input hidden name="id" value="${(mockExam.id)}">
                        </div>
                        <div class="analyze-pie-chart" id="analyzePieChart">
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
<script type="text/template" id="resultOverview">
    <tr>
        <td>
            <div class="result-cell"><%=data.totalScore%></div>
            <div class="result-cell"><%=data.passLine%></div>
            <div class="result-cell"><%=data.passRate%>%</div>
        </td>
        <td>
            <div class="result-cell"><%=Number(data.highScore).toFixed(1)%></div>
            <div class="result-cell"><%=Number(data.lowScore).toFixed(1)%></div>
            <div class="result-cell"><%=Number(data.averScore).toFixed(1)%></div>
        </td>
    </tr>
</script>
<script type="text/template" id="peExamManaTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI ;i++){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%if(peData.tableTitles[i].order){%>
                    <div class="pe-th-wrap" data-type="publishTime">
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
            <#--考试编号-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].user.userName%>">
                        <%=peData.rows[j].user.userName%>
                    </div>
                </td>
            <#--考试名称-->
                <td>
                    <a class="pe-stand-table-alink pe-dark-font pe-ellipsis exam-batch-td view-exam"
                       title="<%=peData.rows[j].examCount%>"
                       data-id="<%=peData.rows[j].id%>"><%=peData.rows[j].examCount%>
                    </a>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].highestScore%>"><%=peData.rows[j].highestScore%>
                    </div>
                </td>

                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].highestScore%>"><%=peData.rows[j].lowestScore%>
                    </div>
                </td>
                <%if(peData.rows[j].averageScore){%>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].averageScore%>"><%=peData.rows[j].averageScore%>
                    </div>
                </td>
                <%}else {%>
                <td>--</td>
                <%}%>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].passCount%>"><%=peData.rows[j].passCount%></div>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].noPassCount%>"><%=peData.rows[j].noPassCount%>
                    </div>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].passRate%>"><%=peData.rows[j].passRate%>%</div>
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
            {'title': '考生姓名', 'width': 15, 'type': ''},
            {'title': '考试次数', 'type': 'examName', 'width': 10},
            {'title': '最高分', 'width': 15, 'type': '', 'name': 'indefinite'},//.name === 'indefinite'
            {'title': '最低分', 'width': 15, 'type': '', 'order': true},
            {'title': '平均分', 'width': 10, 'type': ''},
            {'title': '通过次数', 'width': 15, type: ''},
            {'title': '未通过次数', 'width': 10, type: ''},
            {'title': '通过率', 'width': 10, type: ''}
        ];
        /*表格生成*/
        $('.analyze-pie-chart').peGrid({
            url: pageContext.rootPath + '/ems/simulationExam/manage/searchMockExamResultDetail',
            formParam: $('#resultDetaiForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'peExamManaTemp',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle //表格头部的数量及名称数组;
        });


        var resultStatistic = {
            examId: '${(exam.id)!}',
            init: function () {
                var _this = this;
                _this.initData();
                _this.bind();
            },

            initData: function () {
                var _this = this;
                _this.renderResultOverview();
            },


            renderResultOverview: function () {
                var _this = this;
                var examId = $('input[name="exam.id"]').val();
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/simulationExam/manage/statisticOverview?id=' + examId,
                    data: $('#overviewForm').serialize(),
                    success: function (data) {
                        $('.result-overview-show').html(_.template($('#resultOverview').html())({data: data}));
                    }
                });
            },
            bind: function () {
                var _this = this;
                /*成绩总揽的批次的checkbox的点击事件*/
                $('.arrange-choose-box').off().click(function () {
                    var iconCheck = $(this).find('span.iconfont');
                    var thisRealCheck = $(this).find('input[type="checkbox"]');
                    if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                        iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                        thisRealCheck.prop('checked', 'checked');
                    } else {
                        iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisRealCheck.removeProp('checked');
                    }

                    _this.renderResultOverview();
                });
            }
        };
        resultStatistic.init();
    });
</script>
</@p.pageFrame>