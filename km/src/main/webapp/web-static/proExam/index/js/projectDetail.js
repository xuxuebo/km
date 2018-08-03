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
                if(result){
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
            url: pageContext.resourcePath + '/knowledge/searchKnowledge?page=1&pageSize=100&libraryId='+libraryId,
            dataType: 'json',
            success: function (result) {
                var data = result.rows;
                for (var i = 0; i < data.length; i++) {
                    data[i].knowledgeSize = conver(data[i].knowledgeSize);
                }
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
            url: pageContext.resourcePath + '/library/dynamic?page=1&pageSize=10 &libraryId='+libraryId,
            dataType: 'json',
            success: function (result) {
                var data = result.rows;
                for (var i = 0; i < data.length; i++) {
                    data[i].knowledgeSize = conver(data[i].knowledgeSize);
                }
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
})
