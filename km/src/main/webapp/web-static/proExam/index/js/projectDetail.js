$(function () {
    var libraryId= '${libraryId!}';
    // 项目介绍
    function initProjectDesc(){
        var projectDetailDetail = $('#projectDetailDetail').html();
        var $projectDeatil = $("#projectDeatil");
        var data= null;
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/library/load?libraryId='+libraryId,
            dataType: 'json',
            success: function (result) {
                data = JSON.parse(result);
            }
        });
        var table, initSort = {
            name: "desc",
            size: "desc",
            uploadTime: "desc"
        };
        if(data){
            renderTable();
            function renderTable() {
                $projectDeatil.html(_.template(projectDetailDetail)({data: data, sort: initSort}));
            }
        }
    }
    // 初始化项目
    function initMajorProject() {
        var tplsFileTable = $('#tplsFileTable').html();
        var $fileList = $("#fileList");
        var data = [];
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/knowledge/searchKnowledge?page=1&pageSize=100&libraryId='+libraryId,
            dataType: 'json',
            success: function (result) {
                data = result.rows;
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
            $fileList.html(_.template(tplsFileTable)({list: data, sort: initSort}));
        }
    }
    // 贡献榜单
    // 云库动态
    function initActivity() {
        var tplsActivityTable = $('#tplsActivityTable').html();
        var $activityList = $("#activityList");
        var data = [];
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/library/dynamic?page=1&pageSize=10 &libraryId='+libraryId,
            dataType: 'json',
            success: function (result) {
                data = result.rows;
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
            $activityList.html(_.template(tplsActivityTable)({list: data, sort: initSort}));
        }
    }
})
