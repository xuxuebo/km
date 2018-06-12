<#assign ctx=request.contextPath/>
<#--todo开发开始做这个页面的跳转时记得把下面的import和p.pageFrame删除-->
<#import "../../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header">
    <input type="hidden" name="comExam" value="comExam"/>
    <#if examArrange.optType?? && examArrange.optType =='VIEW'>
        <h3 class="paper-add-accredit-title">考试详情·已添加组织
            <a href="${ctx!}/ems/exam/manage/initUserPage?id=${(examArrange.id)!}&optType=${(examArrange.optType)!}"
               class="bank-item-nav-link preview-paper-analysis-btn floatR" style="margin-left:18px;font-weight:normal;color:#fff;">
                <span class="iconfont preview-paper-analysis-icon icon-show-analysis"></span>查看已添加人员</a>
        </h3>

    <#else >
        <h3 class="paper-add-accredit-title">添加考生</h3>
    </#if>
</div>
<section class="exam-add-member-all-wrap">
    <div class="pe-manage-content-right" style="padding-top: 10px;">
        <div class="pe-manage-panel pe-manage-default">
            <div class="pe-stand-table-panel" style="border: 0;">
                <#if !((examArrange.optType?? && examArrange.optType =='VIEW') || (noCanAddUser?? && noCanAddUser))>
                    <div class="pe-stand-table-top-panel" style="padding-left: 0;">
                        <button type="button" class="pe-btn pe-btn-green add-org">添加组织</button>
                        <#if !(arrangeStatus?? && arrangeStatus =='PROCESS')>
                            <button type="button" class="pe-btn pe-btn-primary remove-org">移除</button>
                        </#if>
                        <#--<button type="button" class="pe-btn pe-btn-primary">导出考生信息</button>-->
                        <a class="add-member-btn"
                           href="${ctx!}/ems/exam/manage/initUserPage?id=${(examArrange.id)!}&exam.id=${(examArrange.exam.id)!}">
                            <span class="iconfont icon-add-by-user"></span>
                            &nbsp;按人员添加
                        </a>
                    <#--<span class="pe-table-tip floatR">共有<span class="pe-table-number-tip" id="showKnowledgeTotal">0</span>条记录</span>-->
                    </div>
                <#else>
                <div class="pe-stand-table-top-panel" style="padding-left: 0;"></div>
                </#if>
            <#--表格包裹的div-->
                <div class="pe-stand-table-main-panel">
                    <div class="pe-stand-table-wrap"></div>
                    <div class="pe-stand-table-pagination"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="exam-add-members-btns">
        <button type="button" class="pe-btn pe-btn-blue pe-large-btn pe-view-question-close-btn">关闭</button>
    </div>
    <form id="orgForm">
        <input type="hidden" name="id" value="${(examArrange.id)!}"/>
        <input type="hidden" name="exam.id" value="${(examArrange.exam.id)!}"/>
    </form>
</section>
<#--渲染表格模板-->
<script type="text/template" id="examAddMemberTemp">
    <table class="pe-stand-table pe-stand-table-default checkbox-table">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <%if(peData.tableTitles[i].title === 'checkbox'){%>
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
        <#--<tr class="pe-stand-bg"></tr>-->
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j
        <lenJ ;j++){%>
            <tr data-index="<%=j%>">
                <%if(peData.tableTitles[0].title === 'checkbox'){%>
                <td>
                    <label class="pe-checkbox pe-paper-check" data-id="<%=peData.rows[j].organize.id%>">
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheck"/>
                    </label>
                </td>
                <%}%>
            <#--部门名称-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].organizeName%>"><%=peData.rows[j].organize.namePath%></div>
                </td>
            <#--部门下人数-->
                <td>
                    <a href="javascript:;" class="pe-ellipsis organize-user-count" title="<%=peData.rows[j].userCount%>"
                        data-id="<%=peData.rows[j].organize.id%>"><%=peData.rows[j].organize.userCount?peData.rows[j].organize.userCount:'0'%></a>
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
        $('.exam-add-member-all-wrap').css({'minHeight':(window.innerHeight - 64 -60-6)});
        var arrangeId = '${(examArrange.id)!}';
        var examId = '${(examArrange.exam.id)!}';
        var batchUserManage = {
            initData: function () {
                /*自定义表格头部数量及宽度*/
            <#if !((examArrange.optType?? && examArrange.optType =='VIEW') || (noCanAddUser?? && noCanAddUser))>
                var peTableTitle = [
                    {'title': 'checkbox', 'width': 4},
                    {'title': '部门名称', 'width': 70},
                    {'title': '部门下的考生人数', 'width': 26}
                ];
            <#else>
                peTableTitle = [
                    {'title': '部门名称', 'width': 70},
                    {'title': '部门下的考生人数', 'width': 30}
                ];
            </#if>


                /*表格生成*/

                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/exam/manage/searchSelectOrg',
                    formParam:$('#orgForm').serialize(),
                    tempId: 'examAddMemberTemp',//表格模板的id
                    showTotalDomId: 'showTotal',
                    title: peTableTitle
                });

            },

            init: function () {
                $('.add-org').on('click',function(){
                    PEMO.DIALOG.selectorDialog({
                        title: '按部门添加',
                        area: ['870px', '500px'],
                        content: [pageContext.rootPath + '/ems/exam/manage/initSelectorOrg?id=' + arrangeId + '&exam.id=' + examId, 'no'],
                        btn: ['关闭'],
                        btn1: function (index) {
                            layer.close(index);
                            $('.pe-stand-table-wrap').peGrid('load', $('#orgForm').serializeArray());
                            window.opener.countUser(arrangeId,'ORGANIZE');
                        }
                    });
                });
                /*关闭按钮事件*/
                $('.pe-view-question-close-btn').on('click', function () {
                    window.close();
                });

                $('.pe-question-choosen-btn').on('click',function(){
                    $('.pe-stand-table-wrap').peGrid('load',$('#orgForm').serializeArray());
                });

                $('.remove-org').on('click',function(){
                    var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                    if (!rows || rows.length <= 0) {
                        PEMO.DIALOG.alert({
                            content: '请至少先选择一个部门！',
                            btn:['我知道了'],
                            yes:function(){
                                layer.closeAll();
                            }
                        });

                        return false;
                    }

                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要移除选中部门么？</div>',
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/exam/manage/deleteExamUser',
                                data: {
                                    'id': arrangeId,
                                    'exam.id': examId,
                                    'referIds': JSON.stringify(rows)
                                },
                                success: function (data) {
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '移除成功',
                                            time: 1000,
                                            end: function () {
                                                $('.pe-stand-table-wrap').peGrid('load',$('#orgForm').serializeArray());
                                                window.opener.countUser(arrangeId,'ORGANIZE');
                                            }
                                        });
                                        return false;
                                    } else {
                                        PEMO.DIALOG.tips({
                                            content: data.message,
                                            time: 2000
                                        });
                                    }
                                }
                            });
                        },
                        btn1: function () {
                            layer.closeAll();
                        }
                    });
                });
            }
        };

        $('.pe-stand-table-wrap').delegate('.organize-user-count', 'click', function () {
            var organizeId = $(this).attr('data-id');
            var userCount = $(this).text();
            var namePath = $(this).parent().prev().children().text();
            var data = {id:organizeId,userCount:userCount,namePath:namePath};
            PEMO.DIALOG.selectorDialog({
                content: [pageContext.rootPath + '/ems/exam/manage/initOrganizeUserPage?id='+organizeId+'&userCount='+userCount+ '&namePath='+namePath,'no'],
                skin: 'pe-add-exam-dialog view-organize-exam-users',
                needPagination:true,
                area: ['900px', '585px'],
                btn:['关闭']
            });
        });

        batchUserManage.init();
        batchUserManage.initData();
    })
</script>
</@p.pageFrame>