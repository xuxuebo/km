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
            <div class="analyze-head-name">[<#if exam.examType =='OFFLINE'>线下<#elseif exam.examType == 'ONLINE'>
                线上<#else>综合</#if>]${(exam.examName)!}</div>
        </div>
        <div class="pe-manage-panel pe-manage-default">
            <div class="pe-no-nav-main-wrap" style="width:1166px;">
                <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                    <h2 class="pe-question-head-text">成绩总揽</h2>
                </div>
                <div class="analyze-column-chart" id="analyzeColumnChart">

                </div>
                <#if knowledges?? && (knowledges?size >0)>
                    <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                        <h2 class="pe-question-head-text" style="margin-top:20px;">知识点弱项分析</h2>
                    </div>
                    <div class="week-analyze-all-wrap">
                        <ul class="analyze-radar-choose-wrap">
                            <form id="knowledgeForm">
                                <li class="floatL analyze-radar-choose" data-type="knowledge">
                                    知识点显示筛选<span class="iconfont icon-thin-arrow-down arrow"></span>
                                    <div class="analyze-choose-panel knowledge-analyze">
                                        <#list knowledges as knowledge>
                                            <#if knowledge_index == 0>
                                            <span class=" pe-checkbox pe-check-by-list knowledge-choose-box" for=""
                                                   style="margin-right:15px;margin-left:15px;">
                                            <#else>
                                            <span class=" pe-checkbox pe-check-by-list knowledge-choose-box" for="" style="margin-right:15px;">
                                            </#if>
                                            <span class="iconfont icon-checked-checkbox peChecked"></span>
                                            <input class="pe-form-ele" checked="checked" type="checkbox"
                                                   name="knowledgeIds" title="${(knowledge.knowledgeName)!}"
                                                   value="${(knowledge.id)!}">${(knowledge.knowledgeName)!}
                                        </span>
                                        </#list>
                                    </div>
                                </li>
                            </form>
                        </ul>

                    <#--蜘蛛图-->
                        <div class="analyze-radar-chart" id="analyzeRadarChart">

                        </div>
                    </div>
                </#if>
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
                _this.renderResultOverview();
                <#if knowledges?? && (knowledges?size >0)>
                    _this.renderKnowledgeAnalysis();
                </#if>
            },


            renderResultOverview: function () {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/client/statisticMyOverview',
                    data: {examId: _this.examId},
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
                            colorByPoint: false
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
                        enabled:false
                    },
                    credits: {
                        enabled: false
                    },
                    series: [{
                        data: data
                    }]
                });
            },

            renderKnowledgeAnalysis: function () {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/client/statisticMyKnowledge?id=' + _this.examId,
                    data: $('#knowledgeForm').serialize(),
                    success: function (data) {
                        if ($.isEmptyObject(data)) {
                            return false;
                        }

                        var kCategories = [], knowledgeIds = [];
                        $('input[name="knowledgeIds"]:checked').each(function (i, dom) {
                            kCategories.push($(dom).attr('title'));
                            knowledgeIds.push($(dom).val());
                        });

                        var avgScores = [],myScores = [];
                        $.each(knowledgeIds,function(i,v){
                            avgScores.push(data.avgScoreMap[v]);
                            myScores.push(data.myScoreMap[v]);
                        });

                        Highcharts.chart('analyzeRadarChart', {
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
                                pointFormat: '<span style="color:{series.color}">{series.name}: <b>{point.y:.2f}</b><br/>'
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


                /*知识点的弱项分析的知识点的checkbox的点击事件*/
                $('.knowledge-choose-box').off().click(function () {
                    var iconCheck = $(this).find('span.iconfont'),
                            thisRealCheck = $(this).find('input[type="checkbox"]');//该知识点存储的各批次分数对象;
                    if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                        iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                        thisRealCheck.prop('checked', 'checked');
                    } else {
                        iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisRealCheck.removeProp('checked');
                    }

                    resultStatistic.renderKnowledgeAnalysis();
                });
            }
        };

        resultStatistic.init();
    });
</script>
</@p.pageFrame>