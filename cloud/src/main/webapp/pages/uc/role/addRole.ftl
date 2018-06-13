<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">用户</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">角色管理</li>
        <#if edit?? && edit>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">编辑角色</li>
        <#else >
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">新增角色</li>
        </#if>
    </ul>
</div>
<section class="pe-all-panel">
    <form id="addUserForm" class="validate">
        <div class="pe-user-msg-detail">
            <label class="pe-table-form-label pe-question-label">
                     <span class="pe-input-tree-text">
                         <span><span style="color:red;">*</span>角色名称:</span>
                    </span>
                <input class="pe-table-form-text pe-question-score-num" value="${(role.roleName)!}" type="text"
                       name="roleName" maxlength="10"/>
                <input value="${(role.id)!}" type="hidden" name="id"/>
            </label>
        </div>
        <div class="pe-user-msg-detail" style="height:88px;">
                 <span class="pe-input-tree-text">
                        角色描述:
                 </span>
            <label>
                <textarea name="comments" class="pe-right-text-area" style="width:526px;"
                          maxlength="100">${(role.comments)!}</textarea>
            </label>
        </div>
        <div class="pe-user-mag-detail">
            <span class="pe-input-tree-text floatL">
                角色权限:
            </span>
            <div class="role-tree-wrap">
                <ul id="peZtreeMain" class="ztree pe-tree-container pe-no-manage-tree add-role-tree-container" data-type="km"></ul>
            </div>
        </div>
        <div class="pe-btns-group-wrap" style="margin-left:80px;">
        <#if edit?? && edit>
            <button type="button" class="pe-btn pe-btn-blue save-add-role-btn edit">保存</button>
        <#else>
            <button type="button" class="pe-btn pe-btn-blue save-add-role-btn add">确定</button>
        </#if>
            <button type="button" class="pe-btn pe-btn-purple cancel-add-role-btn">取消</button>

        </div>
    </form>
</section>
<script type="text/javascript">
    $(function(){
        var roleId = '${(role.id)!''}'
        var settingInputTree = {
            isCheckbox:true,
            dataUrl: pageContext.rootPath + '/uc/role/manage/listAuthTree?roleId=' + roleId,
            clickNode:function(treeNode){
            },
            saveChecked:function(zTree){
                //执行点击保存按钮获取所选择的所有节点;
            },
            width:518
        };
        PEMO.ZTREE.initTree('peZtreeMain', settingInputTree);

        $('.save-add-role-btn').click(function(){
            if( !$("#addUserForm").valid()){
                return false;
            }
                //获取当前页面树的总对象
            var roleTree = $.fn.zTree.getZTreeObj('peZtreeMain');
                //true为选取勾选的节点，false为选取未勾选的节点,节点对象里面包含个节点所有属性，包括id
            var checkedNode = roleTree.getCheckedNodes();
            var authoritiesObj = {};
            for (var i = 0; i < checkedNode.length; i++) {
                authoritiesObj['authorities[' + i + '].id'] = checkedNode[i].id;
            }

            var url = pageContext.rootPath + '/uc/role/manage/saveRole?' + $('#addUserForm').serialize();
            if ($(this).hasClass("edit")) {
                url = pageContext.rootPath + '/uc/role/manage/updateRole?' + $('#addUserForm').serialize();
            }

            $.ajax({
                type: 'post',
                dataType: 'json',
                data: authoritiesObj,
                url: url,
                success: function (data) {
                    PEMO.DIALOG.tips({
                        content: '保存成功',
                        time: 1000,
                        end: function () {
                            history.back(-1);
                        }
                    });
                }
            });
        });

        $('.cancel-add-role-btn').click(function () {
            history.back(-1);
        });
        /*校验*/
        $('#addUserForm').validate({
            errorElement:'em',
            onkeyup:false,
            rules:{
                roleName:'required',
                maxlength:50
            },
            messages:{
                roleName:'角色名称不能为空哦'
            }
        })
    })
</script>