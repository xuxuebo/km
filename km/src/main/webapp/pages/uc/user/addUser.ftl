<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">用户</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">用户管理</li>
    <#if user?? && user.id??>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">编辑用户</li>
    <#else >
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">新增用户</li>
    </#if>
    </ul>
</div>
<section class="pe-add-user-all-wrap">
    <form id="editItemForm" class="validate" action="javascript:;">
        <input type="hidden" name="id" value="${(user.id)!}"/>
        <div class="pe-question-top-head" style="margin-bottom:20px;">
            <h2 class="pe-question-head-text">新增用户</h2>
        </div>
        <div class="pe-add-user-item-wrap over-flow-hide">
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                 <span class="pe-input-tree-text">
                    <span style="color:red;">*</span>
                     <span>姓&emsp;名:</span>
                </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" type="text" value="${(user.userName)!}"
                           name="userName" maxlength="50">
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text">
                        <span style="color:red;">*</span>
                         <span>用户名:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" type="text" name="loginName"
                           value="${(user.loginName)!}"
                           maxlength="50"/>
                </label>
            </div>
        <#if !(user?? && user.id??)>
            <div class="pe-user-msg-detail" style="margin-bottom:40px;">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text">
                         <span>密&emsp;码:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" type="password" name="password">
                </label>
                <div class="pe-add-user-tip-text">默认密码为102030，可修改，密码长度不少于6位</div>
            </div>
        </#if>
            <div class="pe-user-msg-detail">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text">
                         <span>工&nbsp;&nbsp;号:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" value="${(user.employeeCode)!}" type="text"
                           name="employeeCode"
                           maxlength="20"/>
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text">
                         <span>手机号:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" value="${(user.mobile)!}" type="text"
                           name="mobile" maxlength="11">
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                    <span class="pe-input-tree-text">
                         <span>入职时间:</span>
                    </span>
                    <div class="pe-date-wrap">
                        <div data-toggle="datepicker" class="control-group input-daterange">
                            <#--<label class="control-label pe-label-name floatL">考试时间：</label>-->
                            <div class="controls pe-date-wrap">
                                <input type="text" name="entryTime" style="width: 300px;" class="pe-table-form-text input-medium input-date pe-time-text laydate-icon" value="${(user.entryTime?string("yyyy-MM-dd"))!}"/>
                            </div>
                        </div>
                    </div>
                </label>
            </div>
        </div>
        <div class="pe-question-top-head pe-question-more-wrap" style="margin-bottom:20px;border-bottom:0px;">
            <h2 class="pe-question-head-text"> 更多信息</h2>
            <span class="pe-add-question-more-msg">
                        <span class="iconfont icon-pack"></span>
                 </span>
        </div>
        <div class="pe-add-user-item-wrap" id="moreMsg" style="display:none;">
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                 <span class="pe-input-tree-text">
                     <span>邮&emsp;箱:</span>
                </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" value="${(user.email)!}" type="text"
                           name="email" maxlength="50">
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <div class="pe-main-input-tree clearF" style="relative;">
                    <span class="pe-input-tree-text">
                        部&emsp;门:
                    </span>
                    <div class="pe-stand-filter-form-input  pe-organize-input-tree">
                        <input class="pe-tree-show-name" name="organizeName" readonly="readonly" title="${(user.organize.organizeName)!}" type="text" maxlength=50 value="${(user.organize.organizeName)!}" style="    width: 305px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;"/>
                        <input type="hidden" name="organize.id" value="${(user.organize.id)!}"/>
                        <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"
                              style="height:36px;line-height:36px;"></span>
                        <div class="pe-select-tree-wrap pe-input-tree-wrap-drop pe-input-tree-drop-third"
                             style="display:none;">
                            <ul id="organizeTreeData" class="ztree pe-tree-container floatL"></ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="pe-user-msg-detail">
                <div class="pe-main-input-tree clearF" style="relative;">
                    <span class="pe-input-tree-text">
                        岗&emsp;位:
                    </span>
                    <div class="pe-stand-filter-form-input pe-position-input-tree pe-km-input-tree">
                        <label class="input-tree-choosen-label" style="max-width:240px;">
                        <#if user?? && user.positions?? && (user.positions?size>0)>
                            <#list user.positions as position>
                                <span class="search-tree-text" title="${(position.positionName)!}"
                                      data-id="${(position.id)!}">${(position.positionName)!}</span>
                            </#list>
                        </#if>
                            <input class="pe-tree-show-name" value="" name="positionName" readonly="readonly" style="width:2px;"></input>
                        </label>
                        <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"
                              style="height:34px;line-height:34px;"></span>
                        <span class="iconfont icon-inputDele position-input-tree-dele input-icon"
                              style="display:none;"></span>
                        <div class="pe-select-tree-wrap pe-input-tree-wrap-drop pe-input-tree-drop-two"
                             style="display:none;width:">
                            <ul id="postTreeData" class="ztree pe-tree-container floatL"></ul>
                            <ul id="bankTreeChildren" class="pe-input-tree-children-container"
                                style="overflow: auto;">暂无，请点击左边进行筛选</ul>
                        </div>
                        <input type="hidden" name="positionId"/>
                    </div>
                </div>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text">
                         <span>身份证:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" value="${(user.idCard)!}" type="text"
                           name="idCard" maxlength="50">
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <span class="pe-input-tree-text">
                         <span>性&emsp;别:</span>
                    </span>
                <div class="pe-gender-wrap">
                    <label class="pe-radio green-raido-check">
                        <span class="iconfont <#if (user?? && (user.sexType??) && user.sexType == 'MALE')>icon-checked-radio<#else>icon-unchecked-radio</#if>"></span>
                        <span class="pe-select-true-answer">
                        <input class="pe-form-ele"
                               <#if (user?? && (user.sexType??) && user.sexType == 'MALE')>checked="checked"</#if>
                               type="radio" value="MALE" name="sexType"/>男
                    </span>
                    </label>
                    <label class="pe-radio green-raido-check">
                        <span class="iconfont <#if user?? && (user.sexType??) && user.sexType == 'FEMALE'>icon-checked-radio<#else>icon-unchecked-radio</#if>"></span>
                        <span class="pe-select-true-answer">
                        <input class="pe-form-ele"
                               <#if user?? && (user.sexType??) && user.sexType == 'FEMALE'>checked="checked"</#if>
                               type="radio" value="FEMALE" name="sexType"/>女
                    </span>
                    </label>
                    <label class="pe-radio green-raido-check">
                        <span class="iconfont <#if user?? && (user.sexType??) && user.sexType == 'SECRECY'  || !(user??) || !(user.sexType??)>icon-checked-radio<#else>icon-unchecked-radio</#if>"></span>
                        <span class="pe-select-true-answer">
                        <input class="pe-form-ele"
                               <#if user?? && (user.sexType??) && user.sexType == 'SECRECY' || !(user??) || !(user.sexType??)>checked="checked"</#if>
                               type="radio" value="SECRECY" name="sexType"/>保密
                    </span>
                    </label>
                </div>
            </div>
            <div class="pe-user-msg-detail">
                <div class="pe-main-input-tree clearF" style="relative;">
                    <span class="pe-input-tree-text">
                        角&emsp;色:
                    </span>
                    <div class="pe-stand-filter-form-input  pe-role-input-tree pe-km-input-tree">
                        <label class="input-tree-choosen-label" style="max-width:240px;">
                        <#if user?? && user.roles?? && (user.roles?size>0)>
                            <#list user.roles as role>
                                <span class="search-tree-text" title="${(role.roleName)!}"
                                      data-id="${(role.id)!}">${(role.roleName)!}</span>
                            </#list>
                        </#if>
                            <input class="pe-tree-show-name" value="" name="roleName" style="width:2px;"></input>
                        </label>

                        <input type="hidden" name="roleClassify" value=""/>
                        <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                        <span class="iconfont icon-inputDele role-input-tree-dele input-icon"
                              style="display:none;"></span>
                        <div class="pe-select-tree-wrap pe-input-tree-wrap-drop pe-input-tree-drop-third"
                             style="display:none;top:38px;">
                            <ul id="roleTreeData" class="ztree pe-tree-container floatL"></ul>
                        </div>
                    </div>
                    <input type="hidden" name="roleId"/>
                </div>
            </div>
            <div class="pe-user-msg-detail" style="height:80px;">
                 <span class="pe-input-tree-text">
                        联系地址:
                 </span>
                <textarea name="address" class="pe-right-text-area" value="${(user.address)!}" maxlength="100"/>
            </div>
            <div class="pe-user-msg-detail" style="height:80px;">
                 <span class="pe-input-tree-text">
                        头像设置:
                 </span>
                <button type="button" class="pe-user-head-edit-btn">
                    <img onerror="javascript:this.src='${resourcePath!}/web-static/proExam/images/default/default_face.png'" src="${(user.facePath)!}"/>
                    <span>编辑头像</span>
                </button>
                <input type="hidden" name="faceFileId" class="target-fileId" value="${(user.faceFileId)!}"/>
                <input type="hidden" name="faceFileName" class="target-fileName" value="${(user.faceFileName)!}"/>
            </div>
        </div>
        <div class="pe-btns-wrap" style="margin-top: 60px;margin-bottom: 94px;">
            <button class="pe-btn pe-btn-blue pe-btn-save" type="submit" style="margin-left:89px;">保存</button>
            <button class="pe-btn pe-btn-cancel" type="button">取消</button>
        </div>
    </form>
</section>
<script type="text/template" id="errMsgInfo">
    <span class="pe-form-validate-tip">
        <span class="iconfont icon-caution-tip"></span>
        <span><%=errMsg%></span>
    </span>
</script>
<script type="text/template" id="positionTemplate">
    <%if(data.length !== 0){%>
    <%_.each(data, function(position) {%>
    <li class="pe-search-children-nodes">
        <label class="pe-checkbox">
            <%if(_.contains(positionIds,position.id)){%>
            <span class="iconfont icon-checked-checkbox"></span>
            <input class="pe-form-ele" type="checkbox" data-id="<%=position.id%>" checked="checked"
                   title="<%=position.positionName%>" value=""/><%=position.positionName%>
            <%}else{%>
            <span class="iconfont icon-unchecked-checkbox"></span>
            <input class="pe-form-ele" type="checkbox" data-id="<%=position.id%>" title="<%=position.positionName%>"
                   value=""/><%=position.positionName%>
            <%}%>
        </label>
    </li>
    <%});%>
    <%}else{%>
    <div class="input-tree-no-data-tip">此类别下暂无数据</div>
    <%}%>
</script>
<script>
    $(function () {
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        //判断名字是否过长
        $('input[name="userName"]').keyup(function(){
            $('.pe-form-validate-tip').remove();
            var userName=$('input[name="userName"]').val();
            if(userName.length>50){
                $('input[name="userName"]').after(_.template($('#errMsgInfo').html())({errMsg: '姓名长度过长！'}));
            }
        });
        $('.position-input-tree-dele').click(function (e) {
            var e = e || window.event;
            e.stopPropagation();
            e.preventDefault();
            $(this).siblings('.input-tree-choosen-label').find('.search-tree-text').remove();
            var thisCheckedBox = $(this).parent('div').find('.pe-input-tree-wrap-drop').find('.pe-input-tree-children-container').find('li .icon-checked-checkbox');
            thisCheckedBox.removeClass('icon-checked-checkbox peChecked').addClass('icon-unchecked-checkbox').siblings('input').removeProp('checked');
            $(this).hide().siblings('.icon-class-tree').show();
            $('input[name="positionId"]').val('');
        });

        //部门渲染
        var organizeTreeData = {
            dataUrl: pageContext.rootPath + '/uc/user/manage/listTree',
            clickNode: function (treeNode) {
                if (!treeNode.pId) {
                    return false;
                }

                $('.pe-organize-input-tree').find('.pe-tree-show-name').val(treeNode.name);
                $('input[name="organize.id"]').val(treeNode.id);
            },
            width: 308
        };
        PEBASE.inputTree({dom: '.pe-organize-input-tree', treeId: 'organizeTreeData', treeParam: organizeTreeData});
//        inputTreeKeyup($('.pe-organize-input-tree'), 'organizeTreeData');
        //岗位树渲染 pe-post-input-tree
        var postTreeData = {
            dataUrl: pageContext.rootPath + '/uc/position/manage/listTree',
            clickNode: function (treeNode) {
                $('#bankTreeChildren').html('');
                var setting = {
                    url: pageContext.rootPath + '/uc/position/manage/listPosition',
                    data: {categoryId: treeNode.id},
                    success: function (data) {
                        var positionIds = [];
                        $('.pe-position-input-tree .input-tree-choosen-label').find('span').each(function (index, ele) {
                            positionIds.push($(ele).data('id'));
                        });

                        $('#bankTreeChildren').append(_.template($('#positionTemplate').html())({
                            data: data,
                            positionIds: positionIds
                        }));
                        var obj = {'func2': editUser.choosePosition};
                        PEBASE.peFormEvent('checkbox', obj);
                    }
                };
                PEBASE.ajaxRequest(setting);
            },
            width: 308
        };
        PEBASE.inputTree({dom: '.pe-position-input-tree', treeId: 'postTreeData', treeParam: postTreeData});
        inputTreeKeyup($('.pe-position-input-tree'), 'postTreeData');
        $('.pe-input-tree-search-btn').click(function (e) {
            var e = e || window.event;
            e.stopPropagation();
            e.preventDefault();
            if ($(this).hasClass('icon-inputDele')) {
                //pe-km-input-tree
                $(this).siblings('.input-tree-choosen-label').html('');
                var thisCheckedBox = $(this).parent('div').find('.pe-input-tree-wrap-drop').find('.pe-input-tree-children-container').find('li .icon-checked-checkbox');
                thisCheckedBox.removeClass('icon-checked-checkbox peChecked').addClass('icon-unchecked-checkbox').siblings('input').removeProp('checked');
                $(this).removeClass('icon-inputDele').addClass('icon-class-tree');
                $('input[name="positionId"]').val('');
            }

        });

        //角色树渲染 pe-role-input-tree
        var roleTreeData = {
            isCheckbox: true,
            isNoIcoIcon: true,
            dataUrl: pageContext.rootPath + '/uc/user/manage/listRoleTree',
            clickNode: function (treeNode) {
                if (treeNode.isParent) {
                    return false;
                }
                $('.pe-post-input-tree').find('.pe-tree-show-name').val(treeNode.name);
                $('input[name="postClassify"]').val(treeNode.id);
            },
            isCheckHasChecked:function(zTree){
                var inputLables= $('.pe-role-input-tree').find('.input-tree-choosen-label span');
                var hasCheckNode = [];
                inputLables.each(function(d,index){
                    var keyType = 'id',Dvalue = $(this).attr('data-id');
                    var thisCheckNode = zTree.getNodesByParamFuzzy(keyType, Dvalue,null)[0];
                        thisCheckNode.checked = true;
                        thisCheckNode.checkedClass = true;
                   $('#' + thisCheckNode.tId+ '_check').removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox');
                });
            },
            //checkbox点击事件,通过treeNode的checked或者checkedClass是否为true来判断是否选中或取消了
            checkboxFuc: function (zTree, treeNode) {
                var thisLabel = $('.pe-role-input-tree .input-tree-choosen-label');
                var idDom;
                thisLabel.find('span').each(function (index, ele) {
                    if ($(ele).data('id') === treeNode.id) {
                        idDom = ele;
                        return false;
                    }
                });
                if (treeNode.checked && !idDom) {
                    if (thisLabel.find('.search-tree-text').get(0)) {
                        var checkedText = $('.pe-role-input-tree .search-tree-text');
                        var beforeScrollLeft = checkedText.outerWidth() * checkedText.length;
                        thisLabel.find('.search-tree-text').last().after('<span class="search-tree-text" title="' + treeNode.name + '" data-id="' + treeNode.id + '">' + treeNode.name + '</span>')
                        $('.pe-role-input-tree .input-tree-choosen-label').scrollLeft(beforeScrollLeft + $('.pe-role-input-tree .search-tree-text').outerWidth());
                        thisLabel.find('.pe-tree-show-name').insertAfter(thisLabel.find('.search-tree-text').last()).focus();
                    } else {
                        thisLabel.find('.pe-tree-show-name').before('<span class="search-tree-text" title="' + treeNode.name + '" data-id="' + treeNode.id + '">' + treeNode.name + '</span>');
                    }
                    thisLabel.find('.search-tree-text').last().data('node', treeNode);
                } else {
                    thisLabel.find(idDom).remove();
                }
            },
            width: 308,
            isPeers:true
        };
        $('.role-input-tree-dele').click(function (e) {
            var e = e || window.event;
            e.stopPropagation();
            e.preventDefault();
            $(this).siblings('.input-tree-choosen-label').find('.search-tree-text').remove();
            var roleTree = $.fn.zTree.getZTreeObj('roleTreeData');
            var checkNodeArr = roleTree.getCheckedNodes(true);
            for (var j = 0, len = checkNodeArr.length; j < len; j++) {
                roleTree.checkNode(checkNodeArr[j], false, true);
            }
            $(this).hide().siblings('.icon-class-tree').show();
            $('input[name="roleClassify"]').val('');
        });
        PEBASE.inputTree({dom: '.pe-role-input-tree', treeId: 'roleTreeData', treeParam: roleTreeData});
        inputTreeKeyup($('.pe-role-input-tree'), 'roleTreeData');
        PEBASE.peFormEvent('radio');

        /* nput树类型的输入框在div里面左右移动删除功能;*/
        function inputTreeKeyup(wrapDom, treeId) {
            wrapDom.find('.pe-tree-show-name').on('keyup', function (e) {
                var treeObj;
                if (!treeObj) {
                    treeObj = $.fn.zTree.getZTreeObj(treeId);
                }

                var keyCode = (e || event).keyCode;
                var thisInput = $(this);
                var thisVal = $.trim(thisInput.val());
                var thisSpan;
                var labelSpans = wrapDom.find('.search-tree-text');
                if (keyCode === 8) {//Backspace
                    thisSpan = $(this).prev(".search-tree-text");
                    if (!thisVal && thisSpan && labelSpans) {
                        if (thisInput.attr('name') === 'roleName') {
                            treeObj.checkNode(thisSpan.data('node'), false, true);
                        } else if (thisInput.attr('name') === 'positionName') {
                            var positionId = thisSpan.data('id');
                            var checkInput = $("input[data-id=" + positionId + "]");
                            checkInput.removeProp('checked');
                            checkInput.prev().removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        }
                        thisSpan.remove();
                    }
                    if (wrapDom.find('.icon-inputDele').get(0) && !wrapDom.find('.search-tree-text').get(0)) {
                        wrapDom.find('.icon-inputDele').hide().siblings('.icon-class-tree').show();
                    }
                }
                if (keyCode === 37) {//left
                    thisSpan = $(this).prev(".search-tree-text");
                    if (!thisVal && thisSpan && labelSpans && labelSpans.index(thisSpan) >= 0) {
                        thisSpan.before($(this));
                        setTimeout(function () {
                            thisInput.focus();
                        }, 500);

                    }
                }
                if (keyCode === 39) {//right
                    thisSpan = $(this).next(".search-tree-text");
                    if (!thisVal && thisSpan && labelSpans && (labelSpans.index(thisSpan) <= labelSpans.length - 1)) {
                        thisSpan.after($(this));
                        setTimeout(function () {
                            thisInput.focus();
                        }, 500);
                    }
                }
                if (keyCode === 46) {//delete
                    thisSpan = $(this).next(".search-tree-text");
                    if (!thisVal && thisSpan.get(0)) {
                        if (thisInput.attr('name') === 'role') {
                            treeObj.checkNode(thisSpan.data('node'), false, true);
                        } else {
                            var positionId = thisSpan.data('id');
                            var checkInput = $("input[data-id=" + positionId + "]");
                            checkInput.removeProp('checked');
                            checkInput.prev().removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        }
                        thisSpan.remove();
                    }
                    if (wrapDom.find('.icon-inputDele').get(0) && !wrapDom.find('.search-tree-text').get(0)) {
                        wrapDom.find('.icon-inputDele').hide().siblings('.icon-class-tree').show();
                    }
                }

                $(this).width($(this).val().length > 0 ? $(this).val().length * 16 : 2);
            });
        }

        $("#editItemForm").validate({
            errorElement: 'em',
            rules: {
                userName: "required",
                loginName: {
                    required: true,
                    remote: {
                        url: pageContext.rootPath + '/uc/user/manage/checkLoginName',     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        data: {
                            username: function () {
                                return $("input[name='loginName']").val();
                            },
                            userId: function () {
                                return $("input[name='id']").val();
                            }
                        }
                    }
                },
                password: {minlength: 6},
                mobile: {
                    isMobile: true,
                    remote: {
                        url: pageContext.rootPath + '/uc/user/manage/checkMobile',
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        data: {
                            mobile: function () {
                                return $("input[name='mobile']").val();
                            },
                            userId: function () {
                                return $("input[name='id']").val();
                            }
                        }
                    }
                },
                email: {
                    email: true,
                    remote: {
                        url: pageContext.rootPath + '/uc/user/manage/checkEmail',
                        type: "post",
                        dataType: "json",
                        data: {
                            email: function () {
                                return $("input[name='email']").val();
                            },
                            userId: function () {
                                return $("input[name='id']").val();
                            }
                        }
                    }
                },
                idCard: {
                    isIdCardNo: true,
                    remote: {
                        url: pageContext.rootPath + '/uc/user/manage/checkIdCard',
                        type: "post",
                        dataType: "json",
                        data: {
                            idCard: function () {
                                return $("input[name='idCard']").val();
                            },
                            userId: function () {
                                return $("input[name='id']").val();
                            }
                        }
                    }
                }
            },
            messages: {
                userName: "姓名不能为空",
                loginName: {
                    required: "用户名不能为空",
                    remote: "用户名不能重复"
                },
                password: {minlength: '密码长度不少于6位！'},
                mobile: {
                    isMobile: "请输入正确的手机格式",
                    remote: '该手机号已被占用!'
                },
                email: {
                    email: "请输入正确的邮箱格式",
                    remote: '该邮箱已被占用，请验证是否是同一人使用！'
                },
                idCard: {
                    isIdCardNo: "请输入正确的身份证",
                    remote: '该身份证已被占用，请验证是否是同一人使用！'
                }
            },
            submitHandler: function (form) {
                //form.submit();
                var positionId = '';
                $('.pe-position-input-tree .input-tree-choosen-label span').each(function (index, ele) {
                    if (positionId) {
                        positionId = positionId + ',';
                    }

                    positionId = positionId + $(ele).data('id');
                });

                if (positionId) {
                    $('input[name="positionId"]').val(positionId);
                }

                var roleId = '';
                $('.pe-role-input-tree .input-tree-choosen-label span').each(function (index, ele) {
                    if (roleId) {
                        roleId = roleId + ',';
                    }

                    roleId = roleId + $(ele).data('id');
                });

                if (roleId) {
                    $('input[name="roleId"]').val(roleId);
                }

                var setting = {
                    url: pageContext.rootPath + '/uc/user/manage/saveUser',
                    data: $('#editItemForm').serialize(),
                    success: function (data) {
                        if (!data.success) {
                            PEMO.DIALOG.tips({
                                content: data.message,
                                time: 2000
                            });
                            return false;
                        }

                        PEMO.DIALOG.tips({
                            content: '保存成功',
                            time: 1000,
                            end: function () {
                                location.href = '#url='+pageContext.rootPath+'/uc/user/manage/initPage&nav=user';
                            }
                        });
                    }
                };

                PEBASE.ajaxRequest(setting);
            }
        });

        //点击更多信息按钮点击事件
        $('.pe-add-question-more-msg').click(function () {
            if ($(this).find('.iconfont').hasClass('icon-pack')) {
//                $(this).addClass('more-rotate');
                $('#moreMsg').slideDown();
                $(this).find('.iconfont').removeClass('icon-pack').addClass('icon-show');
                $('.pe-question-top-head').css('border-bottom', '2px solid #e0e0e0');
            } else if ($(this).find('.iconfont').hasClass('icon-show')) {
                $('#moreMsg').slideUp();
                $(this).find('.iconfont').removeClass('icon-show').addClass('icon-pack');
                $('.pe-question-top-head').css('border-bottom', '0px');
            }

        });

        $('.pe-btn-cancel').on('click', function () {
            location.href = '#url='+pageContext.rootPath+'/uc/user/manage/initPage&nav=user';
        });

        $('.pe-user-head-edit-btn').on('click', function () {
            PEMO.DIALOG.selectorDialog({
                content: pageContext.rootPath + '/uc/user/client/initCutHeadPage?userId=${(user.id)!}',
                area: ['606px', '400px'],
                title: '修改头像',
                btn1: function () {
                },
                btn2: function () {
                    layer.closeAll();
                },
                success: function (d,index) {
                    var iframeBody = layer.getChildFrame('body', index);
                    var hasPicSrc = $('.pe-user-head-edit-btn').find('img').attr('src');
                    if(hasPicSrc){
                        $(iframeBody).find('.jcrop-preview').prop("src", hasPicSrc);
                    }
                }
            });
        });
    });
    var editUser = {
        //验证用户信息
        validateUser: function () {
            $('.pe-form-validate-tip').remove();
            var isVal = true;

            var $userName = $('input[name="userName"]');
            var userName = $userName.val();
            if (!userName) {
                $userName.after(_.template($('#errMsgInfo').html())({errMsg: '姓名不能为空！'}));
                isVal = false;
            }
            var $loginName = $('input[name="loginName"]');
            var loginName = $loginName.val();
            var userId = $('input[name="id"]').val();
            if (!loginName) {
                $loginName.after(_.template($('#errMsgInfo').html())({errMsg: '用户名不能为空！'}));
                isVal = false;
            } else {
                var setting = {
                    url: pageContext.rootPath + '/uc/user/manage/checkLoginName',
                    async: false,
                    data: {'loginName': loginName, 'userId': userId},
                    success: function (data) {
                        if (!data.success) {
                            $loginName.after(_.template($('#errMsgInfo').html())({errMsg: '用户名不能重复！'}));
                            isVal = false;
                        }
                    }
                };

                PEBASE.ajaxRequest(setting);
            }
            var $password = $('input[name="password"]');
            var pwd = $password.val();
            if (pwd && pwd.length < 6) {
                $password.after(_.template($('#errMsgInfo').html())({errMsg: '密码长度不少于6位！'}));
                isVal = false;
            }
            var $employeeCode=$('input[name="employeeCode"]');
            var employeeCode=$employeeCode.val();
            if(!/^[0-9]*$/.test(employeeCode)){
                $employeeCode.after(_.template($('#errMsgInfo').html())({errMsg: '工号只能包含数字！'}));
                isVal = false;
            }

            if(employeeCode && employeeCode.length >20){
                $employeeCode.after(_.template($('#errMsgInfo').html())({errMsg: '工号长度最多20位！'}));
                isVal = false;
            }

            var $mobile = $('input[name="mobile"]');
            var mobile = $mobile.val();
            if (mobile) {
                if (!/^((13[0-9])|(15[^4])|(18[0,1,2,3,5-9])|(17[0-8])|(147))\d{8}$/.test(mobile)) {
                    $mobile.after(_.template($('#errMsgInfo').html())({errMsg: '手机号输入不正确！'}));
                    isVal = false;
                }

                setting = {
                    url: pageContext.rootPath + '/uc/user/manage/checkMobile',
                    async: false,
                    data: {'mobile': mobile, 'userId': userId},
                    success: function (data) {
                        if (!data.success) {
                            $mobile.after(_.template($('#errMsgInfo').html())({errMsg: '该手机号已被占用!'}));
                            isVal = false;
                        }
                    }
                };
                PEBASE.ajaxRequest(setting);
            }
            var $email = $('input[name="email"]');
            var email = $email.val();
            if (email) {
                if (!/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/.test(email)) {
                    $email.after(_.template($('#errMsgInfo').html())({errMsg: '邮箱格式输入不正确！'}));
                    isVal = false;
                }

                setting = {
                    url: pageContext.rootPath + '/uc/user/manage/checkEmail',
                    async: false,
                    data: {'email': email, 'userId': userId},
                    success: function (data) {
                        if (!data.success) {
                            $email.after(_.template($('#errMsgInfo').html())({errMsg: '该邮箱已被占用，请验证是否是同一人使用！'}));
                            isVal = false;
                        }
                    }
                };

                PEBASE.ajaxRequest(setting);
            }

            var $idCard = $('input[name="idCard"]');
            var idCard = $idCard.val();
            if (idCard) {
                if (!/^[1-9]\d{7}((0[1-9])||(1[0-2]))((0[1-9])||(1\d)||(2\d)||(3[0-1]))\d{3}$/.test(idCard)
                        && !/^[1-9]\d{5}[1-9]\d{3}((0[1-9])||(1[0-2]))((0[1-9])||(1\d)||(2\d)||(3[0-1]))\d{3}([0-9]||X)$/.test(idCard)) {
                    $idCard.after(_.template($('#errMsgInfo').html())({errMsg: '身份证格式不正确！'}));
                    isVal = false;
                }

                setting = {
                    url: pageContext.rootPath + '/uc/user/manage/checkIdCard',
                    async: false,
                    data: {'idCard': idCard, 'userId': userId},
                    success: function (data) {
                        if (!data.success) {
                            $idCard.after(_.template($('#errMsgInfo').html())({errMsg: '该身份证已被占用，请验证是否是同一人使用！'}));
                            isVal = false;
                        }
                    }
                };

                PEBASE.ajaxRequest(setting);
            }

            return isVal;
        },

        choosePosition: function (inputDom) {
            var id = inputDom.data('id');
            if (!id) {
                return false;
            }

            var idDom;
            var thisLabel = $('.pe-position-input-tree .input-tree-choosen-label');
            thisLabel.find('span').each(function (index, ele) {
                if ($(ele).data('id') === id) {
                    idDom = ele;
                    return false;
                }
            });
            if (inputDom.prop('checked') && !idDom) {
                var checkedText = $('.pe-position-input-tree .search-tree-text');
                var beforeScrollLeft = checkedText.outerWidth() * checkedText.length;
                thisLabel.append('<span class="search-tree-text" title="' + inputDom.attr('title') + '" data-id="' + id + '">' + inputDom.attr('title') + '</span>');
                thisLabel.siblings('.icon-class-tree').hide().siblings('.icon-inputDele').show();
                $('.pe-position-input-tree .input-tree-choosen-label').scrollLeft(beforeScrollLeft + $('.pe-position-input-tree .search-tree-text').outerWidth());
                thisLabel.find('.pe-tree-show-name').insertAfter(thisLabel.find('.search-tree-text').last()).focus();

            } else if (!inputDom.prop('checked') && idDom) {
                $(idDom).remove();
                if (!thisLabel.find('span').get(0)) {
                    thisLabel.siblings('.icon-class-tree').show().siblings('.icon-inputDele').hide();
                }
            }
        }
    };


</script>