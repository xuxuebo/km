'use strict';
requirejs(['jquery', 'underscore', "layer"], function ($, _, layer) {
    var $yunContentBody = $('#yunContentBody');
    var $yAside = $('#YAside');
    //路由
    var route = {
        routes: {
            'yun': {//'yun'
                "templateId": '#tplYun',
                nav: 'my-yun',
                cb: "YunCb"
            },
            //TODO
            'public/.+': {//'index'
                "templateId": '#tplPublic',
                nav: 'public-yun',
                cb: "publicCb"
            },
            'recycle': {//'index'
                "templateId": '#tplRecycle',
                nav: 'recycle-yun',
                cb: "recycleCb"
            }
        },
        YunCb: function (container, routeInfo, cb) {
            initYunPage(container, routeInfo);
        },
        publicCb: function (container, routeInfo, cb) {
            initPublicPage(container, routeInfo);
        },
        recycleCb: function (container, routeInfo, cb) {
            initRecyclePage(container, routeInfo);
        }
    };

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
            try {
                route[routeInfo.cb]($yunContentBody, routeInfo, cb);
            } catch (e) {
                console.error("没有此" + routeInfo.cb + "方法", e);
            }
        }
    }

    if (('onhashchange' in window) && ((typeof document.documentMode === 'undefined') || document.documentMode == 8)) {
        $(window).bind("hashchange", changeHashCb);
    }

    /*初始化*/
    changeHashCb();


    //我的云盘
    function initYunPage(container, routeInfo) {
        var _tpl = $(routeInfo.templateId).html();
        container.html(_.template(_tpl)({title: '我的云库'}));
        //table渲染
        var data = [
            {
                id: '1231',
                fileType: 'file',
                fileName: '2018/05/11会议材料',
                size: '-',
                time: '2018/05/13 11:20'
            },
            {
                id: '1232131312',
                fileType: 'audio',
                fileName: '2018/05/11会议材料',
                size: '43.45M',
                time: '2018/05/13 11:20'
            },
            {
                id: '1232131331',
                fileType: 'video',
                fileName: '2018/05/11会议材料',
                size: '43.45M',
                time: '2018/05/13 11:20'
            },
            {
                id: '1232131314',
                fileType: 'word',
                fileName: '2018/05/11会议材料',
                size: '43.45M',
                time: '2018/05/13 11:20'
            }
        ];
        var _table = $("#tplTable").html();
        var $yunTable = $('#yunTable');

        var table, initSort = {
            name: "desc",
            size: "desc",
            uploadTime: "desc"
        };
        renderTable();
        function renderTable() {
            $yunTable.html(_.template(_table)({list: data, sort: initSort}));
            table = initTable($yunTable);
            $yunTable.find('.sort').click(function () {
                data.splice(0, 0, {
                    id: '1231',
                    fileType: 'video',
                    fileName: '排序数据',
                    size: '23M',
                    time: '2018/05/13 11:20'
                });
                //降序 TODO
                $yunTable.html(_.template(_table)({
                    list: data, sort: $.extend({}, initSort, {name: 'asc'})
                }));
            });
        }

        //绑定事件
        //复制到我的云库
        $('.js-copy').on('click', function () {
            var selectList = table.getSelect();
            if (selectList.length === 0) {
                layer.msg("请先选择操作项");
                return;
            }
            //TODO
        });
        //下载
        $('.js-download').on('click', function () {

        });
        //删除
        $('.js-del').on('click', function () {

        });


    }

    //公共库
    function initPublicPage() {

    }

    //回收站
    function initRecyclePage() {

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


        return {
            getSelect: function () {
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

});