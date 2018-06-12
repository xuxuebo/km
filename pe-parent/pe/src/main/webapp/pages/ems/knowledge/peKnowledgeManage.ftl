<#--面包屑提示及提示语区域-->
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">试题</li><li class="pe-brak-nav-items iconfont icon-bread-arrow">知识点管理</li>
    </ul>
</div>
<form name="peFormSub" id="knowledgeFormSub">
<div class="pe-knowledge-manage-all-wrap">
<#--树状布局开始,可复用,记得调用下面的初始化函数;-->
    <div class="pe-manage-content-left floatL">
        <div class="pe-classify-wrap floatL">
            <div class="pe-classify-top over-flow-hide pe-form">
                <span class="floatL pe-classify-top-text">按类别筛选</span>
                <button type="button" title="管理类别" class="floatR iconfont pe-control-tree-btn icon-set set-category-btn"></button>
                <span class="floatR pe-checkbox knowledge-category-include pe-check-by-list" id="knowledge-category" for="peFormEle5">
                    <span class="iconfont icon-checked-checkbox peChecked"></span>
                <#--树状包含子类的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                    <input class="pe-form-ele" name="category.include" value="true" checked="checked" type="checkbox"/><span class="include-subclass">包含子类</span>
                </span>
            </div>
            <div class="pe-classify-tree-wrap">
                <div class="pe-tree-search-wrap">
                    <input class="pe-tree-form-text" type="text" placeholder="输入知识点关键字">
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
        <#--头部筛选区域-->
            <div class="pe-manage-panel-head">
                <div class="pe-stand-filter-form">
                    <div class="pe-stand-form-cell" style="margin-bottom: 0px;">
                        <label class="pe-form-label floatL" for="peMainKeyName">
                            <span class="pe-label-name floatL">知识点名称:</span>
                            <input id="peMainKeyName" class="pe-stand-filter-form-input" maxlength="20" type="text"
                                   name="knowledgeName">
                        </label>
                        <label class="pe-form-label floatL" for="peMainKeyText" style="">
                            <span class="pe-label-name floatL">创建人:</span>
                            <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text" placeholder="姓名/用户名/工号/手机号"
                                   name="createBy">
                        </label>
                        <button type="button" class="pe-btn pe-btn-blue pe-question-choosen-btn">筛选</button>
                    </div>

                <#--节点id取值-->
                    <input type="hidden" name="category.id" value="${(category.id)!}"/>
                    <input type="hidden" name="category.categoryName" value="${(category.categoryName)!}"/>
                </div>
            </div>
            <div class="pe-stand-table-panel">
                <div class="pe-stand-table-top-panel">
                <@authVerify authCode="ITEM_KNOWLEDGE_MANAGE_ADD"><button type="button" data-id="" class="pe-btn pe-btn-green pe-new-question-btn">新增知识点</button></@authVerify>
                    <#--<span class="pe-table-tip floatR">共有<span class="pe-table-number-tip" id="showKnowledgeTotal">0</span>条记录</span>-->
                </div>
        <#--表格包裹的div-->
                <div class="pe-stand-table-main-panel">
                    <div class="pe-stand-table-wrap"></div>
                    <div class="pe-stand-table-pagination"></div>
                </div>
            </div>
        </div>
    </div>
</div>
</form>
<#--右侧表格主题部分结束-->
<#--渲染表格模板-->
<script type="text/template" id="peQuestionTableTep">
    <table class="pe-stand-table pe-stand-table-default">
        <thead class="pe-stand-thead">
        <tr class="pe-stand-tr">
            <%for(var i =0,lenI = peData.tableTitles.length;i<lenI;i++){%>
                <th style="width:<%=peData.tableTitles[i].width%>%">
                    <%=peData.tableTitles[i].title%>
                </th>
                <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ;j++){%>
            <tr data-id="<%=peData.rows[j].id%>">
            <#--生成知识点名称-->
                <td>
                    <div class="pe-ellipsis" title="<%=peData.rows[j].knowledgeName%>"
                         data-id="<%=peData.rows[j].id%>">
                        <%=peData.rows[j].knowledgeName%>
                    </div>
                </td>
                <td>
                    <div class="pe-stand-table-btn-group">
                        <button type="button" data-id="<%=peData.rows[j].id%>"
                              data-categoryname="<%=peData.rows[j].category.categoryName%>"
                              data-categoryid="<%=peData.rows[j].category.id%>"
                              data-name="<%=peData.rows[j].knowledgeName%>"
                              class="pe-table-edit-btn pe-icon-btn iconfont icon-edit"></button>
                        <button type="button" data-id="<%=peData.rows[j].id%>"
                              class="iconfont pe-icon-btn icon-delete pe-knowledge-delete"></button>
                    </div>
                </td>
            </tr>
            <%}%>
            <%}else{%>
            <tr>
                <td class="pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
                    <div class="pe-result-no-date"></div>
                    <p class="pe-result-date-warn">暂无数据</p>
                </td>
            </tr>
            <%}%>
        </tbody>
    </table>
</script>
<#--编辑，新增对话框内容模板-->
<script type="text/template" id="confirmDialogTemp">
    <div class="clearF">
        <div class="validate-form-cell" style="margin-left:80px;">
            <em class="error" style="display: none;"></em>
        </div>
        <label class="floatL">
         <span class="pe-label-name floatL">知识点名称:</span>
            <input class="pe-table-form-text pe-stand-filter-form-input pe-km-tree-name" type="text" placeholder="请输入知识点名称"
                   name="questionName" maxlength="6">
        </label>
        <div class="pe-main-km-text-wrap clearF">
            <span class="pe-label-name floatL">知识点类别:</span>
            <div class="pe-km-search-key pe-input-tree-wrap pe-stand-filter-form-input" style="position:relative;">
                <input class="pe-tree-show-name" value="" placeholder="请选择类别" name="questionClassType"
                       readonly="readonly" style="weidth:204px;">
                <input class="pe-tree-show-id" type="hidden" name="chooseCategoryId" >
                <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                <div class="pe-input-tree-wrap-drop pe-select-tree-wrap" style="display:none;">
                    <ul id="peSelelctInputTree" class="ztree pe-tree-container"></ul>
                </div>
            </div>
        </div>
    </div>
</script>
<script>
    function checkBank(knowledgeName,categoryId,knowledgeId){
        var $error = $('.validate-form-cell').find('.error').eq(0);
        var $knowledgeName = $('input[name="questionName"]');
        var $category = $('input[name="questionClassType"]').parent();
        if(knowledgeName===undefined || knowledgeName === ''){
            $error.show().text('请输入知识点名称');
            $knowledgeName.addClass('error');
            $category.removeClass('error');
            return false;
        }else if(categoryId===undefined || categoryId ==='') {
            $error.show().text('请选择知识点类别');
            $category.addClass('error');
            $knowledgeName.removeClass('error');
            return false;
        }

        var hasName = false;
        PEBASE.ajaxRequest({
            url: pageContext.rootPath + '/ems/knowledge/manage/checkName',
            data:{
                "knowledgeName": knowledgeName,
                "category.id": categoryId,
                "id":knowledgeId
            },
            async:false,
            success:function(data){
                if(!data.success){
                    var $error = $('.validate-form-cell').find('em.error').eq(0).show().html(data.message);
                    hasName=true;
                }
            }
        });
        if(hasName){
            $knowledgeName.addClass('error');
            $category.removeClass('error');
            return false;
        }else {
            $error.text('');
            $knowledgeName.removeClass('error');
            return true;
        }


    }

    //筛选
    $('.pe-question-choosen-btn').on('click', function () {
        $('.pe-stand-table-wrap').peGrid('load', $('#knowledgeFormSub').serializeArray());
    });

    //类别点击筛选事件
    $('.pe-check-by-list').off().click(function(){
        var iconCheck = $(this).find('span.iconfont');
        var thisRealCheck = $(this).find('input[type="checkbox"]');
        if (iconCheck.hasClass('icon-unchecked-checkbox')) {
            iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
            thisRealCheck.prop('checked', 'checked');//这里在ie8下目前会报错“意外的调用了方法”,待解决
        }else{
            iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
            thisRealCheck.removeProp('checked');
        }
        $('.pe-stand-table-wrap').peGrid('load', $('#knowledgeFormSub').serializeArray());
    });


    //点击树状节点时，请求不同的类别下的数据
    $(function () {
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        /*自定义表格头部数量及宽度*/
        var peTableTitle = [
            {'title': '知识点名称', 'width': 80},
            {'title': '操作', 'width': 12}
        ];
        //测试类别变量
//            var nodeParam = 'category.id=a6dc7e13abfb48e49b17ca234877090d';
        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/ems/knowledge/manage/search',
            tempId: 'peQuestionTableTep',//表格模板的id
            title: peTableTitle, //表格头部的数量及名称数组;
            formParam:$('#knowledgeFormSub').serializeArray()
        });

        var settingUrl = {
            dataUrl: pageContext.rootPath + '/ems/knowledge/manage/listCategory',
            clickNode: function (treeNode) {
                if (treeNode.pId == null) {
                    $('input[name="category.id"]').val(null);
                    $('input[name="category.categoryName"]').val(null);
                } else {
                    $('input[name="category.id"]').val(treeNode.id);
                    $('input[name="category.categoryName"]').val(treeNode.name);
                }

                $('.pe-stand-table-wrap').peGrid('load', $('#knowledgeFormSub').serializeArray());
            },

            optUrl: {
                editUrl: pageContext.rootPath + '/base/category/manage/edit?categoryType=KNOWLEDGE',
                addUrl: pageContext.rootPath + '/base/category/manage/add?categoryType=KNOWLEDGE',
                deleUrl: pageContext.rootPath + '/base/category/manage/delete?categoryType=KNOWLEDGE',
                moveUrl: pageContext.rootPath + '/base/category/manage/moveLevel',
                isNewNode: false
            },
            type:'km'
        };
        /*dataJson为树状的数据，showUrl为点击节点展示列表的请求地址*/
        /*addUrl,editUrl,removeUrl,moveUrl为管理功能所需要的地址*/
        //初始化左侧树状功能；peZtreeMain为主要树的id
        PEMO.ZTREE.initTree('peZtreeMain', settingUrl);
    });

    //删除知识点
    $('.pe-stand-table-wrap').delegate('.pe-knowledge-delete','click',function () {
        var knowledgeId = $(this).data("id");
        PEMO.DIALOG.confirmR({
            content:'<div><h3 class="pe-dialog-content-head">确定删除选中的知识点么？</h3></div>',
            btn2:function(){
                $.post(pageContext.rootPath+'/ems/knowledge/manage/delete',{'knowledgeId':knowledgeId},function(data){
                    if(data.success){
                        PEMO.DIALOG.tips({
                            content:'删除成功',
                            time:2000,
                            end:function(){
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
                },'json')
            },
            btn1:function(){
                layer.closeAll();
            }
        });
    });

    //编辑知识点
    $('.pe-stand-table-wrap').delegate('.pe-table-edit-btn','click',function () {
        var knowledgeId = $(this).data("id");
        var knowledgeName = $(this).data("name");
        var categoryName = $(this).data("categoryname");
        var categoryId = $(this).data("categoryid");
        PEMO.DIALOG.confirmL({
            content:_.template($('#confirmDialogTemp').html())(),
            skin: 'pe-layer-confirm pe-knowledge-manage-layer',
            title: '编辑知识点',
            btnAlign:'l',
            area:['475px'],
            btn: ['保存','取消'],
            btn1: function () {
                var knowledgeName = $('input[name="questionName"]').val();
                var knowledgeCategoryId = $('input[name="chooseCategoryId"]').val();
                //校验编辑知识点内容
                var isError = checkBank(knowledgeName,knowledgeCategoryId,knowledgeId);
                if(!isError){
                    return false;
                }

                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/knowledge/manage/editKnowledge',
                    data: {
                        'id': knowledgeId,
                        'knowledgeName': knowledgeName,
                        'category.id': knowledgeCategoryId
                    },
                    success: function (data) {
                        if (data.success) {
                            layer.closeAll();
                            PEMO.DIALOG.tips({
                                content: '编辑成功',
                                time: 1000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });

                            return false;
                        }

                        PEMO.DIALOG.alert({
                            content: data.message,
                            btn: ['我知道了'],
                            yes: function (index) {
                                layer.close(index);
                            }
                        });
                    }
                });
            },
            btn2:function(){
                layer.closeAll();
            },
            success:function(){
                $('input[name="questionName"]').val(knowledgeName);
                $('input[name="questionClassType"]').val(categoryName);
                $('input[name="chooseCategoryId"]').val(categoryId);

                //初始化弹框里面的input类型的树状功能：
                var settingNewKmTree = {
                    dataUrl: pageContext.rootPath + '/ems/knowledge/manage/listCategory',
                    clickNode: function (treeNode) {
                        if (treeNode.pId == null) {
                            $('input[name="chooseCategoryId"]').val(null);
                            $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(null);
                        } else {
                            $('input[name="chooseCategoryId"]').val(treeNode.id);
                            $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                        }

                    }
                };
                //题库类型输入框类型树状弹框 dom为需要下拉框的那一行div元素 pe-km-input-tree
                PEBASE.inputTree({dom: '.pe-input-tree-wrap', treeId: 'peSelelctInputTree', treeParam: settingNewKmTree,isRefresh:true});
            }
        });
    });

    //新增知识点
    $('.pe-new-question-btn').click(function () {
        PEMO.DIALOG.confirmL({
            content: _.template($('#confirmDialogTemp').html())(),
            title: '新增知识点',
            btnAlign:'l',
            area:['475px'],
            skin: 'pe-layer-confirm pe-knowledge-manage-layer',
            btn: ['确定','取消'],
            btn1: function () {
                var knowledgeName = $('input[name="questionName"]').val();
                var knowledgeCategoryId = $('input[name="chooseCategoryId"]').val();
                //校验新增知识点内容
                var isError = checkBank(knowledgeName,knowledgeCategoryId);
                if(!isError){
                    return false;
                }

                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/knowledge/manage/addKnowledge',
                    data: {
                        "knowledgeName": knowledgeName,
                        "category.id": knowledgeCategoryId
                    },
                    success: function (data) {
                        
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '新增成功',
                                time: 1000,
                                end: function (index) {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });
                            layer.closeAll();

                        }else{
                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function (index) {
                                    layer.close(index);
                                }
                            });
                        }

                    }
                });
            },
            btn2:function(){
                layer.closeAll();
            },
            success: function () {
                
                $('input[name="questionClassType"]').val($('input[name="category.categoryName"]').val());
                $('input[name="chooseCategoryId"]').val($('input[name="category.id"]').val());
                //初始化弹框里面的input类型的树状功能：
                var settingNewKmTree = {
                    dataUrl: pageContext.rootPath + '/ems/knowledge/manage/listCategory',
                    clickNode:function(treeNode){
                        if (treeNode.pId == null) {
                            $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(null);
                            $('input[name="chooseCategoryId"]').val(null);
                        } else {
                            $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                            $('input[name="chooseCategoryId"]').val(treeNode.id);
                        }
                    }
                };

                //题库类型输入框类型树状弹框 dom为需要下拉框的那一行div元素 pe-km-input-tree
                PEBASE.inputTree({dom: '.pe-input-tree-wrap', treeId: 'peSelelctInputTree', treeParam: settingNewKmTree,isRefresh:true});
            }
        });
    });
</script>