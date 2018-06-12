<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header">
    <h3 class="paper-add-accredit-title" ></h3>
</div>
    <div class="pe-manage-content-right paper-add-accredit-wrap" style="background-color:#f4f6f9;">
        <div class="pe-manage-panel pe-manage-default" style="min-height:647px;background:#fff;">
            <div class="pe-stand-table-panel">
                <div class="pe-stand-table-top-panel" style="height:72px;">
                    <button type="button" class="pe-btn pe-btn-green">添加授权</button>
                    <button type="button" class="pe-btn pe-btn-primary pe-paper-accredit-all-btn">移除</button>
                    <p class="pe-add-user-tip-text">已授权以下人员可以使用</p>
                </div>
            <#--表格包裹的div-->
                <div class="pe-stand-table-main-panel">
                    <div class="pe-stand-table-wrap"></div>
                    <div class="pe-stand-table-pagination"></div>
                    <input type="hidden" name="paperTemplateAuth.id" >
                </div>
            </div>
        </div>
    </div>
<#--渲染表格模板-->
<script type="text/template" id="paperAccreditUser">
    <table class="pe-stand-table pe-stand-table-default checkbox-table">
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
                <td>
                    <label class="<%if (peData.rows[j].canDelete) {%>pe-checkbox<%} else {%>disabled-click<%}%> pe-paper-check" data-id="<%=peData.rows[j].user.id%>">
                        <span class="iconfont icon-unchecked-checkbox" <%if (!peData.rows[j].canDelete) {%>style="font-size: 14px;"<%}%>></span>
                        <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheck"/>
                    </label>
                </td>
            <#--姓名-->
                <td>
                    <div class="pe-ellipsis <%if(peData.rows[j].createTemplate){%>
                    icon-top-secret-icon <%}%>" title="<%=peData.rows[j].user.userName%>">
                        <%=peData.rows[j].user.userName%>
                    </div>
                </td>
            <#--手机号-->
                <td><%=peData.rows[j].user.mobile%></td>
            <#--部门-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].user.organize.organizeName%>">
                        <%=peData.rows[j].user.organize.organizeName%>
                    </div>
                </td>
            <#--岗位-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].user.positionName%>">
                        <%=peData.rows[j].user.positionName%>
                    </div>
                </td>
            <#--状态-->
            <#--hover才会出现的移除-->
                <td>
                    <%if(!peData.rows[j].createTemplate){%>
                    <div class="pe-stand-table-btn-group">
                        <button type="button" class="pe-paper-accredit-btn pe-icon-btn iconfont icon-delete" title=""
                              data-id="<%=peData.rows[j].user.id%>" style="display: block;"></button>
                    </div>
                    <%}%>
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
    $(function(){
        //可在这里请求得到试卷的名称，或者参数传过来
        $('.paper-add-accredit-title').html('${(template.paperName)!}');
        var templateId = '${(template.id)!}';
        /*自定义表格头部数量及宽度*/
        var peTableTitle = [
            {'title': 'checkbox', 'width': 4},
            {'title': '姓名', 'width':20},
            {'title': '手机号', 'width': 20},
            {'title': '部门', 'width': 20},
            {'title': '岗位', 'width': 20},
            {'title': '操作', 'width': 10}
        ];
        var formData = {
            'paperTemplateId': templateId
        };
        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/ems/template/manage/searchAuth',
            formParam: formData,//表格上方表单的提交参数
            tempId: 'paperAccreditUser',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle, //表格头部的数量及名称数组;
            onLoad:function(){

            }
        })//peGrid结束

        $('.pe-btn-green').on('click',function(){
            PEMO.DIALOG.selectorDialog({
                title:'试卷授权',
                area: ['900px', '590px'],
                content:[pageContext.rootPath+'/ems/template/manage/toAuthorize?id='+templateId,'no'],
                end:function(){
                    $('.pe-stand-table-wrap').peGrid('refresh');
                }
            });
        });

        //单个移除试卷人员权限
        $('.pe-stand-table-wrap').delegate('.pe-paper-accredit-btn', 'click', function () {
            var userId = $(this).attr('data-id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定移除选中的人员么？</h3></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/template/manage/deleteAuth',
                        data: {paperTemplateId: templateId, userId: userId},
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '移除成功',
                                    time: 1000,
                                    end: function () {
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
                            })
                        }
                    });
                },
                btn1: function () {
                    layer.closeAll();
                }
            })
        });

        //批量移除授权人员
        $('.pe-btn-primary').on('click', function () {
            var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
            if (!rows || rows.length <= 0) {
                PEMO.DIALOG.alert({
                    content: '请至少先选择一位人员！',
                    btn:['我知道了'],
                    yes:function(){
                        layer.closeAll();
                    }
                });

                return false;
            }

            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定移除选中的人员么？</h3></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/template/manage/deleteAuths',
                        data: {paperTemplateId: templateId, userId: JSON.stringify(rows)},
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '移除成功',
                                    time: 1000,
                                    end: function () {
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
                            })
                        }
                    });
                },
                btn1: function () {
                    layer.closeAll();
                }
            })
        });
    })
</script>
</@p.pageFrame>