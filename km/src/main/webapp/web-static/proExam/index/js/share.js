$(function () {
    /*初始化*/
    var typeIds;
    var orgTreeId;
    var orgType;
    var orgTreeData;
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
    $('.y-share-project-type-item').click(function(){
        $(this).toggleClass('y-active');
        // orgTreeId = treeNode.id;
        var orgTxt = $('#orgTreeAndUsers .curSelectedNode').attr('title');
        // listOrgTreeAndUsers.clickNode();
        typeIds = getTypeIds();
        var param = {
            'orgTreeId':orgTreeId,
            'orgType':orgType,
            'typeIds':typeIds
        };
        initShareTab(param);
    });
    //初始化表格
    function initShareTab(param) {
        console.log(param);
        //table渲染
        var _table = $("#tplShareTable").html();
        var $shareTable = $('#shareTable');
        var data = [];
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/knowledge/search',
            dataType: 'json',
               data: {"param": param},
            success: function (result) {
                data = result;
            }
        });
        for (var i = 0; i < data.length; i++) {
            data[i].knowledgeSize = conver(data[i].knowledgeSize);
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
        $('.js-share-y').on('click', function () {
            //id
            var selectList = table.getSelect();
            if (selectList.length === 0) {
                layer.msg("请先选择操作项");
                return;
            }
            var knowledgeIds = "";
            for (var i = 0; i < selectList.length; i++) {
                knowledgeIds += selectList[i] + ",";
            }
            knowledgeIds = knowledgeIds.substring(0, knowledgeIds.length - 1);
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
                        treePosition: 'inputDropDown'
                    };
                    PEMO.ZTREE.initTree('editOrgTree', settingInputTree);
                    var treeObj = $.fn.zTree.getZTreeObj("editOrgTree");
                    treeObj.expandAll(true);
                }
            });
        });
        //从本地分享
        $('.js-share-local').on('click',function () {
            PEMO.DIALOG.selectorDialog({
                content: pageContext.rootPath + '/km/knowledge/openUpload',
                area: ['600px', '400px'],
                title: '上传文件',
                btn1: function () {
                },
                btn2: function () {
                    layer.closeAll();
                },
                success: function (d, index) {
                    var iframeBody = layer.getChildFrame('body', index);
                    var hasPicSrc = $('.pe-user-head-edit-btn').find('img').attr('src');
                    if (hasPicSrc) {
                        $(iframeBody).find('.jcrop-preview').prop("src", hasPicSrc);
                    }
                }
            });
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
        dataUrl: pageContext.rootPath + '/km/uc/user/manage/listOrgTreeAndUsers',
        clickNode: function (treeNode) {
            //筛选条件全部恢复到全部
            $('.y-share-project-type-list').each(function(){
                $(this).find('dd span').removeClass('y-active').eq(0).addClass('y-active');
            });
            orgTreeId = treeNode.id;
            orgType = treeNode.type;
            typeIds = getTypeIds();
            var param = {
                'orgTreeId':orgTreeId,
                'orgType':orgType,
                'typeIds':typeIds
            };
            initShareTab(param);
        },
        treePosition: 'inputDropDown'
    };
    PEMO.ZTREE.initTree('orgTreeAndUsers', listOrgTreeAndUsers);
    var OrgTreeObj = $.fn.zTree.getZTreeObj("orgTreeAndUsers");
    // OrgTreeObj.expandAll(true);
});
$("#searchBtn").on('click', function () {
    var $searchKeyword = $("#searchKeyword");
    console.log($searchKeyword);

    var _keyword = $searchKeyword.val();
    console.log(_keyword);
    $.ajax({
        async: false,//此值要设置为FALSE  默认为TRUE 异步调用
        type: "POST",
        url: pageContext.resourcePath + '/knowledge/fullTextSearch?keyword=' + _keyword,
        dataType: 'json',
        success: function (result) {
            data = result;
            for (var i = 0; i < data.length; i++) {
                data[i].knowledgeSize = conver(data[i].knowledgeSize);
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
                    debugger;
                    console.log(treeNode);
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
//转换单位
function conver(limit) {
    var size = "";
    if (limit < 0.1 * 1024) { //如果小于0.1KB转化成B
        size = limit.toFixed(2) + "B";
    } else if (limit < 0.1 * 1024 * 1024) {//如果小于0.1MB转化成KB
        size = (limit / 1024).toFixed(2) + "KB";
    } else if (limit < 0.1 * 1024 * 1024 * 1024) { //如果小于0.1GB转化成MB
        size = (limit / (1024 * 1024)).toFixed(2) + "MB";
    } else { //其他转化成GB
        size = (limit / (1024 * 1024 * 1024)).toFixed(2) + "GB";
    }

    var sizestr = size + "";
    var len = sizestr.indexOf("\.");
    var dec = sizestr.substr(len + 1, 2);
    if (dec == "00") {//当小数点后为00时 去掉小数部分
        return sizestr.substring(0, len) + sizestr.substr(len + 3, 2);
    }
    return sizestr;
}




