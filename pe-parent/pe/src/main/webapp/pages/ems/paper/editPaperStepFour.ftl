<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">试卷</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">试卷管理</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">编辑试卷</li>
    </ul>
</div>
<section class="add-paper-block" style="padding: 25px,25px,57px,35px;">
<#--头部添加试卷进度步数-->
    <div class="pe-add-paper-top-head">
    <ul class="over-flow-hide edit-step-state">
        <li class="add-paper-step-item floatL step-complete edit-paper-basic">
            <div class="add-step-icon-wrap">
                           <span class="iconfont icon-step-circle floatL">
                            <span class="add-step-number">1</span>
                           </span>
                <div class="add-step-line"></div>
            </div>
            <span class="add-step-text">基本信息</span>
        </li>
        <li class="add-paper-step-item add-paper-step-two floatL step-complete edit-paper-must">
            <div class="add-step-icon-wrap">
                <div class="add-step-line add-step-two-line"></div>
                            <span class="iconfont icon-step-circle floatL">
                              <span class="add-step-number">2</span>
                            </span>
                <div class="add-step-line"></div>
            </div>
            <span class="add-step-text" style="margin-left:95px;">必考题</span>
        </li>
        <#if template.paperType?? && template.paperType == 'RANDOM'>
            <li class="add-paper-step-item add-paper-step-two floatL step-complete edit-paper-random">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                             <span class="iconfont icon-step-circle floatL">
                               <span class="add-step-number">3</span>
                             </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text" style="margin-left:95px;">随机题</span>
            </li>
            <li class="add-paper-step-item add-paper-step-three floatL overStep" style="width:156px;">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line"></div>
                             <span class="iconfont icon-step-circle floatL">
                               <span class="add-step-number">4</span>
                             </span>
                </div>
                <span class="add-step-text" style="margin-left:88px;">使用授权</span>
            </li>
        <#else>
            <li class="add-paper-step-item add-paper-step-three floatL overStep edit-paper-auth" style="width:156px;">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line"></div>
                             <span class="iconfont icon-step-circle floatL">
                               <span class="add-step-number">3</span>
                             </span>
                </div>
                <span class="add-step-text" style="margin-left:88px;">使用授权</span>
            </li>
        </#if>
    </ul>
    </div>
    <div class="pe-add-paper-main-content over-flow-hide paper-accredit-inline-wrap">
        <div class="pe-add-paper-left floatL" style="border:1px solid #e0e0e0;">
            <div class="add-paper-left-head">使用授权</div>
            <div class="add-paper-left-content">
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                        <button type="button" class="pe-btn pe-btn-green pe-accredit-btn" style="margin-left:0;">添加授权
                        </button>
                        <button type="button" class="pe-btn pe-btn-primary pe-paper-accredit-all-btn">移除</button>
                        <p class="pe-add-user-tip-text" style="padding-top: 5px;">已授权以下人员可以使用</p>
                    </div>
                <#--表格包裹的div-->
                    <div class="pe-stand-table-main-panel" style="margin-top: 6px;">
                       <div class="pe-stand-table-wrap" style="padding:0 15px;"></div>
                       <div class="pe-stand-table-pagination"></div>
                    </div>
                </div>
            </div>
            <div class="pe-btns-group-wrap" style="margin-top:35px;margin-left: 25px;">
                <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
            </div>
        </div>
        <div class="add-paper-right add-paper-border">
            <div class="add-paper-right-header paper-most-secret iconfont icon-top-secret-icon">
                <h4 class="add-paper-name">${(template.paperName)!}</h4>
            </div>
            <div class="add-paper-right-list paper-info">
                <dl class="app-paper-info">
                    <dt class="paper-info-title">试卷类型：</dt>
                    <dd class="paper-info-value"><#if template.paperType?? && template.paperType == 'RANDOM'>随机卷<#else>固定卷</#if></dd>
                    <dt class="paper-info-title">总题数：</dt>
                    <dd class="paper-info-value">${(totalItem)!'0'}</dd>
                </dl>
                <a href="${ctx!}/ems/template/manage/initViewPaperPage?templateId=${(template.id)!}"
                   class="pe-btn pe-btn-green pe-paper-preview-btn" target="_blank">预览试卷</a>
                <div class="clear"></div>
            </div>
            <div class="add-paper-right-list add-paper-item-type-wrap">
                <p class="paper-must-title">
                    必考题(共${(totalMustItem)!'0'}道，总分${(totalMustMark?string('#.#'))!'0'}分)
                </p>
                <#if mustCountMap??>
                    <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
                        <#if mustCountMap[itemType]??>
                            <div class="paper-must-list">
                                <span class="paper-ques-type" style="margin-bottom:15px;">
                                    <#if itemType=='SINGLE_SELECTION'>
                                    单选题：
                                        <#elseif itemType=='MULTI_SELECTION'>
                                            多选题：
                                    <#elseif itemType=='INDEFINITE_SELECTION'>
                                        不定项选择题：
                                    <#elseif itemType=='JUDGMENT'>
                                        判断题：
                                    <#elseif itemType=='FILL'>
                                        填空题：
                                    <#else>
                                        问答题：
                                    </#if><span class="paper-single-choosen">${(mustCountMap[itemType])!}</span>
                                </span>
                            </div>
                        </#if>
                    </#list>
                </#if>
            </div>
            <div class="add-paper-right-list add-paper-item-type-wrap question-random-panel">
                <p class="paper-must-title">
                    随机题(共${(totalRandomItem)!'0'}道)
                </p>
                <dl class="app-paper-info">
                <#if randomCountMap??>
                    <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
                        <#if randomCountMap[itemType]??>
                            <dt class="paper-info-title pe-info-sort"><#if itemType=='SINGLE_SELECTION'>
                                单选题：
                            <#elseif itemType=='MULTI_SELECTION'>
                                多选题：
                            <#elseif itemType=='INDEFINITE_SELECTION'>
                                不定项选择题：
                            <#elseif itemType=='JUDGMENT'>
                                判断题：
                            <#elseif itemType=='FILL'>
                                填空题：
                            <#else>
                                问答题：
                            </#if></dt>
                            <dd class="paper-info-value">${(randomCountMap[itemType])!}</dd>
                        </#if>
                    </#list>
                </#if>
                </dl>
                <p class="add-paper-tip-text floatL" style="margin-left:0;">*随机题需考试下发后才生成，故无法统计总分值</p>
            </div>
        </div>
    </div>
</section>
<#--渲染表格模板-->
<script type="text/template" id="paperAccreditUser">
    <table class="pe-stand-table pe-stand-table-default checkbox-table">
        <thead>
        <tr>
            <%for(var i =0,len = peData.tableTitles.length;i<len;i++){%>
            <%if(peData.tableTitles[i].title === 'checkbox') {%>
            <th style="width:<%=peData.tableTitles[i].width%>%">
                <label class="pe-checkbox pe-paper-all-check">
                    <span class="iconfont icon-unchecked-checkbox"></span>
                    <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheckAll"/>
                </label>
            </th>
            <%}else{%>
            <th style="width:<%=peData.tableTitles[i].width%>%">
                <%=peData.tableTitles[i].title%>
            </th>
            <%}%>
            <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
        <tr data-id="<%=peData.rows[j].id%>">
            <td>
                <label class="<%if (peData.rows[j].canDelete) {%>pe-checkbox<%} else {%>disabled-click<%}%> pe-paper-check" data-id="<%=peData.rows[j].user.id%>">
                    <span class="iconfont icon-unchecked-checkbox" <%if (!peData.rows[j].canDelete) {%>style="font-size: 14px;"<%}%>></span>
                    <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheck"/>
                </label>
            </td>
        <#--姓名-->
            <td>
                <div class="pe-ellipsis" title="<%=peData.rows[j].user.userName%>">
                    <%=peData.rows[j].user.userName%>
                </div>
            </td>
        <#--手机号-->
            <td><%=peData.rows[j].user.mobile%></td>
        <#--部门-->
            <td>
                <div class="pe-ellipsis" title="<%=peData.rows[j].createBy%>">
                    <%=peData.rows[j].user.organize?peData.rows[j].user.organize.organizeName:''%>
                </div>
            </td>
        <#--岗位-->
            <td>
                <div class="pe-ellipsis" title="<%=peData.rows[j].user.positionName%>">
                    <%=peData.rows[j].user.positionName%>
                </div>
            </td>
        <#--状态-->
        <#--hover才会出现的移除-->
            <td>
                <%if (peData.rows[j].canDelete) {%>
                <div class="pe-stand-table-btn-group">
                    <button type="button" class="pe-paper-accredit-btn pe-icon-btn iconfont icon-delete" title="删除" data-id="<%=peData.rows[j].user.id%>">
                    </button>
                </div>
                <%}%>
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
<script>
    $(function () {
        var templateId = '${(template.id)!}';
        var peTableTitle = [
            {'title': 'checkbox', 'width': 4},
            {'title': '姓名', 'width': 14},
            {'title': '手机号', 'width': 14},
            {'title': '部门', 'width': 25},
            {'title': '岗位', 'width': 25},
            {'title': '操作', 'width': 10}
        ];
        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/ems/template/manage/searchAuth',
            formParam: {paperTemplateId: templateId},
            tempId: 'paperAccreditUser',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle, //表格头部的数量及名称数组;
            onLoad: function () {
                $('.pe-stand-tr .pe-stand-td').last().css('paddingRight', '15px');

            }//onload结束
        });//peGrid结束

        ////单个移除试卷人员权限
        $('.pe-stand-table-wrap').delegate('.pe-paper-accredit-btn', 'click', function () {
            var userId = $(this).attr('data-id');
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定移除选中的人员么？</h3></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/template/manage/deleteAuth',
                        data: {
                            paperTemplateId: templateId,
                            userId: userId
                        },
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '移除成功',
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
                                yes: function () {
                                    layer.closeAll();
                                }
                            })
                        }
                    });
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });

        $('.pe-step-back-btn').on('click', function () {
            location.href = '#url=' + pageContext.rootPath + '/ems/template/manage/initPage&nav=examPaper';
            PEBASE.publickHeader();
            //定义页面所有的checkbox，和radio的模拟点击事件
            PEBASE.peFormEvent('checkbox');
            PEBASE.peFormEvent('radio');
        });
        //批量移除授权人员
        $('.pe-btn-primary').on('click', function () {
            var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
            if (!rows || rows.length <= 0) {
                PEMO.DIALOG.alert({
                    content: '请选择要移除授权的人员',
                    btn:['我知道了'],
                    yes:function(){
                        layer.closeAll();
                    }
                });

                return false;
            }

            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定移除选中的人员么？</h3></div>',
                btn2: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/template/manage/deleteAuths',
                        data: {
                            paperTemplateId: templateId,
                            userId: JSON.stringify(rows)
                        },
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '移除成功',
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
                            })
                        }
                    });
                },
                btn1: function () {
                    layer.closeAll();
                }
            })
        });

        //试卷授权弹窗
        $('.pe-accredit-btn').on('click', function () {
            PEMO.DIALOG.selectorDialog({
                title: '试卷授权',
                content: [pageContext.rootPath + '/ems/template/manage/toAuthorize?id=' + templateId, 'no'],
                end:function(){
                    $('.pe-stand-table-wrap').peGrid('refresh');
                }
            });
        });

        $('.edit-step-state .edit-paper-must').on('click',function(){
            var param = {
                templateEdit:true,
                templateId:'${(template.id)!}'
            };
            $('#peMainPulickContent').load(pageContext.rootPath+'/ems/template/manage/initMustPage',param);
        });

        $('.edit-step-state .edit-paper-random').on('click',function(){
            var param = {
                templateEdit:true,
                templateId:'${(template.id)!}'
            };
            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initRandomPage',param);
        });

        $('.edit-step-state .edit-paper-basic').on('click',function(){
            var param = {
                templateEdit:true,
                id:'${(template.id)!}'
            };
            $('#peMainPulickContent').load(pageContext.rootPath+'/ems/template/manage/initBasicEditPage',param);
        });
    })
</script>

