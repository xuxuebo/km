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
            <form class="pe-form">
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
                        已选（<span id="peSelectedNum">0</span>）<span style="color: red;">注：最多选择4个监考员</span>
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
    <tr data-index="<%=i%>" data-id="<%=list[i].id%>" class="select-user" data-name="<%=list[i].userName%>"
        data-login="<%=list[i].loginName%>">
        <td  title="<%=list[i].loginName%>"><%=list[i].loginName%></td>
        <td title="<%=list[i].userName%>"><%=list[i].userName%></td>
    </tr>
    <%}%>
</script>
<script>
    $(function () {
//        PEBASE.isPlaceholder();
        var selector = {
            arrangeId: '${(arrangeId)!}',
            limitNum: 4,
            URLS: {
                available: '${ctx!}/ems/itemBank/manage/searchAdmin',
                selected: '',
                save: ''
            },
            availableData: [],
            selectData: [],
            renderAvailable: function () {
                $('#peAvailableNum').text(this.availableData.length);
                $('.pe-selector-available tbody').html(_.template($('#peAvailableTpl').html())({list: this.availableData}));
            },
            renderSelected: function () {
                $('#peSelectedNum').text(this.selectData.length);
                $('.pe-selector-selected tbody').html(_.template($('#peAvailableTpl').html())({list: this.selectData}));
            },

            searchAdmin: function (data) {
                var id = '';
                $.each(selector.selectData, function (index, data) {
                    if (index != 0) {
                        id = id + ',';
                    }

                    id = id + data.id;
                });

                $('.add-question-bank-item', parent.document).each(function (i, e) {
                    var userId = $(this).data('id');
                    if (id) {
                        id = id + ',';
                    }

                    id = id + userId;
                });

                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    url: selector.URLS.available,
                    success: function (data) {
                        selector.availableData.length = 0;
                        for (var index = 0; index < data.rows.length; index++) {
                            if (id.indexOf(data.rows[index].id) === -1) {
                                selector.availableData.push(data.rows[index]);
                            }
                        }

                        selector.renderAvailable();
                    }
                });
            },
            init: function () {
                var _this = this;
                _this.searchSelected();
                _this.searchAdmin(null);
                _this.initEvent();
            },
            searchSelected: function () {
                $('#arrangeMonitor${(arrangeId)!}', parent.document).find('.add-question-bank-item').each(function (i, e) {
                    selector.selectData.push({
                        id: $(this).data('id'),
                        loginName: $(this).data('login'),
                        userName: $(this).attr('title')
                    });
                });

                selector.renderSelected();
            },
            initEvent: function () {
                var _this = this;
                //交互
                $('.pe-selector-available,.pe-selector-selected').on('click', "tbody tr", function (e) {
               /*     $('.pe-selector-available tr').removeClass('selected');
                    $('.pe-selector-selected  tr').removeClass('selected');*/
                    if (!$(this).hasClass('unable')) {
                        $(this).toggleClass("selected");
                    }
                });
                //选择
                $('button[data-role="select"]').click(function () {
                    var indexArr = [];
                    var $selected = $(".pe-selector-available tr.selected");
                    var count = _this.selectData.length  + $selected.size();
                    $('.pe-selector-available tr.selected').each(function () {
                        indexArr.push(parseInt($(this).attr('data-index')));
                    });

                    if (count > _this.limitNum) {
                        layer.msg('超过人数上限');
                        return false;
                    }


                    for (var i = 0; i < indexArr.length; i++) {
                       /* _this.availableData.splice(indexArr[i], 1);*/
                        _this.selectData.push(_this.availableData[indexArr[i]]);
                    }

                    for (var i = 0; i < indexArr.length; i++) {
                        _this.availableData.splice(indexArr[i], 1);
                    }

                    _this.renderAvailable();
                    _this.renderSelected();
                });

                //全选
                $('button[data-role="selectAll"]').click(function () {
                    if ((_this.selectData.length + _this.availableData.length) >= _this.limitNum) {
                        layer.msg('超过人数上限');
                        return false;
                    }

                    for (var i = 0; i < _this.availableData.length; i++) {
                        _this.selectData.push(_this.availableData[i]);
                    }
                    _this.availableData = [];
                    _this.renderAvailable();
                    _this.renderSelected();
                });

                //移除
                $('button[data-role="remove"]').click(function () {
                    var indexArr = [];
                    $('.pe-selector-selected tr.selected').each(function () {
                        indexArr.push(parseInt($(this).attr('data-index')));
                    });

                    for (var i = 0; i < indexArr.length; i++) {
                        _this.availableData.unshift(_this.selectData[indexArr[i]]);
                    }

                    for(var i = 0; i< indexArr.length;i++){
                        _this.selectData.splice(indexArr[i],1);
                    }

                    _this.renderAvailable();
                    _this.renderSelected();
                });

                //清空
                $('button[data-role="removeAll"]').click(function () {
                    for (var i = 0; i < _this.selectData.length; i++) {
                        if (!_this.selectData[i].selected) {
                            _this.availableData.unshift(_this.selectData.splice(i, 1)[0]);
                            i--;
                        }
                    }
                    _this.renderAvailable();
                    _this.renderSelected();
                });

                //保存
                $('button[data-role="save"]').click(function () {
                    var param = {
                        bankAuths: JSON.stringify(_this.selectData)
                    };

                });

                //关键字搜索
                $('.pe-tree-search-btn').on('click', function () {
                    selector.searchAdmin($('.pe-form').serialize());
                });

            }
        };

        selector.init();
        //关键字搜索
        $('#keyword').keydown(function (e) {
            if (e.keyCode == 13) {
                selector.searchAdmin($('.pe-form').serializeArray());
                return false;
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
    });


</script>
</body>
</html>