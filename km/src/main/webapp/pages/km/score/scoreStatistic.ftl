<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">

</div>
<section class="exam-manage-all-wrap">
    <form id="scoreManageForm">
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel" style="float: left;">
                        <button type="button" class="pe-btn pe-btn-green create-exercise-btn">积分规则</button>
                    </div>
                    <div class="pe-stand-table-top-panel">
                        <input type="text" class="pe-tree-form-text" name="codeAndName" placeholder="工号/姓名/用户名"
                               style="border: 1px solid #ccc;margin: -3px 0 0 10px;border-radius: 20px;width: 280px;">
                    </div>
                    <div class="clear"></div>
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
            <tr data-id="<%=peData.rows[j].userId%>">
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].employeeCode%>"><%=peData.rows[j].employeeCode%>
                    </div>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].userName%>"><%=peData.rows[j].userName%>
                    </div>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].loginName%>"><%=peData.rows[j].loginName%>
                    </div>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].organizeName%>"><%=peData.rows[j].organizeName%>
                    </div>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].score%>"><%=peData.rows[j].score%>
                    </div>
                </td>
                <td>
                    <div class="pe-stand-table-btn-group">
                        <button type="button" class="edit-btn pe-icon-btn iconfont icon-view-detail" title="积分明细"
                                data-id="<%=peData.rows[j].userId%>"></button>
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

<script type="text/template" id="confirmDialogUpdate">
    <div>
        <form id="library_detail_update_form">
            <input type="hidden" name="id" value="<%=data.id%>">
            <input type="hidden" name="code" value="<%=data.code%>">
            <div class="pe-add-question-text">
                <span class="pe-label-name floatL introduction-info">规则名称:</span>
                <input class="pe-stand-filter-form-input" maxlength="50" type="text"
                       placeholder="请输入规则名称" name="name" value="<%=data.name%>">
            </div>
            <div class="pe-add-question-text">
                <span class="pe-label-name floatL introduction-info">规则分值:</span>
                <input class="pe-stand-filter-form-input" max="1000" type="number"
                       placeholder="请输入规则分值" name="score" value="<%=data.score%>">
            </div>
        </form>
        <div class="pe-main-km-text-wrap">
            <div class="pe-km-search-key pe-input-tree-wrap pe-stand-filter-form-input" style="display: none">

            </div>
        </div>
    </div>
</script>

<script>
    $(function () {
        var peTableTitle = [
            {'title': '工号', 'width': 20},
            {'title': '姓名', 'width': 20},
            {'title': '用户名', 'width': 20},
            {'title': '部门', 'width': 20},
            {'title': '积分值', 'width': 10},
            {'title': '操作', 'width': 10}
        ];

        var exerciseManage = {
            init: function () {
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/score/manage/searchStatistic',
                    formParam: $('#scoreManageForm').serializeArray(),
                    tempId: 'peExerManaTemp',
                    showTotalDomId: 'showTotal',
                    title: peTableTitle
                });
                var _this = this;
                _this.bind();
            },

            bind: function () {
                $(".pe-tree-form-text").keyup(function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    var thisSearchVal = $.trim($(this).val());
                    if (e.keyCode === 13 || e.keyCode === 108 || !thisSearchVal) {
                        $('.pe-stand-table-wrap').peGrid('load', $('#scoreManageForm').serializeArray());
                    }
                });

                $('.create-exercise-btn').on('click', function () {
                    parent.$('#yunContentBody').html('<iframe style="width:100%;height: 100%;margin-left:0;" src="/km/front/manage/initPage#url=/km/score/manage/scoreRule"></iframe>');
                });

                $('.pe-stand-table-main-panel').delegate('.edit-btn', 'click', function () {
                    var id = $(this).data("id");
                    parent.$('#yunContentBody').html('<iframe style="width:100%;height: 100%;margin-left:0;" src="/km/front/manage/initPage#url=/km/score/manage/scoreDetail?userId=' + id + '"></iframe>');
                })

            }
        };
        exerciseManage.init();
    })

</script>
<link rel="stylesheet" href="${resourcePath!}/web-static/proExam/index/css/index.css">