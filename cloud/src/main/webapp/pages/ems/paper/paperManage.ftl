<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">试卷</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">试卷管理</li>
    </ul>
</div>
<div class="pe-paper-manage-all-wrap">
    <span class="admin-manage-tip-msg">*系统管理员能查看所有的试卷，其他管理员只能查看本人创建的和其他人授权自己使用的试卷</span>
    <form name="peFormSub" id="peFormSub">
<#--树状布局开始,可复用,记得调用下面的初始化函数;-->
     <div class="pe-manage-content-left floatL">
      <div class="pe-classify-wrap">
        <div class="pe-classify-top over-flow-hide pe-form">
            <span class="floatL pe-classify-top-text">按试卷类别筛选</span>
            <button type="button" title="管理类别" class="floatR iconfont icon-set pe-control-tree-btn set-category-btn"></button>
            <span class="floatR pe-checkbox item-category-include pe-check-by-list">
                <span class="iconfont icon-checked-checkbox"></span>
                <input id="paperIncludeDom" class="pe-form-ele" value="true" name="category.include" type="checkbox" checked="checked"/><span class="include-subclass">包含子类</span>
            </span>
        </div>
        <div class="pe-classify-tree-wrap">
            <div class="pe-tree-search-wrap">
            <#--复用时，保留下面的input单独classname 'pe-tree-form-text'-->
                <input class="pe-tree-form-text" type="text" placeholder="请输入类别名称">
            <#--<span class="pe-placeholder">请输入题库名称</span>--><#--备用,误删-->
                <span class="iconfont pe-tree-search-btn icon-search-magnifier"></span>
            </div>
            <div class="pe-tree-content-wrap">
                <div class="pe-tree-main-wrap">
                    <div class="node-search-empty">暂无</div>
                <#--pe-no-manage-tree为非管理树类添加的样式，是管理类的树，无需此class-->
                    <ul id="paperZtreeMain" class="ztree pe-tree-container" data-type="km"></ul>
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
                            <label class="pe-form-label floatL" for="peMainKeyText">
                                <span class="pe-label-name floatL">关键字:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="试卷名称/编号"
                                       name="paperName">
                            </label>
                            <div class="over-flow-hide">
                                <div class="pe-time-wrap floatL">
                                    <div data-toggle="datepicker" class="control-group input-daterange">
                                        <label class="control-label pe-label-name floatL">创建时间：</label>
                                        <div class="controls pe-date-wrap">
                                            <input type="text" id="pePaperStartTime" name="queryStartTime" class="pe-table-form-text input-medium input-date pe-time-text laydate-icon"><span>-</span>
                                            <input type="text" id="pePaperEndTime" name="queryEndTime" class="pe-table-form-text input-medium input-date pe-time-text laydate-icon">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="pe-stand-form-cell">
                            <label class="pe-form-label floatL" for="peMainKeyText" style="">
                                <span class="pe-label-name floatL">创建人:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text" placeholder="用户名/姓名/手机号/工号"
                                       name="createBy">
                            </label>
                            <dl>
                                <dt class="pe-label-name floatL">&emsp;状&emsp;态:</dt>
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
                        <button type="button" class="pe-btn pe-btn-blue floatL pe-question-choosen-btn">筛选</button>
                    </div>
                </div>
                <input type="hidden" name="category.id" value="${(category.id)!}"/>
                <input type="hidden" name="category.categoryName" value="${(category.categoryName)!}"/>
                <input type="hidden" name="itemBank.category.include" value="true"/>
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                    <@authVerify authCode="PAPER_ADD"><button type="button" class="pe-btn pe-btn-green pe-new-question-btn">创建试卷</button></@authVerify>
                        <button type="button" class="pe-btn pe-btn-primary " id="batchDeleteDom">删除</button>
                        <button type="button" class="pe-btn pe-btn-primary " id="batchStopDom">停用</button>
                    </div>
                    <#--表格包裹的div-->
                    <div class="pe-stand-table-main-panel">
                        <div class="pe-stand-table-wrap"></div>
                        <div class="pe-stand-table-pagination"></div>
                    </div>
                </div>
            </div>
      </div>
    </form>
 </div>
<#--右侧表格主题部分结束-->
<#--渲染表格模板-->
    <script type="text/template" id="paperTableTep">
        <table class="pe-stand-table pe-stand-table-default checkbox-table">
            <thead>
            <tr>
                <%for(var i =0,lenI = peData.tableTitles.length;i<lenI ;i++){%>
                    <%if(peData.tableTitles[i].title === 'checkbox'){%>
                    <th style="width:<%=peData.tableTitles[i].width%>%">
                        <label class="pe-checkbox pe-paper-all-check">
                            <span class="iconfont icon-unchecked-checkbox"></span>
                            <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheckAll"/>
                        </label>
                    </th>
                    <%}else{%>
                        <%if(peData.tableTitles[i] && peData.tableTitles[i].needIcon){%>
                            <th style="width:<%=peData.tableTitles[i].width%>%;padding-left:22px;">
                        <%}else{%>
                            <th style="width:<%=peData.tableTitles[i].width%>%">
                        <%}%>
                        <%=peData.tableTitles[i].title%>
                    </th>
                    <%}%>
                    <%}%>
            </tr>
            </thead>
            <tbody>
            <#--<tr class="pe-stand-bg"></tr>-->
            <%if(peData.rows.length !== 0){%>
            <%for(var j =0,lenJ = peData.rows.length;j<lenJ;j++){%>
                <tr data-index="<%=j%>">
                    <td>
                        <label class="pe-checkbox pe-paper-check " data-id="<%=peData.rows[j].id%>">
                            <span class="iconfont icon-unchecked-checkbox"></span>
                            <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheck"/>
                        </label>
                    </td>
                <#--生成题型类-->
                    <td><div class="pe-ellipsis" title="<%=peData.rows[j].paperCode%>"><%=peData.rows[j].paperCode%></div></td>
                    <td style="padding-left:22px;position:relative;">
                        <%if(peData.rows[j].security){%>
                         <span class="iconfont icon-security"></span>
                        <%}%>
                        <a class="pe-stand-table-alink pe-dark-font pe-ellipsis" title="<%=peData.rows[j].paperName%>"
                                               href="${ctx!}/ems/template/manage/initViewPaperPage?templateId=<%=peData.rows[j].id%>"
                                               target="_blank"><%=peData.rows[j].paperName%></a>
                    </td>
                    <%if(peData.rows[j].paperType === 'FIXED'){%>
                    <td>固定</td>
                    <%}else if(peData.rows[j].paperType === 'RANDOM'){%>
                    <td>随机</td>
                    <%}else {%>
                    <td></td>
                    <%}%>
                    <td><div class="pe-ellipsis" title="<%=peData.rows[j].createBy%>"><%=peData.rows[j].createBy%></div></td>
                    <td><%=peData.rows[j].createDate%></td>
                <#--此处生成题型状态-->
                    <%if(peData.rows[j].paperStatus === 'ENABLE'){%>
                    <td>启用</td>
                    <%}else if(peData.rows[j].paperStatus === 'DISABLE'){%>
                <#--此处为所属状态，我不知道改选哪个属性-->
                    <td>停用</td>
                    <%}else if(peData.rows[j].paperStatus === 'DRAFT'){%>
                    <td>草稿</td>
                    <%}else {%>
                    <td></td>
                    <%}%>
                <#--<%}else{%>-->
                    <td>
                        <div class="pe-stand-table-btn-group">
                            <%if(peData.rows[j].paperStatus === 'ENABLE'&& peData.rows[j].canEdit==='true'){%>
                        <button type="button" class="pe-table-stop-btn pe-icon-btn iconfont icon-stop" title="停用"
                              data-id="<%=peData.rows[j].id%>"></button>
                            <%}else if(peData.rows[j].paperStatus === 'DRAFT' || peData.rows[j].paperStatus ===
                            'DISABLE'){%>
                        <button type="button" class="enable-btn pe-icon-btn iconfont icon-start" title="启用"
                              data-id="<%=peData.rows[j].id%>"></button>
                            <%}%>
                        <button type="button" class="edit-btn pe-icon-btn iconfont icon-edit" title="编辑"
                              data-id="<%=peData.rows[j].id%>"></button>
                        <button type="button" class="delete-btn pe-icon-btn iconfont icon-delete" title="删除"
                              data-id="<%=peData.rows[j].id%>"></button>
                            <%if( peData.rows[j].paperStatus === 'ENABLE' && !peData.rows[j].security){%>
                        <@authVerify authCode="VERSION_OF_TEMPLATE_AUTHORIZE">
                            <button type="button" class="auth-btn pe-icon-btn iconfont icon-pe-accredit" title="授权"
                                    data-id="<%=peData.rows[j].id%>"></button>
                        </@authVerify>
                            <%}%>
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
    <script>
        $(function () {
            /*自定义表格头部数量及宽度*/
            var peTableTitle = [
                {'title': 'checkbox', 'width': 5},
                {'title': '试卷编号', 'width': 16},
                {'title': '试卷名称', 'width': 23,'needIcon':true},
                {'title': '试卷类型', 'width': 8},
                {'title': '创建人', 'width': 12},
                {'title': '创建日期', 'width': 14},
                {'title': '状态', 'width': 6},
                {'title': '操作', 'width': 14}
            ];
            /*表格生成*/
            $('.pe-stand-table-wrap').peGrid({
                url: pageContext.rootPath + '/ems/template/manage/search',
                formParam: $('#peFormSub').serializeArray(),//表格上方表单的提交参数
                tempId: 'paperTableTep',//表格模板的id
                showTotalDomId: 'showTotal',
                title: peTableTitle, //表格头部的数量及名称数组;
                onLoad: function () {
                }
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
                $('.pe-stand-table-wrap').peGrid('load', $('#peFormSub').serializeArray());
            });

            $('.pe-stand-table-wrap').delegate('.pe-table-stop-btn', 'click', function () {
                var id = $(this).data('id');
                PEMO.DIALOG.confirmR({
                    content: '<div><h3 class="pe-dialog-content-head">确定停用选中的试卷么？</h3><p class="pe-dialog-content-tip">停用的试卷可以再次被启用。 </p></div>',
                    btn2: function () {
                        $.post(pageContext.rootPath + '/ems/template/manage/stopTemplate', {'templateId': id}, function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '停用成功',
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
                        }, 'json');
                    },
                    btn1:function(){
                        layer.closeAll();
                    }
                });
            });

            $('.pe-stand-table-wrap').delegate('.enable-btn', 'click', function () {
                var id = $(this).data('id');
                PEMO.DIALOG.confirmR({
                    content: '<div><h3 class="pe-dialog-content-head">确定启用选中的试卷么？</h3></div>',
                    btn2: function () {
                        PEBASE.ajaxRequest({
                            url : pageContext.rootPath + '/ems/template/manage/checkTemplate',
                            data : {'templateId': id},
                            success : function(data){
                                if (data.success) {
                                    enableTemplate(id);
                                    return false;
                                } else if (!data.success && data.data && data.data.length > 0) {
                                    PEMO.DIALOG.confirmR({
                                        content: '<div><h3 class="pe-dialog-content-head">必考题的数量减少了，确定继续启用么？</h3></div>',
                                        btn2:function(){
                                            enableTemplate(id);
                                        },
                                        btn1:function(){
                                            layer.closeAll();
                                        }
                                    });
                                } else {
                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function () {
                                            layer.closeAll();
                                        }
                                    });
                                }
                            }
                        });
                    },
                    btn1:function(){
                        layer.closeAll();
                    }
                });
            });

            $('.pe-stand-table-wrap').delegate('.delete-btn', 'click', function () {
                var id = $(this).data('id');
                PEMO.DIALOG.confirmR({
                    content: '<div><h3 class="pe-dialog-content-head">确定删除选中的试卷么？</h3><p class="pe-dialog-content-tip">删除后，试卷不可以恢复，请谨慎操作。 </p></div>',
                    btn2: function () {
                        $.post(pageContext.rootPath + '/ems/template/manage/deleteTemplate', {'templateId': id}, function (data) {
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
                            })
                        }, 'json');
                    },
                    btn1:function(){
                        layer.closeAll();
                    }
                });
            });

            $('.pe-stand-table-wrap').delegate('.edit-btn', 'click', function () {
                var id = $(this).data('id');
                var url = encodeURIComponent(pageContext.rootPath + '/ems/template/manage/initBasicEditPage?id='+id+"&templateEdit=true");
                location.href = '#url='+url+"&nav=examPaper";
            });

            $('.pe-stand-table-wrap').delegate('.auth-btn', 'click', function () {
                var id = $(this).attr('data-id');
                window.open(pageContext.rootPath + '/ems/template/manage/toSearchAuth?paperTemplateId=' + id)
            });

            $('.pe-question-choosen-btn').on('click', function () {
                $('.pe-stand-table-wrap').peGrid('load', $('#peFormSub').serializeArray());
            });

            $('.item-category-include span').on('click', function () {
                if ($(this).prop('checked')) {
                    $('input[name="category.include"]').val('true');
                } else {
                    $('input[name="category.include"]').val('false');
                }
            });

            $('#batchDeleteDom').on('click', function () {
                var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                if (!rows || rows.length <= 0) {
                    PEMO.DIALOG.alert({
                        content: '请至少先选择一份试卷！',
                        btn:['我知道了'],
                        yes:function(){
                            layer.closeAll();
                        }
                    });

                    return false;
                }

                PEMO.DIALOG.confirmR({
                    content: '<div><h3 class="pe-dialog-content-head">确定删除选中的试卷么？</h3><p class="pe-dialog-content-tip">删除后，试卷不可以恢复，请谨慎操作。 </p></div>',
                    btn2: function () {
                        $.post(pageContext.rootPath + '/ems/template/manage/batchDeleteTemplate', {'templateId': JSON.stringify(rows)}, function (data) {
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
                            })
                        }, 'json');
                    },
                    btn1:function(){
                        layer.closeAll();
                    }
                });
            });

            $('#batchStopDom').on('click', function () {
                var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                if (!rows || rows.length <= 0) {
                    PEMO.DIALOG.alert({
                        content: '请至少先选择一份试卷！',
                        btn:['我知道了'],
                        yes:function(){
                            layer.closeAll();
                        }
                    });

                    return false;
                }

                PEMO.DIALOG.confirmR({
                    content: '<div><h3 class="pe-dialog-content-head">确定停用选中的试卷么？</h3><p class="pe-dialog-content-tip">停用的试卷可以再次被启用。 </p></div>',
                    btn2: function () {
                        $.post(pageContext.rootPath + '/ems/template/manage/batchStopTemplate', {'templateId': JSON.stringify(rows)}, function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '停用成功',
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
                        }, 'json');
                    },
                    btn1:function(){
                        layer.closeAll();
                    }
                });
            });

            $('.pe-new-question-btn').click(function () {
                var categoryId = $('input[name="category.id"]').val();
                location.href='#';//这是因为我在这里做了一次新的赋值 改变了location.href的值
                location.href = '#url='+pageContext.rootPath + '/ems/template/manage/initBasicEditPage?category.id='+categoryId+"&nav=examPaper";//这里又重新赋值为之前的值，所以你看到浏览器地址栏的值和之前的一样，其实我已经变了一次
            });

            var settingUrl = {
                dataUrl: pageContext.rootPath + '/ems/template/manage/listTree',
                clickNode: function (treeNode) {
                    $('input[name="category.id"]').val(treeNode.id);
                    $('input[name="category.categoryName"]').val(treeNode.name);
                    $('.pe-stand-table-wrap').peGrid('load', $('#peFormSub').serializeArray());
                },
                optUrl: {
                    editUrl: pageContext.rootPath + '/base/category/manage/edit?categoryType=PAPER',
                    addUrl: pageContext.rootPath + '/base/category/manage/add?categoryType=PAPER',
                    deleUrl: pageContext.rootPath + '/base/category/manage/delete?categoryType=PAPER',
                    moveUrl: pageContext.rootPath + '/base/category/manage/moveLevel',
                    isNewNode: false
                }
            };

            PEMO.ZTREE.initTree('paperZtreeMain', settingUrl);
            PEBASE.peSelect($('.pe-question-select'), null, $('input[name="peQuestionType"]'));
            PEBASE.peSelect($('.pe-diff-select'), null, $('input[name="peQuestionDifficulty"]'));
            PEBASE.peFormEvent('checkbox');
            PEBASE.peFormEvent('radio');

            function enableTemplate(id){
                PEBASE.ajaxRequest({
                    url : pageContext.rootPath + '/ems/template/manage/enableTemplate',
                    data : {'templateId': id},
                    success : function(data){
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '启用成功',
                                time: 1000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });

                            return false;
                        }

                        PEMO.DIALOG.alert({
                            content: data.message,
                            area:['420px'],
                            btn:['我知道了'],
                            yes:function(){
                                layer.closeAll();
                            }
                        });
                    }
                });
            }
        });
        $(function(){
            PEBASE.isPlaceholder();
        })
    </script>