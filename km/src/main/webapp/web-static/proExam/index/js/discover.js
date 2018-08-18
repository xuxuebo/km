$(function () {
    var $hotTagContainer = $('#hotTagContainer'),
        $tplHotTagContainer = $('#tplHotTagContainer'),
        $hotResource = $('#hotResource'),
        $tplHotResourceContainer = $('#tplHotResourceContainer'),
        $ctrPerson = $('#ctrPerson'),
        $ctrPersonNav = $('#ctrPersonNav'),
        $tplCtrPerson = $('#tplCtrPerson'),
        $departmentRank = $('#departmentRank'),
        $tplDepartmentRank = $('#tplDepartmentRank'),
        $dSearchNpt = $('#dSearchNpt'),
        $dSearchGlobal = $('#dSearchGlobal'),
        $dSearchPersonal = $('#dSearchPersonal'),
        $dSearchFileNum = $('#dSearchFileNum'),
        $dSearchUploadNum = $('#dSearchUploadNum'),
        $dCloudList = $('#dCloudList'),
        $tplCloudList = $('#tplCloudList');

    // 渲染文件数量-已上传数量
    $.ajax({
        url: pageContext.resourcePath + "/statistic/fileCount",
        dataType: 'json',
        success: function (result) {
            if (result) {
                $dSearchFileNum.text(result.totalCount);
                $dSearchUploadNum.text(result.dayCount);
            }
        }
    });


    // 渲染热门标签
    function renderHotTag() {
        var hotTagData = {};
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + "/library/hotLibrary",
            data: {"libraryType":"PROJECT_LIBRARY", "hotCount":8},
            dataType: 'json',
            success: function (result) {
                hotTagData.hotProject=result;
            }
        });
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + "/library/hotLibrary",
            data: {"libraryType":"SPECIALTY_LIBRARY", "hotCount":8},
            dataType: 'json',
            success: function (result) {
                hotTagData.hotMajor=result;
                var html = _.template($tplHotTagContainer.html())({
                    d: hotTagData
                });
                $hotTagContainer.html(html);
            }
        });
    }

    renderHotTag();

    // 渲染热门资源
    function renderHotResource() {
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + "/knowledge/searchHotKnowledge",
            data: {"page":1,"pageSize":7},
            dataType: 'json',
            success: function (result) {
                $hotResource.html(_.template($tplHotResourceContainer.html())({list: result.rows}));
            }
        });

    }

    renderHotResource();

    // 渲染贡献达人
    function renderCtrPerson(type) {
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/statistic/rank?type=' + type,
            dataType: 'json',
            success: function (result) {
                $ctrPerson.html(_.template($tplCtrPerson.html())({list: result}));
            }
        });
    }

    renderCtrPerson("WEEK");

    // 渲染达人类别点击事件
    $ctrPersonNav.delegate('.d-ctr__nav', 'click', function() {
        var $this = $(this);
        var type = $this.attr('data-type');
        $this.addClass('active').siblings().removeClass('active');
        renderCtrPerson(type);
    });

    // 渲染部门排行
    function renderDepartmentRank() {
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/statistic/orgRank',
            dataType: 'json',
            success: function (result) {
                $departmentRank.html(_.template($tplDepartmentRank.html())({list: result}));
            }
        });
    }

    renderDepartmentRank();

    // 全局搜索点击事件
    $dSearchGlobal.click(function() {
        var val = $.trim($dSearchNpt.val());
        if(!val) {
            return;
        }

        $(".discover-all-search").val(val);
        $("li[data-type='dataShare']").click();
    });

    // 个人云库搜索点击事件
    $dSearchPersonal.click(function() {
        var val = $.trim($dSearchNpt.val());
        if(!val) {
            return;
        }

        $(".discover-search").val(val);
        $("#searchKeyword").val(val);
        $("li[data-type='index']").click();
    });

    // 渲染云库动态
    function renderCloudList() {
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/library/dynamic',
            data: {"page":1,"pageSize":6},
            dataType: 'json',
            success: function (result) {
                $dCloudList.html(_.template($tplCloudList.html())({list: result.rows}));
            }
        });
    }

    renderCloudList();
});