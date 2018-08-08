<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">

</div>
<section class="exam-manage-all-wrap">
    <form id="projectManageForm">
        <input type="hidden" name="libraryType" value="PROJECT_LIBRARY"/>
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                        <button type="button" class="pe-btn pe-btn-green create-exercise-btn">新增重点项目</button>
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
            <tr data-id="<%=peData.rows[j].id%>">
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].libraryName%>"><%=peData.rows[j].libraryName%>
                    </div>
                </td>

                <td>
                    <div class="pe-stand-table-btn-group">
                        <button type="button" class="edit-btn pe-icon-btn iconfont icon-edit" title="编辑"
                                data-id="<%=peData.rows[j].id%>"
                                data-libraryname="<%=peData.rows[j].libraryName%>"></button>
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
<script type="text/template" id="confirmDialogTemp">
    <div>
        <form id="library_detail_form">
            <div class="pe-add-question-text">
                <span class="pe-label-name floatL introduction-info"><%=data.firstName%>:</span>
                <input class="pe-stand-filter-form-input" maxlength="50" type="text"
                       placeholder="请输入<%=data.firstName%>"
                       name="<%=data.firstInputName%>">
            </div>
            <div class="pe-add-question-text show-user">
                <span class="pe-label-name floatL introduction-info">负责人:</span>
                <select class="pe-select-user" name="libraryDetail.chargeIds" multiple="multiple">
                    <%if(user.length !== 0){%>
                    <%_.each(user,function(item,i){%>
                    <option value="<%=item.id%>"><%=item.userName%></option>
                    <%})}%>
                </select>
            </div>
            <div class="pe-add-question-text pe-user-msg-detail" style="height:100px;">
                 <span class="pe-input-tree-text introduction-info">
                        上传封面:
                 </span>
                <button type="button" class="pe-user-head-edit-btn2" onclick="projectImgUpload()">
                    <img src="${resourcePath!}/web-static/proExam/images/default-image.png"/>
                    <span>编辑封面</span>
                </button>
                <input type="hidden" name="libraryDetail.faceId" class="target-fileId" value=""/>
                <input type="hidden" name="libraryDetail.faceName" class="target-fileName" value=""/>
            </div>
            <div class="pe-add-question-text">
                <span class="pe-label-name floatL introduction-info">项目介绍:</span>
                <!-- 加载编辑器的容器 -->
                <textarea name="libraryDetail.summary" id="webContainer-1" cols="30" rows="10"
                          maxlength="1300" style="width:500px;height:200px;"></textarea>
            </div>
        </form>
        <div class="pe-main-km-text-wrap">
            <div class="pe-km-search-key pe-input-tree-wrap pe-stand-filter-form-input" style="display: none">

            </div>
        </div>
    </div>
</script>
<script type="text/template" id="confirmDialogUpdate">
    <div>
        <form id="library_detail_update_form">
            <input type="hidden" name="id" value="<%=data.id%>">
            <input type="hidden" name="libraryDetail.id" value="<%=data.libraryDetail.id%>">
            <input type="hidden" name="libraryDetail.libraryId" value="<%=data.id%>">
            <div class="pe-add-question-text">
                <span class="pe-label-name floatL introduction-info">项目名称:</span>
                <input class="pe-stand-filter-form-input" maxlength="50" type="text"
                       placeholder="请输入项目名称" name="libraryName" value="<%=data.libraryName%>">
            </div>
            <div class="pe-add-question-text show-user">
                <span class="pe-label-name floatL introduction-info">负责人:</span>
                <select class="pe-select-user" name="libraryDetail.chargeIds" multiple="multiple">
                    <%if(user.length !== 0){%>
                    <%_.each(user,function(item,i){%>
                    <option value="<%=item.id%>" <%if(compare(data.libraryDetail.chargeIds, item.id)){%>selected="selected"<%}%>><%=item.userName%></option>
                    <%})}%>
                </select>
            </div>
            <div class="pe-add-question-text pe-user-msg-detail" style="height:100px;">
                 <span class="pe-input-tree-text introduction-info">
                        上传封面:
                 </span>
                <button type="button" class="pe-user-head-edit-btn2" onclick="projectImgUpload()">
                    <img onerror="javascript:this.src='${resourcePath!}/web-static/proExam/images/default-image.png'" src="<%=data.libraryDetail.facePath%>"/>
                    <span>编辑封面</span>
                </button>
                <input type="hidden" name="libraryDetail.faceId" class="target-fileId" value="<%=data.libraryDetail.faceId%>"/>
                <input type="hidden" name="libraryDetail.faceName" class="target-fileName" value="<%=data.libraryDetail.faceName%>"/>
            </div>
            <div class="pe-add-question-text">
                <span class="pe-label-name floatL introduction-info">项目介绍:</span>
                <!-- 加载编辑器的容器 -->
                <textarea name="libraryDetail.summary" id="webContainer-1" cols="30" rows="10"
                          maxlength="1300" style="width:500px;height:200px;"><%=data.libraryDetail.summary%></textarea>
            </div>
        </form>
        <div class="pe-main-km-text-wrap">
            <div class="pe-km-search-key pe-input-tree-wrap pe-stand-filter-form-input" style="display: none">

            </div>
        </div>
    </div>
</script>

<#--<script>
    window.UEDITOR_HOME_URL = "${resourcePath!}/web-static/proExam/js/uEditor/";
</script>-->
<link rel="stylesheet" href="${resourcePath!}/web-static/proExam/index/css/multiple-select.css">
<#--<script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/jquery-1.10.2.min.js"></script>-->
<#--<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/uEditor/ueditor.config.js"></script>-->
<#--<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/uEditor/ueditor.all.min.js"></script>-->
<#--<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/uEditor/lang/zh-cn/zh-cn.js"></script>-->
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/multiple-select.js"></script>

<#--<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-peGrid.js"></script>-->
<script>
    function compare(target, source){
        if (!source) {
            return false;
        }
        if (!target) {
            return false;
        }
        return target.indexOf(source) >= 0;
    }
    $(function () {
        var UEditorS;
        var peTableTitle = [
            {'title': '重点项目名称', 'width': 80},
            {'title': '操作', 'width': 20}
        ];

        var user = [];
        $.ajax({
            async: false,
            type: "POST",
            url: pageContext.resourcePath + '/uc/user/manage/search',//公共库的查询列表
            data: {"autoCount": false, "autoPaging": false},
            dataType: 'json',
            success: function (result) {
                user = result.rows;
            }
        });
        var exerciseManage = {
            init: function () {
                 $('.pe-stand-table-wrap').peGrid({
                     url: pageContext.rootPath + '/library/manage/searchLibrary',
                     formParam: $('#projectManageForm').serializeArray(),
                     tempId: 'peExerManaTemp',
                     showTotalDomId: 'showTotal',
                     title: peTableTitle
                 });
                var _this = this;
                _this.bind();
            },

            bind: function () {
                $('.create-exercise-btn').on('click', function () {
                    PEMO.DIALOG.confirmL({
                        content: _.template($('#confirmDialogTemp').html())({data: {'firstName': '项目名称', 'firstInputName': 'libraryName'}, user:user}),
                        area: ['800px', '600px'],
                        btn: ['确定', '取消'],
                        btnAlign: 'l',
                        title: '新增重点项目',
                        skin: 'project-introduction-add',
                        btn1: function () {
                            var libraryName = $('input[name="libraryName"]').val();
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/project/addProject',
                                data: $("#library_detail_form").serialize(),
                                success: function (data) {
                                    var message;
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '新增成功',
                                            time: 1000,
                                            end: function () {
                                                layer.closeAll('page');
                                            }
                                        });
                                        $('.pe-stand-table-wrap').peGrid('load', $('#projectManageForm').serializeArray());
                                        return false;
                                    } else if (data.message == "NAME_EMPTY") {
                                        message = '项目名称不可为空！';
                                    } else if (data.message == "NAME_REPEAT") {
                                        message = '项目名称已存在！';
                                    } else {
                                        message = '新增失败！';
                                    }

                                    PEMO.DIALOG.alert({
                                        content: message,
                                        btn: ['我知道了'],
                                        yes: function (index) {
                                            layer.close(index);
                                        }
                                    });
                                }
                            });
                        },
                        success: function () {
//                            UEditorS = UE.getEditor('webContainer');
                            // $('.selectpicker').selectpicker({
                            //     'selectedText': 'cat',
                            //     'style': 'btn-white'
                            // });
                            $("select").multipleSelect({
                                filter: true,
                                placeholder: "请选择",
                                selectAllText: '全选'
                            });
                        },
                        cancel: function () {
//                            UEditorS.destroy();
                        },
                        btn2 :function () {
//                            UEditorS.destroy();
                        }
                    });
                });

                $('.pe-stand-table-main-panel').delegate('.edit-btn', 'click', function () {
                    var id = $(this).data("id");
                    var name = $(this).data("libraryname");
                    console.log(name);
                    var data = {};
                    $.ajax({
                        async: false,//此值要设置为FALSE  默认为TRUE 异步调用
                        type: "POST",
                        url: pageContext.resourcePath + '/library/load',
                        data: {'libraryId': id},
                        dataType: 'json',
                        success: function (result) {
                            data = result;
                        }
                    });
                    PEMO.DIALOG.confirmL({
                        content: _.template($('#confirmDialogUpdate').html())({data: data, user:user}),
                        area: ['800px', '600px'],
                        title: '编辑重点项目',
                        btn: ['保存', '取消'],
                        btnAlign: 'l',
                        skin: 'project-introduction-add',
                        success: function () {
                            $("select").multipleSelect({
                                filter: true,
                                placeholder: "请选择",
                                selectAllText: '全选'
                            });
                        },
                        btn1: function () {
                            var libraryName = $('input[name="libraryName"]').val();
                            PEBASE.ajaxRequest({
                                //此处要返回给我新的修改过的节点的id，好和旧的的id进行比较从而是否刷新树节点
                                url: pageContext.rootPath + '/project/updateProject',
                                data: $("#library_detail_update_form").serialize(),
                                success: function (data) {
                                    var message;
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '编辑成功',
                                            time: 1000,
                                            end: function () {
                                                layer.closeAll('page');
                                            }
                                        });
                                        $('.pe-stand-table-wrap').peGrid('load', $('#projectManageForm').serializeArray());
                                        return false;
                                    } else if (data.message == "NAME_EMPTY") {
                                        message = '项目名称不可为空！';
                                    } else if (data.message == "NAME_REPEAT") {
                                        message = '项目名称已存在！';
                                    } else {
                                        message = '编辑失败！';
                                    }

                                    PEMO.DIALOG.alert({
                                        content: message,
                                        btn: ['我知道了'],
                                        yes: function (index) {
                                            layer.close(index);
                                            success();
                                        }
                                    });
                                }
                            });
                        }
                    });
                    $('input[name="libraryName"]').val(name);
                })

            }
        };
        exerciseManage.init();
    })

    function projectImgUpload() {
        PEMO.DIALOG.selectorDialog({
            content: pageContext.rootPath + '/project/initProjectFace',
            area: ['606px', '400px'],
            title: '项目封面',
            btn1: function () {
            },
            btn2: function () {
                layer.closeAll();
            },
            success: function (d,index) {
                var iframeBody = layer.getChildFrame('body', index);
                var hasPicSrc = $('.pe-user-head-edit-btn2').find('img').attr('src');
                if(hasPicSrc){
                    $(iframeBody).find('.jcrop-preview').prop("src", hasPicSrc);
                }
            }
        });
    }
</script>
<link rel="stylesheet" href="${resourcePath!}/web-static/proExam/index/css/index.css">