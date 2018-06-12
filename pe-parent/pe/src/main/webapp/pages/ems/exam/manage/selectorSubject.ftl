<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>选择器</title>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/iconfont.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css"/>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.pagination.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.easydropdown.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-peGrid.js?_v=${(resourceVersion)!}"></script>
    <script>
        var pageContext = {
            rootPath: '${ctx!}'
        }
    </script>
</head>
<body class="pe-selector-body" style="padding: 0 20px;">
<div class="pe-selector-wrap">
    <form id="selectorSubjectForm">
        <input type="hidden" name="examStatus" value="ENABLE">
        <input type="hidden" name="includeCreator" value="true">
        <#--<input type="hidden" name="category.include" value="true">-->
        <div class="pe-stand-table-panel exam-subject-dialog-panel">
            <div class="pe-stand-table-top-panel">
                <div class="pe-stand-filter-form">
                    <div class="pe-stand-form-cell selector-subject-cell">
                        <label class="pe-form-label floatL" for="peMainKeyText">
                        <#--<span class="pe-label-name floatL">关键字:</span>-->
                            <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                   placeholder="科目名称/编号/创建人" name="examKey">
                        </label>
                        <div class="subject-dialog-opt">
                            <a href="javascript:;" class="iconfont icon-new-add">
                                <span class="btn-drop-down ">
                                    <div class="selector-subject-arrow"></div>
                                    <span href="javascript:;" class="drop-item save-online-subject-page">新建线上科目</span>
                                    <span href="javascript:;" class="drop-item save-offline-subject-page">新建线下科目</span>
                                </span>
                            </a>
                            <a href="javascript:;" class="iconfont icon-refresh refresh-subject"></a>
                        </div>
                        <dl class="over-flow-hide selector-subject-cell-type">
                            <dt class="pe-label-name">科目类型:</dt>
                            <dd class="pe-stand-filter-label-wrap">
                                <label class=" pe-checkbox" for="" style="margin-right:15px;">
                                    <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                    <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                           name="examTypes" value="ONLINE"/>线上
                                </label>
                                <label class=" pe-checkbox" for="" style="margin-right:15px;">
                                    <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                           name="examTypes" value="OFFLINE"/>线下
                                </label>
                            </dd>
                        </dl>
                        <button type="button" class="pe-btn pe-btn-blue pe-question-choosen-btn floatR selector-choosen-btn">筛选</button>
                    </div>
                </div>
            </div>
        <#--表格包裹的div-->
            <div class="pe-stand-table-main-panel">
                <div class="pe-stand-table-wrap select-subject"></div>
                <div class="pe-stand-table-pagination" style="display:none;"></div>
            </div>
        </div>
    </form>
</div>
<script src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}" type="application/javascript"></script>
<#--渲染表格模板-->
<script type="text/template" id="markerPaperUser">
    <table class="pe-stand-table pe-stand-table-default checkbox-table">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <%if(peData.tableTitles[i].title === 'checkbox'){%>
                <th style="width:<%=peData.tableTitles[i].width%>%">
                    <label class="pe-radio pe-paper-all-check">
                        <span class="iconfont icon-unchecked-radio"></span>
                        <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheckAll"/>
                    </label>
                </th>
                <%}else{%>
                <%if(peData.tableTitles[i] && peData.tableTitles[i].needIcon){%>
                <th style="width:<%=peData.tableTitles[i].width%>%;padding-left:22px;">
                    <%}else{%>
                <th style="width:<%=peData.tableTitles[i].width%>%">
                    <%}%>
                    <%=peData.tableTitles[i].title%>
                </th>
                <%}%>
                <%}%>
        </tr>
        </thead>
        <tbody>
        <#--<tr class="pe-stand-bg"></tr>-->
        <#--rows.length ===0 为前端无数据时临时改的，实际为!== 0-，及下面的[1,2,3,4,5]也是假的，最后删除]-->
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ;j++){%>
            <tr data-index="<%=j%>">
                <td>
                    <label class="pe-radio pe-subject-check" data-id="<%=peData.rows[j].id%>" data-name="<%=peData.rows[j].examName%>">
                        <%if ('${chooseSubjectIds!}'.indexOf(peData.rows[j].id) >= 0){%>
                        <span class="iconfont icon-checked-radio" style="color: #999;"></span>
                        <input class="pe-form-ele"  type="radio" disabled/>
                        <%}else{%>
                        <span class="iconfont icon-unchecked-radio"></span>
                        <input class="pe-form-ele"  type="radio" name="subjectCheck"/>
                        <%}%>
                    </label>
                </td>
                <#--科目编号-->
                <td>
                    <div class="pe-ellipsis" title=""><%=peData.rows[j].examCode%></div>
                </td>
                <#--科目名称-->
                <td>
                    <%=peData.rows[j].examName%>
                </td>
               <#--科目类型-->
                <%if(peData.rows[j].examType === 'ONLINE'){%>
                <td>线上</td>
                <%}else if(peData.rows[j].examType === 'OFFLINE'){%>
                <td>线下</td>
                <%}else if(peData.rows[j].examType === 'COMPREHENSIVE'){%>
                <td>综合</td>
                <%}else {%>
                <td></td>
                <%}%>
                <#--创建人-->
                <td>
                    <div class="pe-ellipsis" title=""><%=peData.rows[j].createBy%></div>
                </td>
            </tr>
            <%}%>
            <%}else{%>
            <tr>
                <td class="pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
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
        $(document).ajaxSend(function (event, jqxhr, settings) {
            var times = (new Date()).getTime() + Math.floor(Math.random() * 10000);
            if (settings.url.indexOf('?') > -1) {
                settings.url = settings.url + '&_t=' + times;
            } else {
                settings.url = settings.url + '?_t=' + times;
            }

        });
        /*自定义主体表格头部数量及宽度*/
        var peTableTitle = [
            {'title': '', 'width': 4},
            {'title': '科目编号', 'width': 22},
            {'title': '科目名称', 'width': 36},
            {'title': '类型', 'width': 10},
            {'title': '创建人', 'width': 10}
        ];
        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/ems/exam/manage/searchSubject',
            formParam: $('#selectorSubjectForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'markerPaperUser',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle, //表格头部的数量及名称数组;
            pagination: 'layer',
            onLoad: function () {
                PEBASE.peFormEvent('checkbox');
                $('.pe-stand-table tr').click(function(e){
                    var e = e || window.event;
                    $(this).find('label.pe-radio').trigger('click');
                })
            }
        });

        $('.save-online-subject-page').on('click', function () {
            window.open(pageContext.rootPath+'/front/manage/initPage#url='
                    + pageContext.rootPath + '/ems/exam/manage/initExamInfo?examType=ONLINE&subject=true&source=ADD&nav=examMana','');
        });

        $('.save-offline-subject-page').on('click', function () {
            window.open(pageContext.rootPath+'/front/manage/initPage#url=' + pageContext.rootPath
                    + '/ems/exam/manage/initExamInfo?examType=OFFLINE&subject=true&source=ADD&nav=examMana','');
        });

        $('.refresh-subject').on('click', function () {
            var data= {'examStatus':'ENABLE'};
            $('.pe-stand-table-wrap').peGrid('load',data);
        });

        $('.selector-choosen-btn').on('click',function(){
            $('.pe-stand-table-wrap').peGrid('load',$('#selectorSubjectForm').serializeArray());
        })
    });


</script>
</body>
</html>