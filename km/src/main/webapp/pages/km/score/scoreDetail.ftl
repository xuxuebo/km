<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">

</div>
<section class="exam-manage-all-wrap">
    <form id="scoreManageForm">
        <input type="hidden" name="userId" value="${userId!}">
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                        <button type="button" class="pe-btn pe-btn-green create-exercise-btn">返回</button>
                    </div>
                <#--表格包裹的div-->
                    <div class="pe-stand-table-main-panel">
                        <div class="pe-stand-table-wrap"></div>
                        <div class="pe-stand-table-pagination"></div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</section>
<script type="text/template" id="peExerManaTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%if(peData.tableTitles[i].order){%>
                    <div class="pe-th-wrap">
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
            <tr>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].ruleName%>"><%=peData.rows[j].ruleName%>
                    </div>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].knowledgeName%>"><%=peData.rows[j].knowledgeName%>
                    </div>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].score%>"><%=peData.rows[j].score%>
                    </div>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].userName%>"><%=peData.rows[j].userName%>
                    </div>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].createTimeStr%>"><%=peData.rows[j].createTimeStr%>
                    </div>
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
        $('.create-exercise-btn').on('click', function () {
            parent.$('#yunContentBody').html('<iframe style="width:100%;height: 100%;margin-left:0;" src="/km/front/manage/initPage#url=/km/score/manage/initPage"></iframe>');
        });

        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/score/manage/searchDetail',
            formParam: $('#scoreManageForm').serializeArray(),
            tempId: 'peExerManaTemp',
            showTotalDomId: 'showTotal',
            title: [
                {'title': '积分类型', 'width': 25},
                {'title': '知识名称', 'width': 30},
                {'title': '积分值', 'width': 10},
                {'title': '操作人', 'width': 20},
                {'title': '操作时间', 'width': 15}
            ]
        });
    })

</script>
<link rel="stylesheet" href="${resourcePath!}/web-static/proExam/index/css/index.css">