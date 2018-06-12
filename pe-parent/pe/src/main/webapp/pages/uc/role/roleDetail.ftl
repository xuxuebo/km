<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header">
    <h3 class="paper-add-accredit-title" >角色详情</h3>

</div>
<section class="pe-all-panel paper-view-role-detail-wrap">
    <form id="addUserForm">
        <div class="role-detail-view-wrap">
            <span class="floatL role-veiw-label">角色名称:</span>
            <div class="">${(role.roleName)!''}</div>
        </div>
        <div class="role-detail-view-wrap">
           <span class="role-veiw-label floatL">角色描述:</span>
            <div class="role-view-detail-wrap ">${(role.comments)!''}</div>
        </div>
        <div class="role-detail-view-wrap">
            <span class="role-veiw-label floatL">角色权限:</span>
            <div class="role-tree-wrap" style="margin-left:70px;">
                <ul id="peZtreeMain" class="ztree pe-tree-container pe-no-manage-tree add-role-tree-container"
                    data-type="km"></ul>
            </div>
        </div>
        <div class="role-detail-view-wrap" style="margin-bottom:10px;">
            <div class="role-veiw-label">角色成员:</div>
        </div>
        <div class="role-detail-view-wrap">
        <#--表格包裹的div-->
            <div class="pe-stand-table-main-panel">
                <div class="pe-stand-table-wrap"></div>
                <div class="pe-stand-table-pagination"></div>
                <input type="hidden" name="paperTemplateAuth.id" >
            </div>
        </div>
        <div class="pe-add-paper-step-btns" style="text-align:center;">
            <button type="button" class="pe-btn pe-btn-blue pe-preview-close-btn">关闭</button>
        </div>
    </form>
</section>
<#--渲染表格模板-->
<script type="text/template" id="paperAccreditUser">
    <table class="pe-stand-table pe-stand-table-default checkbox-table">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i<lenI;i++){%>
            <th style="width:<%=peData.tableTitles[i].width%>%">
                <%=peData.tableTitles[i].title%>
            </th>
            <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
            <tr data-id="<%=peData.rows[j].id%>">
            <#--姓名-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].userName%>">
                        <%=peData.rows[j].userName%>
                    </div>
                </td>
            <#--用户名-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].loginName%>">
                        <%=peData.rows[j].loginName%>
                    </div>
                </td>
            <#--工号-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].employeeCode%>">
                        <%=peData.rows[j].employeeCode%>
                    </div>
                </td>
            <#--手机号-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].mobile%>">
                        <%=peData.rows[j].mobile%>
                    </div>
                </td>
            <#--岗位-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].positionName%>">
                        <%=peData.rows[j].positionName%>
                    </div>
                </td>
            <#--状态-->
                <td>
                    <div class="pe-ellipsis" title="">
                        <%if(peData.rows[j].status == "ENABLE"){%>
                        启用
                        <%}else if(peData.rows[j].status == "FORBIDDEN"){%>
                        冻结
                        <%}else{%>
                        删除
                        <%}%>
                    </div>
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
<script type="text/javascript">
    $(function(){
        /*自定义表格头部数量及宽度*/
        var peTableTitle = [
            {'title': '姓名', 'width': 15},
            {'title': '用户名', 'width': 15},
            {'title': '工号', 'width': 15},
            {'title': '手机号', 'width': 16},
            {'title': '岗位', 'width': 20},
            {'title': '状态', 'width': 10}
        ];
        var roleId = '${(role.id)!''}';
        var formData = {
            'roleId': roleId
        };
        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/uc/role/manage/searchSelectUser',
            formParam: formData,//表格上方表单的提交参数
            tempId: 'paperAccreditUser',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle, //表格头部的数量及名称数组;
            onLoad:function(){

            }
        })//peGrid结束

        /*节点树*/
        var settingInputTree = {
            isCheckbox: true,
            isCheckBoxCanEdit:true,//如果让整个checkbox树不可点击,设置此值为true
            dataUrl: pageContext.rootPath + '/uc/role/manage/listAuthTree?roleId=' + roleId,
            clickNode:function(treeNode){
            },
            saveChecked:function(zTree){
                //执行点击保存按钮获取所选择的所有节点;
            },
            width:518
        };
        PEMO.ZTREE.initTree('peZtreeMain', settingInputTree);

        $('.pe-preview-close-btn').click(function () {
            window.close();
        });
    })
</script>
</@p.pageFrame>