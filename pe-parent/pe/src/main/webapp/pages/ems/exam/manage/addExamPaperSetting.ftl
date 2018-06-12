<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
    <#if exam?? && exam.subject?? && exam.subject>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">科目管理</li>
        <#if exam.markUpId??>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览
                <#else>
                    补考设置
                </#if>
            </li>
        <#elseif exam.examType?? && exam.examType == 'ONLINE'>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑线上科目
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览线上科目
                <#else>
                    创建线上科目
                </#if>
            </li>
        <#else>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑线下科目
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览线下科目
                <#else>
                    创建线下科目
                </#if>
            </li>
        </#if>
    <#else>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">考试管理</li>
        <#if exam.markUpId??>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览
                <#else>
                    补考设置
                </#if>
            </li>
        <#elseif exam.examType?? && exam.examType == 'ONLINE'>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑线上考试
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览线上考试
                <#else>
                    创建线上考试
                </#if>
            </li>
        <#elseif exam.examType?? && exam.examType == 'OFFLINE'>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑线下考试
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览线下考试
                <#else>
                    创建线下考试
                </#if>
            </li>
        <#else>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑综合考试
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览综合考试
                <#else>
                    创建综合考试
                </#if>
            </li>
        </#if>
    </#if>
    </ul>
</div>
<section class="steps-all-panel">
    <form id="examManageForm">
        <div class="add-exam-top-head">
            <ul class="over-flow-hide step-items-wrap <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-step-state</#if>">
                <li class="add-paper-step-item floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover basic-step-item<#else>step-complete</#if>"
                    style="text-align:left;"><#--#b8ecaa-->
                    <div class="add-step-icon-wrap">
                   <span class="iconfont icon-step-circle floatL">
                    <span class="add-step-number">1</span>
                   </span>
                        <div class="add-step-line"></div>
                    </div>
                    <span class="add-step-text">基本信息</span>
                </li>
                <li class="add-paper-step-item add-paper-step-two floatL overStep">
                    <div class="add-step-icon-wrap">
                        <div class="add-step-line add-step-two-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                           <span class="add-step-number">2</span>
                        </span>
                        <div class="add-step-line"></div>
                    </div>
                    <span class="add-step-text">试卷设置</span>
                </li>
            <#if exam?? && exam.subject?? && exam.subject>
                <li class="add-paper-step-item add-paper-step-three floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover setting-step-item</#if>">
                    <div class="add-step-icon-wrap">
                        <div class="add-step-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">3</span>
                     </span>
                    </div>
                    <span class="add-step-text">考试设置</span>
                </li>
            <#else >
                <li class="add-paper-step-item add-paper-step-two floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover arrange-step-item</#if>">
                    <div class="add-step-icon-wrap">
                        <div class="add-step-line add-step-two-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">3</span>
                     </span>
                    <#if !(exam.markUpId??)><div class="add-step-line"></div></#if>
                    </div>
                    <span class="add-step-text">考试安排</span>
                </li>
                <#if !(exam.markUpId??)>
                <li class="add-paper-step-item add-paper-step-three floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover setting-step-item</#if>">
                    <div class="add-step-icon-wrap">
                        <div class="add-step-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">4</span>
                     </span>
                    </div>
                    <span class="add-step-text">考试设置</span>
                </li>
                </#if>
            </#if>
            </ul>
        </div>
        <div class="add-exam-main-panel add-exam-step-two-wrap">
            <div class="add-exam-item-wrap">
            <#--没有添试卷时及添加试卷过程中-->
            <#if (exam.paperTemplate)?? && (exam.paperTemplate.id)?? && (exam.paperTemplate.id)! != "">
            <#--添试卷完成时-->
                <div class="add-exam-step-two-complete">
                    <div class="create-top-panel">

                    </div>
                <#--表格包裹的div-->
                    <div class="pe-stand-table-main-panel">
                        <div class="pe-stand-table-wrap"></div>
                        <div class="pe-stand-table-pagination"></div>
                    </div>
                </div>
            <#else>
                <#if exam?? && exam.status?? && (exam.status == 'NO_START' || exam.status == 'DRAFT')>
                    <div class="add-paper-no-item-wrap  exam-paper-setting-btn exam-paper-create-btn" <#if exam.optType?? && exam.optType == 'VIEW'>style="display: none"</#if>>
                        <div class="add-paper-no-icon">
                            <div class="exam-add-pic-wrap">
                            </div>
                        </div>
                    <#--没有添加试卷时-->
                        <p class="pe-add-paper-tip">点击选择试卷</p>
                    <#--添加试卷完成.如果完成了，固定试卷上面的"loading"去除，改为"load-over"-->
                    </div>
                </#if>
                    <div class="add-paper-no-item-wrap exam-paper-msg-btn <#if !(exam.optType?? && exam.optType != 'VIEW')>exam-paper-view-state</#if>" <#if !(exam.optType?? && exam.optType == 'VIEW' ) && !((exam.examType?? && exam.examType == 'OFFLINE') && (exam.status?? && (exam.status == 'PROCESS' )))>style="display: none" </#if>>
                        <p class="pe-add-paper-tip">暂无试卷</p>
                    </div>
            </#if>
            </div>
        </div>
    </form>
</section>
<div class="pe-btns-group-wrap" style="text-align:center;margin-left:0;">
<#if exam.status == 'NO_START' || exam.status == 'ENABLE' || exam.status == 'DRAFT'||exam.status='PROCESS'>
    <#if exam.optType?? && (exam.optType == 'VIEW')>
        <div class="view-exam-group-one">
    <#else>
        <#if !(exam.optType?? && exam.optType == 'UPDATE')>
            <button type="button" class="pe-btn pe-btn-purple pe-step-pre-btn">上一步</button>
            <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-next">下一步</button>
        </#if>
    </#if>
    <#if exam.source?? && exam.source == 'ADD'>
        <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
    <#else >
        <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
    </#if>
    <#if (exam.optType?? && (exam.optType == 'VIEW') && (exam.status?? && exam.status !='PROCESS'))>
            <a href="javascript:;" class="pe-view-user-btn i-need-edit-exam"><span class="iconfont icon-edit"></span>我要编辑考试信息
            </a>
        </div>
        <div class="view-exam-group-two" style="display: none;">
            <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
        </div>
    </div>
    </#if>
<#elseif exam.subject?? && exam.subject && exam.status == 'DISABLE'>
    <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
<#else>
        <button type="button" class="pe-btn pe-btn-white pe-large-btn new-page-close-btn">关闭</button>
</#if>
</div>
<script type="text/template" id="editPaper">
    <div class="exam-paper-model">
                            <span class="add-exam-type" data-type='<#if (exam.paperTemplate.paperType)! == "FIXED">
                                固定<#elseif (exam.paperTemplate.paperType)! == "RANDOM">随机</#if>'>
                                [<#if (exam.paperTemplate.paperType)! == "FIXED">
                                固定<#elseif (exam.paperTemplate.paperType)! == "RANDOM">随机</#if>]</span>
        <span class="model-paper-name">${(exam.paperTemplate.paperName)!}</span>
    </div>
    <#if exam.status == 'NO_START' || exam.status == 'ENABLE' || exam.status == 'DRAFT'>
    <button type="button" class="pe-add-paper-add-btn exam-paper-setting-btn"><span
            class="iconfont icon-new-add"></span>继续选择试卷
    </button>
    <input type="hidden" id="paperTemplateId" value="${(exam.paperTemplate.id)!}"/>
    <div class="exam-create-kinds-paper over-flow-hide"
         <#if (exam.paperTemplate.paperType)! == "FIXED" || exam.paperCount<=0 >style="display: none;" </#if>>
        <div class="exam-create-paper-tip floatL">你还可以生成<span
                class="exam-can-create-num">${(exam.paperCount)!'100'}</span>,继续生成
            <input type="text" class="exam-create-num-input" id="randomNum"/>
            套试卷
        </div>
        <button type="button" class="floatL pe-btn pe-btn-purple exam-create-paper-btn"
                id="generatePaper">立即生成
        </button>
    </div>
    </#if>
</script>
<#--渲染表格模板-->
<script type="text/template" id="peQuestionTableTep">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%_.each(peData.tableTitles,function(tableTitle){%>
            <th style="width:<%=tableTitle.width%>%">
                <%=tableTitle.title%>
            </th>
            <%});%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%_.each(peData.rows,function(paper,index){%>
        <tr data-id="<%=paper.id%>">
        <#--试卷序号-->
            <td>
                <div class="pe-ellipsis"><%=paper.showOrder%></div>
            </td>
        <#--试卷来源-->
            <td>
                <div class="pe-ellipsis" title="<%=paper.paperTemplate.paperName%>"><%=paper.paperTemplate.paperName%>
                </div>
            </td>
        <#--试卷总数-->
            <td>
                <div class="pe-ellipsis" title="<%=paper.itemCount%>"><%=paper.itemCount%></div>
            </td>
        <#--试题分值-->
            <td>
                <div class="pe-ellipsis" title="<%=paper.mark%>"><%=(Number(paper.mark)).toFixed(1)%></div>
            </td>
        <#--综合难度-->
            <td>
                <div class="pe-ellipsis">
                    <div class="pe-star-wrap">
                        <%if(paper.level == 'SIMPLE'){%>
                        <span class="pe-star-container floatL" style="cursor: auto;">
                                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                      </span>
                        <%}else if(paper.level == 'RELATIVELY_SIMPLE'){%>
                        <span class="pe-star-container floatL" style="cursor: auto;">
                                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                      </span>
                        <%}else if(paper.level == 'MORE_DIFFICULT'){%>
                        <span class="pe-star-container floatL" style="cursor: auto;">
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty"></span>
                                      </span>
                        <%}else if(paper.level == 'DIFFICULT'){%>
                        <span class="pe-star-container floatL" style="cursor: auto;">
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                      </span>
                        <%}else{%>
                        <span class="pe-star-container floatL" style="cursor:auto;">
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty"></span>
                                         <span class="pe-star iconfont icon-start-difficulty"></span>
                                      </span>
                        <%}%>
                    </div>
                </div>
            </td>
        <#--操作-->
            <td>
                <div class="pe-stand-table-btn-group">
                    <a class="pe-icon-btn iconfont icon-preview preview-paper" style="font-size:16px;" title="预览"
                       href="${ctx!}/ems/exam/manage/initViewPaper?paperId=<%=paper.id%>" target="_blank">
                    </a>
                <#if exam.status == 'NO_START' || exam.status == 'ENABLE' || exam.status == 'DRAFT' >
                        <a class="pe-icon-btn iconfont icon-edit edit-paper" title="编辑"
                           href="${ctx!}/ems/exam/manage/initEditPaper?paperId=<%=paper.id%>" target="_blank"
                           data-id="<%=paper.id%>" <#if exam.optType?? && exam.optType == 'VIEW'>style="display:none;"</#if>
                        </a>
                        <a class="pe-icon-btn iconfont icon-delete delete-paper" title="删除"
                           data-id="<%=paper.id%>" <#if exam.optType?? && exam.optType == 'VIEW'>style="display:none;"</#if>>
                        </a>
                    </#if>
                </div>
            </td>
        </tr>
        <%});%>
        <%}else{%>
        <tr class="pe-stand-tr">
            <td class="pe-stand-td pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
                <div class="pe-result-no-date"></div>
                <p class="pe-result-date-warn">暂无数据</p>
            </td>
        </tr>
        <%}%>
        </tbody>
    </table>
</script>
<#--试卷正在生成中模板-->
<script type="text/template" id="paperCreatingTemp">
    <div class="paper-creating-paper-name">
        <span class="add-exam-type">[<%=data.type%>]</span><%=data.paperName%>
    </div>
    <div class="paper-creating-pic-wrap"></div>
    <div class="creating-loading-tip">正在生成试卷...</div>
</script>
<#--试卷生成成功中模板-->
<script type="text/template" id="paperCreateSuccessTemp">
    <div class="paper-creating-paper-name">
        <span class="add-exam-type">[<%=data.type%>]</span><%=data.paperName%>
    </div>
    <div class="paper-creating-success-pic-wrap"></div>
    <div class="creating-loading-tip">已经为您生成了<%=data.size%>套试卷</div>
</script>
<script>
    $(function () {
        if(typeof changeExamManaStorage === 'function'){
            window.removeEventListener("storage", changeExamManaStorage,false);
        }

        var optType = '${(exam.optType)!}';
        var source = '${(exam.source)!}';
        var subject = '${((exam.subject)!)?string('true','false')}';
        var editPaper = {
            initData: function () {
                var peTableTitle = [
                    {'title': '试卷序号', 'width': 10},
                    {'title': '试卷来源', 'width': 30},
                    {'title': '试题总量', 'width': 10},
                    {'title': '试题分值', 'width': 10},
                    {'title': '综合难度', 'width': 20},
                    {'title': '操作', 'width': 14}
                ];

                /*表格生成*/
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/exam/manage/searchPaper',
                    formParam: {'examId': '${(exam.id)!}'},
                    tempId: 'peQuestionTableTep',//表格模板的id
                    showTotalDomId: 'showTotal',
                    title: peTableTitle //表格头部的数量及名称数组;
                });

                if(optType != 'VIEW'){
                    $('.create-top-panel').html(_.template($('#editPaper').html())())
                }

            },

            init: function () {
                window.addEventListener("storage", function (e) {
                    if(!e.newValue){
                        return;
                    }

                    if (e.key === 'EXAM_PAPER_EDIT') {
                        $('.pe-stand-table-wrap').peGrid('refresh', {'examId': '${(exam.id)!}'});
                        localStorage.removeItem(e.key);
                    }
                });

                $('.edit-step-state .arrange-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType,source:source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage', params);
                });

                $('.edit-step-state .basic-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType,source:source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamInfo', params);
                });

                $('.edit-step-state .setting-step-item').on('click', function () {
                    var examTye = '${(exam.examType)!}';
                    var params = {id: '${(exam.id)!}', optType: optType,subject:'${((exam.subject)!)?string('true','false')}',source:source};
                    if (examTye === 'OFFLINE') {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initOfflineExamSetting', params);
                    }else if(examTye === 'ONLINE'){
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamSetting', params);
                    }
                });



                $(".pe-step-pre-btn").on('click', function () {
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamInfo?id=${(exam.id)!}');
                });

                $(".pe-step-next-btn").on('click', function () {
                    if(source=='ADD'){
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage?id=${(exam.id)!}&source=ADD');
                    }else {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage?id=${(exam.id)!}');
                    }

                    if (optType == 'VIEW') {
                        $('.view-exam-group-one').show();
                        $('.view-exam-group-two').hide();
                        $('input:not(.laydate-time)').attr('disabled', true);
                        $('button').attr('disabled', true);
                    }
                });

                $('.new-page-close-btn').on('click',function(){
                    window.close();
                });

                $('.pe-stand-table-wrap').delegate('.delete-paper', 'click', function () {
                    var paperId = $(this).data('id');
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要删除该试卷么？</div>',
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/exam/manage/deletePaper',
                                data: {'paperId': paperId},
                                success: function (data) {
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '删除成功',
                                            time: 1000,
                                            end: function () {
                                                $('.pe-stand-table-wrap').peGrid('refresh', {'examId': '${(exam.id)!}'});
                                                editPaper.countPaper($('#paperTemplateId').val(),function (data) {
                                                    if(!data || data <= 0){
                                                        $('.exam-create-kinds-paper').hide();
                                                        return false;
                                                    }

                                                    $('.exam-can-create-num').text(data);
                                                    $('.exam-create-num-input').val('');
                                                    $('.exam-create-kinds-paper').show();
                                                });

                                            }
                                        });

                                        return false;
                                    } else {
                                        PEMO.DIALOG.alert({
                                            content: data.message,
                                            btn: ['我知道了'],
                                            yes: function (index) {
                                                layer.close(index);
                                                layer.close(loadingLayerIndex);
                                            }
                                        });
                                        return false;
                                    }
                                }
                            });
                        },
                        btn1: function () {
                            layer.closeAll();
                        }
                    });

                });

                $('.steps-all-panel').delegate('.exam-paper-setting-btn','click',function(){
                    PEMO.DIALOG.selectorDialog({
                        title: '选择试卷',
                        content: [pageContext.rootPath + '/ems/exam/manage/addExamPaper?examId=${(exam.id)!}', 'no'],
                        area: ['925px', '670px'],
                        btn: ['取消', '确认'],
                        needPagination:true,
                        skin: 'pe-add-exam-dialog exam-create-paper-dialog',
                        btn2: function () {
                            var $paperCheck = $($(layer.getChildFrame('.select-paper-template'))).find("input[name='paperCheck']:checked").parent('.pe-paper-check');
                            var thisCheckId = $paperCheck.data('id');
                            var thisCheckName = $paperCheck.data('title');
                            var thisCheckType = $paperCheck.data('type');
                            if (!thisCheckId) {
                                PEMO.DIALOG.tips({
                                    content: '请选择试卷！',
                                    btn: ['我知道了'],
                                    yes: function (index) {
                                        layer.close(index);
                                    }
                                });

                                return false;
                            }
                            var dataLoading = {
                                "type": $paperCheck.parents('tr').find('.paper-type').html(),
                                "paperName": $paperCheck.parents('tr').find('.pe-dark-font').html()
                            };
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/exam/manage/checkPaperTemplate',
                                data: {'templateId': thisCheckId},
                                success: function (data) {
                                    if (data.success) {
                                        $('.exam-create-paper-dialog').hide();
                                        /*生成试卷loading弹框样式*/
                                        var loadingLayerIndex = layer.open({
                                            type: 1,
                                            closeBtn: 0,
                                            title: '',
                                            skin: 'creating-paper-dialog',
                                            area: ['620px', '300px'], //宽高
                                            content: _.template($('#paperCreatingTemp').html())({data: dataLoading})
                                        });
                                        /*关闭正在生成提示弹框*/
                                        setTimeout(function () {
                                            layer.close(loadingLayerIndex);
                                            editPaper.countPaper(thisCheckId,function (data) {
                                                layer.closeAll();
                                                if(!data || data <= 0){
                                                    PEMO.DIALOG.alert({
                                                        content: '无法生成足够的试卷，请选择其他试卷模板尝试',
                                                        btn: ['我知道了'],
                                                        yes: function (index) {
                                                            layer.close(index);
                                                            layer.close(loadingLayerIndex);
                                                        }
                                                    });

                                                    return false;
                                                }

                                                if(data>2){
                                                    data = 2;
                                                }

                                                var dataSuccess = {
                                                    "type": dataLoading.type,
                                                    "paperName": dataLoading.paperName,
                                                    "size": data
                                                };

                                                editPaper.generatePaper(thisCheckId, data, function (data) {
                                                    var params = {id:'${(exam.id)!}',optType:optType,'paperTemplateId': thisCheckId};
                                                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper',params);
                                                }, dataSuccess);
                                            });

                                            return false;
                                        }, 2000);

                                    } else {
                                        PEMO.DIALOG.alert({
                                            content: data.message,
                                            btn: ['我知道了'],
                                            yes: function (index) {
                                                layer.close(index);
                                                layer.close(loadingLayerIndex);
                                            }
                                        });
                                    }


                                }
                            });

                            return false;
                        },
                        btn1: function () {
                            layer.closeAll();
                        },
                        success:function(){
                        }
                    });
                });

                $('.steps-all-panel .add-paper-no-item-wrap').hover(
                        function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                                $(this).addClass('no-paper-wrap-hover');
                        },
                        function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            $(this).removeClass('no-paper-wrap-hover');
                        }

                );

                $('.pe-step-back-btn').on('click', function () {
//                    history.back(-1);
                    if (subject && subject === 'true') {
                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initSubjectPage&nav=examMana';
                    } else {
                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initPage&nav=examMana';
                    }
                });

                $(".create-top-panel").delegate('#generatePaper','click',function () {
                    var randomNum = $("#randomNum").val();
                    var count = parseInt($('.exam-can-create-num').text());
                    if (!randomNum) {
                        PEMO.DIALOG.tips({
                            content: "请输入生成试卷数量！",
                            time: 1000
                        });
                        return false;
                    }
                    if (randomNum < 0 || randomNum >count) {
                        PEMO.DIALOG.tips({
                            content: "输入的试卷数量非法，请重新输入！",
                            time: 1000
                        });
                        return false;
                    }

                    var dataSucc = {
                        "type": $('.add-exam-type').attr('data-type'),
                        "paperName": $('.model-paper-name').html(),
                        "size": randomNum
                    };

                    editPaper.generatePaper($("#paperTemplateId").val(), randomNum, function () {
                        $('.pe-stand-table-wrap').peGrid('refresh', {'examId': '${(exam.id)!}'});
                        $('.exam-can-create-num').text(count-randomNum);
                        if(count-randomNum <= 0){
                            $('.exam-create-kinds-paper').hide();
                        }
                    }, dataSucc, true);
                });

                //我要编辑考试
                $('.i-need-edit-exam').on('click', function () {
                    $('.create-top-panel').html(_.template($('#editPaper').html())());
                    $(this).remove();
                    $('.exam-paper-msg-btn').hide();
                    $('.exam-paper-create-btn').show();
                    $('.view-exam-group-two').show();
                    $('.view-exam-group-one').hide();
                    $('.edit-paper').show();
                    $('.delete-paper').show();
                });
            },

            countPaper:function (templateId,callback) {
                PEBASE.ajaxRequest({
                    url : pageContext.rootPath+'/ems/exam/manage/countPaper',
                    data:{examId:'${(exam.id)!}',templateId:templateId},
                    success:function (data) {
                        if(callback){
                            callback(data);
                        }
                    }
                });
            },

            generatePaper: function (thisCheckId, count, func, dataSuccess, isBtnCreate) {
                if (isBtnCreate) {
                    /*生成试卷loading弹框样式*/
                    var loadingLayerIndex = layer.open({
                        type: 1,
                        closeBtn: 0,
                        title: '',
                        skin: 'creating-paper-dialog',
                        area: ['620px', '300px'], //宽高
                        content: _.template($('#paperCreatingTemp').html())({data: dataSuccess})
                    });
                }
                dataSuccess.size = count;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/manage/makePaper',
                    data: {'exam.id': '${(exam.id)!}', 'paperTemplate.id': thisCheckId, 'makeCount': count},
                    success: function (data) {
                        if (data.success) {
                            if (isBtnCreate) {
                                setTimeout(function () {
                                    layer.close(loadingLayerIndex);
                                    /*生成试卷success弹框样式*/
                                    layer.open({
                                        type: 1,
                                        closeBtn: 0,
                                        title: '',
                                        skin: 'creating-paper-dialog creating-success-dialog',
                                        time: 1000,
                                        area: ['620px', '300px'], //宽高
                                        content: _.template($('#paperCreateSuccessTemp').html())({data: dataSuccess}),
                                        end: func
                                    });
                                }, 2000);
                            } else {
                                /*生成试卷success弹框样式*/
                                layer.open({
                                    type: 1,
                                    closeBtn: 0,
                                    title: '',
                                    skin: 'creating-paper-dialog creating-success-dialog',
                                    time: 1000,
                                    area: ['620px', '300px'], //宽高
                                    content: _.template($('#paperCreateSuccessTemp').html())({data: dataSuccess}),
                                    end: func
                                });
                                return false;
                            }

                        } else {
                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function (shiIndex) {
                                    layer.close(shiIndex);
                                }
                            });
                        }


                    }
                });
            }
        };

        editPaper.initData();
        editPaper.init();
    })
</script>