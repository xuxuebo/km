<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">用户</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">角色管理</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">权限设置</li>
    </ul>
</div>
<section class="pe-all-panel">
    <form id="addUserForm">
        <div class="pe-user-mag-detail">
            <input value="${(role.id)!}" type="hidden" name="id" maxlength="50"/>
            <input value="${(role.roleName)!}" type="hidden" name="roleName" maxlength="50"/>
            <span class="pe-input-tree-text floatL">
                角色权限:
            </span>
            <div class="role-tree-wrap">
                <ul id="peZtreeMain" class="ztree pe-tree-container pe-no-manage-tree add-role-tree-container"
                    data-type="km"></ul>
            </div>
        </div>
        <div class="pe-btns-group-wrap" style="margin-left:80px;">
            <button type="button" class="pe-btn pe-btn-blue save-add-role-btn">确定</button>
            <button type="button" class="pe-btn pe-btn-purple cancel-add-role-btn">取消</button>

        </div>
    </form>
</section>
<script type="text/javascript">
    $(function () {
        var roleId = '${(role.id)!}';
        var settingInputTree = {
            isCheckbox: true,
            dataUrl: pageContext.rootPath + '/uc/role/manage/listAuthTree?roleId=' + roleId,
            clickNode: function (treeNode) {
            },
            saveChecked: function (zTree) {
                //执行点击保存按钮获取所选择的所有节点;
            },
            width: 518
        };
        PEMO.ZTREE.initTree('peZtreeMain', settingInputTree);

        $('.save-add-role-btn').click(function () {
            //获取当前页面树的总对象
            var roleTree = $.fn.zTree.getZTreeObj('peZtreeMain');
            //true为选取勾选的节点，false为选取未勾选的节点,节点对象里面包含个节点所有属性，包括id
            var checkNodeArr = roleTree.getCheckedNodes(true);
            if(checkNodeArr && checkNodeArr.length === 0){
                PEMO.DIALOG.tips({
                    "content":'<p>必须要选择一个权限哦亲</p>',
                    time:1500
                });
                return false;
            }
            var authoritiesObj = {};
            for (var i = 0; i < checkNodeArr.length; i++) {
                authoritiesObj['authorities[' + i + '].id'] = checkNodeArr[i].id;
            }

            var url = pageContext.rootPath + '/uc/role/manage/updateRole?' + $('#addUserForm').serialize();
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
        })

        $('.cancel-add-role-btn').click(function () {
            history.back(-1);
        });
    })
</script>