<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">科目管理</li>
    </ul>
</div>
<section class="subject-manage-all-wrap">
    <form id="examManageForm">
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-manage-panel-head" style="padding: 32px 0 14px 22px;">
                    <div class="pe-stand-filter-form">
                        <div class="pe-stand-form-cell" style="margin-top: -18px;height: 30px;">
                            <label class="pe-form-label floatL" for="peMainKeyText">
                                <span class="pe-label-name floatL">关键字:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="科目名称/编号"
                                       name="examKey">
                            </label>
                            <label class="pe-form-label " for="peMainKeyText" style="margin-right: 26px;">
                                <span class="pe-label-name floatL">创建人:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="姓名/用户名/工号/手机号"
                                       name="createUser">
                            </label>
                        </div>
                        <div class="pe-stand-form-cell">
                            <dl class="over-flow-hide floatL" style="margin-left:0;">
                                <dt class="pe-label-name">类&nbsp;&nbsp;&nbsp;型:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class=" pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                        <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examTypes" value="ONLINE"/>线上
                                    </label>
                                    <label class=" pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examTypes" value="OFFLINE"/>线下
                                    </label>
                                </dd>
                            </dl>
                            <dl class="over-flow-hide" style="margin-left:147px;">
                                <dt class="pe-label-name">状&nbsp;&nbsp;&nbsp;态:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                        <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examStatus" value="ENABLE"/>启用
                                    </label>
                                    <label class="pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="examStatus" value="DRAFT"/>草稿
                                    </label>
                                    <label class="pe-checkbox" style="margin-right:15px;">
                                        <span class="iconfont icon-unchecked-checkbox"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" type="checkbox"
                                               name="examStatus" value="DISABLE"/>停用
                                    </label>
                                </dd>
                            </dl>
                        </div>
                        <button type="button" class="pe-btn floatL pe-btn-blue pe-question-choosen-btn">筛选</button>
                        <input class="pe-form-ele" type="hidden" name="includeCreator" value="false">
                    </div>
                </div>
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                    <@authVerify authCode="EXAM_SUBJECT_ADD_ONLINE"><button type="button" class="pe-btn pe-btn-green online-btn">创建线上科目</button></@authVerify>
                    <@authVerify authCode="EXAM_SUBJECT_ADD_OFFLINE"><button type="button" class="pe-btn pe-btn-primary offline-btn">创建线下科目</button></@authVerify>
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
<#--渲染表格模板-->
<#--渲染表格模板-->
<script type="text/template" id="peExamManaTemp">
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
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
            <tr data-id="<%=peData.rows[j].id%>">
            <#--考试编号-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].examCode%>"><%=peData.rows[j].examCode%></div>
                </td>
            <#--考试名称-->
                <td>
                    <a href="javascript:;" class="pe-stand-table-alink pe-dark-font pe-ellipsis">
                        <div class="pe-ellipsis exam-batch-td view-exam" title="<%=peData.rows[j].examName%>"
                             data-id="<%=peData.rows[j].id%>"><%=peData.rows[j].examName%>
                        </div>
                    </a>
                </td>
            <#--试卷类型-->
                <%if(peData.rows[j].examType === 'ONLINE'){%>
                <td>线上</td>
                <%}else if(peData.rows[j].examType === 'OFFLINE'){%>
                <td>线下</td>
                <%}else {%>
                <td></td>
                <%}%>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].createBy%>"><%=peData.rows[j].createBy%></div>
                </td>
            <#--状态-->
                <%if(peData.rows[j].status === 'DRAFT'){%>
                <td>草稿</td>
                <%}else if(peData.rows[j].status === 'ENABLE'){%>
                <td>启用</td>
                <%}else if(peData.rows[j].status === 'DISABLE'){%>
                <td>停用</td>
                <%}else {%>
                <td></td>
                <%}%>
                <td>
                    <div class="pe-stand-table-btn-group">
                        <%if(peData.rows[j].status === 'DRAFT' || peData.rows[j].status === 'DISABLE'){%>
                        <button type="button" class="start-btn pe-icon-btn iconfont icon-start" title="启用"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}else if(peData.rows[j].status === 'ENABLE'){%>
                        <button type="button" class="stop-btn pe-icon-btn iconfont icon-stop" title="停用"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}%>
                        <button type="button" class="edit-btn pe-icon-btn iconfont icon-edit" title="编辑"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <button type="button" class="dele-btn pe-icon-btn iconfont icon-delete" title="删除"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <button type="button" title="复制" class="pe-btn pe-icon-btn iconfont icon-copy" data-id="<%=peData.rows[j].id%>">
                        </button>
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
<#--考试管理编辑弹框模板-->
<script type="text/template" id="examEditDialogTemp">
    <div class="pe-stand-form-cell" style="margin-bottom:15px;">
        <label class="pe-form-label" for="peMainKeyText">
            <span class="pe-label-name floatL"><span style="color:#f00;">*</span>批次名称:</span>
            <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                   placeholder="姓名/用户名/工号/手机号"
                   name="paperName">
        </label>
    </div>
    <div class="pe-stand-form-cell" style="margin-bottom:15px;">
        <div class="pe-time-wrap">
            <span class="pe-label-name floatL"><span style="color:#f00;">*</span>开始时间:</span>
            <div class="pe-date-wrap">
                <input id="peExamDialogStartTime"
                       class="pe-table-form-text pe-time-text pe-start-time laydate-icon"
                       type="text" name="queryStartTime">
                <#--<span class="iconfont icon-date input-icon"></span>-->
            </div>
        </div>
    </div>
    <div class="pe-stand-form-cell" style="margin-bottom:15px;">
        <div class="pe-time-wrap">
            <span class="pe-label-name floatL"><span style="color:#f00;">*</span>结束时间:</span>
            <div class="pe-date-wrap">
                <input id="peExamDialogEndTime"
                       class="pe-table-form-text pe-time-text pe-start-time laydate-icon"
                       type="text" name="queryStartTime">
                <#--<span class="iconfont icon-date input-icon"></span>-->
            </div>
        </div>
    </div>
    <div class="pe-stand-form-cell">
        <label class="pe-form-label" for="peMainKeyText">
            <span class="pe-label-name floatL">考试设置:</span>
            <a href="javascript:;" class="exam-add-new-user">添加考生</a>
        </label>
    </div>
</script>
<script>
    $(function () {
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        var peTableTitle = [
            {'title': '科目编号', 'width': 20},
            {'title': '科目名称', 'width': 27},
            {'title': '类型', 'width': 8},
            {'title': '创建人', 'width': 10, 'name': 'indefinite'},//.name === 'indefinite'
            {'title': '状态', 'width': 8},
            {'title': '操作', 'width': 15}
        ];

        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/ems/exam/manage/searchSubject',
            formParam: $('#examManageForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'peExamManaTemp',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle//表格头部的数量及名称数组;
        });

        $('.pe-question-choosen-btn').on('click', function () {
            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
        });

        $('.online-btn').click(function () {
            location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initExamInfo?examType=ONLINE&subject=true&nav=examMana';
        });

        $('.pe-stand-table-wrap').delegate('.view-exam', 'click', function () {
            var id = $(this).data('id');
            location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initExamInfo?id=' + id + '&optType=VIEW&nav=examMana';
        });

        $('.offline-btn').click(function () {
            location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initExamInfo?examType=OFFLINE&subject=true&nav=examMana';
        });

        $('.pe-stand-table-wrap').delegate('.dele-btn', 'click', function (data) {
            var id = $(this).attr('data-id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定删除该科目么？</h3><p class="pe-dialog-content-tip">删除后，科目不可以恢复，请谨慎操作。</p></div>',
                btn2: function () {
                    $.post(pageContext.rootPath + '/ems/exam/manage/deleteExam', {'id': id}, function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '删除成功',
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
                    }, 'json');
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });

        $('.pe-stand-table-wrap').delegate('.start-btn', 'click', function () {
            var id = $(this).attr('data-id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定启用这个科目么？</h3></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/enableSubject',
                        data: {id: id},
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '启用成功',
                                    time: 1000,
                                    end: function () {
                                        $('.pe-stand-table-wrap').peGrid('refresh');
                                    }
                                });

                                return false;
                            }

                            var errorHtml = '<p style="font-size: 14px;">';
                            $.each(data.data, function (i, errMsg) {
                                errorHtml = errorHtml + '<span class="iconfont icon-tree-dot" style="font-size: 12px;margin-left: 3px;"></span>' + errMsg + '<br/>';
                            });

                            errorHtml = errorHtml + '</p>'
                            PEMO.DIALOG.alert({
                                content: errorHtml,
                                btn: ['我知道了'],
                                area: ['500px'],
                                yes: function () {
                                    layer.closeAll();
                                },
                                success: function () {
                                    $('.layui-layer .layui-layer-content').height('auto');
                                }
                            });
                        }
                    })
                },
                btn1: function () {
                    layer.closeAll();
                }
            })
        });

        $('.pe-stand-table-wrap').delegate('.stop-btn', 'click', function () {
            var id = $(this).attr('data-id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定停用该科目么？</h3><p class="pe-dialog-content-tip">停用对已经启用的综合考试没有影响。</p></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/disableSubject',
                        data: {id: id},
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '停用成功',
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
                    })
                },
                btn1: function () {
                    layer.closeAll();
                }
            })
        });

        $('.pe-stand-table-wrap').delegate('.edit-btn', 'click', function () {
            var id = $(this).attr('data-id');
            location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initExamInfo?examType=ONLINE&optType=UPDATE&id='+id +"&nav=examMana";
        });

        $('.pe-stand-table-wrap').delegate('.icon-copy', 'click', function () {
            var id = $(this).attr('data-id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定复制该科目么？</h3></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/copyExam',
                        data: {'id': id, 'subject': 'true'},
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '复制成功',
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
                    })
                },
                btn1: function () {
                    layer.closeAll();
                }
            })
        });
    })
</script>