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
        <input type="hidden" name="id" value="${organize.id!}">
        <div class="pe-stand-table-panel exam-subject-dialog-panel view-organize-exam-users">
            <div class="pe-stand-table-top-panel">
                <div class="view-organize-name">${(organize.namePath)!}<span class="organize-hightlight"></span></div>
                <div class="view-organize-user-num">考生数：<span class="organize-user-detail-num">${(organize.userCount)!'0'}</span>人</div>
            </div>
        <#--表格包裹的div-->
            <div class="pe-stand-table-main-panel" style="height:444px;overflow:auto;">
                <div class="pe-stand-table-wrap select-subject" ></div>
                <div class="pe-stand-table-pagination" style="display:none;"></div>
            </div>
        </div>
    </form>
</div>
<script src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js" type="application/javascript"></script>
<#--渲染表格模板-->
<script type="text/template" id="markerPaperUser">
    <table class="pe-stand-table pe-stand-table-default checkbox-table">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%if(peData.tableTitles[i].order){%>
                    <div class="pe-th-wrap" data-type="startTime">
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
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ;j++){%>
            <tr data-index="<%=j%>">
                <td>
                    <div class="pe-ellipsis" title=""><%=peData.rows[j].userName%></div>
                </td>
                <#--用户名-->
                    <td>
                        <div class="pe-ellipsis" title=""><%=peData.rows[j].loginName%></div>
                    </td>
                <#--工号-->
                    <td>
                        <div class="pe-ellipsis" title=""><%=peData.rows[j].employeeCode%></div>
                    </td>
                <#--手机号-->
                    <td>
                        <div class="pe-ellipsis" title=""><%=peData.rows[j].mobile%></div>
                    </td>
                <#--岗位-->
                <td>
                    <div class="pe-ellipsis" title=""><%=peData.rows[j].positionName%></div>
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
        /*自定义主体表格头部数量及宽度*/
        var peTableTitle = [
            {'title': '姓名', 'width': 18},
            {'title': '用户', 'width': 18},
            {'title': '工号', 'width': 18},
            {'title': '手机号', 'width': 18},
            {'title': '岗位', 'width': 28}
        ];
        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/uc/user/manage/searchByOrganize',
            formParam: $('#selectorSubjectForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'markerPaperUser',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle, //表格头部的数量及名称数组;
            pagination: 'layer',
            onLoad: function () {
//                $('.pe-stand-table-main-panel').css({'height':'585px','overflow':'auto'});
                PEBASE.peFormEvent('checkbox');
            }
        });

    });


</script>
</body>
</html>