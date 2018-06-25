
<div class="pe-test-question-manage pe-organize-manage-all-wrap">
<#--树状布局开始,可复用,记得调用下面的初始化函数;-->
    <form name="peFormSub" id="peFormSub">
        <div class="organize-manage-search-wrap">
        <#--复用时，保留下面的input单独classname 'pe-tree-form-text'-->
            <input class="pe-tree-form-text" type="text" placeholder="输入标签名称筛选">
        <#--<span class="pe-placeholder">请输入题库名称</span>备用,误删-->
            <span class="iconfont pe-tree-search-btn input-icon icon-search-magnifier"></span>
        </div>
        <div class="pe-classify-wrap">
            <div class="pe-classify-tree-wrap">
                <div class="pe-tree-content-wrap">
                    <div class="pe-tree-main-wrap">
                        <div class="node-search-empty">暂无</div>
                    <#--pe-no-manage-tree为非管理树类添加的样式，是管理类的树，无需此class-->
                        <ul id="peZtreeMain" class="ztree pe-tree-container pe-no-manage-tree"
                            style="background-color:#fff;height:602px;"></ul>
                    </div>
                </div>
            <#--部门管理根据需要是否显示-->
                <div>
                <#--<div class="pe-control-tree-btn iconfont icon-complete-management" style="display: none"></div>-->
                </div>
            </div>
        </div>
    <#--节点id取值-->
        <input type="hidden" name="label.id" value="${(label.id)!}"/>
        <input type="hidden" name="label.labelName" value="${(label.labelName)!}"/>
        <input type="hidden" name="label.parentId" value="${(label.parentId)!}"/>
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
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        var settingUrl = {
            dataUrl: pageContext.rootPath + '/km/label/listTree',
            optUrl: {
                deleUrl: pageContext.rootPath + '/km/label/deleteLabel',
                deleContent: '<div><h3 class="pe-dialog-content-head">确定要删除这个标签？</h3>' +
                '<p class="pe-dialog-content-tip">删除后将不能恢复，请谨慎操作！</p></div>',
                moveUrl: pageContext.rootPath + '/km/label/moveShowOrder',
                isNewNode: false
            },
            clickNode:function(){},
            zTreeIsEditState: true,
            treeRenderType:'label',
            type:'label',
            alwaysEdit:true,
            //新增部门
            addNodeFunc: function (zTree, treeNode) {
                PEMO.DIALOG.confirmL({
                    content: _.template($('#confirmDialogTemp').html())({
                        data: {
                            'firstName': '标签名称',
                            'firstInputName': 'labelName',
                            'treeName': '上级标签',
                            'treeInputName': 'parentName',
                            'treeInputId': 'parentId'
                        }
                    }),
                    area: '468px',
                    btn: ['确定','取消'],
                    btnAlign:'l',
                    title: '新增部门',
                    btn1: function () {
                        var parentId = $('input[name="parentId"]').val();
                        var labelName = $('input[name="labelName"]').val();
                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath + '/km/label/addLabel',
                            data: {
                                'labelName': labelName,
                                'parentId': parentId
                            },
                            success: function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '新增成功',
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
                            dataUrl: pageContext.rootPath + '/km/label/listTree',
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

            //编辑部门
            editNodeFunc: function (zTree, treeNode) {
                var id = treeNode.id;
                var parentNode = treeNode.getParentNode();
                PEMO.DIALOG.confirmL({
                    content: _.template($('#confirmDialogTemp').html())({
                        data: {
                            'firstName': '标签名称',
                            'firstInputName': 'labelName',
                            'treeName': '上级标签',
                            'treeInputName': 'parentName',
                            'treeInputId': 'parentId'
                        }
                    }),
                    area: '468px',
                    title: '编辑部门',
                    btn: ['保存','取消'],
                    btnAlign:'l',
                    btn1: function () {
                        var labelName = $('input[name="labelName"]').val();
                        var parentId = $('input[name="parentId"]').val();
                        PEBASE.ajaxRequest({
                            //此处要返回给我新的修改过的节点的id，好和旧的的id进行比较从而是否刷新树节点
                            url: pageContext.rootPath + '/km/label/updateLabel',
                            data: {
                                'id': id,
                                'labelName': labelName,
                                'parentId': parentId
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
                            dataUrl: pageContext.rootPath + '/km/label/listTree',
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
                $('input[name="labelName"]').val(treeNode.name);
                $('input[name="parentId"]').val(treeNode.pId);
                $('input[name="parentName"]').val(parentNode.name);

            }
        };
        //初始化左侧树状功能；peZtreeMain为主要树的id
        PEMO.ZTREE.initTree('peZtreeMain', settingUrl);
    });
</script>