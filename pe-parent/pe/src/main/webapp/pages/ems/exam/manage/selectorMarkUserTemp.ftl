<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>选择器</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon" />
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
<body class="pe-selector-body" style="padding: 0 20px;margin-top:0;">
<div class="pe-selector-wrap">
    <form id="selectorPaperTemplateForm">
        <input type="hidden" name="queryStatus" value="ENABLE">
        <input type="hidden" name="examId" value="${examId!}">
        <div class="pe-stand-table-panel" style="border-top:none;">
            <div class="pe-stand-table-top-panel" style="padding-left:0;padding-top:6px;">
                <button type="button" class="pe-btn pe-btn-green mark-user-btn">分配评卷人
                </button>
            </div>
        <#--表格包裹的div-->
            <div class="pe-stand-table-main-panel" style="height:450px;overflow:auto;">
                <div class="pe-stand-table-wrap select-marker-template"></div>
                <div class="pe-stand-table-pagination"></div>
            </div>
        </div>
    </form>
</div>
<script src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}" type="application/javascript"></script>
<#--渲染表格模板-->
<script type="text/template" id="markerPaperUser">
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
                <%if(peData.tableTitles[i] && peData.tableTitles[i].needIcon){%>
                <th style="width:<%=peData.tableTitles[i].width%>%;padding-left:22px;">
                    <%}else{%>
                <th style="width:<%=peData.tableTitles[i].width%>%">
                    <%}%>
                    <%=peData.tableTitles[i].title%>
                </th>
                <%}%>
                <%}%>
        </tr>
        </thead>
        <tbody>
        <#--<tr class="pe-stand-bg"></tr>-->
        <#--rows.length ===0 为前端无数据时临时改的，实际为!== 0-，及下面的[1,2,3,4,5]也是假的，最后删除]-->
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
            <tr data-index="<%=j%>">
                <td>
                    <label class="pe-checkbox pe-paper-check" data-id="<%=peData.rows[j].id%>">
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <input class="pe-form-ele" value="ENABLE" type="checkbox"/>
                    </label>
                </td>
            <#--生成序号类-->
                <td>
                    <div class="pe-ellipsis" title=""><%=j+1%></div>
                </td>
            <#--试题-->
                <td>
                    <a class="pe-stand-table-alink pe-dark-font pe-ellipsis" title="<%=peData.rows[j].stemOutline%>"
                       href="javascript:;"><%=peData.rows[j].stemOutline%>
                    </a>
                </td>
            <#--评卷人-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].judgeUserName%>">
                        <%=peData.rows[j].judgeUserName%>
                    </div>
                </td>
            <#--操作;-->
                <td>
                    <div class="pe-stand-table-btn-group">
                        <a title="设置评分权重" class="pe-icon-btn markWeight"
                           data-id="<%=peData.rows[j].id%>">设置评分权重</a>
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
<script type="text/template" id="setMarkTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <th style="width:<%=peData.tableTitles[i].width%>%"><%=peData.tableTitles[i].title%></th>
                <%}%>
        </tr>
        </thead>
        <tbody>
        <#--rows.length ===0 为前端无数据时临时改的，实际为!== 0-，及下面的[1,2,3,5也是假的，最后删除]-->
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
            <tr data-index="<%=j%>">
                <input type="hidden" name="judgeUserIds" value="<%=peData.rows[j].id%>"/>
            <#--评卷人-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].user.userName%>">
                        <%=peData.rows[j].user.userName%>
                    </div>
                </td>
            <#--评分权重-->
                <td>
                    <div class="pe-ellipsis" title="">
                        <input type="text" value="<%=peData.rows[j].rate%>" class="mark-percent-input"
                               name="markPercent"/>%
                    </div>
                </td>
            <#--操作;-->
                <td>
                    <div class="pe-stand-table-btn-group">
                        <a title="设置评分权重" class="pe-icon-btn iconfont icon-delete markDele"
                           data-id="<%=peData.rows[j].id%>"></a>
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
<script>
    $(function () {
        /*自定义主体表格头部数量及宽度*/
        var peTableTitle = [
            {'title': 'checkbox', 'width': 4},
            {'title': '序号', 'width': 8},
            {'title': '试题', 'width': 40},
            {'title': '评卷人', 'width': 30},
            {'title': '操作', 'width': 10}
        ];
        /*表格生成*/
        $('.select-marker-template').peGrid({
            url: pageContext.rootPath + '/ems/exam/manage/listAllExamItem',
            formParam: $('#selectorPaperTemplateForm').serializeArray(),//表格上方表单的提交参数
            tempId: 'markerPaperUser',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle, //表格头部的数量及名称数组;
            pagination: "layer",
            onLoad: function () {
                $('.pe-stand-table-pagination').hide();
                PEBASE.peFormEvent('checkbox');
            }
        });

        /*分配评卷人*/
        $(".mark-user-btn").click(function () {
            var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
            if (!rows || rows.length <= 0) {
                PEMO.DIALOG.alert({
                    content: '请至少先选择一道试题！',
                    btn: ['我知道了'],
                    yes: function () {
                        layer.closeAll();
                    }
                });

                return false;
            }

            $(parent.document).find("#itemIds").val(JSON.stringify(rows));
            parent.window.PEMO.DIALOG.selectorDialog({
                title: '分配评卷人',
                area: ['970px', '580px'],
                content: [pageContext.rootPath + '/ems/exam/manage/initSelector?type=JUDGE_ITEM_USER&id=${(examId)!}', 'no'],
                btn: ['关闭'],
                btn1: function (index) {
                    parent.window.layer.close(index);
                },
                end: function () {
                    $('.select-marker-template').peGrid('load', $('#selectorPaperTemplateForm').serializeArray());
                }
            });
        });

        /*权重分配按钮点击事件*/
        $('.select-marker-template').delegate('.markWeight', 'click', function () {
            var itemId = $(this).data('id');
            var judgeUserParam = {"examId": '${examId!}', "itemId": itemId};
            PEMO.DIALOG.confirmR({
                title: '设置评分权重',
                content: '<form id="judgeUserRateForm"><span class="set-mark-tip validate-wrong-color"><span class="iconfont icon-caution-tip"></span>评分权重相加必须等于100%！</span><div class="pe-stand-table-main-panel">'
                + '<div class="pe-stand-table-wrap set-mark-template-table" ></div>'
                + '<div class="pe-stand-table-pagination mark-pagination"></div></div></form>',
                btn: ['取消', '保存'],
                skin: 'pe-layer-confirmA set-mark-dialog',
                btn2: function () {
                    var setInput = $('.set-mark-template-table').find('input[name="markPercent"]');
                    var setMarkAllNum = 0;
                    $.each(setInput, function (index, singleDom) {
                        var thisVal = $(singleDom).val();
                        if (!thisVal) {
                            thisVal = 0;
                            $(singleDom).val(thisVal);
                        }
                        setMarkAllNum += parseInt(thisVal);
                    });
                    if (setMarkAllNum > 100 || setMarkAllNum < 100) {
                        $('.set-mark-tip').show().animate({
                            left: 112
                        }, 50, function () {
                            $(this).animate({
                                left: 120
                            }, 50, function () {
                                $(this).animate({
                                    left: 116
                                }, 50)
                            })
                        });
                        return false;
                    } else {
                        $('.set-mark-tip').hide()
                    }

                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/saveJudgeUserRate',
                        data: $('#judgeUserRateForm').serializeArray(),
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '设置成功',
                                    time: 1000,
                                    end: function () {
                                        layer.closeAll();
                                    }
                                });
                                return false;
                            }

                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function (shiIndex) {
                                    layer.close(shiIndex);
                                }
                            })
                        }
                    });
                },
                btn1: function (quxiaoindex) {
                    layer.close(quxiaoindex);
                },
                success: function () {
                    var setMarkTableTitle = [
                        {'title': '评卷人', 'width': 30},
                        {'title': '评分权重', 'width': 40},
                        {'title': '操作', 'width': 14}
                    ];
                    /*设置评分弹框里的表格生成*/
                    $('.set-mark-template-table').peGrid({
                        url: pageContext.rootPath + '/ems/exam/manage/searchJudgeUsers',
                        formParam: judgeUserParam,//表格上方表单的提交参数
                        tempId: 'setMarkTemp',//表格模板的id
                        showTotalDomId: 'showTotal',
                        title: setMarkTableTitle, //表格头部的数量及名称数组;
                        onLoad: function () {
                            $('.mark-pagination').hide();
                            PEBASE.peFormEvent('checkbox');
                        }
                    });

                    /*设置权重分配弹框里的输入框输入值检验*/
                    //markPercent
                    $('.set-mark-template-table').delegate('.mark-percent-input', 'keyup', function (e) {
                        var e = e || window.event;
                        var eKeyCode = e.keyCode;
                        var thisVal = this.value;
                        if ((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || eKeyCode === 110 || eKeyCode === 190 || eKeyCode === 8 || eKeyCode === 108) {
                            if (parseFloat(thisVal) > 100) {
                                this.value = 100;
                            } else {
                                if ((thisVal.indexOf('.') !== -1) && (thisVal.indexOf('.') !== thisVal.lastIndexOf('.'))) {
                                    this.value = thisVal.substring(0, thisVal.lastIndexOf('.'));
                                }
                                if (thisVal.length >= 4 && (thisVal.indexOf('.') !== -1)) {
                                    this.value = thisVal.substring(0, thisVal.indexOf('.') + 2);
                                }
                            }
                        } else {
                            this.value = thisVal;
                            return false;
                        }

                    });

                    $('.set-mark-template-table').delegate('.mark-percent-input', 'keydown', function (e) {
                        var e = e || window.event;
                        var eKeyCode = e.keyCode;
                        var thisVal = this.value;
                        if (!((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || eKeyCode === 110 || eKeyCode === 190 || eKeyCode === 8 || eKeyCode === 108)) {
                            this.value = thisVal;
                            return false;
                        }
                    });

                    $('.set-mark-template-table').delegate('.markDele', 'click', function (e) {
                        var judgeUserId = $(this).data('id');
                        PEMO.DIALOG.confirmL({
                            content: "确定删除该评卷人？",
                            area: '350px',
                            skin: 'pe-layer-confirm pe-exam-manage-time-dialog',
                            title: '提示信息',
                            btn: ['确定', '取消'],
                            btnAlign: 'l',
                            btn1: function (i) {
                                PEBASE.ajaxRequest({
                                    url: pageContext.rootPath + '/ems/exam/manage/deleteJudgeUser',
                                    data: {"judgeUserId": judgeUserId},
                                    success: function (data) {
                                        if (data.success) {
                                            PEMO.DIALOG.tips({
                                                content: '删除成功',
                                                time: 1000,
                                                end: function () {
                                                    $('.set-mark-template-table').peGrid('load', judgeUserParam);
                                                    $('.select-marker-template').peGrid('load', $('#selectorPaperTemplateForm').serializeArray());
                                                    layer.close(i);
                                                }
                                            });
                                            return false;
                                        }

                                        PEMO.DIALOG.alert({
                                            content: data.message,
                                            btn: ['我知道了'],
                                            yes: function (shiIndex) {
                                                layer.close(shiIndex);
                                                layer.close(i)
                                            }
                                        })
                                    }
                                });
                            },
                            btn2: function () {
                                layer.closeAll();
                            }
                        });
                    });
                }
            });
        });
    });
</script>
</body>
</html>