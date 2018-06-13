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
            <div class="analyze-head-name">
                模拟考试
            </div>
        </div>
        <div class="pe-manage-panel pe-manage-default">
            <div class="pe-no-nav-main-wrap" style="width:1166px;">
                <#if knowledges?? && (knowledges?size >0)>
                    <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                        <h2 class="pe-question-head-text" style="margin-top:20px;">知识点弱项分析</h2>
                    </div>
                    <div class="week-analyze-all-wrap">
                        <ul class="analyze-radar-choose-wrap">
                            <form id="knowledgeForm">
                                <li class="floatL analyze-radar-choose" data-type="knowledge">
                                    知识点显示筛选
                                    <div class="analyze-choose-panel knowledge-analyze" style="display:block;">
                                        <#list knowledges as knowledge>
                                            <#if knowledge_index == 0>
                                            <label class=" pe-checkbox pe-check-by-list knowledge-choose-box" for=""
                                                   style="margin-right:15px;margin-left:15px;">
                                            <#else>
                                            <label class=" pe-checkbox pe-check-by-list knowledge-choose-box" for=""
                                                   style="margin-right:15px;">
                                            </#if>
                                            <span class="iconfont icon-checked-checkbox peChecked"></span>
                                            <input class="pe-form-ele" data-index="${knowledge_index}" checked="checked"
                                                   type="checkbox"
                                                   name="knowledgeIds" title="${(knowledge.knowledgeName)!}"
                                                   value="${(knowledge.id)!}">${(knowledge.knowledgeName)!}
                                        </label>
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
                //         _this.renderResultOverview();
                <#if knowledges?? && (knowledges?size >0)>
                    _this.renderKnowledgeAnalysis();
                </#if>
            },

            renderKnowledgeAnalysis: function () {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/simulationExam/client/statisticKnowledge?id=' + _this.examId,
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
                        var scoreVals = {};
                        resultStatistic.saveLeftRadarData.cate = $.extend(true, [], kCategories);
                        resultStatistic.saveLeftRadarData.array = $.extend(true, [], knArray);
                        for (var i = 0, iLen = data.length; i < iLen; i++) {
                            scoreVals[i] = resultStatistic.getNewDataList(data[i])
                        }
                        knArray = [{name: "我的成绩", data: scoreVals[0], pointPlacement: "on"}, {
                            name: "平均成绩",
                            data: scoreVals[1],
                            pointPlacement: "on"
                        }];
                        resultStatistic.renderRadarChart(kCategories, knArray);

                    }
                });

            },
            getNewDataList: function (dataObj) {
                if (!dataObj || $.isEmptyObject(dataObj)) {
                    return false
                }
                var newListArry = [];
                $('input[name="knowledgeIds"]').each(function (index) {

                    var knowledgeId = $(this).val();

                    newListArry.push(dataObj[knowledgeId]);
                });
                return newListArry;
            },
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
                    /* series:[{name: 'Allocated Budget',
                         data: [50, 100,100, 100],
                         pointPlacement: 'on'}]*/
                });
            },
            bind: function () {
                var _this = this;
                /*知识点的弱项分析的知识点的checkbox的点击事件*/
                $('.knowledge-choose-box').off().click(function () {
                    var thisCheckboxLenth = $(this).parent('.analyze-choose-panel').find('.knowledge-choose-box').length;
//                    if(thisCheckboxLenth <= 3){
//                        PEMO.DIALOG.alert({
//                            content:'至少保留3个'
//                        })
//                    }
                    var knowledges = $('input[name="knowledgeIds"]').val();
                    var knowledgeIds = [];
                    $.each(knowledges, function (n, value) {
                        knowledgeIds.push(value);
                    });

                    console.log('leftNewCateData', resultStatistic.saveLeftRadarData.cate);
                    console.log('leftNewSeries', resultStatistic.saveLeftRadarData.array);
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
                            //  _this.find('.analyze-choose-panel').hide();
                        }
                );
            }
        };

        resultStatistic.init();
    });
</script>
</@p.pageFrame>