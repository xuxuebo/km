<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">试卷</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">试卷管理</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">新增试卷</li>
    </ul>
</div>
<div class="add-paper-block" style="padding:25px 18px;">
<#--头部添加试卷进度步数-->
    <div class="pe-add-paper-top-head">
    <#if template.templateEdit?? && template.templateEdit>
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
                    <#if (version?? && version == 'ENTERPRISE' && template.paperStatus?? && template.paperStatus == 'ENABLE'&& template.security?? && !template.security)
                    || (template.paperType?? && template.paperType == 'RANDOM')>
                        <div class="add-step-line"></div>
                    </#if>
                </div>
                <span class="add-step-text" style="    display: inline-block;width: 100%;text-align: center;margin-left: 0;">必考题</span>
            </li>
            <#if template.paperType?? && template.paperType == 'RANDOM'>
                <li class="add-paper-step-item add-paper-step-two floatL overStep">
                    <div class="add-step-icon-wrap">
                        <div class="add-step-line add-step-two-line"></div>
                             <span class="iconfont icon-step-circle floatL">
                               <span class="add-step-number">3</span>
                             </span>
                        <#if version?? && version == 'ENTERPRISE' && template.paperStatus?? && template.paperStatus == 'ENABLE'&& template.security?? && !template.security>
                            <div class="add-step-line"></div>
                        </#if>
                    </div>
                    <span class="add-step-text" style="margin-left:95px;">随机题</span>
                </li>
                <#if version?? && version == 'ENTERPRISE' && template.paperStatus?? && template.paperStatus == 'ENABLE'&&  template.security?? && !template.security>
                    <li class="add-paper-step-item add-paper-step-three floatL step-complete edit-paper-auth"
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
            <#else>
                <#if version?? && version == 'ENTERPRISE' && template.paperStatus?? && template.paperStatus == 'ENABLE'&& template.security?? && !template.security>
                    <li class="add-paper-step-item add-paper-step-three floatL step-complete edit-paper-auth"
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
            </#if>
        </ul>
    <#else>
        <ul class="over-flow-hide">
            <li class="add-paper-step-item floatL step-complete ">
                <div class="add-step-icon-wrap">
                   <span class="iconfont icon-step-circle floatL">
                    <span class="add-step-number">1</span>
                   </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">基本信息</span>
            </li>
            <li class="add-paper-step-item add-paper-step-two floatL step-complete ">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                      <span class="add-step-number">2</span>
                    </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text" style="margin-left:95px;">必考题</span>
            </li>
            <li class="add-paper-step-item add-paper-step-two floatL overStep">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">3</span>
                     </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text" style="margin-left:95px;">随机题</span>
            </li>
            <li class="add-paper-step-item add-paper-step-three floatL ">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line"></div>
                     <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">4</span>
                     </span>
                </div>
                <span class="add-step-text" style="margin-left:105px;">完成</span>
            </li>
        </ul>
    </#if>
    </div>
    <input name="paperStatus" value="${(template.paperStatus)!}" type="hidden"/>
    <form id="randomSetForm">
        <div class="pe-add-paper-main-content over-flow-hide" style="overflow: visible !important;">
            <input name="id" value="${(template.id)!}" type="hidden"/>
            <div class="pe-add-paper-left floatL" style="width:842px;">
                <div class="add-paper-left-head show-bank-error"
                     style="background-color: #fff;padding: 0;height: 45px;display: none;">
                    <label class="show-must-item-error">
                        <label class="item-error-content"></label>
                        <a class="iconfont icon-dialog-close-btn close-stop-item-msg"
                           style="float: right;margin-top: 3px;margin-right: 5px;color: #999;cursor: pointer;"></a>
                    </label>
                </div>
                <div class="add-paper-left-head">随机题目</div>
                <div class="add-paper-left-content" style="padding: 10px 6px 10px;">
                    <input type="hidden" name="sr.p" value="${(template.sr.p?string('true','false'))!'true'}"/>
                    <div class="add-paper-content-top">
                        <dl style="overflow: hidden;">
                            <dt class="pe-label-item-left floatL">题库:</dt>
                            <dd style="margin-bottom:15px; overflow: hidden;" class="banklist">
                            <#if itemBanks?? && (itemBanks?size>0)>
                                <#list itemBanks as itemBank>
                                <div class="pe-paper-item paper-bank-item">
                                    <a title="${(itemBank.bankName)!}"
                                       class="add-question-bank-item bank-list <#if !itemBank.authBank>expire-content-class</#if>">
                                        <span class="paper-random-bank">${(itemBank.bankName)!}</span>
                                        <span class="iconfont icon-inputDele <#if !itemBank.authBank>expire-delete-btn-class</#if>">
                                            <input type="hidden" name="itemBankId" value="${(itemBank.id)!}"/>
                                        </span>
                                    </a>
                                </div>
                                </#list>
                            </#if>
                                <span class="pe-like-link pe-choosen-question-bank">选择题库</span>
                            </dd>
                            <dt class="pe-label-item-left floatL">知识点:</dt>
                            <dd style="margin-bottom:15px; overflow: hidden;">
                            <#if knowledges?? && (knowledges?size>0)>
                                <#list knowledges as knowledge>
                                <div class="pe-paper-item paper-knowledge-item">
                                    <a title="${(knowledge.knowledgeName)!}" style="margin-right:0;"
                                       class="add-question-bank-item knowledge-list <#if knowledge.expireKnowledge?? && knowledge.expireKnowledge>expire-content-class</#if>"><span
                                            class="paper-random-bank">${(knowledge.knowledgeName)!}</span><span
                                            class="iconfont icon-inputDele <#if knowledge.expireKnowledge?? && knowledge.expireKnowledge>expire-delete-btn-class</#if>"><input
                                            type="hidden" name="knowledgeId"
                                            value="${(knowledge.id)!}"/></span></a>
                                </div>
                                </#list>
                            </#if>
                                <span class="pe-like-link pe-choosen-knowledge">选择知识点</span>
                            </dd>
                        </dl>
                    </div>
                    <div class="add-paper-content-detail-wrap">
                        <p class="add-paper-detail-msg">请在如下表格中设置试卷的题型、难度及题目数量:</p>
                        <div class="paper-choose-question pe-form-select">
                            <select class="pe-select-question dropdown">
                                <option value="" selected>全部试题</option>
                                <option value="true"
                                        <#if template.sr?? && template.sr.t?? && template.sr.t>selected="selected"</#if>>
                                    绝密试题
                                </option>
                                <option value="false"
                                        <#if template.sr?? && template.sr.t?? && !template.sr.t>selected="selected"</#if>>
                                    非绝密试题
                                </option>
                            </select>
                            <input name="sr.t" type="hidden"/>
                            <span class="iconfont icon-tip pe-paper-tip"></span>
                        </div>
                        <div class="paper-question-types">
                            <ul class="question-item-setting-opt-content">
                            </ul>
                            <div class="paper-detail-type-setting">
                            <#if template.sr?? && template.sr.p?? && !template.sr.p>
                                <span class="setting-info">如果想简化设置，请点击：</span>
                                <button type="button" class="pe-btn pe-btn-green paper-question-setting-btn"
                                >我想简单设置
                                </button>
                            <#else>
                                <span class="setting-info">如果想按难度设置各题型的数量，请点击：</span>
                                <button type="button" class="pe-btn pe-btn-green paper-question-setting-btn"
                                >我想精确设置
                                </button>
                            </#if>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </form>
    <div class="add-paper-right add-paper-border" style="width:300px;">
        <div class="add-paper-right-header paper-most-secret iconfont icon-top-secret-icon" style="padding:13px;">
            <h4 class="add-paper-name" style="text-overflow:ellipsis;white-space:nowrap;overflow:hidden;width:100%;" title="${(template.paperName)!}">${(template.paperName)!}</h4>
        </div>
        <div class="add-paper-right-list paper-info" style="padding:25px 13px;">
            <dl class="app-paper-info">
                <dt class="paper-info-title" style="text-align:left;">试卷类型：</dt>
                <dd class="paper-info-value" ><#if template.paperType?? && template.paperType == 'FIXED'>固定卷<#else>
                    随机卷</#if></dd>
                <dt class="paper-info-title" style="text-align:left;">&emsp;总题数：</dt>
                <dd class="paper-info-value itemCount-number">${(template.itemCount)!'0'}</dd>
            </dl>
            <a href="javascript:void(0);" class="pe-btn pe-btn-green pe-paper-preview-btn">预览试卷</a>
            <div class="clear"></div>
        </div>
        <div class="add-paper-right-list add-paper-item-type-wrap" style="min-height: 0px;">
            <p class="paper-must-title">
                必考题(共${(totalMustItem)!'0'}道，${(totalMustMark)!'0'}分)
            </p>
        <#if mustCountMap??>
            <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
                <#if mustCountMap[itemType]??>
                    <div class="paper-must-list">
                                <span class="paper-ques-type" style="margin-bottom:15px;">
                                    <#if itemType=='SINGLE_SELECTION'>
                                        单选题
                                    <#elseif itemType=='MULTI_SELECTION'>
                                        多选题
                                    <#elseif itemType=='INDEFINITE_SELECTION'>
                                        不定项选择题
                                    <#elseif itemType=='JUDGMENT'>
                                        判断题
                                    <#elseif itemType=='FILL'>
                                        填空题
                                    <#else>
                                        问答题
                                    </#if>：<span class="paper-single-choosen">${(mustCountMap[itemType])!}</span>
                                </span>
                    </div>
                </#if>
            </#list>
        </#if>
        </div>
        <div class="add-paper-right-list add-paper-item-type-wrap question-random-panel" style="min-height: 0px;">
            <p class="paper-must-title">
                随机题(共<span class="show-random-num">0</span>道)
            </p>
            <dl class="app-paper-info random-paper-info">
            </dl>
            <p class="add-paper-tip-text floatL">*随机题需考试下发后才生成，故无法统计总分值</p>
        </div>
    </div>
</div>
<div class="clear"></div>
<div class="pe-btns-group-wrap" style="margin-left:28px;">
<#if !(template.templateEdit?? && template.templateEdit)>
    <button type="button" class="pe-btn pe-btn-purple pe-step-pre-btn">上一步</button>
    <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft">保存为草稿</button>
    <button type="button" class="pe-btn pe-btn-blue pe-step-save-and-use">保存并启用</button>
<#else>
    <button type="button" class="pe-btn pe-btn-blue pe-large-btn edit-save-paper">保存</button>
</#if>

    <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
</div>
<script type="text/template" id="showRandomTemp">
    <%_.each(data, function(item){%>
    <dt class="paper-info-title"><%=item.typeName%></dt>
    <dd class="paper-info-value">&nbsp;&nbsp;<%=item.count%></dd>
    <%})%>
</script>
<script type="text/template" id="paperAddQuestionTemp">
    <%_.each([1,2,3,4,5,6], function(index){ if(sm[index].c || (dbSm && dbSm[index] && dbSm[index].c)){%>
    <li class="question-type-item">
        <%if (p == 'false') {%>
        <dl class="floatL question-type-item-name pe-step-name" data-index="<%=index%>">
        <%}else{%>
        <dl class="floatL question-type-item-name pe-step-name" data-index="<%=index%>" style="width:230px;">
        <%}%>
            <%if (p == 'false') {%>
                <dt class="pe-label-item-left floatL pe-step-item">
                    <%if (index ==1){%>单选题:<%} else if(index ==2){%>多选题:<%} else if(index ==3){%>不定项选择题:<%} else if(index
                    ==4){%>判断题:<%} else if(index ==5){%>填空题:<%} else if(index ==6){%>问答题:<%}%>
                </dt>
            <%}else{%>
                <dt class="pe-label-item-left floatL pe-step-item" style="width:96px;">
                <%if (index ==1){%>单选题:<%} else if(index ==2){%>多选题:<%} else if(index ==3){%>不定项选择题:<%} else if(index
                ==4){%>判断题:<%} else if(index ==5){%>填空题:<%} else if(index ==6){%>问答题:<%}%>
                </dt>
            <%}%>
            <dd class="question-number">
                <%if (p == 'false') {%>
                                        <span class="paper-show-detail-setting">
                                            [<span class="question-has-choosen-all-num"><%=!dbP && dbSm && dbSm[index]?dbSm[index].c:'0'%></span>/<span
                                                class="quesiton-all-num"><%=sm[index].c%></span>]
                                        </span>
                <%} else {%>
                                        <span class="paper-show-simple-setting">
                                            <input type="text"
                                                   value="<%=dbP && dbSm && dbSm[index]?dbSm[index].c:''%>"
                                                   <%if (dbP && dbSm && dbSm[index] && dbSm[index].c>sm[index].c){%>
                                                    class="question-simple-has-choosen-num error-input"
                                                    <%} else {%>
                                                    class="question-simple-has-choosen-num"
                                                    <%}%>
                                                   name="sr.sm['<%=index%>'].c">/<span
                                                class="quesiton-all-num"><%=sm[index].c%></span>
                                        </span>
                <%}%>
            </dd>
        </dl>
        <%if (p == 'false') {%>
        <div class="question-detail-setting-wrap">
            <dl class="floatL question-choosen-type-num-item <%if (!sm[index].m[5] && (!dbSm || !dbSm[index] || !dbSm[index].m || !dbSm[index].m[5])){%>disabled<%}%>">
                <dt class="pe-label-item-left floatL">困难:</dt>
                <dd class="question-number">
                    <input type="text" value="<%=dbSm && dbSm[index]?(dbSm[index].m?dbSm[index].m[5]:''):''%>"
                    <%if (dbSm && dbSm[index] && dbSm[index].m && dbSm[index].m[5]>sm[index].m[5]){%>
                    class="question-has-choosen-num error-input"
                    <%} else {%>
                    class="question-has-choosen-num"
                    <%}%>
                    name="sr.sm['<%=index%>'].m['5']">/<span
                        class="quesiton-all-num"><%=sm[index].m[5]%></span>
                </dd>
            </dl>
            <dl class="floatL question-choosen-type-num-item <%if (!sm[index].m[4] && (!dbSm || !dbSm[index] || !dbSm[index].m || !dbSm[index].m[4])){%>disabled<%}%>">
                <dt class="pe-label-item-left floatL">较难:</dt>
                <dd class="question-number">
                    <input type="text" value="<%=dbSm && dbSm[index]?(dbSm[index].m?dbSm[index].m[4]:''):''%>"
                    <%if (dbSm && dbSm[index] && dbSm[index].m && dbSm[index].m[4]>sm[index].m[4]){%>
                    class="question-has-choosen-num error-input"
                    <%} else {%>
                    class="question-has-choosen-num"
                    <%}%>
                    name="sr.sm['<%=index%>'].m['4']">/<span
                        class="quesiton-all-num"><%=sm[index].m[4]%></span>
                </dd>
            </dl>
            <dl class="floatL question-choosen-type-num-item <%if (!sm[index].m[3] && (!dbSm || !dbSm[index] || !dbSm[index].m || !dbSm[index].m[3])){%>disabled<%}%>">
                <dt class="pe-label-item-left floatL">中等:</dt>
                <dd class="question-number">
                    <input type="text" value="<%=dbSm && dbSm[index]?(dbSm[index].m?dbSm[index].m[3]:''):''%>"
                    <%if (dbSm && dbSm[index] && dbSm[index].m && dbSm[index].m[3]>sm[index].m[3]){%>
                    class="question-has-choosen-num error-input"
                    <%} else {%>
                    class="question-has-choosen-num"
                    <%}%>
                    name="sr.sm['<%=index%>'].m['3']">/<span
                        class="quesiton-all-num"><%=sm[index].m[3]%></span>
                </dd>
            </dl>
            <dl class="floatL question-choosen-type-num-item <%if (!sm[index].m[2] && (!dbSm || !dbSm[index] || !dbSm[index].m || !dbSm[index].m[2])){%>disabled<%}%>">
                <dt class="pe-label-item-left floatL">较易:</dt>
                <dd class="question-number">
                    <input type="text" value="<%=dbSm && dbSm[index]?(dbSm[index].m?dbSm[index].m[2]:''):''%>"
                    <%if (dbSm && dbSm[index] && dbSm[index].m && dbSm[index].m[2]>sm[index].m[2]){%>
                    class="question-has-choosen-num error-input"
                    <%} else {%>
                    class="question-has-choosen-num"
                    <%}%>
                    name="sr.sm['<%=index%>'].m['2']">/<span
                        class="quesiton-all-num"><%=sm[index].m[2]%></span>
                </dd>
            </dl>
            <dl class="floatL question-choosen-type-num-item <%if (!sm[index].m[1] && (!dbSm || !dbSm[index] || !dbSm[index].m || !dbSm[index].m[1])){%>disabled<%}%>">
                <dt class="pe-label-item-left floatL">
                    容易:
                </dt>
                <dd class="question-number">
                    <input type="text" value="<%=dbSm && dbSm[index]?(dbSm[index].m?dbSm[index].m[1]:''):''%>"
                    <%if (dbSm && dbSm[index] && dbSm[index].m && dbSm[index].m[1]>sm[index].m[1]){%>
                    class="question-has-choosen-num error-input"
                    <%} else {%>
                    class="question-has-choosen-num"
                    <%}%>
                    name="sr.sm['<%=index%>'].m['1']">/<span
                        class="quesiton-all-num"><%=sm[index].m[1]%></span>
                </dd>
            </dl>
        </div>
        <%}%>
    </li>
    <%}})%>
</script>
<script>
    var dbSetting;
    var editRandomPaper = {
        init: function () {
            $('.pe-add-paper-add-btn').click(function () {
            <#--PEMO.DIALOG.dialog({-->
            <#--title:'题库授权',-->
            <#--url: '${ctx!}/pages/common/selector'-->
            <#--});-->
                $('.add-paper-no-item-wrap').hide();
                $('.add-paper-no-item-wrap').hide();
                $('.paper-must-list').show();
                // $('.add-paper-has-item-wrap').html(_.template($('#paperAddQuestionTemp').html())({data:items}))
            });
            $('.add-question-bank-item').hover(
                    function () {
                        $(this).find('.icon-inputDele').show();
                    },
                    function () {
                        $(this).find('.icon-inputDele').hide();
                    }
            );

            //试题简单，详细设置按钮点击事件
            $('.paper-question-setting-btn').click(function () {
                var isVal = false;
                $('input[name="itemBankId"]').each(function (index, ele) {
                    if ($(ele).val()) {
                        isVal = true;
                        return false;
                    }
                });

                if (!isVal) {
                    PEMO.DIALOG.tips({
                        content: '请选择题库！',
                        time: 1000
                    });

                    return false;
                }

                var isP = $('input[name="sr.p"]').val();
                if (!isP || isP === 'false') {
                    $('input[name="sr.p"]').val('true');
                    $('.setting-info').text('如果想按难度设置各题型的数量，请点击：');
                    $(this).text('我想精确设置');
                } else {
                    $('input[name="sr.p"]').val('false');
                    $('.setting-info').text('如果想简化设置，请点击：');
                    $(this).text('我想简单设置');
                }

                editRandomPaper.countItem();
                $('.question-item-setting-opt-content').toggleClass('question-show-detail-open');
            });

            $('.add-paper-content-top').delegate('.icon-inputDele', 'click', function () {

                var $a = $(this).parents('a.add-question-bank-item');
                   $a.parents('.paper-knowledge-item').remove();
                   $a.remove();
                if (!$a.hasClass('bank-list')) {
                    editRandomPaper.countItem();
                    return false;
                }

               editRandomPaper.listKnowledge();
            });

            $('input[name="sr.t"]').on('change', function () {
                var isVal = false;
                $('input[name="itemBankId"]').each(function (index, ele) {
                    if ($(ele).val()) {
                        isVal = true;
                        return false;
                    }
                });

                if (!isVal) {
                    return false;
                }

                editRandomPaper.countItem();
            });

            $('.paper-question-types').delegate('.question-has-choosen-num', 'blur', function () {
                var thisNum = $(this).val();
                if (!thisNum || !/^[0-9]*$/.test(thisNum) || parseInt(thisNum) <= 0) {
                    $(this).val('');
                    thisNum = 0;
                }

                var thisAllNum = $(this).parents().children('.quesiton-all-num').text();
                if (parseInt(thisNum) > parseInt(thisAllNum)) {
                    thisNum = thisAllNum;
                    $(this).val(thisAllNum);
                }

                var allNum = 0;
                $(this).parents('.question-type-item').find('.question-has-choosen-num').each(function (index, ele) {
                    var questionNum = $(this).val();
                    if (questionNum) {
                        allNum = allNum + parseInt(questionNum);
                    }
                });

                if ($(this).hasClass('error-input')) {
                    $(this).removeClass('error-input');
                }

                $(this).parents('.question-type-item').find('.question-has-choosen-all-num').text(allNum);
                editRandomPaper.showRandCount('.question-has-choosen-all-num', false);
            });

            $('.paper-question-types').delegate('.question-simple-has-choosen-num', 'blur', function () {
                var inputNum = $(this).val();
                if (!inputNum || !/^[0-9]*$/.test(inputNum) || parseInt(inputNum) <= 0) {
                    inputNum = '';
                }

                var allNum = $(this).parents('.paper-show-simple-setting').children('.quesiton-all-num').text();
                if (parseInt(inputNum) > parseInt(allNum)) {
                    inputNum = allNum;
                }

                if ($(this).hasClass('error-input')) {
                    $(this).removeClass('error-input');
                }

                $(this).val(inputNum);
                editRandomPaper.showRandCount('.question-simple-has-choosen-num', true);
            });
            //选择知识点
            $('.pe-choosen-knowledge').on('click', function () {
                var $banks = $('.banklist a');
                if ($banks.length == 0) {
                    PEMO.DIALOG.alert({
                        content: "请先选择题库！",
                        btn: ['我知道了'],
                        yes: function () {
                            layer.closeAll();
                        }
                    });
                    return;
                }


                PEMO.DIALOG.selectorDialog({
                    title: '选择知识点',
                    area: ['900px', '490px'],
                    content: [pageContext.rootPath + '/ems/template/manage/initSelectKlPage?itemAttribute=EXAM', 'no'],
                    success: function (layero, index) {
                        layer.getChildFrame('.pe-btn-green').on('click', function () {
                            var expireKlIds = [];
                            $('.knowledge-list.expire-content-class').each(function (index, ele) {
                                expireKlIds.push($(ele).find('input[name="knowledgeId"]').val());
                            });

                            $('.knowledge-list').remove();
                            $('.paper-knowledge-item').remove();
                            $(layer.getChildFrame('.pe-selector-selected tbody td')).each(function (index, ele) {
                                var name = $(ele).data('name');
                                var id = $(ele).data('id');
                                if (expireKlIds.indexOf(id) >= 0) {
                                    //原型正常的
//                                    var knowledgeDom = '<a title="' + name + '" class="add-question-bank-item knowledge-list expire-content-class"><span class="paper-random-bank">'
//                                            + name + '</span><span class="iconfont icon-inputDele expire-delete-btn-class"><input type="hidden" name="knowledgeId" value="'
//                                            + id + '"/></span>-</a>';
                                    /*四局演示添加*/
                                    var knowledgeDom = '<a title="' + name + '" class="add-question-bank-item knowledge-list expire-content-class"><span class="paper-random-bank">'
                                            + name + '</span><span class="iconfont icon-inputDele expire-delete-btn-class"><input type="hidden" name="knowledgeId" value="'
                                            + id + '"/></span></div></a>';
                                } else {
//                                    knowledgeDom = '<div class="pe-paper-item"><a title="' + name + '" class="add-question-bank-item knowledge-list"><span class="paper-random-bank">'
//                                            + name + '</span><span class="iconfont icon-inputDele"><input type="hidden" name="knowledgeId" value="'
//                                            + id + '"/></span></a></div>';
                                    /*四局演示添加*/
                                    knowledgeDom = '<div class="pe-paper-item paper-knowledge-item" style="margin-right:10px;"><a style="margin-right:0;" title="' + name + '" class="add-question-bank-item knowledge-list"><span class="paper-random-bank">'
                                            + name + '</span><span class="iconfont icon-inputDele"><input type="hidden" name="knowledgeId" value="'
                                            + id + '"/></span></a>';
                                }

                                $('.pe-choosen-knowledge').before(knowledgeDom);
                            });

                            layer.close(index);
                            editRandomPaper.countItem();
                        });
                    }
                });
            });

            $('.pe-step-save-draft').on('click', function () {
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/template/manage/saveRandom?paperStatus=DRAFT',
                    data: $('#randomSetForm').serialize(),
                    success: function (data) {
                        location.href = "#url=" + pageContext.rootPath + "/ems/template/manage/initPage&nav=examPaper";//如果出现返回后，表格中的某些按钮不能点击时，在来解决;
                    }
                });
            });

            $('.pe-step-pre-btn').on('click', function () {
                $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initMustPage', {templateId: '${(template.id)!}'});
            });

            $('.pe-step-back-btn').on('click', function () {
                location.href = "#url=/pe/ems/template/manage/initPage&nav=examPaper";//如果出现返回后，表格中的某些按钮不能点击时，在来解决;
//                            history.back(-1);
            });

            $('.pe-step-save-and-use').on('click', function () {
                if ($('.question-simple-has-choosen-num,.question-has-choosen-num').hasClass('error-input')) {
                    $('.item-error-content').html('题库里的试题有被禁用和删除的，无法支撑随机题的筛选，注意下方红色框的题型数量，调整后再保存');
                    $('.show-bank-error').slideDown('fast');
                    return false;
                }

                editRandomPaper.enableTemplate();
            });

            $('.pe-choosen-question-bank').on('click', function () {
                PEMO.DIALOG.selectorDialog({
                    title: '选择题库',
                    area: ['960px', '620px'],
                    content: [pageContext.rootPath + '/ems/template/manage/initSelectBankPage?itemAttribute=EXAM', 'no'],
                    success: function (layero, index) {
                        layer.getChildFrame('.select-bank-ok-btn').on('click', function () {
                            var noAuthBankIds = [];
                            $('.bank-list.expire-content-class').each(function (index, ele) {
                                noAuthBankIds.push($(ele).find('input[name="itemBankId"]').val());
                            });

                            $('.bank-list').remove();
                            $('.paper-bank-item').remove();
//                            $('.paper-knowledge-item').remove();
                            $(layer.getChildFrame('.selected-bank-name')).each(function (index, ele) {
                                var bankName = $(ele).attr('title');
                                var id = $(ele).data('id');
                                if (noAuthBankIds.indexOf(id) >= 0) {
                                    var bankDom = '<a title="' + bankName + '" class="add-question-bank-item bank-list expire-content-class"><span class="paper-random-bank">'
                                            + bankName + '</span><span class="iconfont icon-inputDele expire-delete-btn-class"><input type="hidden" name="itemBankId" value="'
                                            + id + '"/></span></a>';
                                } else {
                                    bankDom = '<div class="pe-paper-item paper-bank-item"><a title="' + bankName + '" class="add-question-bank-item bank-list"><span class="paper-random-bank">'
                                            + bankName + '</span><span class="iconfont icon-inputDele"><input type="hidden" name="itemBankId" value="'
                                            + id + '"/></span></a></div>';
                                }

                                $('.pe-choosen-question-bank').before(bankDom);

                            });

                            layer.close(index);
//                            editRandomPaper.countItem();
                            editRandomPaper.listKnowledge();
                        });
                    }
                });
            });

            $('.edit-step-state .edit-paper-basic').on('click', function () {
                var param = {
                    templateEdit: '${(template.templateEdit?string('true','false'))!}',
                    id: '${(template.id)!}'
                };
                $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initBasicEditPage', param);
            });

            $('.edit-step-state .edit-paper-must').on('click', function () {
                var param = {
                    templateEdit: '${(template.templateEdit?string('true','false'))!}',
                    templateId: '${(template.id)!}'
                };
                $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initMustPage', param);
            });

            $('.edit-step-state .edit-paper-auth').on('click', function () {
                $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initPaperAuth?templateId=${(template.id)!}');
            });

            $('.edit-save-paper').on('click', function () {
                if ($('.question-simple-has-choosen-num,.question-has-choosen-num').hasClass('error-input')) {
                    $('.item-error-content').html('题库里的试题有被禁用和删除的，无法支撑随机题的筛选，注意下方红色框的题型数量，调整后再保存');
                    $('.show-bank-error').slideDown('fast');
                    return false;
                }

                var paperStatus = $('input[name="paperStatus"]').val();
                $('.bank-list.expire-content-class').remove();
                $('.error-bank-knowledge-info').remove();
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/template/manage/saveRandom?paperStatus=' + paperStatus,
                    data: $('#randomSetForm').serialize(),
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

            $('.pe-add-paper-main-content').delegate('.close-stop-item-msg', 'click', function (e) {
                var e = e || window.event;
                e.stopPropagation();
                e.preventDefault();
                $('.show-bank-error').slideUp("fast");
            });

            $('.pe-add-paper-main-content').delegate('.clear-stop-bank', 'click', function (e) {
                var e = e || window.event;
                e.stopPropagation();
                e.preventDefault();
                $('.bank-list.expire-content-class').remove();
                $('.error-bank-knowledge-info').remove();
                $('.show-bank-error').slideUp('fast');
            });

            $('.pe-paper-preview-btn').on('click', function () {
                var paperStatus = $('input[name="paperStatus"]').val();
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/template/manage/saveRandom?paperStatus=' + paperStatus,
                    data: $('#randomSetForm').serialize(),
                    async: false,
                    success: function (data) {
                        window.open('${ctx!}/ems/template/manage/initViewPaperPage?templateId=${(template.id)!}','');
                    }
                });
            });
        },

        enableTemplate: function () {
            PEBASE.ajaxRequest({
                url: pageContext.rootPath + '/ems/template/manage/saveRandom?paperStatus=ENABLE',
                data: $('#randomSetForm').serialize(),
                success: function (data) {
                    if (data.success) {
                        PEMO.DIALOG.alert({
                            content: '启用成功',
                            time: 1000,
                            end: function () {
                                window.location.href = "/pe/front/manage/initPage#url=/pe/ems/template/manage/initPage&nav=examPaper";//如果出现返回后，表格中的某些按钮不能点击时，在来解决;
                            },
                            success: function () {
                                $('.layui-layer .layui-layer-content').height(26);
                            }
                        });

                        return false;
                    }

                    PEMO.DIALOG.alert({
                        content: data.message,
                        skin: 'long-tip-content',
                        btn: ['我知道了'],
                        yes: function () {
                            layer.closeAll();
                        }
                    });
                }
            });
        },

        listKnowledge : function () {
            var itemBankIds = [];
            $('input[name="itemBankId"]').each(function (index, ele) {
                itemBankIds.push($(ele).val());
            });

            if (itemBankIds.length <= 0) {
                $('.knowledge-list').remove();
                $('.paper-knowledge-item').remove();
                editRandomPaper.countItem();
                return false;
            }

            PEBASE.ajaxRequest({
                url: '${ctx!}/ems/knowledge/manage/listForTemplate?bankIds=' + JSON.stringify(itemBankIds),
                async: false,
                success: function (data) {
                    if ($.isEmptyObject(data)) {
                        $('.knowledge-list').remove();
                        $('.paper-knowledge-item').remove();
                    } else {
                        var availableData = [];
                        $.each(data, function (index, knowledge) {
                            availableData.push(knowledge.id);
                        });

                        $('input[name="knowledgeId"]').each(function (index, ele) {
                            var selectId = $(ele).val();
                            if (availableData.indexOf(selectId) === -1) {
                                $(ele).parents('.paper-knowledge-item').remove();
//                                    $(ele).parents('.add-question-bank-item').remove();
                            }
                        });
                    }

                    editRandomPaper.countItem();
                }
            });
        },

        countItem: function () {
            var params = {
                'sr.p': $('input[name="sr.p"]').val(),
                'sr.t': $('input[name="sr.t"]').val(),
                'id': $('input[name="id"]').val()
            };
            var itemBankIds = [];
            $('input[name="itemBankId"]').each(function (index, ele) {
                itemBankIds.push($(ele).val());
            });

            var knowledgeIds = [];
            $('input[name="knowledgeId"]').each(function (index, ele) {
                knowledgeIds.push($(ele).val());
            });

            params.itemBankId = JSON.stringify(itemBankIds);
            params.knowledgeId = JSON.stringify(knowledgeIds);
            var $optContent = $('.question-item-setting-opt-content');
            PEBASE.ajaxRequest({
                data: params,
                url: pageContext.rootPath + '/ems/template/manage/countItem',
                success: function (data) {

                    var p = $('input[name="sr.p"]').val();
                    $optContent.html('');
                    if ($.isEmptyObject(data)) {
                        return false;
                    }

                    $optContent.html(_.template($('#paperAddQuestionTemp').html())({
                        p: p,
                        sm: data.sm,
                        dbSm: dbSetting ? dbSetting.sm : null,
                        dbP: dbSetting ? dbSetting.p : null
                    }));

                    if (p === 'false') {
                        if (!$optContent.hasClass('question-show-detail-open')) {
                            $optContent.addClass('question-show-detail-open');
                        }

                        editRandomPaper.showRandCount('.question-has-choosen-all-num', false);
                    } else {
                        if ($optContent.hasClass('question-show-detail-open')) {
                            $optContent.removeClass('question-show-detail-open');
                        }

                        editRandomPaper.showRandCount('.question-simple-has-choosen-num', true);
                    }

                    if ($('.expire-content-class').length > 0) {
                        $('.show-bank-error').slideDown('fast');
                    } else {
                        $('.show-bank-error').slideUp('fast');
                    }

                    var errorMsg = '';
                    if ($('.question-simple-has-choosen-num,.question-has-choosen-num').hasClass('error-input')) {
                        errorMsg = '题库里的试题有被禁用和删除的，无法支撑随机题的筛选，注意下方红色框的题型数量，调整后再保存';
                    }

                    if ($('.expire-content-class').length > 0) {
                        errorMsg = '灰色字体的题库（或知识点）您已无权使用，点击&nbsp;<button type="button" class="clear-stop-bank">保存</button>&nbsp;自动在本试卷中移除这些题库';
                    }


                    if ($('.expire-content-class').length > 0 && $('.expire-content-class').length == $('.bank-list').length) {
                        errorMsg = '灰色字体的题库你已无权使用，请重新选择一个题库';
                    }

                    if (errorMsg) {
                        $('.item-error-content').html(errorMsg);
                        $('.show-bank-error').slideDown('fast');
                    }
                }
            });
        },

        showRandCount: function (dom, isInput) {
            var data = [];
            var typeAllNum = 0;
            $('.show-random-num').text('0');
            $('.random-paper-info').html('');
            $('.question-type-item-name').each(function (index, ele) {
                if (!isInput) {
                    var count = $(ele).find(dom).text();
                } else {
                    count = $(ele).find(dom).val();
                }

                if (count && parseInt(count) > 0) {
                    var typeName = $(ele).children('.pe-label-item-left').text();
                    data.push({typeName: typeName.trim(), count: count});
                    typeAllNum = typeAllNum + parseInt(count);
                }

            });

            $('.itemCount-number').text(typeAllNum +${(totalMustItem)!'0'});
            if (data.length <= 0) {
                return false;
            }

            $('.random-paper-info').html(_.template($('#showRandomTemp').html())({data: data}));
            $('.show-random-num').text(typeAllNum);
        },
        changeSelect: function () {
            var isVal = false;
            $('input[name="itemBankId"]').each(function (index, ele) {
                if ($(ele).val()) {
                    isVal = true;
                    return false;
                }
            });

            if (!isVal) {
                return false;
            }

            editRandomPaper.countItem();
        }
    };

    $(function () {
        PEBASE.peSelect($('.pe-select-question'), null, $('input[name="sr.t"]'), null, editRandomPaper.changeSelect);
        editRandomPaper.init();
        dbSetting = eval("(" + '${(template.srJson)!}' + ")");

        editRandomPaper.countItem();
        if (dbSetting && dbSetting.sm) {
            var randoms = [];
            var totalNum = 0;
            $.each([1, 2, 3, 4, 5], function (index, value) {
                if (!dbSetting.sm[value] || dbSetting.sm[value].c <= 0) {
                    return;
                }

                var typeName = '问答题';
                if (value == 1) {
                    typeName = '单选题';
                } else if (index == 2) {
                    typeName = '多选题';
                } else if (index == 3) {
                    typeName = '不定项选择题';
                } else if (index == 4) {
                    typeName = '判断题';
                } else if (index == 5) {
                    typeName = '填空题';
                }

                totalNum = totalNum + dbSetting.sm[value].c;
                randoms.push({'typeName': typeName, 'count': dbSetting.sm[value].c});
            });

            $('.random-paper-info').html(_.template($('#showRandomTemp').html())({data: randoms}));
            $('.show-random-num').text(totalNum);
        }
    });
</script>

