
<div class="pe-test-question-manage pe-organize-manage-all-wrap">
    <form name="peFormSub" id="peFormSub">
        <div class="organize-manage-search-wrap" style="float:left;margin-right: 20px;">
            <input class="pe-tree-form-text" type="text" placeholder="输入类别名称筛选">
            <span class="iconfont pe-tree-search-btn input-icon icon-search-magnifier"></span>
        </div>
        <button type="button" class="pe-btn pe-btn-green back-exercise-btn">返回</button>
        <div class="clear"></div>
        <div class="pe-classify-wrap">
            <div class="pe-classify-tree-wrap">
                <div class="pe-tree-content-wrap">
                    <div class="pe-tree-main-wrap">
                        <div class="node-search-empty">暂无</div>
                        <ul id="peZtreeMain" class="ztree pe-tree-container pe-no-manage-tree"
                            style="background-color:#fff;height:602px;"></ul>
                    </div>
                </div>
                <div>
                </div>
            </div>
        </div>
    <#--节点id取值-->
        <input type="hidden" name="organize.id" value=""/>
        <input type="hidden" name="organize.organizeName" value=""/>
        <input type="hidden" name="organize.parentId" value=""/>
    </form>
</div>
<#--编辑，新增对话框内容模板-->
<script type="text/template" id="confirmDialogTemp">
    <div class="clearF">
        <label class="floatL">
            <span class="pe-label-name floatL"><%=data.firstName%>:</span>
            <input class="pe-stand-filter-form-input" maxlength="50" type="text" placeholder="请输入<%=data.firstName%>"
                   name="<%=data.firstInputName%>">
        </label>
        <div class="pe-main-km-text-wrap">
            <span class="pe-label-name floatL"><%=data.treeName%>:</span>
            <div class="pe-km-search-key pe-input-tree-wrap pe-stand-filter-form-input">
                <input class="pe-tree-show-name" value="" name="<%=data.treeInputName%>" readonly="true">
                <input class="pe-tree-show-id" type="hidden" value="" name="<%=data.treeInputId%>">
                <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                <div class="pe-select-tree-wrap pe-input-tree-wrap-drop" style="display:none;">
                    <ul id="peSelelctInputTree" class="ztree pe-tree-container"></ul>
                </div>
            </div>
        </div>
    </div>
</script>
<script>
    $(function () {
        $('.back-exercise-btn').on('click', function () {
            parent.$('#yunContentBody').html('<iframe style="width:100%;height: 100%;margin-left:0;" src="/km/front/manage/initPage#url=/km/uc/position/manage/initPage"></iframe>');
        });
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        var settingUrl = {
            dataUrl: pageContext.rootPath + '/uc/position/manage/listTree',
            optUrl: {
                deleUrl: pageContext.rootPath + '/base/category/manage/delete',
                deleContent: '<div><h3 class="pe-dialog-content-head">确定要删除这个类别？</h3>' +
                '<p class="pe-dialog-content-tip">删除后将不能恢复，请谨慎操作！</p></div>',
                moveUrl: pageContext.rootPath + '/base/category/manage/moveLevel',
                isNewNode: false
            },
            clickNode:function(){},
            zTreeIsEditState: true,
            treeRenderType:'organize',
            type:'organize',
            alwaysEdit:true,
            //新增类别
            addNodeFunc: function (zTree, treeNode) {
                PEMO.DIALOG.confirmL({
                    content: _.template($('#confirmDialogTemp').html())({
                        data: {
                            'firstName': '类别名称',
                            'firstInputName': 'organizeName',
                            'treeName': '上级类别',
                            'treeInputName': 'parentName',
                            'treeInputId': 'parentId'
                        }
                    }),
                    area: '468px',
                    btn: ['确定','取消'],
                    btnAlign:'l',
                    title: '新增类别',
                    btn1: function () {
                        var parentId = $('input[name="parentId"]').val();
                        var name = $('input[name="organizeName"]').val();
                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath + '/base/category/manage/add',
                            data: {
                                'name': name,
                                'pId': parentId
                            },
                            success: function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '类别新增成功',
                                        time: 1000,
                                        end: function () {
                                            layer.closeAll('page');
                                            $('#peZtreeMain').mCustomScrollbar('destroy');
                                            PEMO.ZTREE.initTree('peZtreeMain', settingUrl);
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
                    success: function () {
                        //初始化弹框里面的input类型的树状功能：
                        var settingInputTree = {
                            dataUrl: pageContext.rootPath + '/uc/position/manage/listTree',
                            clickNode: function (treeNode) {
                                $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                                $('.pe-input-tree-wrap').find('.pe-tree-show-id').val(treeNode.id);
                            }
                        };
                        //题库类型输入框类型树状弹框 dom为需要下拉框的那一行div元素 pe-km-input-tree
                        PEBASE.inputTree({
                            dom: '.pe-input-tree-wrap',
                            treeId: 'peSelelctInputTree',
                            treeParam: settingInputTree
                        });
                    }
                });
                $('input[name="parentName"]').val(treeNode.name);
                $('input[name="parentId"]').val(treeNode.id);
            },

            //编辑类别
            editNodeFunc: function (zTree, treeNode) {
                var id = treeNode.id;
                var parentNode = treeNode.getParentNode();
                PEMO.DIALOG.confirmL({
                    content: _.template($('#confirmDialogTemp').html())({
                        data: {
                            'firstName': '类别名称',
                            'firstInputName': 'organizeName',
                            'treeName': '上级类别',
                            'treeInputName': 'parentName',
                            'treeInputId': 'parentId'
                        }
                    }),
                    area: '468px',
                    title: '编辑类别',
                    btn: ['保存','取消'],
                    btnAlign:'l',
                    btn1: function () {
                        var organizeName = $('input[name="organizeName"]').val();
                        var parentId = $('input[name="parentId"]').val();
                        PEBASE.ajaxRequest({
                            //此处要返回给我新的修改过的节点的id，好和旧的的id进行比较从而是否刷新树节点
                            url: pageContext.rootPath + '/base/category/manage/edit',
                            data: {
                                'id': id,
                                'name': organizeName,
                                'pId': parentId
                            },
                            success: function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '编辑成功',
                                        time: 1000,
                                        end:function(){
                                            layer.closeAll('page');
                                            $('#peZtreeMain').mCustomScrollbar('destroy');
                                            PEMO.ZTREE.initTree('peZtreeMain', settingUrl);
                                        }
                                    });

                                    return false;
                                }

                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn:['我知道了'],
                                    yes:function(index){
                                        layer.close(index);
                                        success();
                                    }
                                });
                            }
                        });
                    },
                    success: function () {
                        //初始化弹框里面的input类型的树状功能：
                        var settingInputTree = {
                            dataUrl: pageContext.rootPath + '/uc/position/manage/listTree',
                            clickNode: function (treeNode) {
                                $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                                $('.pe-input-tree-wrap').find('.pe-tree-show-id').val(treeNode.id);
                            }
                        };
                        //题库类型输入框类型树状弹框 dom为需要下拉框的那一行div元素 pe-km-input-tree
                        PEBASE.inputTree({
                            dom: '.pe-input-tree-wrap',
                            treeId: 'peSelelctInputTree',
                            treeParam: settingInputTree
                        });
                    }
                });
                $('input[name="organizeName"]').val(treeNode.name);
                $('input[name="parentId"]').val(treeNode.pId);
                $('input[name="parentName"]').val(parentNode.name);

            }
        };
        //初始化左侧树状功能；peZtreeMain为主要树的id
        PEMO.ZTREE.initTree('peZtreeMain', settingUrl);
    });
</script>