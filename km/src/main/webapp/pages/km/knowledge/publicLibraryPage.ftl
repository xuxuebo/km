<#assign ctx=request.contextPath/>

<section class="exam-manage-all-wrap">
    <form id="examManageForm">
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">

                <input type="hidden" name="subject" value="false">
                <input type="hidden" name="libraryId" value="${libraryId!}">

                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">

                        <button type="button" class="pe-btn pe-btn-green create-online-btn">下载</button>

                        <button type="button" class="pe-btn pe-btn-green offline-btn">复制到我的云库</button>
                    </div>

                    <div class="pe-stand-table-main-panel">
                        <div class="pe-stand-table-wrap"></div>
                        <div class="pe-stand-table-pagination"></div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</section>
<#--渲染表格模板-->
<script type="text/template" id="publicTableTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>

        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
            <#--<tr data-id="<%=peData.rows[j].id%>">

                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].knowledgeName%>"><%=peData.rows[j].knowledgeName%></div>
                </td>
            </tr>-->

            <tr class="y-table__tr" data-id="<%=peData.rows[j].id%>">
                <td class="y-table__td checkbox">
                    <label class="y-checkbox">
                        <input type="checkbox">
                        <span class="y-checkbox__span"></span>
                    </label>
                </td>
                <td class="y-table__td name">
                    <div class="y-table__opt__bar">
                        <button type="button" title="点击下载" data-id="<%=peData.rows[j].id%>" class="yfont-icon opt-item js-opt-download">&#xe64f;</button>
                        <button type="button" title="分享" data-id="<%=peData.rows[j].id%>" class="yfont-icon opt-item js-opt-share">&#xe652;</button>
                        <button type="button" title="删除" data-id="<%=peData.rows[j].id%>" class="yfont-icon opt-item js-opt-delete">&#xe652;</button>
                    </div>
                    <div class="y-table__filed_name type-<%=peData.rows[j].knowledgeType%>">
                        <%=peData.rows[j].knowledgeName%>
                    </div>
                </td>
                <td class="y-table__td size">
                    <%=peData.rows[j].knowledgeSize%>
                </td>
                <td class="y-table__td upload-time">
                    <%=peData.rows[j].createTime%>
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
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        var peTableTitle = [
            {'title': 'checkbox', 'width': 5},
            {'title': '文件名', 'width': 20, 'type': ''},
            {'title': '大小',  'width': 15},
            {'title': '上传日期', 'width': 5}
        ];

        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/knowledge/publicLibraryData',
            formParam: $('#examManageForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'publicTableTemp',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle //表格头部的数量及名称数组;
        });


        //复制
        $('.pe-stand-table-wrap').delegate('.stop-arrange-btn', 'click', function () {
            var id = $(this).data('id');
            var type = $(this).data('type');
            var text;
            if (type === 'BATCH') {
                text = '确定作废该批次的考试么？？';
            } else {
                text = '确定作废该科目的考试么？';
            }
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">' + text + '</h3><p class="pe-dialog-content-tip">作废后，不可以恢复，请谨慎操作。 </p></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/cancelArrange',
                        data: {'arrangeId': id},
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '作废成功',
                                    time: 1000,
                                    end: function () {
                                        $('.pe-stand-table-wrap').peGrid('refresh');
                                    }
                                });
                                return false;
                            }
                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function () {
                                    layer.closeAll();
                                }
                            })
                        }
                    });
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });







    })

</script>