<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>选择器</title>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css"/>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.pagination.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.easydropdown.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-peGrid.js?_v=${(resourceVersion)!}"></script>
</head>
<body class="pe-selector-body" style="padding: 0 20px;">
<div class="pe-paper-manage-all-wrap">
    <form id="selectorPaperTemplateForm">
        <input type="hidden" name="queryStatus" value="ENABLE">
        <input type="hidden" name="category.id" value="${categoryId!}">
        <input type="hidden" name="category.include" value="true">
        <div class="pe-manage-panel-head pe-add-exam-dialog-wrap">
            <div class="pe-stand-filter-form">
                <div class="pe-stand-form-cell">
                    <label class="pe-form-label floatL" for="peMainKeyText">
                        <span class="pe-label-name floatL">关键字:</span>
                        <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                               placeholder="试卷名称/编号" name="paperName">
                    </label>
                    <label class="pe-form-label" for="peMainKeyText" style="">
                        <span class="pe-label-name floatL">创建人:</span>
                        <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                               placeholder="用户名/姓名/手机号/工号"  name="createBy">
                    </label>
                    </div>
                    <div class="pe-stand-form-cell">
                    <dl class="over-flow-hide floatL" style="margin-right:158px;">
                        <dt class="pe-label-name floatL">试卷类型:</dt>
                        <dd class="pe-stand-filter-label-wrap">
                            <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                       name="queryType" value="FIXED"/>固定
                            </label>
                            <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                       name="queryType" value="RANDOM"/>随机
                            </label>
                        </dd>
                    </dl>
                    <dl class="floatL">
                        <dt class="pe-label-name floatL">试卷属性:</dt>
                        <dd class="pe-stand-filter-label-wrap">
                            <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                       name="querySecurity" value="flase"/>普通
                            </label>
                            <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                <span class="iconfont icon-checked-checkbox peChecked"></span>
                                <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                       name="querySecurity" value="true"/>绝密
                            </label>
                        </dd>
                    </dl>
                    <button type="button" class="pe-btn pe-btn-blue pe-question-choosen-btn">筛选</button>
                </div>

            </div>
        </div>
        <div class="pe-stand-table-panel">
        <#--表格包裹的div-->
            <div class="pe-stand-table-main-panel">
                <div class="pe-stand-table-wrap select-paper-template"></div>
                <#--<div class="pe-stand-table-pagination" style="display:none;"></div>-->
            </div>
        </div>
    </form>
</div>
<script src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}" type="application/javascript"></script>
<#--渲染表格模板-->
<script type="text/template" id="paperTableTep">
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
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
            <tr data-index="<%=j%>">
                <td>
                    <label class="pe-radio pe-paper-check" data-id="<%=peData.rows[j].id%>" data-title="<%=peData.rows[j].paperName%>" data-type="<%=peData.rows[j].paperType%>">
                        <%if ('${fixTemplateIds!}'.indexOf(peData.rows[j].id) >= 0){%>
                        <span class="iconfont icon-checked-radio" style="color: #999;"></span>
                        <input class="pe-form-ele" value="ENABLE" type="radio" disabled/>
                        <%}else{%>
                        <span class="iconfont icon-unchecked-radio"></span>
                        <input class="pe-form-ele" value="ENABLE" type="radio" name="paperCheck"/>
                        <%}%>
                    </label>
                </td>
            <#--生成题型类-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].paperCode%>"><%=peData.rows[j].paperCode%></div>
                </td>
                <td style="padding-left:22px;position:relative;">
                    <%if(peData.rows[j].security){%>
                    <span class="iconfont icon-security"></span>
                    <%}%>
                    <a class="pe-stand-table-alink pe-dark-font pe-ellipsis" title="<%=peData.rows[j].paperName%>"
                       href="${ctx!}/ems/template/manage/initViewPaperPage?templateId=<%=peData.rows[j].id%>"
                       target="_blank"><%=peData.rows[j].paperName%></a>
                </td>
                <%if(peData.rows[j].paperType === 'FIXED'){%>
                <td class="paper-type">固定</td>
                <%}else if(peData.rows[j].paperType === 'RANDOM'){%>
                <td class="paper-type">随机</td>
                <%}else {%>
                <td class="paper-type"></td>
                <%}%>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].createBy%>"><%=peData.rows[j].createBy%></div>
                </td>
                <td><%=peData.rows[j].createDate%></td>
            <#--此处生成题型状态-->
                <%if(peData.rows[j].paperStatus === 'ENABLE'){%>
                <td>启用</td>
                <%}else if(peData.rows[j].paperStatus === 'DISABLE'){%>
                <td>停用</td>
                <%}else if(peData.rows[j].paperStatus === 'DRAFT'){%>
                <td>草稿</td>
                <%}else {%>
                <td></td>
                <%}%>
            </tr>
            <%}%>
            <%}else{%>
            <tr>
                <td class="pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
                    <div class="pe-result-no-date" style="height: 236px;"></div>
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

        /*自定义表格头部数量及宽度*/
        var peTableTitle = [
            {'title': '', 'width': 4},
            {'title': '试卷编号', 'width': 16},
            {'title': '试卷名称', 'width': 24, 'needIcon': true},
            {'title': '试卷类型', 'width': 8},
            {'title': '创建人', 'width': 12},
            {'title': '创建日期', 'width': 14},
            {'title': '状态', 'width': 6}
        ];
        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: '${ctx!}/ems/template/manage/search',
            formParam: $('#selectorPaperTemplateForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'paperTableTep',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle, //表格头部的数量及名称数组;
            pagination: 'layer',
            onLoad: function (data) {
                PEBASE.peFormEvent('radio');
            }
        });

        $('.pe-question-choosen-btn').on('click',function(){
            $('.pe-stand-table-wrap').peGrid('load',$('#selectorPaperTemplateForm').serializeArray());
        });

        //类别点击筛选事件
        $('.pe-check-by-list').off().click(function () {
            var iconCheck = $(this).find('span.iconfont');
            var thisRealCheck = $(this).find('input[type="checkbox"]');
            if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                thisRealCheck.prop('checked', 'checked');//这里在ie8下目前会报错“意外的调用了方法”,待解决
            } else {
                iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                thisRealCheck.removeProp('checked');
            }
            $('.pe-stand-table-wrap').peGrid('load', $('#selectorPaperTemplateForm').serializeArray());
        });
    });
</script>
</body>
</html>