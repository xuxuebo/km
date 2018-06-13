<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>选择器</title>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/iconfont.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css"/>
</head>
<body class="pe-selector-body" style="padding: 0 20px 15px;">
<div class="pe-selector-wrap">
    <div class="pe-panel pe-panel-default">
        <div class="pe-panel-body pe-selector-content" style="border-top-width: 0px;">
            <div class="pe-selector-available">
                <div class="pe-panel pe-panel-info">
                    <div class="pe-panel-header" style="position: relative;">
                        待选（<span id="peAvailableNum">0</span>）
                        <input id="keyword" class="pe-tree-form-text" style="width:170px;height:15px;border:1px;"
                               name="knowledge" placeholder="（已选题库下包含的知识点）" type="text"/>
                        <span class="iconfont pe-tree-search-btn icon-search-magnifier" style="position: absolute;top: 15px;right: 0px;"></span>
                    </div>
                    <div class="pe-panel-body pe-selector-list-content">
                        <div class="pe-selector-list-wrap">
                            <table class="pe-table">
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
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="pe-selector-opt-bar text-right" style="padding: 11px 0;">
        <button type="button" class="pe-btn pe-btn-green" data-role="save">保存</button>
    </div>
</div>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
<script src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}" type="application/javascript"></script>
<script type="text/template" id="peAvailableTpl">
    <%for(var i=0;i < list.length ;i++){%>
    <tr class="<%=list[i].selected?'unable':''%>" data-index="<%=i%>">
        <td title="<%=list[i].knowledgeName%>"><%=list[i].knowledgeName%></td>
    </tr>
    <%}%>
</script>
<script type="text/template" id="peSelectedTpl">
    <%for(var i=0;i < list.length;i++){%>
    <tr data-index="<%=i%>">
        <td title="<%=list[i].knowledgeName%>" data-name="<%=list[i].knowledgeName%>" data-id="<%=list[i].id%>"><%=list[i].knowledgeName%></td>
    </tr>
    <%}%>
</script>
<#--
todo
list[i].createBank  创建人小图标
-->
<script>

    $(function () {
        //ie9不支持Placeholder问题
//        PEBASE.isPlaceholder();
        var itemAttribute='${itemAttribute!}';
        var bankIds = [];
        $('input[name="itemBankId"]',parent.document).each(function (index, ele) {
            bankIds.push($(ele).val());
        });

        var templateId = $('input[name="templateId"]',parent.document).val();
        var selector = {
            URLS: {
                available: '${ctx!}/ems/knowledge/manage/listForTemplate?bankIds='+JSON.stringify(bankIds)+'&itemAttribute='+itemAttribute
            },
            availableData: [],
            selectData: [],
            renderAvailable: function () {
                $('#peAvailableNum').text(this.availableData.length);
                $('.pe-selector-available tbody').html(_.template($('#peAvailableTpl').html())({list: this.availableData}));
            },
            renderSelected: function () {
                $('#peSelectedNum').text(this.selectData.length);
                $('.pe-selector-selected tbody').html(_.template($('#peSelectedTpl').html())({list: this.selectData}));
            },

            searchAdmin : function(data){
                var id = '';
                $.each(selector.selectData,function(index,data){
                    if(index!=0){
                        id = id + ',';
                    }

                    id = id + data.id;
                });

                $.ajax({
                    type:'post',
                    dataType:'json',
                    data:data,
                    url:selector.URLS.available,
                    success:function (data) {
                        selector.availableData = [];
                        if(data && data.length>0){
                            for(var index=0;index < data.length;index++){
                                if(id.indexOf(data[index].id) === -1){
                                    selector.availableData.push(data[index]);
                                }
                            }

                            selector.renderAvailable();
                        }
                    }
                });
            },
            init: function () {
                var _this = this;
                $('.knowledge-list',parent.document).each(function(index,ele){
                    _this.selectData.push({'id':$(ele).find('input[name="knowledgeId"]').val(),'knowledgeName':$(ele).attr('title')});
                });

                _this.renderSelected();
                selector.searchAdmin(null);
                _this.initEvent();
            },
            initEvent: function () {
                var _this =this;
                //交互
                $('.pe-selector-available,.pe-selector-selected').on('click', "tbody tr", function (e) {
                    $('.pe-selector-available tr').removeClass('unable');
                    $('.pe-selector-available tr').removeClass('selected');
                    $('.pe-selector-selected  tr').removeClass('unable');
                    $('.pe-selector-selected  tr').removeClass('selected');
                    if (!$(this).hasClass('unable')) {
                        $(this).toggleClass("selected");
                    }
                });

                //选择
                $('button[data-role="select"]').click(function () {
                    var indexArr = [];
                    $('.pe-selector-available tr.selected').each(function(){
                        indexArr.push(parseInt($(this).attr('data-index')));
                    });
                    for(var i=0;i<indexArr.length;i++){
                        _this.selectData.unshift(_this.availableData.splice(indexArr[i],1)[0]);
                    }
                    _this.renderAvailable();
                    _this.renderSelected();
                });

                //全选
                $('button[data-role="selectAll"]').click(function () {
                    for(var i=0;i<_this.availableData.length;i++){
                        _this.selectData.unshift(_this.availableData[i]);
                    }
                    _this.availableData = [];
                    _this.renderAvailable();
                    _this.renderSelected();
                });

                //移除
                $('button[data-role="remove"]').click(function () {
                    var indexArr = [];
                    $('.pe-selector-selected tr.selected').each(function(){
                        indexArr.push(parseInt($(this).attr('data-index')));
                    });
                    for(var i=0;i<indexArr.length;i++){
                        _this.availableData.unshift(_this.selectData.splice(indexArr[i],1)[0]);
                    }
                    _this.renderAvailable();
                    _this.renderSelected();
                });

                //清空
                $('button[data-role="removeAll"]').click(function () {
                    for(var i=0;i<_this.selectData.length;i++){
                        if(!_this.selectData[i].selected){
                            _this.availableData.unshift(_this.selectData.splice(i,1)[0]);
                            i--;
                        }
                    }
                    _this.renderAvailable();
                    _this.renderSelected();
                });

                $('.pe-tree-search-btn').on('click',function(){
                    selector.searchAdmin({'knowledgeName':$('input[name="knowledge"]').val()});
                });
            }
        };

        selector.init();
    });


</script>
</body>
</html>