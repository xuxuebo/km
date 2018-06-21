<#import "../../../noNavTop.ftl" as p>
<#assign ctx=request.contextPath/>
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
            <div class="analyze-head-name">[综合]${(exam.examName)!}</div>
        </div>
        <div class="pe-manage-panel pe-manage-default">
            <div class="pe-no-nav-main-wrap" style="width:1166px;">
                <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                    <h2 class="pe-question-head-text">成绩总揽</h2>
                </div>
                <div class="result-pandect">
                    <div class="analyze-category-wrap">
                        <table class="pe-stand-table result-analyze-table">
                            <thead>
                            <tr>
                                <th style="width:5%;border-left:0;">序号</th>
                                <th style="width:5%;border-left:0;">科目名称</th>
                                <th style="width:5%;border-left:0;">考试类型</th>
                                <th style="width:10%;border-left:0;">考试时间</th>
                                <th style="width:4%;border-left:0;">成绩</th>
                                <th style="width:3%;border-left:0;">状态</th>
                            </tr>
                            </thead>
                            <tbody class="subject-result-overview-show">

                            </tbody>
                        </table>
                    </div>
                </div>
            <#--柱状图-->
                <div class="analyze-column-chart">
                    <div class="analyze-column-chart-header">
                        <div class="pe-form-select floatL question-type-order pe-form-selecting">
                        <#--select模式，取值见下面的hidden的input及peSelect方法-->
                            <select class="pe-question-select dropdown">
                                <option value="${(exam.id)!}" selected>${(exam.examName)!}</option>
                                <#list subjects as subject>
                                    <option value="${(subject.id)!}">${(subject.examName)!}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div id="analyzeColumnChart">

                    </div>
                </div>

                <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                    <h2 class="pe-question-head-text">知识点弱项分析</h2>
                </div>
                <#list subjects as subject>
                    <#if subject.knowledges?? && (subject.knowledges?size>0)>
                        <div class="week-analyze-all-wrap">
                            <form id="knowledgeForm_${(subject_index)!}">
                                <ul class="analyze-radar-choose-wrap">
                                    <li class="floatL analyze-radar-choose">${(subject.examName)!}</li>
                                    <li class="floatL analyze-radar-choose" data-type="knowledge">
                                        知识点显示筛选<span class="iconfont icon-thin-arrow-down arrow"
                                                     style="vertical-align:middle;"></span>
                                        <div class="analyze-choose-panel knowledge-analyze">
                                            <#list subject.knowledges as knowledge>
                                                <#if knowledge_index == 0>
                                                <span class=" pe-checkbox pe-check-by-list knowledge-choose-box"
                                                       for=""
                                                       style="margin-right:15px;margin-left:15px;">
                                                <#else>
                                                <span class=" pe-checkbox pe-check-by-list knowledge-choose-box"
                                                       for=""
                                                       style="margin-right:15px;">
                                                </#if>
                                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                                <input class="pe-form-ele" data-index="${knowledge_index}"
                                                       checked="checked"
                                                       type="checkbox"
                                                       name="knowledgeIds" title="${(knowledge.knowledgeName)!}"
                                                       value="${(knowledge.id)!}">${(knowledge.knowledgeName)!}
                                            </span>
                                            </#list>
                                        </div>
                                    </li>
                                </ul>
                            </form>
                        <#--蜘蛛图-->
                            <div class="analyze-radar-chart" data-so="${(subject_index)!}"
                                 data-name="${(subject.examName)!}"
                                 id="analyzeRadarChart_${(subject_index)!}" data-id="${(subject.id)!}">

                            </div>
                        </div>
                    </#if>
                </#list>
            </div>
        </div>
    </div>
</div>
<script type="text/template" id="subjectResultOverview">
    <%_.each(data,function(exam,index){%>
    <tr>
        <td style="border-left:0;">科目<%=index+1%></td>
        <td style="border-left:0;"><a class="pe-stand-table-alink pe-dark-font pe-ellipsis" title="<%=exam.examName%>"
                                      href="${ctx!}/ems/examResult/client/viewMyPaper?examId=<%=exam.id%>"><%=exam.examName%></a></td>
        <td style="border-left:0;"><%if (exam.examType === 'ONLINE') {%>线上<%} else {%>线下<%}%></td>
        <td style="border-left:0;"><%=moment(exam.startTime).format('YYYY-MM-DD HH:mm')%>~<%=moment(exam.endTime).format('YYYY-MM-DD HH:mm')%></td>
        <td style="border-left:0;"><%=exam.examResult.score?Number(exam.examResult.score).toFixed(1):'--'%></td>
        <td style="border-left:0;">
            <%if (exam.examResult.status === 'MISS_EXAM') {%>
            缺考
            <%} else if (exam.examResult.pass) {%>
            <span style="color: #65cc4a;">通过</span>
            <%} else {%>
            <span style="color: red;">未通过</span>
            <%}%></td>
    </tr>
    <%});%>
</script>
<script type="text/template" id="analyzeChooseTemp">
    <%_.each(data,function(k,index){%>
    <%if(index === 0){%>
    <label class=" pe-checkbox" for="" style="margin-right:15px;margin-left:15px;">
        <%}else{%>
        <label class=" pe-checkbox" for="" style="margin-right:15px;">
            <%}%>
            <span class="iconfont icon-checked-checkbox peChecked"></span>
            <input class="pe-form-ele" checked="checked" type="checkbox" name="examArranges" value=""><%=k%>
        </label>
        <%})%>
</script>
<script>
    $(function () {
        var resultStatistic = {
            examId: '${(exam.id)!}',
            init: function () {
                var _this = this;
                _this.initData();
                _this.bind();
            },

            initData: function () {
                var _this = this;
                //初始化科目成绩详情
                _this.renderSubjectRO();
                _this.renderResultOverview($('.pe-question-select').val());
                PEBASE.peSelect($('.pe-question-select'), null);
                $('.analyze-radar-chart').each(function (i, ele) {
                    var so = $(this).data('so');
                    var examId = $(this).data('id');
                    var subjectName = $(this).data('name');
                    _this.renderKnowledgeAnalysis(examId,so, subjectName);
                });
            },

            renderResultOverview: function (examId) {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/client/statisticMyOverview',
                    data: {examId: examId},
                    success: function (data) {
                        var scoreData = [data.totalScore, Number(Number(data.highScore).toFixed(1)), Number(Number(data.averScore).toFixed(1)), Number(Number(data.lowScore).toFixed(1)), Number(Number(data.myScore).toFixed(1))];
                        _this.renderScoreChart(scoreData);
                    }
                });
            },

            renderScoreChart: function (data) {
                /*柱状图*/
                Highcharts.chart('analyzeColumnChart', {
                    chart: {
                        type: 'bar'
                    },
                    title: {
                        text: ''
                    },
                    xAxis: {
                        categories: ['满分','最高分', '平均分', '最低分', '我的成绩'],
                        title: {
                            text: null
                        }
                    },
                    yAxis: {
                        min: 0,
                        title: {
                            text: '',
                            align: 'high'
                        },
                        labels: {
                            overflow: 'justify'
                        }
                    },
                    tooltip: {
                        enabled: false
                    },
                    plotOptions: {
                        bar: {
                            dataLabels: {
                                enabled: true
                            }
                        },
                        series: {
                            animation: {
                                duration: 2000,
                                easing: 'easeOutBounce'
                            },
                            colorByPoint: true
                        },
                        column: {
                            colorByPoint: true,
                            colors: ['#acd3f5', '#f0d480', '#b8d071', '#eeaf86', '#75bbba', '#e29c9d', '#c19ec1', '#9ab280', '#cbc56e', '#4598c3']
                        }
                    },
                    exporting: {
                        enabled: false
                    },
                    legend: {
                        layout: 'vertical',
                        align: 'right',
                        verticalAlign: 'top',
                        x: -40,
                        y: 100,
                        floating: true,
                        borderWidth: 1,
                        backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
                        shadow: false
                    },
                    credits: {
                        enabled: false
                    },
                    series: [{
                        data: data
                    }]
                });
            },

            renderSubjectRO: function () {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/client/statisticMySO?examId=' + _this.examId,
                    success: function (data) {
                        $('.subject-result-overview-show').html(_.template($('#subjectResultOverview').html())({data: data}));
                    }
                });
            },

            renderKnowledgeAnalysis: function (examId,so,subjectName) {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/client/statisticMyKnowledge?id=' + examId,
                    data: $('#knowledgeForm_'+so).serialize(),
                    success: function (data) {
                        if ($.isEmptyObject(data)) {
                            return false;
                        }

                        var kCategories = [], knowledgeIds = [];
                        $('#knowledgeForm_' + so).find('input[name="knowledgeIds"]:checked').each(function (i, dom) {
                            kCategories.push($(dom).attr('title'));
                            knowledgeIds.push($(dom).val());
                        });

                        var avgScores = [],myScores = [];
                        $.each(knowledgeIds,function(i,v){
                            avgScores.push(data.avgScoreMap[v]);
                            myScores.push(data.myScoreMap[v]);
                        });

                        Highcharts.chart('analyzeRadarChart_'+so, {
                            chart: {
                                polar: true,
                                type: 'line'
                            },
                            title: {
                                text: '',
                                x: -80
                            },
                            exporting: {
                                enabled: false
                            },
                            pane: {
                                size: '80%'
                            },
                            xAxis: {
                                categories: kCategories,
                                tickmarkPlacement: 'on',
                                lineWidth: 0
                            },
                            yAxis: {
                                gridLineInterpolation: 'polygon',
                                lineWidth: 0,
                                alternateGridColor: '#fff',//网格间间隔的颜色
                                min: 0,
                                gridLineColor: '#cfcfcf',//网格边框的颜色
                                tickInterval: 20
                            },
                            credits: {
                                enabled: false
                            },
                            plotOptions: {
                                series: {
                                    showCheckbox: false
                                }
                            },
                            tooltip: {
                                shared: true,
                                borderColor: "#000",
                                pointFormat: '<span style="color:{series.color}">{series.name}: <b>{point.y:.1f}</b><br/>'
                            },
                            legend: {
                                align: 'right',
                                verticalAlign: 'top',
                                y: 20,
                                floating: true,
                                layout: 'vertical'
                            },
                            series: [
                                {
                                    name: '平均水平',
                                    type: 'area',
                                    fillOpacity: 0.05,
                                    data: avgScores,
                                    pointPlacement: 'on'
                                },
                                {
                                    name: '我的水平',
                                    type: 'area',
                                    fillOpacity: 0.05,
                                    data: myScores,
                                    pointPlacement: 'on'
                                }
                            ]
                        });
                    }
                });

            },

            bind: function () {
                var _this = this;
                $('.pe-question-select').on('change', function () {
                    _this.renderResultOverview($(this).val());
                });

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
                /*知识点的弱项分析的知识点的checkbox的点击事件*/
                $('.knowledge-choose-box').off().click(function () {
                    var iconCheck = $(this).find('span.iconfont'),
                            thisRealCheck = $(this).find('input[type="checkbox"]'),
                            $radarChart = $(this).parents('.week-analyze-all-wrap').find('.analyze-radar-chart');

                    if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                        iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                        thisRealCheck.prop('checked', 'checked');
                    } else {
                        iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisRealCheck.removeProp('checked');
                    }

                    var so = $radarChart.data('so'), examId = $radarChart.data('id'), subjectName = $radarChart.data('name');
                    _this.renderKnowledgeAnalysis(examId,so, subjectName);
                });

                /*初始化筛选批次和知识点的功能函数*/
                $('.analyze-radar-choose').hover(
                        function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            var thisDropDown = $(this).find('.analyze-choose-panel');
                            $(this).addClass('item-hover');
                            $(this).find('.iconfont.arrow').removeClass('icon-thin-arrow-down').addClass('icon-thin-arrow-up');
                            thisDropDown.show();
                        },
                        function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            if ($('.analyze-radar-choose:animated').get(0)) {
                                return false;
                            }
                            var _this = $(this);
                            _this.removeClass('item-hover');
                            _this.find('.iconfont.arrow').removeClass('icon-thin-arrow-up').addClass('icon-thin-arrow-down');
                            _this.find('.analyze-choose-panel').hide();
                        }
                );
            }
        };

        resultStatistic.init();
    });
</script>
</@p.pageFrame>