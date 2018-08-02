$(function () {
    var $yunContentBody = $('#yunLContentBody');
    var $yAside = $('#YAside');
    // 初始化树
    initTree();
    //路由
    var publicId = "";
    var publicName = "";
    var breadCrumbsList = [{title: '全部', id: $("#myLibrary").val()}];
    var _breadCrumbsTpl = $("#breadCrumbsTpl").html();

    var route = {
        routes: {
            "selectFileMore": {
                "templateId": '#fileAllList',
                nav: 'share-yun',
                cb: "fileCb"
            },
            "selectActivityMore": {
                "templateId": '#activityAllList',
                nav: 'share-yun',
                cb: "yunActivityCb"
            }
        },
        fileCb: function (container, routeInfo, cb) {
            breadCrumbsList.length =1;
            initFilePage(container, routeInfo);
        },
        yunActivityCb:function (container, routeInfo, cb) {
            breadCrumbsList.length =1;
            initActivityPage(container, routeInfo);
        }
    };

    //初始化
    function changeHashCb(cb) {
        var _hash = location.hash.substring(1);
        if (!_hash) {
            location.hash = 'yun';
        }
        var hashArr = _hash.split("/");
        $yAside.find("li").removeClass('active');
        var routeInfo;
        if (hashArr.length > 1) {
            var subNav = hashArr[1];
            publicId = subNav;
            var subName = $yAside.find('a[data-id="' + subNav + '"]').children('span').data("name");
            publicName = subName;
            //元素同胞
            $yAside.find('a[data-id="' + subNav + '"]').parent().addClass('active').siblings().removeClass('active');

            //$('#yunLContentBody').html('<iframe style="width:100%;height: 100%;margin-left: -170px;" src="/km/front/manage/initPage#url=/km/knowledge/initPublicLibraryPage"></iframe>');
            //$('#yunLContentBody').html('<iframe style="width:100%;height: 100%;margin-left: -170px;" src="/km/front/manage/initPage#url=/km/knowledge/initPublicLibraryPage?libraryId='+publicId+'"></iframe>');
            for (var key in route.routes) {
                if (new RegExp(key).test(_hash)) {
                    routeInfo = route.routes[key];
                    break;
                }
            }
        } else {
            routeInfo = route.routes[hashArr[0]]
        }
        if (typeof routeInfo === "undefined") {
            console.warn('没有改路由信息');
            return;
        }
        /*定位菜单*/
        var $curNav = $yAside.find('.' + routeInfo.nav);
        if ($curNav.size() > 0) {
            $curNav.addClass('active').siblings().removeClass('active');
        }
        if (routeInfo.cb) {
            route[routeInfo.cb]($yunContentBody, routeInfo, cb);
            /* try {

             } catch (e) {
             console.error("没有此" + routeInfo.cb + "方法", e);
             }*/
        }
    }

    //修改
    if (('onhashchange' in window) && ((typeof document.documentMode === 'undefined') || document.documentMode == 8)) {
        $(window).bind("hashchange", changeHashCb);
    }

    /*初始化*/
    changeHashCb();


    // 文件查看更多
    function  initFilePage(container, routeInfo) {
        var _tpl = $(routeInfo.templateId).html();
        container.html(_.template(_tpl)({title: '项目文件'}));
        //table渲染
        var _table = $("#allFileTable").html();
        var $yunTable = $('#fileTable');
        var data = [];
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/knowledge/searchKnowledge?libraryId=1&page=1&pageSize=100',
            dataType: 'json',
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
            $yunTable.html(_.template(_table)({list: data, sort: initSort}));
            table = initTable($yunTable);
        }
    }

    // 云库查看更多
    function initActivityPage(container, routeInfo) {
        var _tpl = $(routeInfo.templateId).html();
        container.html(_.template(_tpl)({title: '云库动态'}));
        //table渲染
        var _table = $("#allActivityTable").html();
        var $yunTable = $('#yunActivityTable');
        var data = [];
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/knowledge/searchKnowledge?libraryId=1&page=1&pageSize=100',
            dataType: 'json',
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
            $yunTable.html(_.template(_table)({list: data, sort: initSort}));
            table = initTable($yunTable);
        }
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

    //初始化菜单
    function initTree(){
        var settingInputTree = {
            isOpen: true,
            dataUrl: pageContext.rootPath + '/km/library/listLibrary?type=PROJECT_LIBRARY',
            clickNode: function (treeNode) {
                orgTreeId = treeNode.id;
                // 项目介绍
                initProjectDesc(orgTreeId);
                //项目文件
                initMajorProject(orgTreeId);
                // 贡献榜单
                //initContribution(orgTreeId);
                //云库动态
                initActivity(orgTreeId);
            },
            treePosition: 'inputDropDown'
        };
        PEMO.ZTREE.initTree('majorProjectTree', settingInputTree);
        setTimeout(function() {
            var zTree= $.fn.zTree.getZTreeObj("majorProjectTree");
            var nodes = zTree.getNodes();
            zTree.checkNode(nodes[0], true, true);
            // 项目介绍
            initProjectDesc(nodes[0].id);
            //项目文件
            initMajorProject(nodes[0].id);
            // 贡献榜单
            //initContribution(nodes[0].id);
            //云库动态
            initActivity(nodes[0].id)
        }, 3000);

    }
    // 项目介绍
    function initProjectDesc(orgTreeId){
        var projectDetailDetail = $('#projectDetailDetail').html();
        var $projectDeatil = $("#projectDeatil");
        var data= null;
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/library/load?libraryId='+orgTreeId,
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
    function initMajorProject(orgTreeId) {
        var tplsFileTable = $('#tplsFileTable').html();
        var $fileList = $("#fileList");
        var data = [];
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/knowledge/searchKnowledge?page=1&pageSize=100&libraryId='+orgTreeId,
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
    function initActivity(orgTreeId) {
        var tplsActivityTable = $('#tplsActivityTable').html();
        var $activityList = $("#activityList");
        var data = [];
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/library/dynamic?page=1&pageSize=10 &libraryId='+orgTreeId,
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
    window.refreshPage = function () {
        var id = $('#myLibrary').val();
        route['YunCb']($yunContentBody, route.routes.yun, null, id);
    }
})

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
//
function funDownload(content, filename) {
    // 创建隐藏的可下载链接
    var a = document.createElement('a');
    a.download = filename;
    a.style.display = 'none';
    // 字符内容转变成blob地址
    //var blob = new Blob([content]);
    //console.log(blob);
    //a.href = URL.createObjectURL(blob);
    a.href = content;
    // 触发点击
    document.body.appendChild(a);
    a.click();
    // 然后移除
    document.body.removeChild(a);
};
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

function handleName(name) {
    if (name.length >= 10) {
        name = name.substring(0, 10);
    }
    return name;
}

function loginOut() {
    PEMO.DIALOG.confirmL({
        content: '您确定退出吗？',
        area: ['350px', '173px'],
        title: '提示',
        btn: ['取消', '确定'],
        btnAlign: 'c',
        skin: ' pe-layer-confirm pe-layer-has-tree login-out-dialog-layer',
        btn1: function () {
            layer.closeAll();
        },
        btn2: function () {
            location.href = pageContext.rootPath + '/km/client/logout';
        },
        success: function () {
            PEBASE.peFormEvent('checkbox');
        }
    });
}

