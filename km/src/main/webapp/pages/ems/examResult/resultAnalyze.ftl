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
            <div class="analyze-head-name">[<#if exam.examType =='OFFLINE'>线下<#elseif exam.examType == 'ONLINE'>
                线上<#else>综合</#if>]${(exam.examName)!}</div>
        </div>
        <div class="pe-manage-panel pe-manage-default">
            <div class="pe-no-nav-main-wrap" style="width:1166px;">
                <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                    <h2 class="pe-question-head-text">成绩总揽</h2>
                </div>
                <div class="result-pandect">
                    <form id="overviewForm">
                        <div class="arrange-wrap"
                             <#if exam.examArranges?? && (exam.examArranges?size == 1)>style="display: none" </#if>>
                            <#list exam.examArranges as examArrange>
                                <span class="pe-checkbox pe-check-by-list arrange-choose-box" for=""
                                       style="margin-right:15px;">
                                    <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <input class="pe-form-ele" checked="checked" type="checkbox" name="arrangeIds"
                                           value="${(examArrange.id)!}">${(examArrange.batchName)!}
                                </span>
                            </#list>
                        </div>
                    </form>
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
                <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                    <h2 class="pe-question-head-text">成绩分布统计</h2>
                </div>
            <#--饼状图-->
                <div class="analyze-pie-chart" id="analyzePieChart">

                </div>
            <#--柱状图-->
                <div class="analyze-column-chart" id="analyzeColumnChart">

                </div>
                <@authVerify authCode="VERSION_OF_RESULT_ANALYSE">
                    <#if knowledges?? && (knowledges?size >0)>
                    <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                        <h2 class="pe-question-head-text" style="margin-top:20px;">知识点弱项分析</h2>
                    </div>
                    <div class="week-analyze-all-wrap">
                        <ul class="analyze-radar-choose-wrap">
                            <form id="knowledgeForm">
                                <li class="floatL analyze-radar-choose" data-type="knowledge">
                                    知识点显示筛选<span class="iconfont icon-thin-arrow-down arrow"
                                                 style="vertical-align:middle;"></span>
                                    <div class="analyze-choose-panel knowledge-analyze">
                                        <#list knowledges as knowledge>
                                            <#if knowledge_index == 0>
                                            <span class=" pe-checkbox pe-check-by-list knowledge-choose-box" for=""
                                                  style="margin-right:15px;margin-left:15px;">
                                            <#else>
                                            <span class=" pe-checkbox pe-check-by-list knowledge-choose-box" for=""
                                                  style="margin-right:15px;">
                                            </#if>
                                            <span class="iconfont icon-checked-checkbox peChecked"></span>
                                            <input class="pe-form-ele" data-index="${knowledge_index}" checked="checked"
                                                   type="checkbox"
                                                   name="knowledgeIds" title="${(knowledge.knowledgeName)!}"
                                                   value="${(knowledge.id)!}">${(knowledge.knowledgeName)!}
                                        </span>
                                        </#list>
                                    </div>
                                </li>
                            </form>
                        <#--<li class="floatL analyze-radar-choose" data-type="batch">-->
                        <#--批次显示筛选<span class="iconfont icon-thin-arrow-down arrow"-->
                        <#--style="vertical-align:middle;"></span>-->
                        <#--<div class="analyze-choose-panel batch-analyze">-->

                        <#--</div>-->
                        <#--</li>-->
                        </ul>

                    <#--蜘蛛图-->
                        <div class="analyze-radar-chart" id="analyzeRadarChart">

                        </div>
                    </div>
                    </#if>
                </@authVerify>
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
                _this.renderResultOverview();
                //考试结果饼状图
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/manage/statisticStatus',
                    data: {examId: _this.examId},
                    success: function (data) {
                        if ($.isEmptyObject(data)) {
                            return false;
                        }

                        var missResult = {count: 0, seriesDatas: []}, passResult = {
                            count: 0,
                            seriesDatas: []
                        }, noPassResult = {count: 0, seriesDatas: []};
                        $.each(data, function (index, examArrange) {
                            missResult.count = missResult.count + examArrange.missCount;
                            noPassResult.count = noPassResult.count + examArrange.noPassCount;
                            passResult.count = passResult.count + examArrange.passCount;
                            <#if exam.examArranges?? && (exam.examArranges?size > 1)>
                            missResult.seriesDatas.push([examArrange.batchName, examArrange.missCount]);
                            passResult.seriesDatas.push([examArrange.batchName, examArrange.passCount]);
                            noPassResult.seriesDatas.push([examArrange.batchName, examArrange.noPassCount]);
                            </#if>
                        });

                        _this.renderStatusChart(missResult, passResult, noPassResult);
                    }
                });

                //考试分数分布柱状图
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/manage/statisticScore',
                    data: {examId: _this.examId},
                    success: function (data) {
                        if ($.isEmptyObject(data)) {
                            return false;
                        }

                        var categories = data.scoreRanges, columnDataOne = [], columnDataTwo = [];
                        $.each(categories, function (i, v) {
                            var score_count = 0, twoData = [];
                            for (var aId in data.scoreMap[v]) {
                                score_count += data.scoreMap[v][aId];
                                <#if exam.examArranges?? && (exam.examArranges?size > 1)>
                                    twoData.push([data.examArrangeMap[aId].batchName, score_count]);
                                </#if>
                            }

                            <#if exam.examArranges?? && (exam.examArranges?size > 1)>
                                columnDataTwo.push({name: '考生人数', id: v, data: twoData});
                            </#if>
                            columnDataOne.push({y: score_count, drilldown: v});
                        });

                        _this.renderScoreChart(categories, columnDataOne, columnDataTwo);
                    }
                });

                <#if knowledges?? && (knowledges?size >0)>
                    _this.renderKnowledgeAnalysis();
                </#if>
            },


            renderResultOverview: function () {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/manage/statisticOverview?id=' + _this.examId,
                    data: $('#overviewForm').serialize(),
                    success: function (data) {
                        $('.result-overview-show').html(_.template($('#resultOverview').html())({data: data}));
                    }
                });
            },

            renderStatusChart: function (missResult, passResult, noPassResult) {
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
                            y: missResult.count,
                            color: "#d4d4d4",
                            drilldown: 'miss'
                        },
                            {
                                name: '未通过',
                                y: noPassResult.count,
                                color: "#ffa614",
                                drilldown: 'noPass'
                            },
                            {
                                name: '通过',
                                y: passResult.count,
                                color: "#7ccd88",
                                drilldown: 'pass'
                            }

                        ]
                    }],
                    drilldown: {
                        series: [{
                            name: '缺考',
                            id: 'miss',
                            data: missResult.seriesDatas
                        }, {
                            name: '未通过',
                            id: 'noPass',
                            data: noPassResult.seriesDatas
                        }, {
                            name: '通过',
                            id: 'pass',
                            data: passResult.seriesDatas
                        }
                        ]
                    }
                });
            },

            renderScoreChart: function (categories, columnDataOne, columnDataTwo) {
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
                        categories: categories,
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
                    }],
                    drilldown: {
                        /*数据处*/
                        series: columnDataTwo
                    }
                });
            },

            renderKnowledgeAnalysis: function () {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/resultReport/manage/statisticKnowledge?id=' + _this.examId,
                    data: $('#knowledgeForm').serialize(),
                    success: function (data) {
                        if ($.isEmptyObject(data)) {
                            return false;
                        }

                        var kCategories = [], knowledgeIds = [];
                        $('input[name="knowledgeIds"]').each(function (i, dom) {
                            kCategories.push($(dom).attr('title'));
                            knowledgeIds.push($(dom).val());
                        });

                        var knArray = [];
                        <#list exam.examArranges as examArrange>
                            var kData = [];
                            //在每个批次进行循环输出的同时，循环每个知识点，把该批次下的分数存储在对应的知识点中;
                            $('input[name="knowledgeIds"]').each(function (i, dom) {
                                var arrangeData = {};
                                if (data.knowledgeMap['${(examArrange.id)}'] == undefined) {
                                    return;
                                }

                                var mark = data.knowledgeMap['${(examArrange.id)}'][$(dom).val()];
                                if(!mark){
                                    mark = 0;
                                }

                                kData.push(mark);
                                arrangeData['arrange' +${examArrange_index}] = data.knowledgeMap['${(examArrange.id)}'][$(dom).val()];
                                if ($.isEmptyObject($(dom).data('arrange'))) {
                                    $(dom).data('arrange', arrangeData)
                                } else {
                                    var newArrangeData = $.extend({}, $(dom).data('arrange'), arrangeData);
                                    $(dom).data('arrange', newArrangeData);
                                }
                            });

                            var batchName = '${(examArrange.batchName)!}';
                            knArray.push({
                                name: batchName,
                                type: 'area',
                                fillOpacity: 0.05,
                                data: kData,
                                pointPlacement: 'on'
                            });
                        </#list>
                        resultStatistic.saveLeftRadarData.cate = $.extend(true, [], kCategories);
                        resultStatistic.saveLeftRadarData.array = $.extend(true, [], knArray);
                        resultStatistic.renderRadarChart(kCategories, knArray);

                    }
                });

            },
            //此名称及类似的咱不要删除!
//            saveRadarData:{
//                cate:[],
//                array:[]
//            },
            saveLeftRadarData: {
                cate: [],
                array: []
            },
            saveRadarObj: {},
            renderRadarChart: function (kCategories, knArray) {
                resultStatistic.saveRadarObj = new Highcharts.chart('analyzeRadarChart', {
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
                    series: knArray
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
                /*知识点的弱项分析的知识点的checkbox的点击事件*/
                $('.knowledge-choose-box').off().click(function () {
                    var thisCheckboxLenth = $(this).parent('.analyze-choose-panel').find('.knowledge-choose-box').length;
//                    if(thisCheckboxLenth <= 3){
//                        PEMO.DIALOG.alert({
//                            content:'至少保留3个'
//                        })
//                    }
                    var iconCheck = $(this).find('span.iconfont'),
                            thisRealCheck = $(this).find('input[type="checkbox"]'),
                            thisCateName = thisRealCheck.attr('title'),
                            thisCateIndex = thisRealCheck.attr('data-index'),//该知识点所在的初始数组位置
                            thisArrangeObj = thisRealCheck.data('arrange'),//该知识点存储的各批次分数对象;
                            leftNewCateData = $.extend(true, [], resultStatistic.saveLeftRadarData.cate),//用于渲染新的蜘蛛图的分类参数(每次点击剩余知识点);
                            leftNewSeries = $.extend(true, [], resultStatistic.saveLeftRadarData.array);//深拷贝已经保存的series,同上;

                    if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                        iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                        thisRealCheck.prop('checked', 'checked');
                        resultStatistic.saveLeftRadarData.cate.splice(thisCateIndex, 0, thisCateName);
                        for (var i = 0, iLen = resultStatistic.saveLeftRadarData.array.length; i < iLen; i++) {
                            /*lenth为批次的数目*/
                            if (thisCateIndex >= resultStatistic.saveLeftRadarData.array[i].data.length) {
                                resultStatistic.saveLeftRadarData.array[i].data.splice(resultStatistic.saveLeftRadarData.array[i].data.length, 0, thisArrangeObj['arrange' + i]);
                            } else {
                                resultStatistic.saveLeftRadarData.array[i].data.splice(thisCateIndex, 0, thisArrangeObj['arrange' + i]);
                            }

                        }
                    } else {
                        iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisRealCheck.removeProp('checked');
                        for (var k1 = 0; k1 < resultStatistic.saveLeftRadarData.cate.length; k1++) {
                            if (resultStatistic.saveLeftRadarData.cate[k1] === thisCateName) {
                                resultStatistic.saveLeftRadarData.cate.splice(k1, 1);
                                for (var j1 = 0; j1 < resultStatistic.saveLeftRadarData.array.length; j1++) {
                                    /*newSeries的lenth为批次的数目*/
                                    resultStatistic.saveLeftRadarData.array[j1].data.splice(k1, 1);
                                }
                            }
                        }

                    }
                    resultStatistic.renderRadarChart(resultStatistic.saveLeftRadarData.cate, resultStatistic.saveLeftRadarData.array);

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