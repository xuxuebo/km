<#assign ctx=request.contextPath/>
<#--面包屑提示及提示语区域-->
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">试题</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">试题管理</li>
    </ul>
</div>
<div class="pe-test-question-manage pe-item-manage-panel">
    <span class="admin-manage-tip-msg">*系统管理员能查看所有的题库，其他管理员只能查看本人创建的和其他人授权自己使用的题库</span>
<#--树状布局开始,可复用,记得调用下面的初始化函数;-->
    <form name="peFormSub" id="peFormSub" class="floatL">
        <div class="pe-manage-content-left floatL">
            <div class="pe-classify-wrap">
                <div class="pe-classify-top over-flow-hide pe-form">
                    <span class="floatL pe-classify-top-text">按题库筛选</span>
                    <#--<button type="button" title="收起类别面板" class="floatR iconfont icon-hide-category"></button>-->
                    <span class="floatR pe-checkbox pe-check-by-list">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input id="itemIncludeDom" class="pe-form-ele" type="checkbox" value="true"
                               name="itemBank.category.include" checked="checked"/><span class="include-subclass" style="margin-right:36px;">包含子类</span>
                    </span>
                </div>
                <div class="pe-classify-tree-wrap">
                    <div class="pe-tree-search-wrap">
                    <#--复用时，保留下面的input单独classname 'pe-tree-form-text'-->
                        <input class="pe-tree-form-text" type="text" placeholder="请输入题库名称" maxlength="50"/>
                    <#--<span class="pe-placeholder">请输入题库名称</span>--><#--备用,误删-->
                        <span class="iconfont pe-tree-search-btn icon-search-magnifier"></span>
                    </div>
                    <div class="pe-tree-content-wrap">
                        <div class="pe-tree-main-wrap">
                            <div class="node-search-empty">暂无</div>
                        <#--pe-no-manage-tree为非管理树类添加的样式，是管理类的树，无需此class-->
                            <ul id="peZtreeMain" class="ztree pe-tree-container" data-type="km"></ul>
                        </div>
                    <#--题库管理根据需要是否显示-->
                    <#--<div class="pe-control-tree-btn iconfont icon-set">管理类别</div>-->
                    </div>
                </div>
            </div>
        </div>
    <#--树状布局 结束,可复用-->
    <#--右侧表格主题部分开始-->
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-manage-panel-head">
                    <div class="pe-stand-filter-form">
                        <div class="pe-stand-form-cell">
                            <label class="pe-form-label floatL">
                                <span class="pe-label-name floatL">关键字:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input"
                                       type="text" placeholder="试题内容/编号/出题人" maxlength="20"
                                       name="keyword">
                            </label>
                            <div id="peMainKmText">
                                <span class="pe-label-name floatL">知&nbsp;识&nbsp;点:&nbsp;</span>
                                <div class="pe-stand-filter-form-input clearF pe-km-input-tree">
                                    <label class="input-tree-choosen-label">
                                    <#if item?? && item.knowledges?? && (item.knowledges?size>0) >
                                        <#list item.knowledges as knowledge>
                                            <span class="search-tree-text" title="${(knowledge.knowledgeName)!}"
                                            data-id="${(knowledge.id)!}">${(knowledge.knowledgeName)!}</span>
                                        </#list>
                                    </#if>
                                        <input class="pe-tree-show-name" value="" name="knowledgeName" maxlength="6" style="padding-right:30px;width:210px;"/>
                                        <input type="hidden" name="knowledge"/>
                                    </label>
                                    <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                            <span class="iconfont icon-inputDele km-input-tree-dele input-icon"
                                  style="display:none;"></span>
                                    <div class="pe-input-tree-drop-two pe-input-tree-wrap-drop"
                                         style="display:none;">
                                        <ul id="peSelelctKmInputTree" class="ztree pe-tree-container floatL"></ul>
                                        <ul id="peSelectKmChildren" class="pe-input-tree-children-container"
                                            style="overflow: auto;">暂无，请点击左边进行筛选</ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="pe-stand-form-cell">
                            <div class="pe-form-select floatL question-type-order">
                            <#--select模式，取值见下面的hidden的input及peSelect方法-->
                                <span class="pe-label-name floatL">题&emsp;型:</span>
                                <select class="pe-question-select dropdown" name="type">
                                    <option value="" selected>全部</option>
                                    <option value="SINGLE_SELECTION">单选题</option>
                                    <option value="MULTI_SELECTION">多选题</option>
                                    <option value="INDEFINITE_SELECTION">不定项选择</option>
                                    <option value="JUDGMENT">判断题</option>
                                    <option value="FILL">填空题</option>
                                    <option value="QUESTIONS">问答题</option>
                                </select>
                            </div>
                            <div class="pe-form-select floatL question-level-order" style="margin:0 30px 0 20px;">
                                <span class="pe-label-name floatL">难&emsp;度:</span>
                                <select class="pe-diff-select dropdown" name="level">
                                    <option value="" selected>全部</option>
                                    <option value="SIMPLE">简单</option>
                                    <option value="RELATIVELY_SIMPLE">较简单</option>
                                    <option value="MEDIUM">中等</option>
                                    <option value="MORE_DIFFICULT">较难</option>
                                    <option value="DIFFICULT">困难</option>
                                </select>
                            </div>
                            <div class="pe-form-select floatL question-level-order" style="margin:0 30px 0 0;">
                                <span class="pe-label-name floatL">试题属性:</span>
                                <select class="pe-diff-select dropdown" name="attributeType">
                                    <option value="" selected>全部</option>
                                    <option value="EXAM">考试专用</option>
                                    <option value="EXERCISE">练习专用</option>
                                    <option value="EXAMEXERCISE">考试练习</option>
                                </select>
                            </div>
                            <dl>
                                <dt class="pe-label-name floatL">状&emsp;态:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                        <input id="peFormEleStart" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="queryStatus" value="ENABLE"/>启用
                                    </label>
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="queryStatus" value="DRAFT"/>草稿
                                    </label>
                                    <label class="floatL pe-checkbox" for="">
                                        <span class="iconfont icon-unchecked-checkbox"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" type="checkbox" name="queryStatus"
                                               value="DISABLE"/>停用
                                    </label>
                                </dd>
                            </dl>
                        </div>
                        <button type="button" style="margin-top: -85px;margin-left: 760px;" class="pe-btn pe-btn-blue pe-question-choosen-btn floatL">筛选</button>
                    </div>
                </div>
            <#--节点id取值-->
                <input type="hidden" name="itemBank.category.id" value="${(category.id)!}"/>
                <input type="hidden" name="itemBank.id" value=""/>
            <#--<input type="hidden" name="order" value=""/>-->
            <#--<input type="hidden" name="sort" value="level"/>-->
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                        <@authVerify authCode="ITEM_MANAGE_ADD"><button type="button" class="pe-btn pe-btn-green pe-new-question-btn">新增试题</button></@authVerify>
                        <@authVerify authCode="ITEM_MANAGE_EXPORT"><button type="button" class="pe-btn pe-btn-primary pe-question-load-btn">试题导入</button></@authVerify>
                        <@authVerify authCode="VERSION_OF_ITEM_EXPORT">
                            <@authVerify authCode="ITEM_MANAGE_EXPORT">
                            <button type="button" class="pe-btn pe-btn-primary pe-question-upload-btn">试题导出
                            </button>
                            </@authVerify>
                        </@authVerify>
                        <@authVerify authCode="ITEM_MANAGE_DELETE"><button type="button" class="pe-btn pe-btn-primary pe-question-delete-btn">删除</button></@authVerify>
                    </div>
                    <div class="pe-stand-table-main-panel">
                        <div class="pe-stand-table-wrap"></div>
                        <div class="pe-stand-table-pagination"></div>
                    </div>
                </div>
            </div>
        </div>
    <#--<div class="pe-mask-listen"></div>-->
    </form>
    <div class="clear"></div>
</div>
<#--右侧表格主题部分结束-->
<#--渲染表格模板-->
<script type="text/template" id="peQuestionTableTep">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI ;i++){%>
                <%if(peData.tableTitles[i].title === 'checkbox'){%>
                <th style="width:<%=peData.tableTitles[i].width%>%">
                    <label class="pe-checkbox pe-paper-all-check">
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheckAll"/>
                    </label>
                </th>
                <%}else{%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%=peData.tableTitles[i].title%>
                </th>
                <%}}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
            <tr data-id="<%=peData.rows[j].id%>">
                <td>
                    <label class="pe-checkbox pe-paper-check " data-id="<%=peData.rows[j].id%>">
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheck"/>
                    </label>
                </td>
            <#--生成题型类-->
                <%if(peData.rows[j].type === 'INDEFINITE_SELECTION'){%>
                <td>不定项选择</td>
                <%}else if(peData.rows[j].type === 'JUDGMENT'){%>
                <td>判断题</td>
                <%}else if(peData.rows[j].type === 'SINGLE_SELECTION'){%>
                <td>单选题</td>
                <%}else if(peData.rows[j].type === 'QUESTIONS'){%>
                <td>问答题</td>
                <%}else if(peData.rows[j].type === 'FILL'){%>
                <td>填空题</td>
                <%}else if(peData.rows[j].type === 'MULTI_SELECTION'){%>
                <td>多选题</td>
                <%}else {%>
                <td></td>
                <%}%>
            <#--生成题型难度-->
                <%if(peData.rows[j].level === 'DIFFICULT'){%>
                <td>困难</td>
                <%}else if(peData.rows[j].level === 'MORE_DIFFICULT'){%>
                <td>较难</td>
                <%}else if(peData.rows[j].level === 'MEDIUM'){%>
                <td>中等</td>
                <%}else if(peData.rows[j].level === 'SIMPLE'){%>
                <td>简单</td>
                <%}else if(peData.rows[j].level === 'RELATIVELY_SIMPLE'){%>
                <td>较简单</td>
                <%}else {%>
                <td></td>
                <%}%>
            <#--生成提干内容-->
                <td><a class="pe-stand-table-alink pe-dark-font pe-ellipsis" title="<%=peData.rows[j].stemOutline%>"

                       href="${ctx!}/ems/item/manage/initViewPage?itemId=<%=peData.rows[j].id%>" target="_blank"><%=(peData.rows[j].stemOutline).replace(/＜｜/g,
                    "＜").replace(/｜＞/g, "＞").replace(/≮/g, "＜").replace(/≯/g, "＞").replace(/｜/g, "").replace(/ /g, "&nbsp;")%></a>
                </td>
            <#--此处为所属知识点-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].itemBank.bankName%>">
                        <%=peData.rows[j].itemBank.bankName%>
                    </div>
                </td>
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].knowledge%>"><%=peData.rows[j].knowledge%></div>
                </td>
            <#--此处生成题型状态-->
                <%if(peData.rows[j].status === 'ENABLE'){%>
                <td>启用</td>
                <%}else if(peData.rows[j].status === 'DISABLE'){%>
            <#--此处为所属状态，我不知道改选哪个属性-->
                <td>停用</td>
                <%}else if(peData.rows[j].status === 'DRAFT'){%>
                <td>草稿</td>
                <%}else {%>
                <td></td>
                <%}%>
            <#--<%}else{%>-->
                <td>
                    <div class="pe-stand-table-btn-group">
                        <%if(peData.rows[j].canEdit){%>
                        <%if(peData.rows[j].status === 'ENABLE'){%>
                        <button type="button" class="stop-btn pe-icon-btn iconfont icon-stop" title="停用"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}else if(peData.rows[j].status === 'DRAFT' || peData.rows[j].status === 'DISABLE'){%>
                        <button type="button" class="start-btn pe-icon-btn iconfont icon-start" title="启用"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}%>
                        <button type="button" class="edit-btn pe-icon-btn iconfont icon-edit" title="编辑"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <button type="button" class="dele-btn pe-icon-btn iconfont icon-delete" title="删除"
                                data-id="<%=peData.rows[j].id%>"></button>
                        <%}%>
                    </div>
                </td>
            </tr>
            <%}%>
            <%}else{%>
            <tr>
                <td class="pe-td pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
                    <div class="pe-result-no-date"></div>
                    <p class="pe-result-date-warn">暂无数据</p>
                </td>
            </tr>
            <%}%>
        </tbody>
    </table>
</script>
<#--知识点类别树渲染-->
<script type="text/template" id="knowledgeTemplate">
    <%if(data.length !== 0){%>
    <%_.each(data, function(knowledge) {%>
    <li class="pe-search-children-nodes"  title="<%=knowledge.name%>">
        <span class="pe-radio km-knowledge-item">
            <%if(_.contains(knowledgeId,knowledge.id)){%>
            <span class="iconfont icon-checked-radio"></span>
            <input class="pe-form-ele" type="radio" name="kmRadio" data-id="<%=knowledge.id%>" checked="checked"
                   value=""/><%=knowledge.name%>
            <%}else{%>
            <span class="iconfont icon-unchecked-radio"></span>
            <input class="pe-form-ele" type="radio" name="kmRadio" data-id="<%=knowledge.id%>" title="<%=knowledge.name%>"
                   value=""/><%=knowledge.name%>
            <%}%>
        </span>
    </li>
    <%});%>
    <%}else{%>
    <div class="input-tree-no-data-tip">此类别下暂无数据</div>
    <%}%>
</script>
<script type="text/javascript">
    $(function () {

        $('input[name="knowledgeName"]').focus(function(){
            if(!$.trim($(this).val())){
                $('.icon-class-tree').show();
                $('.km-input-tree-dele').hide();
            }else{
                $('.icon-class-tree').hide();
                $('.km-input-tree-dele').show();
            }
        });
        $('input[name="knowledgeName"]').on('change',function(){
            if(!$.trim($(this).val())){
                $('.icon-class-tree').show();
                $('.km-input-tree-dele').hide();
                $('input[name="knowledge"]').val('');
                $('#peSelectKmChildren').find('.icon-checked-radio').next('.pe-form-ele').prop('checked',false);
                $('#peSelectKmChildren').find('.icon-checked-radio').addClass('icon-unchecked-radio').removeClass('icon-checked-radio');
            }else{
                $('.icon-class-tree').hide();
                $('.km-input-tree-dele').show();
            }
            var kmZtreeObj =  $.fn.zTree.getZTreeObj('peSelelctKmInputTree');
            var searchRootNode =kmZtreeObj.getNodes();
            kmSearchAndShow(searchRootNode[0],$(this).val());
        });

        //知识点类别树删除
        $('.km-input-tree-dele').click(function (e) {
            var e = e || window.event;
            e.stopPropagation();
            e.preventDefault();
            $(this).siblings('.input-tree-choosen-label').find('.search-tree-text').remove();
            var thisCheckedBox = $(this).parent('div').find('.pe-input-tree-wrap-drop').find('.pe-input-tree-children-container').find('li .icon-checked-radio');
            thisCheckedBox.removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio').siblings('input').removeProp('checked');
            $(this).hide().siblings('.icon-class-tree').show();
            $('input[name="knowledge"]').val('');
            $('input[name="knowledgeName"]').val('');

        });

//        /*保留，有用*/
        function checkIsSaveFull(type, thisRealCheck) {
            return true;
        }

        var $thisKmLableInput = $('#peMainKmText').find('input[name="knowledgeName"]');
        //检查输入框里是否已经有选了的标签;
        function checkInputTreeChoose(inputDom) {
            var thisInputDomVal = $(inputDom).attr('title');
            var thisInputDomId = $(inputDom).attr('data-id');
            $thisKmLableInput.val(thisInputDomVal);
            $('input[name="knowledge"]').val(thisInputDomId);
        }

        //知识点类型输入框类型树状弹框
        var kmInputTree = {
            dataUrl: pageContext.rootPath + '/ems/knowledge/manage/listCategoryKnowledge',
            clickNode: function (treeNode) {
                kmSearchAndShow(treeNode);
            },
            width: 218
        };
        //题库类型输入框类型树状弹框 dom为需要下拉框的那一行div元素 pe-stand-filter-form-input
        PEBASE.inputTree({dom: '.pe-km-input-tree', treeId: 'peSelelctKmInputTree', treeParam: kmInputTree});
        /*自定义表格头部数量及宽度*/
        var peTableTitle = [
            {'title': 'checkbox', 'width': 5},
            {'title': '题型', 'width': 8},
            {'title': '难度', 'width': 8},
            {'title': '试题内容', 'width': 25},
            {'title': '所属题库', 'width': 12},
            {'title': '知识点', 'width': 10},
            {'title': '状态', 'width': 6},
            {'title': '操作', 'width': 10}
        ];
        // var nodeParam = 'category.id=a6dc7e13abfb48e49b17ca234877080a';
        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/ems/item/manage/search',
            formParam: $('#peFormSub').serializeArray(),//表格上方表单的提交参数
            tempId: 'peQuestionTableTep',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle, //表格头部的数量及名称数组;
            onLoad: function () {
                PEBASE.peFormEvent('checkbox');
                PEBASE.peFormEvent('radio',obj);
            }
        });

        $('.pe-stand-table-wrap').delegate('.stop-btn', 'click', function () {
            var id = $(this).data('id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定停用选中的试题么？</h3><p class="pe-dialog-content-tip">停用试题对考试中已生成的试卷没有影响。</p></div>',
                btn2: function () {
                    $.post(pageContext.rootPath + '/ems/item/manage/stopItem', {'itemId': id}, function (data) {
                        if (data.success) {
                            //小型提示框，用于上面弹框确定后的弹框提示,不自动消失，需要的化传参数time
                            PEMO.DIALOG.tips({
                                content: '停用成功',
                                time: 2000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');

                                }
                            });

                            return false;
                        }
                        PEMO.DIALOG.alert({
                            content: data.message,
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });
                    }, 'json');
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });

        $('.pe-stand-table-wrap').delegate('.start-btn', 'click', function () {
            var id = $(this).data('id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定启用选中的试题么？</h3></div>',
                btn2: function () {
                    $.post(pageContext.rootPath + '/ems/item/manage/enableItem', {'itemId': id}, function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '启用成功',
                                time: 2000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });

                            return false;
                        }

                        PEMO.DIALOG.alert({
                            content: data.message,
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        })
                    }, 'json');
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });
        $('.pe-question-upload-btn').on('click', function () {
            location.href =pageContext.rootPath + '/ems/item/manage/exportItems?'+$('#peFormSub').serialize()
        });
        $('.pe-question-load-btn').on('click', function () {
//            location.href = "#url=" + pageContext.rootPath + '/ems/item/manage/openDownload';
            window.open(pageContext.rootPath + '/ems/item/manage/openDownload','');
        });

        $('.pe-question-delete-btn').on('click', function () {
            var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
            if (!rows || rows.length <= 0) {
                PEMO.DIALOG.alert({
                    content: '请至少先选择一道试题！',
                    btn:['我知道了'],
                    yes:function(){
                        layer.closeAll();
                    }
                });

                return false;
            }

            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定删除选中的试题么？</h3><p class="pe-dialog-content-tip">删除试题对考试中已生成的试卷没有影响。 </p></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url : pageContext.rootPath + '/ems/item/manage/deleteItem',
                        data:{itemId:JSON.stringify(rows)},
                        success:function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '删除成功',
                                    time: 1000,
                                    end: function () {
                                        $('.pe-stand-table-wrap').peGrid('refresh');
                                    }
                                });

                                return false;
                            }

                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn:['我知道了'],
                                yes:function(){
                                    layer.closeAll();
                                }
                            });
                        }
                    });
                },
                btn1:function(){
                    layer.closeAll();
                }
            });
        });

        $('.pe-stand-table-wrap').delegate('.edit-btn', 'click', function () {
            var id = $(this).data('id');
            location.href = "#url=" + pageContext.rootPath + '/ems/item/manage/initEditPage?id=' + id + "&nav=question";
        });

        $('.pe-stand-table-wrap').delegate('.dele-btn', 'click', function () {
            var rows = [$(this).data('id')];
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定删除选中的试题么？</h3><p class="pe-dialog-content-tip">删除试题对考试中已生成的试卷没有影响。</p></div>',
                btn2: function () {
                    $.post(pageContext.rootPath + '/ems/item/manage/deleteItem', {'itemId': JSON.stringify(rows)}, function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '删除成功',
                                time: 2000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });

                            return false;
                        }

                        PEMO.DIALOG.alert({
                            content: data.message,
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        })
                    }, 'json')
                },
                btn1: function () {
                    layer.closeAll();
                }
            });


        });


        $('.pe-question-choosen-btn').on('click', function () {
            $('.pe-stand-table-wrap').peGrid('load', $('#peFormSub').serializeArray());
        });
        //类别点击筛选事件
        $('.pe-check-by-list').off().click(function () {
            var iconCheck = $(this).find('span.iconfont');
            var thisRealCheck = $(this).find('input[type="checkbox"]');
            if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                thisRealCheck.prop('checked', 'checked');
            } else {
                iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                thisRealCheck.removeProp('checked');
            }
            $('.pe-stand-table-wrap').peGrid('load', $('#peFormSub').serializeArray());
        });

        $('.pe-new-question-btn').on('click', function () {
            location.href = "#url=" + pageContext.rootPath + '/ems/item/manage/initEditPage?itemBank.id=' +
                    $('input[name="itemBank.id"]').val() + "&nav=question&time="+new Date().getDate();
        });

        var settingUrl = {
            dataUrl: pageContext.rootPath + '/ems/item/manage/listTree',
            clickNode: function (treeNode) {
                $('input[name="itemBank.category.id"]').val('');
                $('input[name="itemBank.id"]').val('');
                if (treeNode) {
                    if (treeNode.isParent) {
                        $('input[name="itemBank.category.id"]').val(treeNode.id);
                    } else {
                        $('input[name="itemBank.id"]').val(treeNode.id);
                    }
                }

                $('.pe-stand-table-wrap').peGrid('load', $('#peFormSub').serializeArray());
            },
            type: 'itemManage'

        };

        PEMO.ZTREE.initTree('peZtreeMain', settingUrl);

        PEBASE.peSelect($('.pe-question-select'), 7, $('input[name="peQuestionType"]'));
        PEBASE.peSelect($('.pe-diff-select'), null, $('input[name="peQuestionDifficulty"]'));
        //知识点的点击或输入框搜索执行函数
        function kmSearchAndShow(treeNode, val) {
            var showFilter = false,
                    searchData = [];
            if (val) {
                showFilter = true;
            }

            (function searchNode(treeNode) {
                var nodeData = treeNode.nodeData,
                    newNodeData = [];
                if(nodeData){
                    if(showFilter){
                        for(var j=0,lenJ=nodeData.length;j<lenJ;j++){
                            try{
                                if(nodeData[j].name.indexOf(val) !== -1){
                                    newNodeData.push(nodeData[j])
                                }
                            }catch(e){
                            }

                        }
                        nodeData = newNodeData;
                    }
                    searchData = searchData.concat(nodeData);
                }
                if (!$.isEmptyObject(treeNode) && treeNode.children) {
                    for (var i = 0, len = treeNode.children.length; i < len; i++) {
                        searchNode(treeNode.children[i])
                    }
                }
            })(treeNode);
            showSearchList(searchData, showFilter, val);
        }
        var obj = {'func1': checkIsSaveFull, 'func2': checkInputTreeChoose};
        //知识点搜索结果进行展示的函数
        function showSearchList(data,showFilter,val) {
            $('#peSelectKmChildren .mCSB_container').html('');
            var knowledgeId = [];
            $('.pe-km-input-tree .input-tree-choosen-label').find('span').each(function (index, ele) {
                knowledgeId.push($(ele).data('id'));
            });

            $('#peSelectKmChildren .mCSB_container').append(_.template($('#knowledgeTemplate').html())({
                data: data,
                knowledgeId: knowledgeId
            }));


            PEBASE.peFormEvent('checkbox');
            PEBASE.peFormEvent('radio',obj);
        }
    });
</script>