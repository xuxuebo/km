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
                    <input type="hidden" name="library.libraryName" value="${(library.libraryName)!}"/>
                    <input type="hidden" name="library.id" value="${(library.id)!}"/>
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
        <#-- 必要字段 测试数据 -->
            <#--<input type="hidden" name="libraryDetail.chargeIds" value="TangFD"/>-->
            <#--<input type="hidden" name="libraryDetail.summary" value="数据数据数据数据数据数据数据数据数据数据数据"/>-->
            <div class="pe-add-question-text">
                <span class="pe-label-name floatL introduction-info"><%=data.firstName%>:</span>
                <input class="pe-stand-filter-form-input" maxlength="50" type="text"
                       placeholder="请输入<%=data.firstName%>"
                       name="<%=data.firstInputName%>">
            </div>
            <div class="pe-add-question-text show-user">
                <span class="pe-label-name floatL introduction-info">负责人:</span>
                <select class="pe-add-select-user" name="libraryDetail.chargeIds" multiple="multiple">
                    <option value="1">哈哈哈</option>
                    <option value="2">测试2</option>
                    <option value="3">测试3</option>
                    <option value="4">测试4</option>
                    <option value="5">测试5</option>
                    <option value="6">测试6</option>
                </select>
            </div>
            <div class="pe-add-question-text">
                <input type="hidden" name="libraryDetail.faceId" value="">
                <input type="hidden" name="libraryDetail.faceName" value="">
                <span class="pe-label-name floatL introduction-info">上传图片:</span>
                <a href="#" class="img-upload" onclick="projectImgUpload()">上传图片</a>
            </div>
            <div class="pe-add-question-text">
                <span class="pe-label-name floatL introduction-info">项目介绍:</span>
                <!-- 加载编辑器的容器 -->
                <textarea name="libraryDetail.summary" id="webContainer" cols="30" rows="10"
                          style="width:400px;height:400px;"></textarea>
            </div>
        </form>
        <div class="pe-main-km-text-wrap">
            <div class="pe-km-search-key pe-input-tree-wrap pe-stand-filter-form-input" style="display: none">

            </div>
        </div>
    </div>
</script>

<script>
    window.UEDITOR_HOME_URL = "${resourcePath!}/web-static/proExam/js/uEditor/";
</script>
<link rel="stylesheet" href="${resourcePath!}/web-static/proExam/index/css/multiple-select.css">
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/uEditor/ueditor.config.js"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/uEditor/ueditor.all.min.js"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/uEditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/multiple-select.js"></script>

<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/jquery.searchableSelect.js"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-peGrid.js"></script>
<script>
    $(function () {
        var UEditorS;
        var peTableTitle = [
            {'title': '重点项目名称', 'width': 300},
            {'title': '操作', 'width': 100}
        ];
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
                        content: _.template($('#confirmDialogTemp').html())({
                            data: {
                                'firstName': '项目名称',
                                'firstInputName': 'libraryName'
                            }
                        }),
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
                            UEditorS = UE.getEditor('webContainer');
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
                            UEditorS.destroy();
                        },
                        btn2 :function () {
                            UEditorS.destroy();
                        }
                    });
                });

                $('.pe-stand-table-main-panel').delegate('.edit-btn', 'click', function () {
                    var id = $(this).data("id");
                    var name = $(this).data("libraryname");
                    console.log(name);
                    PEMO.DIALOG.confirmL({
                        content: _.template($('#confirmDialogTemp').html())({
                            data: {
                                'firstName': '项目名称',
                                'firstInputName': 'libraryName'
                            }
                        }),
                        area: '800px',
                        title: '编辑重点项目',
                        btn: ['保存', '取消'],
                        btnAlign: 'l',
                        btn1: function () {
                            var libraryName = $('input[name="libraryName"]').val();
                            PEBASE.ajaxRequest({
                                //此处要返回给我新的修改过的节点的id，好和旧的的id进行比较从而是否刷新树节点
                                url: pageContext.rootPath + '/project/updateProject',
                                data: {
                                    'id': id,
                                    'libraryName': libraryName
                                },
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
            content: pageContext.rootPath + '/knowledge/openUpload',
            area: ['600px', '400px'],
            title: '上传图片',
            btn1: function () {
            },
            btn2: function () {
                layer.closeAll();
            },
            success: function (d, index) {

            }
        });
    }
</script>
<link rel="stylesheet" href="${resourcePath!}/web-static/proExam/index/css/index.css">