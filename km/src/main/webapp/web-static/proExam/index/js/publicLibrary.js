$(function () {
    var $yunContentBody = $('#yunLContentBody');
    var $yAside = $('#YAside');
    //路由
    var publicId = "";
    var publicName = "";
    var breadCrumbsList = [{title: '全部', id: $("#myLibrary").val()}];
    var _breadCrumbsTpl = $("#breadCrumbsTpl").html();
    var route = {
        routes: {
            'yun': {
                "templateId": '#tplYun',
                nav: 'my-yun',
                cb: "YunCb"
            },
            'yunRecycle': {
                "templateId": '#tplRecycle',
                nav: 'recycle-yun',
                cb: "recycleCb"
            }
        },
        YunCb: function (container, routeInfo, cb, id) {
            initYunPage(container, routeInfo, cb, id);
        },
        recycleCb: function (container, routeInfo, cb) {
            breadCrumbsList.length =1;
            initRecycle(container, routeInfo);
        }
    };
    //修改
    if (('onhashchange' in window) && ((typeof document.documentMode === 'undefined') || document.documentMode == 8)) {
        $(window).bind("hashchange", changeHashCb);
    }
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
        }
    }

    /*初始化*/
    changeHashCb();

    //初始化我的云库页面
    function initYunPage(container, routeInfo, cb, id) {
        var _tpl = $(routeInfo.templateId).html();
        container.html(_.template(_tpl)({title: '我的云库'}));
        //table渲染
        var _table = $("#tplYunTable").html();
        var $yunTable = $('#yunTable');
        var data = [];
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/knowledge/search',
            data: {'libraryId': 1},
            dataType: 'json',
            success: function (result) {
                data = result;
                renderTable();
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
    //回收站
    function initRecycle(container, routeInfo) {
        var _tpl = $(routeInfo.templateId).html();
        container.html(_.template(_tpl)({title: '我的回收站'}));
        //table渲染
        var _table = $("#tplRecycleTable").html();
        var $yunTable = $('#recycleTable');
        var data = [];
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/knowledge/search',
            data: {'libraryId': 1},
            dataType: 'json',
            success: function (result) {
                data = result;
                renderTable();
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

    window.refreshPage = function () {
        var id = $('#myLibrary').val();
        route['YunCb']($yunContentBody, route.routes.yun, null, id);
    }
})




