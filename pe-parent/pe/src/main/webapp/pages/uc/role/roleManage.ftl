<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">用户</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">角色管理</li>
    </ul>
    <a href="javascript:;" style="float: right" class="role-view-user-btn pe-view-user-btn"><span></span>按人员查看
    </a>
</div>
<div class="pe-test-question-manage">
    <form name="peFormSub" id="peFormSub">
    <#--树状布局开始,可复用,记得调用下面的初始化函数;-->
    <#--树状布局 结束,可复用-->
    <#--右侧表格主题部分开始-->
        <div class="pe-manage-content-right" style="margin:0;">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                        <#if superAdmin?? && superAdmin>
                            <button type="button" class="pe-btn pe-btn-green pe-new-question-btn">新增角色</button>
                        </#if>
                    <#--<span class="pe-table-tip floatR">共有<span class="pe-table-number-tip" id="showKnowledgeTotal">0</span>条记录</span>-->
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
</div>


<#--右侧表格主题部分结束-->
<#--渲染表格模板-->
<script type="text/template" id="peQuestionTableTep">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i<lenI;i++){%>
            <%if(peData.tableTitles[i].title === 'checkbox') {%>
            <th style="width:<%=peData.tableTitles[i].width%>%">
                <label class="pe-checkbox pe-paper-all-check">
                    <span class="iconfont icon-unchecked-checkbox"></span>
                    <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheckAll"/>
                </label>
            </th>
            <%}else{%>
            <th style="width:<%=peData.tableTitles[i].width%>%">
                <%=peData.tableTitles[i].title%>
            </th>
            <%}%>
            <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
        <tr data-id="<%=peData.rows[j].id%>">
        <#--角色名称-->
            <td>
                <a href="/pe/uc/role/manage/roleDetail?roleId=<%=peData.rows[j].id%>" target="_blank">
                    <div class="pe-ellipsis pe-dark-font" title="<%=peData.rows[j].roleName%>"
                         data-id="<%=peData.rows[j].id%>"><%=peData.rows[j].roleName%>
                    </div>
                </a>
            </td>
        <#--角色描述-->
            <td><div class="pe-ellipsis" title="<%=peData.rows[j].comments%>"><%=peData.rows[j].comments%></div></td>
        <#--操作-->
            <td>
                <div class="pe-stand-table-btn-group">
                    <button type="button" class="pe-icon-btn iconfont icon-member memberManage" title="成员管理"
                            data-id="<%=peData.rows[j].id%>"></button>
                    <#if superAdmin?? && superAdmin>
                    <button type="button" class="pe-icon-btn iconfont icon-authority authSetting" title="权限设置"
                            data-id="<%=peData.rows[j].id%>"></button>
                        <%if(peData.rows[j].canEdit){%>
                    <button type="button" class="pe-icon-btn iconfont icon-edit editRole" title="编辑"
                            data-id="<%=peData.rows[j].id%>"></button>
                    <button type="button" class="pe-icon-btn iconfont icon-delete deleteRole" title="删除"
                          data-id="<%=peData.rows[j].id%>"></button>
                        <%}%>
                    </#if>
                </div>
            </td>
        </tr>
        <%}%>
        <%}else{%>
        <tr class="pe-stand-tr">
            <td class="pe-stand-td pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
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
        /*自定义表格头部数量及宽度*/
        //宽度单位为百分比！
        var peTableTitle = [
            {'title': '角色名称', 'width': 40},
            {'title': '角色描述', 'width': 40},
            {'title': '操作', 'width': 14}
        ];

        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/uc/role/manage/search',
            formParam: $('#peFormSub').serializeArray(),//表格上方表单的提交参数
            tempId: 'peQuestionTableTep',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle, //表格头部的数量及名称数组;
            onLoad: function () {
                //删除人员
                $('.pe-stand-table-wrap').delegate('.deleteRole','click',function(){
                    var roleId = $(this).data("id");
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要删除该角色吗？</h3><p class="pe-dialog-content-tip">删除后，相关人员的权限将被影响，请谨慎操作！</p></div>',
                        btn2: function () {
                            $.post(pageContext.rootPath + '/uc/role/manage/delete', {'id': roleId}, function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '删除成功',
                                        time: 3000,
                                        end:function(){
                                            $('.pe-stand-table-wrap').peGrid('refresh');
                                        }
                                    });
                                    return false;
                                }

                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn:['我知道了'],
                                    yes:function(){
                                        layer.closeAll();
                                    }
                                });
                            }, 'json');
                        },
                        btn1:function(){
                            layer.closeAll();
                        }
                    });
                });

                //编辑人员
                $('.pe-stand-table-wrap').delegate('.editRole', 'click', function () {
                    var roleId = $(this).attr("data-id");
                    location.href = '#url='+pageContext.rootPath + '/uc/role/manage/editRole?roleId='+ roleId + '&nav=user';

                });

                //权限设置
                $('.pe-stand-table-wrap').delegate('.authSetting', 'click', function () {
                    var roleId = $(this).attr("data-id");
                    location.href = '#url='+pageContext.rootPath + '/uc/role/manage/editAuth?roleId='+ roleId + '&nav=user';
                });

                //成员管理
                $('.pe-stand-table-wrap').delegate('.memberManage', 'click', function () {
                    var roleId = $(this).attr("data-id");
                    PEMO.DIALOG.selectorDialog({
                        title: '成员管理',
                        content: [pageContext.rootPath + '/uc/role/manage/memberManage?roleId=' + roleId, 'no'],
                        area: ['940px', '610px'],
                        end: function () {
                        }
                    });
                });
            }
        });

        $('.pe-new-question-btn').click(function () {
            location.href = '#url='+pageContext.rootPath + '/uc/role/manage/addRole'+"&nav=user";
        });

        /*按人员查看*/
        $('.pe-view-user-btn').click(function () {
            location.href = '#url='+pageContext.rootPath + '/uc/role/manage/toViewRoleByUser'+"&nav=user";
        });
    });
</script>