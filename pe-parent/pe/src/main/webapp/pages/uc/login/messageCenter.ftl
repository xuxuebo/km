<div class="exam-manage-all-wrap user-message-center-wrap user-main-right-panel" style="background:#fff;">
    <form id="examManageForm">
        <div class="">
            <div class="pe-stand-table-panel" style="border-top:none;">
                <div class="pe-stand-table-top-panel">
                    <span class="pe-checkbox pe-paper-all-check" style="padding-right: 20px;color:#666;">
                        <span class="iconfont icon-unchecked-checkbox"></span>&nbsp;全部
                        <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheckAll">
                    </span>
                    <button type="button" class="pe-btn pe-btn-green" id="batchReadDom">标记已读</button>
                    <button type="button" class="pe-btn pe-btn-primary " id="batchDeleteDom">删除</button>
                </div>
            <#--表格包裹的div-->
                <div class="pe-stand-table-main-panel">
                    <div class="pe-stand-table-wrap"></div>
                    <div class="pe-stand-table-pagination"></div>
                </div>
            </div>
        </div>
    </form>
</div>
<script type="text/template" id="peExamManaTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr style="height:1px;padding:0;">
            <th style="width:5%;padding:0;height:0"></th>
            <th style="width:62%;padding:0;height:0"></th>
            <th style="width:14%;padding:0;height:0"></th>
            <th style="width:7%;padding:0;height:0"></th>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%_.each(peData.rows,function(message){%>
        <tr data-id="<%=message.id%>" class="pe-message-table">
            <td>
                <label class="pe-checkbox pe-paper-check" data-id="<%=message.id%>">
                    <span class="iconfont icon-unchecked-checkbox"></span>
                    <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheck"/>
                </label>
            </td>
        <#--考试名称-->
            <td title="<%=message.content%>" class="message-content-cla<%if(message.read){%> pe-massage-table-con<%}%>"
                data-id="<%=message.id%>"
                style="padding-right: 25px!important;cursor: pointer;">
                <%if(!message.read){%><i class="iconfont icon-tree-dot pe-message-dot"></i><%}%><%=message.content%>
            </td>
            <td width="15%">
                <div class="pe-ellipsis">
                    <%=moment(message.createTime).format('YYYY-MM-DD HH:mm')%>
                </div>
            </td>
            <td>
                <div class="pe-stand-table-btn-group">
                    <button type="button" title="标记已读"
                            class="copy-btn pe-btn pe-icon-btn iconfont icon-mark-read pe-mark-read"
                    <%if(message.read){%>disabled<%}%>
                    data-id="<%=message.id%>">
                    </button>
                    <button type="button" class="delete-btn pe-icon-btn iconfont icon-delete pe-message-delete"
                            title="删除"
                            data-id="<%=message.id%>"></button>
                </div>
            </td>
        </tr>
        <%});%>
        <%}else{%>
        <tr>
            <td class="pe-td pe-stand-table-empty" colspan="4">
                <div class="pe-result-no-date"></div>
                <p class="pe-result-date-warn">暂无消息</p>
            </td>
        </tr>
        <%}%>
        </tbody>
    </table>
</script>
<script>
    $(function () {
        userControl.msgCenter.init();
    })
</script>
