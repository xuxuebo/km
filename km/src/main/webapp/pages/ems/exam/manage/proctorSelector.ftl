<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>选择器</title>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css" type="text/css"/>
</head>
<body class="pe-selector-body" style="padding: 15px 20px;">
<div class="pe-selector-wrap">
    <div class="pe-panel pe-panel-default">
        <div class="pe-panel-header">
            <form class="pe-form" id="adminUserForm">
                <div class="pe-form-cell">
                    <div class="pe-control-group" style="position: relative;">
                        <label for="keyword">关键字：</label>
                        <input id="keyword" class="pe-tree-form-text" name="keyword" placeholder="姓名/用户名/工号/手机"
                               type="text"/>
                        <span class="iconfont pe-tree-search-btn icon-search-magnifier"
                              style="position: absolute;top: 5px;right: -2px;"></span>
                    </div>
                </div>
            </form>
        </div>
        <div class="pe-panel-body pe-selector-content">
            <div class="pe-selector-available">
                <div class="pe-panel pe-panel-info">
                    <div class="pe-panel-header">
                        待选（<span id="peAvailableNum">0</span>）
                    </div>
                    <div class="pe-panel-body pe-selector-list-content">
                        <div class="pe-selector-list-wrap">
                            <table class="pe-table">
                                <thead>
                                <tr>
                                    <th style="width: 146px;">用户名</th>
                                    <th>姓名</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
            <div class="pe-selector-opt">
                <button class="pe-btn pe-btn-blue pe-btn-block" type="button" data-role="select">选择 &gt;</button>
                <button class="pe-btn pe-btn-blue pe-btn-block" type="button" data-role="selectAll">全选&gt;&gt;</button>
                <button class="pe-btn pe-btn-blue pe-btn-block" type="button" data-role="remove">&lt; 移除</button>
                <button class="pe-btn pe-btn-blue pe-btn-block" type="button" data-role="removeAll">&lt;&lt;清空</button>
            </div>
            <div class="pe-selector-selected">
                <div class="pe-panel pe-panel-info">
                    <div class="pe-panel-header">
                        已选（<span id="peSelectedNum">0</span>）
                    </div>
                    <div class="pe-panel-body pe-selector-list-content">
                        <div class="pe-selector-list-wrap">
                            <table class="pe-table">
                                <thead>
                                <tr>
                                    <th style="width: 146px;">用户名</th>
                                    <th>姓名</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js"></script>
<script src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js" type="application/javascript"></script>
<script type="text/template" id="peAvailableTpl">
    <%for(var i=0;i < list.length ;i++){%>
    <tr class="<%=list[i].selected?'unable':''%>" data-index="<%=i%>">
        <td title="<%=list[i].loginName%>"><%=list[i].loginName%></td>
        <td title="<%=list[i].userName%>"><%=list[i].userName%></td>
    </tr>
    <%}%>
</script>
<script type="text/template" id="peSelectedTpl">
    <%for(var i=0;i < list.length;i++){%>
    <tr data-index="<%=i%>" class="<%=list[i].createUser?'unable':''%>">
        <td title="<%=list[i].loginName%>"><%=list[i].loginName%></td>
        <td title="<%=list[i].userName%>"><%=list[i].userName%></td>
    </tr>
    <%}%>
</script>
<#--
todo
1、高级筛选
2、list[i].createBank  创建人小图标
-->
<script>
    $(function () {
        var id = '${id!}';
        var type = '${type!}';
      /*  var referIds = [];*/
        var selector = {
            URLS: {
                available: '${ctx!}/ems/exam/manage/searchAdmin?id=' + id + '&type=' + type,
                selected: '${ctx!}/ems/exam/manage/searchAuthorize?id=' + id + '&type=' + type,
                save: '${ctx!}/ems/exam/manage/saveExamAdmin',
                remove: '${ctx!}/ems/exam/manage/deleteExamAdmin'
            },
            availableData: [],
            selectData: [],
            renderAvailable: function (data) {
                var _this = this;
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    url: _this.URLS.available + '&' + $('#adminUserForm').serialize(),
                    success: function (page) {
                        _this.availableData = page.rows;
                        $('.pe-selector-available tbody').html(_.template($('#peAvailableTpl').html())({list: _this.availableData}));
                        $('#peAvailableNum').html(_this.availableData.length);
                    }
                });
            },
            renderSelected: function (data) {
                var _this = this;
                data = $.extend({'autoPaging': false}, data);
                if ('JUDGE_ITEM_USER' === type) {
                    data['itemIds'] = $(parent.document).find("#itemIds").val();
                }

                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    url: _this.URLS.selected,
                    success: function (data) {
                        _this.selectData = data;
                        $('.pe-selector-selected tbody').html(_.template($('#peSelectedTpl').html())({list: _this.selectData}));
                        $('#peSelectedNum').html(_this.selectData.length);
                        localStorage.setItem(type + '_count_' + id, _this.selectData.length);
                        var userSpan = "";
                        for (var i = 0; i < _this.selectData.length; i++) {
                            userSpan += "<a class='tags add-question-bank-item bank-list' data-id='" + _this.selectData[i].id + "'  data-text='" + _this.selectData[i].userName + "' >"
                                    + "<span class='has-item-user-name' title='"+ _this.selectData[i].userName + "'>"+ _this.selectData[i].userName +"</span>";

                            if(!_this.selectData[i].createUser){
                                userSpan+="<span class='iconfont icon-inputDele'></span></a>";
                            }
                        }
                        localStorage.setItem(type + '_name_' + id, userSpan);
                    }
                });
            },
            init: function () {
                var _this = this;
                _this.renderAvailable();
                _this.renderSelected();
                _this.initEvent();
            },
            save: function (data) {
                var _this = this;
                var referIds = [];
                for (var key in data) {
                    referIds.push(data[key]);
                }
                data = {
                    'id': id,
                    'type': type,
                    'referIds': JSON.stringify(referIds),
                    'examUserType': 'USER'
                };
                if ('JUDGE_ITEM_USER' === type) {
                    data['itemIds'] = $(parent.document).find("#itemIds").val();
                }
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    url: selector.URLS.save,
                    success: function (data) {
                        if (data.success) {
                            _this.renderAvailable();
                            _this.renderSelected();
                        } else {
                            alert('保存出错');
                        }
                    },
                    error: function () {
                        alert('请选择人员');
                    }
                });
            },
            remove: function (data) {
                var _this = this;
                var referIds = [];
                for (var key in data) {
                    referIds.push(data[key]);
                }

                data = {'id': id, 'type': type, 'referIds': JSON.stringify(referIds)};
                if ('JUDGE_ITEM_USER' === type) {
                    data['itemIds'] = $(parent.document).find("#itemIds").val();
                }
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    url: selector.URLS.remove,
                    success: function (data) {
                        if (data.success) {
                            _this.renderAvailable();
                            _this.renderSelected();
                        } else {
                            alert('保存出错');
                        }
                    },
                    error: function () {
                        alert('请选择人员');
                    }
                });
            },
            initEvent: function () {
                var _this = this;
                //交互
                $('.pe-selector-available,.pe-selector-selected').on('click', "tbody tr", function (e) {
                    $('.pe-selector-available tr').removeClass('selected');
                    $('.pe-selector-selected tr').removeClass('selected');
                    if (!$(this).hasClass('unable')) {
                        $(this).toggleClass("selected");
                    }
                });

                //选择
                $('button[data-role="select"]').click(function () {
                    var itemsObj = {};
                    $('.pe-selector-available tr.selected').each(function (index, item) {
                        var num = $(this).attr("data-index");
                        itemsObj['users[' + index + '].id'] = _this.availableData[num].id;
                    });

                    _this.save(itemsObj);
                });

                //全选
                $('button[data-role="selectAll"]').click(function () {
                    var itemsObj = {};
                    for (var i = 0; i < _this.availableData.length; i++) {
                        itemsObj['users[' + i + '].id'] = _this.availableData[i].id;
                    }
                    _this.save(itemsObj);
                });


                //移除
                $('button[data-role="remove"]').click(function () {
                    var itemsObj = {};
                    $('.pe-selector-selected tr.selected').each(function (index, item) {
                        var num = $(this).attr("data-index");
                        itemsObj['users[' + index + '].id'] = _this.selectData[num].id;
                    });
                    _this.remove(itemsObj);
                });

                //清空
                $('button[data-role="removeAll"]').click(function () {
                    var itemsObj = {};
                    for (var i = 0; i < _this.selectData.length; i++) {
                        itemsObj['users[' + i + '].id'] = _this.selectData[i].id;
                    }
                    _this.remove(itemsObj);
                });

                //保存
                $('button[data-role="save"]').click(function () {
                    var itemsObj = {};
                    for (var i = 0; i < _this.selectData.length; i++) {
                        itemsObj['users[' + i + '].id'] = _this.selectData[i].id;
                    }
                    _this.save(itemsObj);
                });

                $('.pe-tree-search-btn').on('click', function () {
                    selector.renderAvailable();
                });

            }
        };

        selector.init();
        //去除搜索框的enter事件
        $('#keyword').keydown(function (e) {
            var e = e || window.event;
            if (e.keyCode == 13) {
                e.preventDefault();
            }
        });

        $(document).ajaxSend(function (event, jqxhr, settings) {
            var times = (new Date()).getTime() + Math.floor(Math.random() * 10000);
            if (settings.url.indexOf('?') > -1) {
                settings.url = settings.url + '&_t=' + times;
            } else {
                settings.url = settings.url + '?_t=' + times;
            }

        });
    })
</script>
</body>
</html>