<#import "../../noNavTop.ftl" as p>
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
                    <h2 class="pe-question-head-text" style="border-left:0;padding-left:0;">综合成绩详情</h2>
                    <div class="analyze-category-wrap">
                        <table class="pe-stand-table result-analyze-table">
                            <thead>
                            <tr>
                                <th>
                                    <div class="result-cell">应考</div>
                                    <div class="result-cell">实考</div>
                                    <div class="result-cell">参考率</div>
                                </th>
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
                <div class="result-pandect">
                    <h2 class="pe-question-head-text" style="border-left:0;padding-left:0;">科目成绩详情</h2>
                    <div class="analyze-category-wrap">
                        <table class="pe-stand-table result-analyze-table">
                            <thead>
                            <tr>
                                <th style="border-left:0;">序号</th>
                                <th style="border-left:0;">科目名称</th>
                                <th style="border-left:0;">考试类型</th>
                                <th style="border-left:0;">参考率</th>
                                <th style="border-left:0;">通过率</th>
                                <th style="border-left:0;">最高分</th>
                                <th style="border-left:0;">最低分</th>
                                <th style="border-left:0;">平均分</th>
                            </tr>
                            </thead>
                            <tbody class="subject-result-overview-show">

                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                    <h2 class="pe-question-head-text">成绩分布统计</h2>
                </div>
            <#--饼状图-->
                <div class="analyze-pie-chart" id="analyzePieChart">

                </div>
            <#--柱状图-->
                <div class="analyze-column-chart" id="subjectAnalyzeColumnChart">

                </div>
            <#--柱状图-->
                <div class="analyze-column-chart" style="margin-bottom: 20px;">
                    <div class="analyze-column-chart-header">
                        <div class="pe-form-select floatL question-type-order comp-dropdown-cla">
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
                <div class="pe-question-top-head week-analyze-knowledge" style="border-bottom: 2px solid #e7e7e7;">
                    <h2 class="pe-question-head-text">知识点弱项分析</h2>
                </div>
                <#list subjects as subject>
                    <#if subject.knowledges?? && (subject.knowledges?size>0)>
                        <div class="week-analyze-all-wrap">
                            <form id="knowledgeForm_${(subject_index)!}">
                                <ul class="analyze-radar-choose-wrap">
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
<script type="text/template" id="resultOverview">
    <tr>
        <td>
            <div class="result-cell"><%=data.testCount%></div>
            <div class="result-cell"><%=data.attendCount%></div>
            <div class="result-cell"><%=data.attendRate%>%</div>
        </td>
        <td>
            <div class="result-cell"><%=Number(data.totalScore).toFixed(1)%></div>
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
<script type="text/template" id="subjectResultOverview">
    <%_.each(data,function(exam,index){%>
    <tr>
        <td style="border-left:0;"><%=index+1%></td>
        <td style="border-left:0;"><%=exam.examName%></td>
        <td style="border-left:0;"><%if (exam.examType === 'ONLINE') {%>线上<%} else {%>线下<%}%></td>
        <td style="border-left:0;"><%=exam.resultReport.attendRate%>%</td>
        <td style="border-left:0;"><%=exam.resultReport.passRate%>%</td>
        <td style="border-left:0;"><%=Number(exam.resultReport.highScore).toFixed(1)%></td>
        <td style="border-left:0;"><%=Number(exam.resultReport.lowScore).toFixed(1)%></td>
        <td style="border-left:0;"><%=Number(exam.resultReport.averScore).toFixed(1)%></td>
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
                if (!$('.week-analyze-all-wrap') || $('.week-analyze-all-wrap').length === 0) {
                    $('.week-analyze-knowledge').hide();
                }
                //初始化综合成绩详情
                _this.renderRO();
                //初始化科目成绩详情
                _this.renderSubjectRO();
                //考试结果饼状图
                _this.renderStatusChart();
                //科目考试结果直方图
                _this.renderSubjectChart();
                PEBASE.peSelect($('.pe-question-select'), null);
                _this.renderScoreChart($('.pe-question-select').val());
                $('.analyze-radar-chart').each(function (i, ele) {
                    var so = $(this).data('so');
                    var examId = $(this).data('id');
                    var subjectName = $(this).data('name');
                    _this.renderKnowledgeAnalysis(so, examId, subjectName);
                });
            },

            renderSubjectRO: function () {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/manage/statisticSO?examId=' + _this.examId,
                    success: function (data) {
                        $('.subject-result-overview-show').html(_.template($('#subjectResultOverview').html())({data: data}));
                    }
                });
            },

            renderRO: function () {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/manage/statisticOverview?id=' + _this.examId,
                    success: function (data) {
                        $('.result-overview-show').html(_.template($('#resultOverview').html())({data: data}));
                    }
                });
            },

            renderStatusChart: function () {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/manage/statisticCompStatus',
                    data: {examId: _this.examId},
                    success: function (data) {
                        if ($.isEmptyObject(data)) {
                            return false;
                        }

                        Highcharts.chart('analyzePieChart', {
                            chart: {
                                type: 'pie',
                                plotBackgroundColor: null,
                                plotBorderWidth: null,
                                plotShadow: false
                            },
                            colors: ['#d4d4d4', '#ffa614', '#7ccd88', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
                            labels: {
                                style: {
                                    color: "#000"
                                }
                            },
                            title: {
                                text: '考试结果饼状图',
                                style: {
                                    color: "#666",
                                    fontSize: "18px"
                                }
                            },
                            subtitle: {
                                text: "",
                                color: "#f0f"
                            },
                            tooltip: {
                                pointFormat: '{series.name}: <b>{point.y}</b>'
                            },
                            plotOptions: {
                                pie: {
                                    allowPointSelect: true,
                                    cursor: 'pointer',
                                    depth: 35,
                                    dataLabels: {
                                        enabled: true,
                                        format: '{point.name}'
                                    },
                                    showInLegend: true
                                }
                            },
                            legend: {
                                align: 'left',
                                itemStyle: {
                                    color: "#999",
                                    fontSize: "13px"
                                },
                                layout: "vertical",
                                verticalAlign: "middle",
                                symbolHeight: 13,
                                symbolWidth: 13,
                                symbolRadius: 0,
                                floating: true,
                                itemMarginBottom: 10,
                                x: 100
                            },
                            exporting: {
                                enabled: false
                            },
                            credits: {
                                enabled: false
                            },
                            series: [{
                                type: 'pie',
                                colorByPoint: true,
                                name: '${(exam.examName)!}',
                                data: [{
                                    name: '缺考',
                                    y: data.missCount,
                                    color: "#d4d4d4"
                                },
                                    {
                                        name: '未通过',
                                        y: data.noPassCount,
                                        color: "#ffa614"
                                    },
                                    {
                                        name: '通过',
                                        y: data.passCount,
                                        color: "#7ccd88"
                                    }

                                ]
                            }]
                        });
                    }
                });

            },

            renderSubjectChart: function () {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/manage/statisticSubjectStatus',
                    data: {examId: _this.examId},
                    success: function (data) {
                        if ($.isEmptyObject(data)) {
                            return false;
                        }

                        var subjects = [];
                        $.each(data, function (i, v) {
                            subjects.push({name: v.examName, data: [v.passCount, v.noPassCount, v.missCount]});
                        });

                        $('#subjectAnalyzeColumnChart').highcharts({
                            chart: {
                                type: 'column'
                            },
                            exporting: {
                                enabled: false
                            },
                            credits: {
                                enabled: false
                            },
                            title: {
                                text: '科目考试结果直方图'
                            },
                            xAxis: {
                                categories: [
                                    '通过',
                                    '未通过',
                                    '缺考'
                                ],
                                crosshair: true
                            },
                            yAxis: {
                                min: 0,
                                title: {
                                    text: '考生人数'
                                }
                            },
                            tooltip: {
                                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                '<td style="padding:0"><b>{point.y}</b></td></tr>',
                                footerFormat: '</table>',
                                shared: true,
                                useHTML: true
                            },
                            plotOptions: {
                                column: {
                                    pointPadding: 0.2,
                                    borderWidth: 0
                                }
                            },
                            series: subjects
                        });
                    }
                });
            },

            renderScoreChart: function (examId) {
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/manage/statisticCompScore',
                    data: {examId: examId},
                    success: function (data) {
                        if ($.isEmptyObject(data)) {
                            return false;
                        }

                        var columnDataOne = [];
                        $.each(data.scoreRanges, function (i, v) {
                            columnDataOne.push({y: data.examScoreMap[v]});
                        });
                        /*柱状图*/
                        Math.easeOutBounce = function (pos) {
                            if ((pos) < (1 / 2.75)) {
                                return (7.5625 * pos * pos);
                            }
                            if (pos < (2 / 2.75)) {
                                return (7.5625 * (pos -= (1.5 / 2.75)) * pos + 0.75);
                            }
                            if (pos < (2.5 / 2.75)) {
                                return (7.5625 * (pos -= (2.25 / 2.75)) * pos + 0.9375);
                            }
                            return (7.5625 * (pos -= (2.625 / 2.75)) * pos + 0.984375);
                        };

                        Highcharts.chart('analyzeColumnChart', {
                            chart: {
                                type: 'column'
                            },
                            exporting: {
                                enabled: false
                            },
                            credits: {
                                enabled: false
                            },
                            title: {
                                text: '考试成绩分布直方图',
                                style: {
                                    color: "#666",
                                    fontSize: "18px"
                                }
                            },
                            xAxis: {
                                categories: data.scoreRanges,
                                labels: {//设置横轴坐标的显示样式
                                    rotation: 0,//倾斜度
                                    align: 'center',
                                    style: {
                                        color: '#777',
                                        fontSize: "13px"
                                    }
                                }
                            },
                            yAxis: {
                                tickInterval: 10,
                                title: {
                                    text: '考生人数'
                                }
                            },
                            plotOptions: {
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
                            series: [{
                                name: '考生人数',
                                data: columnDataOne
                            }]
                        });
                    }
                });
            },

            renderKnowledgeAnalysis: function (so, examId, subjectName) {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/manage/statisticCompKnowledge?id=' + examId,
                    data: $('#knowledgeForm_' + so).serialize(),
                    success: function (data) {
                        if ($.isEmptyObject(data)) {
                            return false;
                        }

                        var kCategories = [], kData = [];
                        $('#knowledgeForm_' + so).find('input[name="knowledgeIds"]:checked').each(function (i, dom) {
                            kCategories.push($(dom).attr('title'));
                            kData.push(data.examKnowledgeMap[$(dom).val()]);
                        });

                        resultStatistic.renderRadarChart(kCategories, so, [{
                            name: subjectName,
                            type: 'area',
                            fillOpacity: 0.05,
                            data: kData,
                            pointPlacement: 'on'
                        }]);
                    }
                });
            },
            saveRadarObj: {},
            renderRadarChart: function (kCategories, so, knArray) {
                resultStatistic.saveRadarObj = new Highcharts.chart('analyzeRadarChart_' + so, {
                    chart: {
                        polar: true,
                        type: 'line'
                    },
                    title: {
                        text: '',
                        x: -80
                    },
                    credits: {
                        enabled: false
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
                    series: knArray
                });
            },
            bind: function () {
                var _this = this;
                $('.pe-question-select').on('change', function () {
                    _this.renderScoreChart($(this).val());
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
                    _this.renderKnowledgeAnalysis(so, examId, subjectName);
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