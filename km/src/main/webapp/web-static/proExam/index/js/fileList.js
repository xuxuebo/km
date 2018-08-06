$(function () {
    // 项目文件列表
    var tplYunTable = $('#tplYunTable').html();
    var $yunTable = $("#yunTable");
    var data = [];
    // 项目文件列表url
    var url = pageContext.resourcePath + '/knowledge/searchKnowledge?page=1&pageSize=100&libraryId='+libraryId;
    if (type == 'activity'){
        // 动态文库url
        url = pageContext.resourcePath + '/library/dynamic?page=1&pageSize=10&libraryId='+libraryId;
    }
    $.ajax({
        async: false,//此值要设置为FALSE  默认为TRUE 异步调用
        type: "POST",
        url: url,
        dataType: 'json',
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
        $yunTable.html(_.template(tplYunTable)({list: data, sort: initSort}));
        table = initTable($yunTable);
    }
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

    //上传文件
    $('.js-upload').on('click',function (e) {
        e.preventDefault();
        var deptId, fileIds = "";
        PEMO.DIALOG.selectorDialog({
            content: pageContext.rootPath + '/km/knowledge/openUpload',
            area: ['600px', '400px'],
            title: '上传文件',
            skin: 'js-file-upload',
            btn: ['确定', '取消'],
            btn1: function () {
                var fileList = window.frames[0] && window.frames[0].document.getElementById('theList');
                var length = $(fileList).find('li').length;
                if (window.frames[0] && length == 0) {
                    PEMO.DIALOG.tips({
                        content: '您还未上传文件!',
                        time: 2000
                    });
                    return;
                }

                for (var i = 0; i < length; i++) {
                    fileIds += $($(fileList).find('li')[i]).attr("data-id");
                    if (i < length - 1) {
                        fileIds += ",";
                    }
                }

                if (libraryId) {
                    PEBASE.ajaxRequest({
                        url: '/km/library/addToLibrary',
                        data: {
                            "fileIds": fileIds,
                            "libraryIds": libraryId
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
            }
        });
    });
})
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




