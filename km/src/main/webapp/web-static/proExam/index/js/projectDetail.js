$(function () {
    // 项目介绍
    function initProjectDesc(){
        var projectDetailDetail = $('#projectDetailDetail').html();
        var $projectDeatil = $("#projectDeatil");
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/library/load?libraryId='+libraryId,
            dataType: 'json',
            success: function (result) {
                var table, initSort = {
                    name: "desc",
                    size: "desc",
                    uploadTime: "desc"
                };
                $(".y-major-project-header").html('');
                if(result){
                    $(".y-major-project-header").html(result.libraryName);
                    $projectDeatil.html(_.template(projectDetailDetail)({data: result, sort: initSort}));
                }
            }
        });

    }
    // 初始化项目
    function initMajorProject() {
        var tplsFileTable = $('#tplsFileTable').html();
        var $fileList = $("#fileList");
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/knowledge/searchKnowledge?page=1&pageSize=10&libraryId='+libraryId,
            dataType: 'json',
            success: function (result) {
                var data = result.rows;
                var table, initSort = {
                    name: "desc",
                    size: "desc",
                    uploadTime: "desc"
                };
                $fileList.html(_.template(tplsFileTable)({list: data, sort: initSort}));
            }
        });
    }
    // 云库动态
    function initActivity() {
        var tplsActivityTable = $('#tplsActivityTable').html();
        var $activityList = $("#activityList");
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/library/dynamic?page=1&pageSize=10&libraryId='+libraryId,
            dataType: 'json',
            success: function (result) {
                var data = result.rows;
                var table, initSort = {
                    name: "desc",
                    size: "desc",
                    uploadTime: "desc"
                };
                $activityList.html(_.template(tplsActivityTable)({list: data, sort: initSort}));
            }
        });
    }
    // 贡献榜单
    function initRank() {
        var tplsContributionTable = $('#tplsContributionTable').html();
        var $contributionList = $("#contributionList");
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/library/rank?libraryId='+libraryId,
            dataType: 'json',
            success: function (result) {
                var table, initSort = {
                    name: "desc",
                    size: "desc",
                    uploadTime: "desc"
                };
                $contributionList.html(_.template(tplsContributionTable)({list: result, sort: initSort}));
            }
        });
    }
    initProjectDesc();
    initMajorProject();
    initActivity();
    initRank();

    //上传文件
    $('.project-upload').on('click',function (e) {
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
