<#--面包屑提示及提示语区域-->
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">试卷</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">试卷管理</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">新增试卷</li>
    </ul>
</div>
<div class="pe-add-paper-all-wrap pe-question-item-container" style="padding: 25px 35px 0;" id="peMainPulickContent">
    <div class="pe-add-paper-top-head">

    </div>
    <form id="templateForm">
        <input type="hidden" name="id" value="${(template.id)!}"/>
        <div class="pe-add-paper-content-wrap ">
            <div class="add-paper-item-wrap over-flow-hide">
                <label class="pe-table-form-label floatL">
                    <span class="pe-left-text"><span style="color:red;">*</span>试卷编号:</span>
                <#if template.templateEdit?? && template.templateEdit>
                ${(template.paperCode)!}
                <#else>
                    <input class="pe-table-form-text pe-more-past-time-input" autocomplete="off" type="text"
                           name="paperCode" maxlength="50"
                           value="${(template.paperCode)!}"/>
                </#if>
                </label>
            </div>
            <div class="add-paper-item-wrap over-flow-hide">
                <label class="pe-table-form-label floatL">
                    <span class="pe-left-text"><span style="color:red;">*</span>试卷名称:</span>
                    <input class="pe-table-form-text pe-more-past-time-input" autocomplete="off" type="text"
                           name="paperName" value="${(template.paperName)!}" maxlength="50"/>
                </label>
            </div>
            <div class="add-paper-item-wrap over-flow-hide">
                <div class="pe-top-secret">
                    <div class="floatL pe-left-text"><span style="color:red;">*</span>试卷类型:</div>
                    <label class="pe-radio pe-check-by-list  <#if (template.paperStatus?? && template.paperStatus == 'ENABLE')>disabled-click</#if>">
                        <span class="iconfont <#if ((!(template.templateEdit??) || !(template.templateEdit)) && (!(template.paperType)?? || (template.paperType)! == ""))||((template.paperType)?? && (template.paperType)! == 'FIXED')>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <#--<#if !(template.templateEdit??) || !(template.templateEdit)>-->
                        <input class="pe-form-ele" type="radio" value="FIXED"
                               <#if (!(template.paperType)?? ||(template.paperType)! == "") ||((template.paperType)?? && (template.paperType)! == 'FIXED')>checked="checked"</#if>
                               name="paperType"/>
                    <#--</#if>-->
                        固定卷
                        <span class="add-paper-tip-text">每位考生接收到的试卷内容完全一致</span>
                    </label>
                </div>
                <div class="pe-top-secret">
                    <label class="pe-radio pe-check-by-list <#if (template.paperStatus?? && template.paperStatus == 'ENABLE')>disabled-click</#if>  ">
                        <span class="iconfont <#if (template.paperType)?? && (template.paperType)! == 'RANDOM'>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                    <#--<#if !(template.templateEdit??) || !(template.templateEdit)>-->
                        <input class="pe-form-ele" value="RANDOM" type="radio"
                               <#if (template.paperType)?? && (template.paperType)! == 'RANDOM'>checked="checked"</#if>
                               name="paperType"/>
                    <#--</#if>-->
                        随机卷
                        <span class="add-paper-tip-text">生成试卷模板，考试时每位考生会随机抽取其中一套参加考试</span>
                    </label>
                </div>
            </div>
            <div class="add-paper-item-wrap">
                <div id="peMainKmText" class="pe-main-km-text-wrap">
                    <span class="pe-km-text floatL"><span style="color:transparent;">*</span>试卷属性:</span>
                    <ul class="pe-paper-attribute-wrap pe-flow">
                        <li class="pe-paper-attribute-item <#if (template.security?? && !template.security) || !(template.security??)>cur</#if> floatL"
                            data-type="false">
                            <div class="iconfont paper-attribute-icon icon-normal-paper"></div>
                            <div class="paper-attribute-name">普通试卷</div>
                            <div class="paper-attribute-msg">除创建人外，被授权的管理员也可使用和预览</div>
                            <span class="iconfont icon-solid-circle-chekced"
                                  <#if template.security?? && template.security>style="display:none;"</#if>></span>
                        </li>
                        <li class="pe-paper-attribute-item <#if template.security?? && template.security>cur</#if> floatF"
                            data-type="true">
                            <div class="iconfont paper-attribute-icon icon-top-secret-paper"></div>
                            <div class="paper-attribute-name">绝密试卷</div>
                            <div class="paper-attribute-msg">仅创建人可以管理、使用和预览</div>
                            <span class="iconfont icon-solid-circle-chekced"
                                  <#if (template.security?? && !template.security) || !(template.security??)>style="display:none;"</#if>></span>
                        </li>
                        <input type="hidden" name="security"
                               value="${(template.security?string('true','false'))!'false'}"></input>
                    </ul>
                </div>
            </div>
            <div class="add-paper-item-wrap">
                <div id="peMainKmText" class="pe-main-km-text-wrap" style="margin-left:0;">
                    <span class="pe-km-text floatL"><span style="color:transparent;">*</span>所属类别:</span>
                    <div class="pe-km-search-key pe-input-tree-wrap ">
                    <input class="pe-tree-show-name" style="height:22px;" name="category.categoryName"
                    <#if template?? && template.category?? > value="${(template.category.categoryName)!}"</#if></input>
                        <input type="hidden" name="category.id"
                               value="${(template.category.id)!}"></input>
                        <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                        <div class="pe-select-tree-wrap pe-input-tree-wrap-drop pe-input-tree-drop-third"
                             style="display:none;">
                            <ul id="peSelelctInputTree" class="ztree pe-tree-container"></ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div class="pe-btns-group-wrap" style="margin-top:35px;">
    <#if template.templateEdit?? && template.templateEdit>
        <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn edit-save">保存</button>
    <#else>
        <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-next">下一步</button>
    </#if>
        <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">
            返回
        </button>
    </div>
</div>
<script type="text/template" id="editPaperTopTemp">
    <ul class="over-flow-hide <%if (templateEdit && templateEdit === 'true') {%>edit-step-state<%}%>">
        <li class="add-paper-step-item floatL overStep">
            <div class="add-step-icon-wrap">
                   <span class="iconfont icon-step-circle floatL">
                    <span class="add-step-number">1</span>
                   </span>
                <div class="add-step-line"></div>
            </div>
            <span class="add-step-text">基本信息</span>
        </li>
        <li class="add-paper-step-item add-paper-step-two floatL <%if (templateEdit && templateEdit === 'true') {%>step-complete edit-paper-must<%}%>">
            <div class="add-step-icon-wrap">
                <div class="add-step-line add-step-two-line"></div>
                <span class="iconfont icon-step-circle floatL">
                      <span class="add-step-number">2</span>
                    </span>
                <#if (version?? && version == 'ENTERPRISE') || (template.paperType?? && template.paperType == 'RANDOM') || !(paperTemplate.templateEdit?? && paperTemplate.templateEdit)>
                <%if ((paperStatus === 'ENABLE' && (!security || security === 'false')) || paperType === 'RANDOM' || !templateEdit || templateEdit === 'false'){%>
                <div class="add-step-line"></div>
                <%}%>
                </#if>
            </div>
            <span class="add-step-text" style="margin-left:95px;">必考题</span>
        </li>
        <%if (paperType === 'RANDOM'){%>
        <li class="add-paper-step-item add-paper-step-two floatL <%if (templateEdit && templateEdit === 'true') {%>step-complete edit-paper-random<%}%>">
            <div class="add-step-icon-wrap">
                <div class="add-step-line add-step-two-line"></div>
                <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">3</span>
                     </span>
                <#if (version?? && version == 'ENTERPRISE') || !(paperTemplate.templateEdit?? && paperTemplate.templateEdit)>
                <%if (paperStatus === 'ENABLE' && (!security || security === 'false') || !templateEdit || templateEdit === 'false'){%>
                <div class="add-step-line"></div>
                <%}%>
                </#if>
            </div>
            <span class="add-step-text" style="margin-left:95px;">随机题</span>
        </li>
        <%if (paperStatus === 'ENABLE' && (!security || security === 'false')){%>
        <#if version?? && version == 'ENTERPRISE'>
        <li class="add-paper-step-item add-paper-step-three floatL <%if (templateEdit && templateEdit === 'true') {%>step-complete edit-paper-auth<%}%>"
            style="width:156px;">
            <div class="add-step-icon-wrap">
                <div class="add-step-line"></div>
                <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">4</span>
                     </span>
            </div>
            <span class="add-step-text" style="margin-left:88px;">使用授权</span>
        </li>
        </#if>
        <%}%>
        <%}else{%>
        <%if (paperStatus === 'ENABLE' && (!security || security === 'false')){%>
        <#if version?? && version == 'ENTERPRISE'>
        <li class="add-paper-step-item add-paper-step-three floatL <%if (templateEdit && templateEdit === 'true') {%>step-complete edit-paper-auth<%}%>"
            style="width:156px;">
            <div class="add-step-icon-wrap">
                <div class="add-step-line"></div>
                <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">3</span>
                     </span>
            </div>
            <span class="add-step-text" style="margin-left:88px;">使用授权</span>
        </li>
        </#if>
        <%}%>
        <%}%>
        <%if (!templateEdit || templateEdit === 'false') {%>
        <li class="add-paper-step-item add-paper-step-three floatL " id="finish_step">
            <div class="add-step-icon-wrap">
                <div class="add-step-line"></div>
                <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">
                           <%if (!paperType || (paperType && paperType === 'FIXED')) {%>
                           3<%}else{%>4<%}%>
                       </span>
                     </span>
            </div>
            <span class="add-step-text" style="margin-left:105px;">完成</span>
        </li>
        <%}%>
    </ul>
</script>
<#--<div class="pe-mask-listen"></div>-->
<script type="text/javascript">
    $(function () {
        var paperStatus = '${(template.paperStatus)!}', security = '${(template.security?string('true','false'))!}',
                templateEdit = '${(template.templateEdit?string('true','false'))!}',paperType='${(template.paperType)!}';
        $('.pe-add-paper-top-head').html(_.template($('#editPaperTopTemp').html())({
            paperStatus: paperStatus,
            security: security,
            templateEdit: templateEdit,
            paperType:paperType
        }));

        PEBASE.peFormEvent('radio');
        var settingInputTree = {
            dataUrl: pageContext.rootPath + '/ems/template/manage/listTree',
            clickNode: function (treeNode) {
                if (!treeNode.pId) {
                    return false;
                }

                $('.pe-input-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                $('input[name="category.id"]').val(treeNode.id);
            },
            width: 310
        };
        //输入框类型树状弹框
        PEBASE.inputTree({
            dom: '.pe-input-tree-wrap',
            treeId: 'peSelelctInputTree',
            treeParam: settingInputTree
        });

        //类别点击筛选事件
        $('.pe-check-by-list').off().click(function () {
            if(paperStatus === 'ENABLE'){
                return false;
            }

            var iconCheck = $(this).find('span.iconfont');
            var thisRealCheck = $(this).find('input[type="radio"]');
            var thisRadioName = thisRealCheck.attr('name');
            var thisRadioValue = thisRealCheck.attr('value');
            var thisRadiosIcons = $('input[name="' + thisRadioName + '"]');
            //待选择好radio的图标即可启用
            if (iconCheck.hasClass('icon-unchecked-radio')) {
                for (var i = 0; i < thisRadiosIcons.length; i++) {
                    $(thisRadiosIcons[i]).parents('.pe-radio').find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                }

                thisRadiosIcons.removeClass('icon-unchecked-radio');
                iconCheck.removeClass('icon-unchecked-radio').addClass('icon-checked-radio ');
                if (!iconCheck.parents('pe-paper-all-check').get(0)) {
                    iconCheck.addClass('peChecked');
                }
                thisRealCheck.prop('checked', true);
            }

            paperType = thisRadioValue;
            $('.pe-add-paper-top-head').html(_.template($('#editPaperTopTemp').html())({
                paperStatus: paperStatus,
                security: security,
                templateEdit: templateEdit,
                paperType:paperType
            }));
        });
        //是否绝密
        $('.pe-paper-attribute-item').click(function () {
            $(this).siblings('.pe-paper-attribute-item').removeClass('cur')
                    .find('.icon-solid-circle-chekced').hide();
            $(this).addClass('cur').find('.icon-solid-circle-chekced').show();
            $('input[name="security"]').val($(this).attr('data-type'));
        });

        $('.pe-step-back-btn').on('click', function () {
            location.href = "#url=/pe/ems/template/manage/initPage&nav=examPaper";//如果出现返回后，表格中的某些按钮不能点击时，在来解决;
        });


        //保存试卷基本信息
        $('.save-next').on('click', function () {
            var paperCode = $('input[name="paperCode"]').val();
            var paperName = $('input[name="paperName"]').val();
            if (!paperCode) {
                PEMO.DIALOG.tips({
                    content: "试卷编号不可为空！",
                    time: 1700
                });
                return false;
            }
            if (!paperName) {
                PEMO.DIALOG.tips({
                    content: "试卷名称不可为空！",
                    time: 1000
                });
                return false;
            }
            PEBASE.ajaxRequest({
                url: pageContext.rootPath + '/ems/template/manage/saveBasic',
                data: $('#templateForm').serialize(),
                success: function (data) {
                    if (data.success) {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initMustPage?templateId=' + data.data.id);
                        return false;
                    }
                    PEMO.DIALOG.alert({
                        content: data.message,
                        btn: ['我知道了'],
                        yes: function () {
                            layer.closeAll();
                        }
                    });
                }
            });
        });

        //保存试卷基本信息
        $('.edit-save').on('click', function () {
            var paperName = $('input[name="paperName"]').val();
            if (!paperName) {
                PEMO.DIALOG.tips({
                    content: "试卷名称不可为空！",
                    time: 1000
                });
                return false;
            }
            PEBASE.ajaxRequest({
                url: pageContext.rootPath + '/ems/template/manage/updateBasic',
                data: $('#templateForm').serialize(),
                success: function (data) {
                    if (data.success) {
                        PEMO.DIALOG.alert({
                            content: '编辑成功',
                            time: 1000,
                            success: function () {
                                $('.layui-layer .layui-layer-content').height(26);
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
                }
            });
        });

        $('.pe-add-paper-top-head').delegate(' .edit-paper-must','click', function () {
            var param = {
                templateEdit: '${(template.templateEdit?string('true','false'))!}',
                templateId: '${(template.id)!}'
            };
            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initMustPage', param);
        });

        $('.pe-add-paper-top-head').delegate('.edit-paper-random','click', function () {
            var param = {
                templateEdit: '${(template.templateEdit?string('true','false'))!}',
                templateId: '${(template.id)!}'
            };
            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initRandomPage', param);
        });

        $('.pe-add-paper-top-head').delegate('.edit-paper-auth','click', function () {
            var param = {
                templateId: '${(template.id)!}'
            };

            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initPaperAuth', param);
        });

    });

</script>