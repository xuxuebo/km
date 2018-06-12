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
            <div class="analyze-head-name">${(exercise.exerciseName)!}</div>
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
                                    知识点显示筛选<span class="iconfont icon-thin-arrow-down arrow"
                                                 style="vertical-align:middle;"></span>
                                    <div class="analyze-choose-panel knowledge-analyze">
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
                                                   name="knowledgeIds" title="${(knowledge.knowledgeName)!}"KnowledgeIds
                                                   value="${(knowledge.id)!}">${(knowledge.knowledgeName)!}
                                        </label>
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
                <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                    <h2 class="pe-question-head-text" style="margin-top:20px;">试题分析</h2>
                </div>
                <form id="resultDetailForm" style="background-color: #f4f4f4">
                    <label class="pe-form-label floatL" for="peMainKeyName" style="margin-right: 30px;">
                        <span class="pe-label-name floatL">关键字:</span>
                        <input id="peMainKeyName" class="pe-stand-filter-form-input" placeholder="试题内容" maxlength="20" type="text"
                               name="keyword">
                        <span class="iconfont icon-search-magnifier exercise-item-search"
                              style="padding-top: 3px;font-size: 24px;display: inline-block;color:##666;cursor:pointer;"></span>
                        <input type="hidden" name="exerciseId" value="${exercise.id}">
                    </label>
                    <dl>
                        <dt class="pe-label-name floatL">类&emsp;别:</dt>
                        <dd class="pe-stand-filter-label-wrap">
                            <label class="floatL pe-checkbox pe-check-by-list pe-exercise-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                            <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                       name="queryType" value="SINGLE_SELECTION"/>单选
                            </label>
                            <label class="floatL pe-checkbox pe-check-by-list pe-exercise-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                       name="queryType" value="MULTI_SELECTION"/>多选
                            </label>
                            <label class="floatL pe-checkbox pe-check-by-list pe-exercise-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <input id="peFormEleStop" class="pe-form-ele" checked="checked" type="checkbox"
                                       name="queryType"
                                       value="INDEFINITE_SELECTION"/>不定项
                            </label>
                            <label class="floatL pe-checkbox pe-check-by-list pe-exercise-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <input id="peFormEleStop" class="pe-form-ele" checked="checked" type="checkbox"
                                       name="queryType" value="JUDGMENT"/>判断
                            </label>
                            <label class="floatL pe-checkbox pe-check-by-list  pe-exercise-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <input id="peFormEleStop" class="pe-form-ele" checked="checked" type="checkbox"
                                       name="queryType"
                                       value="FILL"/>填空
                            </label>
                            <label class="floatL pe-checkbox pe-check-by-list pe-exercise-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <input id="peFormEleStop" class="pe-form-ele" checked="checked" type="checkbox"
                                       name="queryType"
                                       value="QUESTIONS"/>问答
                            </label>
                        </dd>
                    </dl>
                </form>
                <div class="pe-stand-table-main-panel">
                    <div class="pe-stand-table-wrap"></div>
                    <div class="pe-stand-table-pagination"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/template" id="itemAnalyze">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI ;i++){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%=peData.tableTitles[i].title%>
                </th>
                <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
            <tr>
            <#--生成提干内容-->
                <td><a class="pe-stand-table-alink pe-dark-font pe-ellipsis" title="<%=peData.rows[j].stemOutline%>"
                       href="${ctx!}/pe/ems/item/manage/initViewPage?itemId=<%=peData.rows[j].id%>" target="_blank"><%=peData.rows[j].stemOutline%></a>
                </td>

                <%if(peData.rows[j].type === 'INDEFINITE_SELECTION'){%>
                <td>不定项选择</td>
                <%}else if(peData.rows[j].type === 'JUDGMENT'){%>
                <td>判断题</td>
                <%}else if(peData.rows[j].type === 'SINGLE_SELECTION'){%>
                <td>单选题</td>
                <%}else if(peData.rows[j].type === 'QUESTIONS'){%>
                <td>问答题</td>
                <%}else if(peData.rows[j].type === 'FILL'){%>
                <td>填空题</td>
                <%}else if(peData.rows[j].type === 'MULTI_SELECTION'){%>
                <td>多选题</td>
                <%}else {%>
                <td></td>
                <%}%>
                <%if(peData.rows[j].type === 'INDEFINITE_SELECTION'||peData.rows[j].type === 'FILL'||peData.rows[j].type === 'SINGLE_SELECTION'||peData.rows[j].type === 'JUDGMENT'||peData.rows[j].type === 'QUESTIONS'||
                peData.rows[j].type === 'MULTI_SELECTION'){%>
            <#--生成正确人次-->
                <td>
                    <div class="pe-ellipsis">
                        <%if(peData.rows[j].rightCount!==undefined){%>
                        <div class="pe-ellipsis"><%=peData.rows[j].rightCount%></div>
                        <%}else{%>
                        <div class="pe-ellipsis">--</div>
                        <%}%>
                    </div>
                </td>
            <#--生成错误人次-->
                <td>
                    <%if(peData.rows[j].wrongCount!==undefined){%>
                    <div class="pe-ellipsis"><%=peData.rows[j].wrongCount%></div>
                    <%}else{%>
                    <div class="pe-ellipsis">--</div>
                    <%}%>

                </td>
                <td>
                    <%if(peData.rows[j].accuracy!==undefined){%>
                    <div class="pe-ellipsis"><%=Number(peData.rows[j].accuracy).toFixed(1)%>%</div>
                    <%}else{%>
                    <div class="pe-ellipsis">--</div>
                    <%}%>
                </td>
                <%}else{%>
                <td>
                    <div class="pe-ellipsis">--</div>
                </td>
            <#--生成错误人次-->
                <td>
                    <div class="pe-ellipsis">--</div>
                </td>
                <td>
                    <div class="pe-ellipsis">--</div>
                </td>
                <%}%>
            <#--生成正确人次-->

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
            {'title': '题干', 'width': 30},
            {'title': '题型', 'width': 8},
            {'title': '答对人次', 'width': 10},
            {'title': '答错人次', 'width': 10},//.name === 'indefinite'
            {'title': '正确率', 'width': 14}
        ];

        var kMap={};
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/ems/exercise/manage/exerciseItemAnalyze',
            formParam: $('#resultDetailForm').serializeArray(),
            tempId: 'itemAnalyze',
            showTotalDomId: 'showTotal',
            title: peTableTitle
        });

        var resultStatistic = {
            exerciseId: '${(exercise.id)!}',
            init: function () {
                var _this = this;
                _this.initData();
                _this.bind();
            },

            initData: function () {
                var _this = this;
                <#if knowledges?? && (knowledges?size >0)>
                    _this.renderKnowledgeAnalysis();
                </#if>

            },

            renderKnowledgeAnalysis: function () {
                var _this = this;

                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exercise/manage/statisticKnowledge?id=' + _this.exerciseId,
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
                        var kData = [];
                        //在每个批次进行循环输出的同时，循环每个知识点，把该批次下的分数存储在对应的知识点中;
                        $('input[name="knowledgeIds"]').each(function (i, dom) {
                            kData.push(data[$(dom).val()]);
                            kMap[$(dom).val()]=data[$(dom).val()];
                        });

                        knArray.push({
                            name: "得分率",
                            type: 'area',
                            fillOpacity: 0.05,
                            data: kData,
                            pointPlacement: 'on'
                        });
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
                        tickInterval: 2
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

                $(".exercise-item-search").click(function(){
                    $('.pe-stand-table-wrap').peGrid("load",$("#resultDetailForm").serializeArray());
                });

                $(".pe-stand-filter-form-input").on("blur",function(){
                    var changeValue = $(this).val();
                    $('.pe-stand-table-wrap').peGrid("load",$("#resultDetailForm").serializeArray());
                });
                /*试题正确率的点击事件*/
                $(".pe-exercise-checkbox").off().click(function(){
                    var iconCheck = $(this).find("span.iconfont"),
                            thisRealCheck = $(this).find('input[type="checkbox"]');
                    if(iconCheck.hasClass('icon-unchecked-checkbox')){
                        iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox');
                        thisRealCheck.prop('checked','true');
                    }else{
                        iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisRealCheck.removeProp("checked");
                    }

                    $('.pe-stand-table-wrap').peGrid("load",$("#resultDetailForm").serializeArray());
                });
                /*知识点的弱项分析的知识点的checkbox的点击事件*/
                $('.knowledge-choose-box').off().click(function () {
                    var thisCheckboxLenth = $(this).parent('.analyze-choose-panel').find('.knowledge-choose-box').length;
                    if(thisCheckboxLenth <= 3){
                        PEMO.DIALOG.alert({
                            content:'至少保留3个'
                        })
                    }

                    var iconCheck = $(this).find('span.iconfont'),
                            thisRealCheck = $(this).find('input[type="checkbox"]'),
                            thisCateName = thisRealCheck.attr('title'),
                            thisCateIndex = thisRealCheck.attr('data-index'),//该知识点所在的初始数组位置
                            thisArrangeObj = thisRealCheck.data('arrange'),//该知识点存储的各批次分数对象;
                            thisCateVale = kMap[thisRealCheck.val()],
                            leftNewCateData = $.extend(true, [], resultStatistic.saveLeftRadarData.cate),//用于渲染新的蜘蛛图的分类参数(每次点击剩余知识点);
                            leftNewSeries = $.extend(true, [], resultStatistic.saveLeftRadarData.array);//深拷贝已经保存的series,同上;

                    if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                        iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                        thisRealCheck.prop('checked', 'checked');
                        resultStatistic.saveLeftRadarData.cate.splice(thisCateIndex, 0, thisCateName);
                        for (var i = 0, iLen = resultStatistic.saveLeftRadarData.array.length; i < iLen; i++) {
                            /*lenth为批次的数目*/
                            if (thisCateIndex >= resultStatistic.saveLeftRadarData.array[i].data.length) {
                                resultStatistic.saveLeftRadarData.array[i].data.splice(resultStatistic.saveLeftRadarData.array[i].data.length, 0, thisCateVale);
                            } else {
                                resultStatistic.saveLeftRadarData.array[i].data.splice(thisCateIndex, 0, thisCateVale);
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