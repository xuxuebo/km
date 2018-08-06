$(function () {
    /*初始化*/
    var typeIds;
    var orgTreeId;
    var orgType;
    var orgTreeData;
    initSpecialty();
    initProject();
    initLabel();
    initShareTab();

    //获取筛选类型
    var getTypeIds = function(){
        var majorIds = '';
        var projectIds = '';
        var labelIds = '';
        $('.js-major .y-active').each(function(){
            majorIds += $(this).data('typeid')+ ",";
        });
        $('.js-project .y-active').each(function(){
            projectIds += $(this).data('typeid')+ ",";
        });
        $('.js-label .y-active').each(function(){
            labelIds += $(this).data('typeid')+ ",";
        });
        majorIds = majorIds.substring(0, majorIds.length - 1);
        projectIds = projectIds.substring(0, projectIds.length - 1);
        labelIds = labelIds.substring(0, labelIds.length - 1);
        return {
            "majorIds":majorIds,
            "projectIds":projectIds,
            "labelIds":labelIds
        };
    };
    $(".y-share-project-type" ).delegate( ".y-share-project-type-item-first", "click", function(){
        var $this = $(this);
        if($this.hasClass('y-active')){
            return;
        }
        $this.addClass('y-active');
        $this.parent().find('.y-share-project-type-item').removeClass('y-active');
        typeIds = getTypeIds();
        var param = {
            'referId':orgTreeId,
            'referType':orgType,
            'tag':typeIds.labelIds,
            'projectLibraryId':typeIds.projectIds,
            'specialtyLibraryId':typeIds.majorIds,
            'knowledgeName':''
        };
        initShareTab(param);
    });
    $(".y-share-project-type" ).delegate( ".y-share-project-type-item", "click", function(){
        var $this = $(this);
        //只能选择一个
        $this.parent().find('.y-share-project-type-item').removeClass('y-active');
        $this.toggleClass('y-active');
        if($this.parent().find('.y-active').length>0){
            $this.parent().find('.y-share-project-type-item-first').removeClass('y-active');
        }else{
            $this.parent().find('.y-share-project-type-item-first').addClass('y-active');
        }

        var orgTxt = $('#orgTreeAndUsers .curSelectedNode').attr('title');
        typeIds = getTypeIds();
        var param = {
            'referId':orgTreeId,
            'referType':orgType,
            'tag':typeIds.labelIds,
            'projectLibraryId':typeIds.projectIds,
            'specialtyLibraryId':typeIds.majorIds,
            'knowledgeName':''
        };
        initShareTab(param);
    } );
    //初始化表格
    function initShareTab(param) {
        //table渲染
        var _table = $("#tplShareTable").html();
        var $shareTable = $('#shareTable');
        var data = [];
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/knowledge/orgShare/search?pageSize=100&page=1',
            dataType: 'json',
               data: param,
            success: function (result) {
                data = result.rows;
            }
        });
        for (var i = 0; i < data.length; i++) {
            data[i].knowledgeSize = YUN.conver(data[i].knowledgeSize);
        }
        var table, initSort = {
            name: "desc",
            size: "desc",
            uploadTime: "desc"
        };
        renderTable();
        function renderTable() {
            $shareTable.html(_.template(_table)({list: data, sort: initSort}));
            table = initTable($shareTable);
            $shareTable.find('.sort').click(function () {
                $shareTable.html(_.template(_table)({
                    list: data, sort: $.extend({}, initSort, {name: 'asc'})
                }));
            });
        }

        //从云库分享
        $('.js-share-y').off().on('click', function () {
            //我的云库弹框
            var knowledgeIds;
            var deptId;
            var table, initSort = {
                name: "desc",
                size: "desc",
                uploadTime: "desc"
            };
            PEMO.DIALOG.confirmL({
                content: '<div class="y-content__table" id="yunTable"><div class="pe-stand-table-pagination"></div></div>',
                area: ['750px', '520px'],
                title: '我的云库',
                btn: ['下一步', '取消'],
                skin: 'y-change-layer',
                resize: false,
                btn1: function () {
                    //id
                    var selectList = table.getSelect();
                    if (selectList.length === 0) {
                        layer.msg("请先选择操作项");
                        return;
                    }
                    knowledgeIds = "";
                    for (var i = 0; i < selectList.length; i++) {
                        knowledgeIds += selectList[i] + ",";
                    }
                    knowledgeIds = knowledgeIds.substring(0, knowledgeIds.length - 1);
                    console.log(knowledgeIds);
                    layer.closeAll();
                    getDept();
                },
                btn2: function () {//取消按钮
                    layer.closeAll();
                },

                success: function () {
                    //table渲染
                    var _table = $("#tplYunTable").html();
                    var $yunTable = $('#yunTable');
                    var data = [];
                    $.ajax({
                        async: false,//此值要设置为FALSE  默认为TRUE 异步调用
                        type: "POST",
                        url: pageContext.resourcePath + '/knowledge/search',
                        data: {},
                        dataType: 'json',
                        success: function (result) {
                            data = result;
                        }
                    });
                    for (var i = 0; i < data.length; i++) {
                        data[i].knowledgeSize = YUN.conver(data[i].knowledgeSize);
                    }
                    renderTable();
                    function renderTable() {
                        $yunTable.html(_.template(_table)({list: data, sort: initSort}));
                        table = initTable($yunTable);
                        $yunTable.find('.sort').click(function () {
                            $yunTable.html(_.template(_table)({
                                list: data, sort: $.extend({}, initSort, {name: 'asc'})
                            }));
                        });
                    }
                }
            });
            function getDept(){
                PEMO.DIALOG.confirmL({
                    content: '<div class="y-content__table tree-and-users-default tree-and-users-dept ztree pe-tree-container mCustomScrollbar" id="ySharedeptTree"><div class="pe-stand-table-pagination"></div></div>',
                    area: ['750px', '520px'],
                    title: '部门',
                    btn: ['保存', '取消'],
                    skin: 'y-share-tree-layer',
                    resize: false,
                    btn1: function () {
                        if(deptId){
                            PEBASE.ajaxRequest({
                                url: '/km/share/shareToOrg',
                                data: {
                                    "knowledgeIds":knowledgeIds,
                                    "libraryIds":deptId
                                },
                                success: function (data) {
                                    if (data.success) {
                                        layer.closeAll();
                                        PEMO.DIALOG.tips({
                                            content: '操作成功',
                                            time: 1000,
                                        });
                                        return false;
                                    }
                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function () {
                                            layer.closeAll();
                                        }
                                    });
                                }
                            });
                        }else{
                            PEMO.DIALOG.tips({
                                content: '您还未选择部门!',
                                time:2000
                            });
                            return;
                        }
                    },
                    btn2: function () {//取消按钮
                        layer.closeAll();
                    },
                    success: function () {
                        //部门树
                        var yDeptOrgTree = {
                            isOpen: true,
                            dataUrl: pageContext.rootPath + '/km/uc/user/listOrgTreeAndUsers',
                            clickNode: function (treeNode) {
                                deptId = treeNode.id;
                            },
                            treePosition: 'inputDropDown'
                        };
                        PEMO.ZTREE.initTree('ySharedeptTree', yDeptOrgTree);
                        var treeObj = $.fn.zTree.getZTreeObj("ySharedeptTree");
                        treeObj.expandAll(true);

                    }
                });
            }


        });
        //从本地分享
        $('.js-share-local').off().on('click',function (e) {
            var deptId, fileIds = "";
            PEMO.DIALOG.selectorDialog({
                content: pageContext.rootPath + '/km/knowledge/openUpload',
                area: ['600px', '400px'],
                title: '上传文件',
                skin:'js-file-upload',
                btn: ['下一步','取消'],
                btn1: function () {
                    var fileList = window.frames[0] &&  window.frames[0].document.getElementById('theList');
                    var length = $(fileList).find('li').length;
                    if(window.frames[0] && length==0){
                        PEMO.DIALOG.tips({
                            content: '您还未上传文件!',
                            time:2000
                        });
                        return;
                    }

                    if (length > 0) {
                        for (var i = 0; i < length; i++) {
                            fileIds += $($(fileList).find('li')[i]).attr("data-id");
                            if (i < length - 1) {
                                fileIds += ",";
                            }
                        }

                        //部门树
                        $('.js-file-upload .layui-layer-content iframe').remove();
                        $('.js-file-upload .layui-layer-content').html('<ul id="deptTree" class="tree-and-users-default tree-and-users-dept ztree pe-tree-container mCustomScrollbar"></ul>');
                        var deptOrgTree = {
                            isOpen: true,
                            dataUrl: pageContext.rootPath + '/km/uc/organize/listTree',
                            clickNode: function (treeNode) {
                                deptId = treeNode.id;
                            },
                            treePosition: 'inputDropDown'
                        };
                        PEMO.ZTREE.initTree('deptTree', deptOrgTree);
                        var treeObj = $.fn.zTree.getZTreeObj("deptTree");
                        treeObj.expandAll(true);
                        $('.js-file-upload .layui-layer-btn0').html('确定');
                        $('.js-file-upload .layui-layer-btn0').addClass('layui-layer-save');
                    }
                    if($('.layui-layer-save').length>0 && deptId){
                        PEBASE.ajaxRequest({
                                url: '/km/share/shareToOrg',
                                data: {
                                    "fileIds":fileIds,
                                    "libraryIds":deptId
                                },
                                success: function (data) {
                                    if (data.success) {
                                        layer.closeAll();
                                        PEMO.DIALOG.tips({
                                            content: '操作成功',
                                            time: 1000,
                                        });
                                        return false;
                                    }
                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function () {
                                            layer.closeAll();
                                        }
                                    });
                                }
                            });
                    }
                },
                btn2: function () {
                    layer.closeAll();
                },
                success: function (d, index) {


                }
                });
            return false;
        });
        //下载
        $('.js-download').on('click', function () {
            var selectList = table.getSelect();
            if (selectList.length === 0) {
                layer.msg("请先选择操作项");
                return;
            }
            var knIds = "";
            for (var i = 0; i < selectList.length; i++) {
                knIds += selectList[i] + ",";
            }
            knIds = knIds.substring(0, knIds.length - 1);

            var fileIds = [];
            PEBASE.ajaxRequest({
                url: pageContext.rootPath + '/km/knowledge/downloadKnowledge2',
                async: false,
                data: {'knowledgeIds': knIds},
                success: function (data) {
                    if (data.success) {
                        downloadFile(data.data.fileUrl, data.data.name);
                    } else {
                        PEMO.DIALOG.alert({
                            content: data.message,
                            btn: ['我知道了'],
                            yes: function (index) {
                                layer.close(index);
                            }
                        });
                    }

                }
            });
        });
        //复制
        $('.js-copy').on('click', function () {
            var selectList = table.getSelect();
            if (selectList.length === 0) {
                layer.msg("请先选择操作项");
                return;
            }
            var knowledgeIds = "";
            for (var i = 0; i < selectList.length; i++) {
                knowledgeIds += selectList[i] + ",";
            }
            if (knowledgeIds.length <= 1) {
                return false;
            }
            knowledgeIds = knowledgeIds.substring(0, knowledgeIds.length - 1);
            var shareIdArr = table.getPubLicShareId();
            var shareIds = "";
            for (var i = 0; i < shareIdArr.length; i++) {
                shareIds += shareIdArr[i] + ",";
            }
            shareIds = shareIds.substring(0, shareIds.length - 1);
            PEMO.DIALOG.confirmL({
                content: '<div><h3 class="pe-dialog-content-head">确定复制选中的文件？</h3><p class="pe-dialog-content-tip">确认后,可在我的云库内查看。 </p></div>',
                btn1: function () {

                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/km/knowledge/copyToMyLibrary',
                        data: {
                            "knowledgeIds": knowledgeIds, "shareIds": shareIds
                        },
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '操作成功',
                                    time: 1000,
                                });
                                layer.closeAll();
                            } else {
                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn: ['我知道了'],
                                    yes: function (index) {
                                        layer.close(index);
                                    }
                                });
                            }

                        }
                    });
                },
                btn2: function () {
                    layer.closeAll();
                },
            });
        });
    }

    //初始化table事件
    function initTable($container) {
        var $thead = $container.find(".y-table__header");
        var $tbody = $container.find("tbody");
        var $allCheckbox = $thead.find('input[type="checkbox"]');
        var $checkbox = $tbody.find('.y-table__td.checkbox').find("input");
        //全选
        $allCheckbox.on("change", function () {
            if (this.checked) {
                $checkbox.prop('checked', 'checked');
            } else {
                $checkbox.removeProp('checked');
            }
        });

        //单行选中
        $checkbox.on("change", function () {
            if (checkAll()) {
                $allCheckbox.prop('checked', 'checked');
            } else {
                $allCheckbox.removeProp('checked');
            }
        });

        //排序
        $thead.find('.sort').on("click", function () {
            var isDes = $(this).hasClass("desc");
            if (isDes) {
                $(this).removeClass('desc').addClass("asc");
            } else {
                $(this).addClass('desc').removeClass("asc");
            }
        });
        //选择所有
        function checkAll() {
            var total = $checkbox.size();
            var count = 0;
            $checkbox.each(function (i, item) {
                if ($(item).get(0).checked) {
                    count++;
                }
            });
            return total === count;
        }

        //选择
        return {
            getPubLicShareId: function () {
                var list = [];
                $checkbox.each(function (i, item) {
                    var $item = $(item);
                    if ($item.get(0).checked) {
                        list.push($item.closest('.y-table__tr').attr('data-shareid'));
                    }
                });
                return list;
            },
            getSelect: function () {
                var list = [];
                $checkbox.each(function (i, item) {
                    var $item = $(item);
                    if ($item.get(0).checked) {
                        list.push($item.closest('.y-table__tr').attr('data-id'));
                    }
                });
                return list;
            },
            getSelectShareId: function () {
                var list = [];
                $checkbox.each(function (i, item) {
                    var $item = $(item);
                    if ($item.get(0).checked) {
                        list.push($item.closest('.y-table__tr').attr('data-id'));
                    }
                });
                return list;
            }
        };
    }
    //初始化树
    var listOrgTreeAndUsers = {
        isOpen: true,
        dataUrl: pageContext.rootPath + '/km/uc/user/listOrgTreeAndUsers',
        clickNode: function (treeNode) {
            //筛选条件全部恢复到全部
            $('.y-share-project-type-list').each(function(){
                $(this).find('dd span').removeClass('y-active').eq(0).addClass('y-active');
            });
            orgTreeId = treeNode.id;
            orgType = treeNode.type;
            typeIds = getTypeIds();
            var param = {
                'referId':orgTreeId,
                'referType':orgType,
                'tag':typeIds.labelIds,
                'projectLibraryId':typeIds.projectIds,
                'specialtyLibraryId':typeIds.majorIds,
                'knowledgeName':''
            };
            $('.show-org-name').text(treeNode.name);
            initShareTab(param);
        },
        treePosition: 'inputDropDown'
    };
    PEMO.ZTREE.initTree('orgTreeAndUsers', listOrgTreeAndUsers);

    // 专业
    function initSpecialty() {
        var tplSpecialtyTable = $('#tplSpecialtyTable').html();
        var $specialtyList = $("#specialty-dd");
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/library/listLibrary?type=SPECIALTY_LIBRARY',
            dataType: 'json',
            success: function (result) {
                var table, initSort = {
                    name: "desc",
                    size: "desc",
                    uploadTime: "desc"
                };
                $specialtyList.html(_.template(tplSpecialtyTable)({list: result, sort: initSort}));
            }
        });
    }
    // 项目
    function initProject() {
        var tplProjectTable = $('#tplSpecialtyTable').html();
        var $projectList = $("#project-dd");
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/library/listLibrary?type=PROJECT_LIBRARY',
            dataType: 'json',
            success: function (result) {
                var table, initSort = {
                    name: "desc",
                    size: "desc",
                    uploadTime: "desc"
                };
                $projectList.html(_.template(tplProjectTable)({list: result, sort: initSort}));
            }
        });
    }
    // 标签
    function initLabel() {
        var tplLabelTable = $('#tplLabelTable').html();
        var $labelList = $("#label-dd");
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/km/label/list',
            dataType: 'json',
            success: function (result) {
                var table, initSort = {
                    name: "desc",
                    size: "desc",
                    uploadTime: "desc"
                };
                $labelList.html(_.template(tplLabelTable)({list: result, sort: initSort}));
            }
        });
    }
});
$("#searchBtn").on('click', function () {
    var $searchKeyword = $("#searchKeyword");
    var _keyword = $searchKeyword.val();
    $.ajax({
        async: false,//此值要设置为FALSE  默认为TRUE 异步调用
        type: "POST",
        url: pageContext.resourcePath + '/knowledge/fullTextSearch?keyword=' + _keyword,
        dataType: 'json',
        success: function (result) {
            data = result;
            for (var i = 0; i < data.length; i++) {
                data[i].knowledgeSize = YUN.conver(data[i].knowledgeSize);
            }
        }
    });

    renderTable();
});

//绑定事件
$('.y-share-table-main-panel').delegate('.js-opt-download', 'click', function () {
    var knIds = $(this).data('id');
    var fileIds = [];
    PEBASE.ajaxRequest({
        url: pageContext.rootPath + '/km/knowledge/downloadKnowledge2',
        async: false,
        data: {'knowledgeIds': knIds},
        success: function (data) {
            if (data.success) {
                downloadFile(data.data.fileUrl, data.data.name);
            } else {
                PEMO.DIALOG.alert({
                    content: data.message,
                    btn: ['我知道了'],
                    yes: function (index) {
                        layer.close(index);
                    }
                });
            }

        }
    });
});

//删除
$('.y-share-table-main-panel').delegate('.js-opt-delete', 'click', function () {
    var knowledgeIds = $(this).data("id");
    if (knowledgeIds == null || knowledgeIds == undefined || knowledgeIds == '') {
        return false;
    }
    PEMO.DIALOG.confirmL({
        content: '<div><h3 class="pe-dialog-content-head">确定删除？</h3><p class="pe-dialog-content-tip">删除后，可在我的回收站找回。 </p></div>',
        btn1: function () {

            PEBASE.ajaxRequest({
                url: pageContext.rootPath + '/km/knowledge/delete',
                data: {
                    "knowledgeIds": knowledgeIds
                },
                success: function (data) {
                    if (data.success) {
                        PEMO.DIALOG.tips({
                            content: '操作成功',
                            time: 1000,
                        });
                        layer.closeAll();
                        //刷新列表
                        route['YunCb']($yunContentBody, route.routes.yun, null, null);
                    } else {
                        PEMO.DIALOG.alert({
                            content: data.message,
                            btn: ['我知道了'],
                            yes: function (index) {
                                layer.close(index);
                            }
                        });
                    }

                }
            });
        },
        btn2: function () {
            layer.closeAll();
        },
    });
});

$('.y-share-table-main-panel').delegate('.js-opt-share', 'click', function () {

    var knowledgeIds = $(this).data("id");
    if (knowledgeIds == null || knowledgeIds == undefined || knowledgeIds == '') {
        return false;
    }
    //分享弹框
    PEMO.DIALOG.confirmL({
        content: _.template($('#shareToPublic').html())({}),
        area: ['468px', '520px'],
        title: '选择公共库',
        btn: ['确定', '取消'],
        skin: 'pe-layer-confirm pe-layer-has-tree organize-change-layer',
        resize: false,
        btnAlign: 'c',
        btn1: function () {
            var libraryId = $('input[name="shareLibraryId"]').val();
            PEBASE.ajaxRequest({
                url: pageContext.rootPath + '/km/knowledge/shareToPublic',
                data: {'knowledgeId': knowledgeIds, 'shareLibraryId': libraryId},
                success: function (data) {
                    if (data.success) {
                        layer.closeAll();
                        PEMO.DIALOG.tips({
                            content: '操作成功',
                            time: 1000,
                        });

                        return false;
                    }
                    PEMO.DIALOG.alert({
                        content: data.message,
                        btn: ['我知道了'],
                        yes: function () {
                            layer.closeAll();
                        }
                    });
                }
            });
        },
        btn2: function () {//取消按钮
            layer.closeAll();
        },

        success: function () {
            //初始化树
            var settingInputTree = {
                isOpen: true,
                dataUrl: pageContext.rootPath + '/km/library/listTree',
                clickNode: function (treeNode) {
                    $('input[name="shareLibraryId"]').val(treeNode.id);
                    //$('.show-org-name').val(treeNode.name);
                },
                treePosition: 'inputDropDown',
            };
            PEMO.ZTREE.initTree('editOrgTree', settingInputTree);
            var treeObj = $.fn.zTree.getZTreeObj("editOrgTree");
            treeObj.expandAll(true);
        }
    });
});
$('.js-opt-dbclick').dblclick(function () {
    var folder = $(this).data('folder');
    var fileId = $(this).data('fileid');
    if (fileId == null || fileId == '') {//没有文件id
        var title = "";
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            data: {'id': folder},
            url: pageContext.rootPath + '/km/library/libraryName',
            dataType: 'json',
            success: function (result) {
                title = result.data;
            }
        });
        breadCrumbsList.push({id: folder, title: title});
        $('#myLibrary').val(folder);
        route['YunCb']($yunContentBody, route.routes.yun, null, folder);
    } else {
        return false;
    }

});
function downloadFile(path, params) {
    var downUrl = $('#downloadServerUrl').val();
    var a = document.createElement('a');
    var corpCode = $('#corpCode').val();
    a.download = '';
    a.style.display = 'none';
    a.href = downUrl + '/file/downLoadFiles?fileIds=' + path + '&fileName=' + params + '&corpCode='+corpCode;
    // 触发点击
    document.body.appendChild(a);
    a.click();
    // 然后移除
    document.body.removeChild(a);
}




