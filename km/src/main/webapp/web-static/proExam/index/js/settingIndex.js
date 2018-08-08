
$(function(){
    var $yunContentBody = $('#yunContentBody');
    var $yAside = $('#YAside');
    //路由
    var route = {
        routes: {
            'user':{
              "templateId":'#tplUser',
                nav:'y-user',
                cb:"userCb"
            },
            'organize':{
                "templateId":'#tplOrganize',
                nav:'y-organize',
                cb:"organizeCb"
            },
            'role':{
                "templateId":'#tplRole',
                nav:'y-role',
                cb:"roleCb"
            },
            'position':{
                "templateId":'#tplPosition',
                nav:'y-position',
                cb:"positionCb"
            },

            'library':{
                "templateId":'#tplLibrary',
                nav:'y-library',
                cb:"libraryCb"
            },
            'label':{
                "templateId":'#tplLabel',
                nav:'y-label',
                cb:"labelCb"
            },
            'specialty':{
                "templateId":'#tplSpecialty',
                nav:'y-specialty',
                cb:"specialtyCb"
            },
            'project':{
                "templateId":'#tplProject',
                nav:'y-project',
                cb:"projectCb"
            }
        },
        userCb: function (container, routeInfo, cb) {
            $('#yunContentBody').html('<iframe style="width:100%;height: 100%;" src="/km/front/manage/initPage#url=/km/uc/user/manage/initPage"></iframe>');
            // initYunPage(container, routeInfo,'用户管理');
        },
        organizeCb: function (container, routeInfo, cb) {
            $('#yunContentBody').html('<iframe style="width:100%;height: 100%;margin-left: 0;" src="/km/front/manage/initPage#url=/km/uc/organize/manage/initPage"></iframe>');
            //initYunPage(container, routeInfo,'部门管理');
        },
        // roleCb: function (container, routeInfo, cb) {
        //     initYunPage(container, routeInfo,'角色管理');
        // },
        positionCb: function (container, routeInfo, cb) {
            $('#yunContentBody').html('<iframe style="width:100%;height: 100%;margin-left:0;" src="/km/front/manage/initPage#url=/km/uc/position/manage/initPage"></iframe>');
            // initYunPage(container, routeInfo,'岗位管理');
        },
        labelCb: function (container, routeInfo, cb) {
            $('#yunContentBody').html('<iframe style="width:100%;height: 100%;margin-left: 0;" src="/km/front/manage/initPage#url=/km/km/label/initPage"></iframe>');
            //initYunPage(container, routeInfo,'标签管理');
        },
        libraryCb:function (container, routeInfo, cb) {
            $('#yunContentBody').html('<iframe style="width:100%;height: 100%;margin-left:0;" src="/km/front/manage/initPage#url=/km/library/manage/initPage"></iframe>');
        },
        specialtyCb:function (container, routeInfo, cb) {
            $('#yunContentBody').html('<iframe style="width:100%;height: 100%;margin-left:0;" src="/km/front/manage/initPage#url=/km/specialty/manage/initPage"></iframe>');
        },
        projectCb:function (container, routeInfo, cb) {
            $('#yunContentBody').html('<iframe style="width:100%;height: 100%;margin-left:0;" src="/km/front/manage/initPage#url=/km/project/manage/initPage"></iframe>');
        }
    };

    function changeHashCb(cb) {
        var _hash = location.hash.substring(1);
        if (!_hash) {
            location.hash = 'user';
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

    if (('onhashchange' in window) && ((typeof document.documentMode === 'undefined') || document.documentMode >= 8)) {
        $(window).bind("hashchange", changeHashCb);
    }

    changeHashCb();

    function initYunPage(container, routeInfo,title) {
        var _tpl = $(routeInfo.templateId).html();
        container.html(_.template(_tpl)({title: title}));

        var _table = $("#tblUserTable").html();//表头
        var $userTable = $('#userTable');//div

        // $('#userTable').load('/km/front/manage/initPage#url=/km/uc/user/manage/initPage')
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