<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">试卷</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">试卷管理</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">新增试卷</li>
    </ul>
</div>
<section class="add-paper-block">
<#--头部添加试卷进度步数-->
    <div class="pe-add-paper-top-head">
    <#if paperTemplate.templateEdit?? && paperTemplate.templateEdit>
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
            <li class="add-paper-step-item add-paper-step-two floatL overStep">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                      <span class="add-step-number">2</span>
                    </span>
                    <#if (version?? && version == 'ENTERPRISE' && paperTemplate.paperStatus?? && paperTemplate.paperStatus == 'ENABLE' && paperTemplate.security?? && !paperTemplate.security) || (paperTemplate.paperType?? && paperTemplate.paperType == 'RANDOM')>
                        <div class="add-step-line"></div>
                    </#if>
                </div>
                <span class="add-step-text" style="margin-left:95px;">必考题</span>
            </li>
            <#if paperTemplate.paperType?? && paperTemplate.paperType == 'RANDOM'>
                <li class="add-paper-step-item add-paper-step-two floatL step-complete edit-paper-random">
                    <div class="add-step-icon-wrap">
                        <div class="add-step-line add-step-two-line"></div>
                     <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">3</span>
                     </span>
                        <#if version?? && version == 'ENTERPRISE' && paperTemplate.paperStatus?? && paperTemplate.paperStatus == 'ENABLE'&& paperTemplate.security?? && !paperTemplate.security>
                            <div class="add-step-line"></div>
                        </#if>
                    </div>
                    <span class="add-step-text" style="margin-left:95px;">随机题</span>
                </li>
                <#if version?? && version == 'ENTERPRISE' && paperTemplate.paperStatus?? && paperTemplate.paperStatus == 'ENABLE'&& paperTemplate.security?? && !paperTemplate.security>
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
                <#if version?? && version == 'ENTERPRISE' && paperTemplate.paperStatus?? && paperTemplate.paperStatus == 'ENABLE'&& paperTemplate.security?? && !paperTemplate.security>
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
            <li class="add-paper-step-item floatL step-complete">
                <div class="add-step-icon-wrap">
                   <span class="iconfont icon-step-circle floatL">
                    <span class="add-step-number">1</span>
                   </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">基本信息</span>
            </li>
            <li class="add-paper-step-item add-paper-step-two floatL overStep ">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                      <span class="add-step-number">2</span>
                    </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text" style="margin-left:95px;">必考题</span>
            </li>
            <#assign finishStepNum = 3/>
            <#if (paperTemplate.paperType)?? && (paperTemplate.paperType)! == 'RANDOM'>
                <#assign finishStepNum = 4/>
                <li class="add-paper-step-item add-paper-step-two floatL ">
                    <div class="add-step-icon-wrap">
                        <div class="add-step-line add-step-two-line"></div>
                            <span class="iconfont icon-step-circle floatL">
                           <span class="add-step-number">3</span>
                         </span>
                        <div class="add-step-line"></div>
                    </div>
                    <span class="add-step-text" style="margin-left:95px;">随机题</span>
                </li>
            </#if>
            <li class="add-paper-step-item add-paper-step-three floatL " style="width:150px;">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line"></div>
                     <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">${finishStepNum!}</span>
                     </span>
                </div>
                <span class="add-step-text" style="margin-left:105px;">完成</span>
            </li>
        </ul>
    </#if>
    </div>
    <div class="pe-add-paper-main-content over-flow-hide add-paper-step-two-all-wrap">
        <div class="pe-add-paper-left floatL">
        <#--没有添加试题时-->
            <div class="add-paper-no-item-wrap">
                <div class="add-paper-no-icon">
                    <div class="paper-no-item-wrap"></div>
                </div>
                <#if (paperTemplate.paperType)?? && (paperTemplate.paperType)! == 'RANDOM'>
                <p class="pe-add-paper-tip">还没添加必考题,请点击下面按钮添加；或点击“下一步”添加随机题。</p>
                <#else>
                    <p class="pe-add-paper-tip">还没添加必考题,请点击下面按钮添加。</p>
                </#if>
            </div>
        <#--添加试题时-->
            <div class="show-stop-item-info" style="display: none;">
                <label class="show-must-item-error">
                    <label>灰色字体的是已经被删除或禁用的试题，点击&nbsp;
                        <button type="button" class="clear-stop-item">清理</button>
                        &nbsp;自动在本试卷中移除这些试题</label>
                    <a class="iconfont icon-dialog-close-btn close-stop-item-msg"
                       style="float: right;margin-top: 3px;margin-right: 5px;color: #999;cursor: pointer;"></a>
                </label>
            </div>
            <div style="color: #999;font-size: 13px;padding: 10px 0px 0px 20px;display: none;" class="show-now-save">
                *必考题的添加、删除为实时保存
            </div>
            <div class="add-paper-has-item-wrap">

            </div>
            <button type="button" class="pe-add-paper-add-btn"><span class="iconfont icon-new-add"></span>添加必考题
            </button>
        </div>
        <div class="add-paper-right add-paper-border">
            <div class="add-paper-right-header paper-most-secret
            <#if paperTemplate.security?? && paperTemplate.security>iconfont icon-secret-label"</#if>>
                <h4 class="add-paper-name">${(paperTemplate.paperName)!}</h4>
            </div>
            <div class="add-paper-right-list paper-info">
                <dl class="app-paper-info">
                    <dt class="paper-info-title">试卷类型：</dt>
                    <dd class="paper-info-value"><#if paperTemplate.paperType?? && paperTemplate.paperType == 'FIXED'>
                        固定卷<#else>随机卷</#if></dd>
                    <dt class="paper-info-title paper-info-total-items">总题数：</dt>
                    <dd class="paper-info-value paper-info-total-items">${(paperTemplate.itemCount)!'0'}</dd>
                </dl>
                <a href="${ctx!}/ems/template/manage/initViewPaperPage?templateId=${(paperTemplate.id)!}"
                   class="pe-btn pe-btn-green pe-paper-preview-btn" target="_blank">预览试卷</a>
                <div class="clear"></div>
            </div>
            <div class="add-paper-right-list add-paper-item-type-wrap paper-right-no-item-wrap">
                <p class="paper-must-title">
                    必考题(共${(totalMustItem)!'0'}道，总分${(totalMustMark?string('#.#'))!'0'}分)
                </p>
            </div>
        </div>
    </div>
    <div class="pe-add-paper-step-btns">
    <#if !(paperTemplate.templateEdit?? && paperTemplate.templateEdit)>
        <button type="button" class="pe-btn pe-btn-purple pe-step-pre-btn">上一步</button>
        <#if paperTemplate.paperType?? && paperTemplate.paperType == 'FIXED'>
            <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft">保存为草稿</button>
            <button type="button" class="pe-btn pe-btn-blue pe-step-save-and-use">保存并启用</button>
        <#else>
            <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn">下一步</button>
        </#if>
    </#if>
        <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回
        </button>
    </div>
</section>
<script type="text/template" id="showTotalTemp">
    <p class="paper-must-title" style="margin: 0;">
        必考题(共<%=data.totalCount%>道，总分<%=data.totalMark?(Number(data.totalMark)).toFixed(1):'0'%>分)
    </p>
    <%_.each(data.types, function(value){%>
    <div class="paper-must-list">
            <span class="paper-ques-type" style="margin-top:15px;">
            <%=value.typeName%>：<span class="paper-single-choosen"><%=value.count%></span>
            </span>
    </div>
    <%});%>
</script>
<script type="text/template" id="paperAddQuestionTemp">
    <#--data=map<String,List<Item>>-->
    <%_.each(['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'], function(itemType){ if (data[itemType]) {%>
    <div class="paper-add-question-type">
        <%if(itemType === 'SINGLE_SELECTION'){%>
        <h2 class="pe-question-head-text" style="margin-bottom:8px;">单选题</h2>
        <%}else if(itemType === 'MULTI_SELECTION'){%>
        <h2 class="pe-question-head-text" style="margin-bottom:8px;">多选题</h2>
        <%}else if(itemType === 'INDEFINITE_SELECTION'){%>
        <h2 class="pe-question-head-text" style="margin-bottom:8px;">不定项选择</h2>
        <%}else if(itemType === 'JUDGMENT'){%>
        <h2 class="pe-question-head-text" style="margin-bottom:8px;">判断题</h2>
        <%}else if(itemType === 'FILL'){%>
        <h2 class="pe-question-head-text" style="margin-bottom:8px;">填空题</h2>
        <%}else if(itemType === 'QUESTIONS'){%>
        <h2 class="pe-question-head-text" style="margin-bottom:8px;">问答题</h2>
        <%}%>

        <%_.each(data[itemType], function(item,index) {%>
        <div class="add-paper-question-item-wrap " data-id="<%=item.id%>">
            <div class="paper-add-item-opt-area">
                <%if(index === 0){%>
                <a class="iconfont icon-up moveUp disabled"></a>
                <%}else{%>
                <a class="iconfont icon-up moveUp"></a>
                <%}%>

                <%if(index === data[itemType].length -1){%>
                <a class="iconfont icon-down moveDown disabled"></a>
                <%}else{%>
                <a class="iconfont icon-down moveDown"></a>
                <%}%>
                <a class="iconfont icon-delete delete-must-item"></a>
            </div>
            <div class="paper-add-question-content   <%if (item.status != 'ENABLE'){%>paper-view-disable-color<%}%>">
                <%if (item.status != 'ENABLE') {%>
                <div class="paper-view-disable-mask"></div>
                <%}%>
                <div class="paper-question-stem">
                    <span class="paper-question-num"><%=(index+1)%>.</span>
                    <span class="pe-question-score" style="max-width: 10%;">(<%=item.mark%>分)</span>
                <#--题干-->
                    <div class="paper-item-detail-stem">
                        <%=item.itemDetail.ics.ct%>
                    </div>
                    <div class="all-images-wrap">
                        <div class="swiper-container">
                            <ul class="itemImageViewWrap swiper-wrapper">
                            </ul>
                            <div class="pagination"></div>
                        </div>
                    </div>
                <#--<span class="pe-question-score" style="max-width: 10%;">(<%=item.mark%>分)</span>-->
                    <div class="pe-question-item-level">
                        <span class="floatL" style="height:20px;line-height:20px;font-size:16px;">难度:</span>
                        <div class="pe-star-wrap">
                        <#--SIMPLE / RELATIVELY_SIMPLE / MEDIUM / MORE_DIFFICULT / DIFFICULT -->
                            <span class="pe-star-container">
                             <%if(item.level == 'SIMPLE'){%>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <%}else if(item.level == 'RELATIVELY_SIMPLE'){%>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <%}else if(item.level == 'MEDIUM'){%>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <%}else if(item.level == 'MORE_DIFFICULT'){%>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <%}else {%>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <%}%>
                         </span>
                        </div>
                    </div>
                </div>
            <#--题目选项-->
                <%if (itemType === 'SINGLE_SELECTION' || itemType === 'MULTI_SELECTION' || itemType ===
                'INDEFINITE_SELECTION') {%>
                <ul>
                    <%_.each(item.itemDetail.ics.ios, function(option,index) {%>
                    <li class="question-single-item-wrap">
                        <%if(itemType === 'SINGLE_SELECTION'){%>
                        <label class="pe-radio over-flow-hide">
                            <span class="iconfont <%if (option.t) {%>icon-checked-radio<%} else {%>icon-unchecked-radio<%}%> floatL"></span>
                            <%}else{%>
                            <label class="pe-checkbox over-flow-hide">
                                <span class="iconfont <%if (option.t) {%>icon-checked-checkbox<%} else {%>icon-unchecked-checkbox<%}%> floatL"></span>
                                <%}%>
                                <div class="question-text-wrap">
                                    <span class="question-item-letter-order"><%=option.so%>.</span>
                                    <p class="question-items-choosen-text"><%=option.ct%>
                                    </p>
                                </div>
                            </label>
                    </li>
                    <%})%>
                </ul>
                <%} else if (itemType === 'JUDGMENT'){%>
                <ul>
                    <li class="question-single-item-wrap">
                        <label class="pe-radio over-flow-hide">
                            <span class="iconfont <%if (item.itemDetail.ics.t) {%>icon-checked-radio<%} else{%>icon-unchecked-radio<%}%> floatL"></span>
                            <div class="question-text-wrap">
                                <p class="question-items-choosen-text">正确</p>
                            </div>
                        </label>
                    </li>
                    <li class="question-single-item-wrap">
                        <label class="pe-radio over-flow-hide">
                            <span class="iconfont <%if (!item.itemDetail.ics.t) {%>icon-checked-radio<%} else{%>icon-unchecked-radio<%}%> floatL"></span>
                            <div class="question-text-wrap">
                                <p class="question-items-choosen-text">错误</p>
                            </div>
                        </label>
                    </li>
                </ul>
                <%} else {%>
                <div>
                    <%item.itemDetail.ics.a%>
                </div>
                <%}%>
                <div class="pe-add-paper-true-answer-wrap">
                    <span class="floatL" <%if (item.status == 'ENABLE')
                    {%>style="color:#444;margin-right:4px;"<%}%>>解析:</span>
                    <div>
                        <%if(item.itemDetail.ics.ep || (item.itemDetail.ics.epImgUrls &&
                        item.itemDetail.ics.epImgUrls.length !==0)){%>
                        <div class="paper-item-detail-stem">
                            <%=item.itemDetail.ics.ep%>
                        </div>
                        <%}else{%>
                        <span style="margin-left:6px;font-size:16px;line-height:1.68;">暂无</span>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
        <%})%>
    </div>
    <%}});%>
</script>
<script type="text/template" id="imageTemp">
    <%_.each(data,function(imageUrl,index){%>
    <li class="pe-view-question-detail-img-wrap swiper-slide over-flow-hide" data-index="<%=index%>"
        style="display:inline-block;">
        <img class="pe-question-detail-img-item" data-original="<%=imageUrl%>" src="<%=imageUrl%>" width="auto"
             height="100%"/>
    </li>
    <%});%>
</script>

<script>
    $(function () {
        var paperTemplateId = '${(paperTemplate.id)!}';
        var mustItem = {
                    initData: function () {
                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath + '/ems/template/manage/findFixedItem',
                            data: {paperTemplateId: paperTemplateId},
                            success: function (data) {
                                if ($.isEmptyObject(data)) {
                                    $('.add-paper-has-item-wrap').html('');
                                    $('.add-paper-no-item-wrap').show();
                                    $('.paper-must-list').hide();
                                    return false;
                                }

                                $('.add-paper-no-item-wrap').hide();
                                $('.paper-must-list').show();
                                $('.add-paper-has-item-wrap').html(_.template($('#paperAddQuestionTemp').html())({data: data}));
                                $('.add-paper-question-item-wrap').each(function(i,wrapDom){
                                    var imageUrls = [];
                                    $(wrapDom).find('img.upload-img').each(function (i, e) {
                                        imageUrls.push($(e).data('src'));
                                        $(e).attr('data-index', i);
                                    });

                                    var imagesWrap = $(wrapDom).find('.all-images-wrap');
                                    if (imageUrls.length > 0) {
                                        $(wrapDom).find('.itemImageViewWrap').html(_.template($('#imageTemp').html())({data:imageUrls}));
                                        imagesWrap.show();
                                    }
                                });

                                var imagesWrap = $('.all-images-wrap');
                                for(var i=0,ILen = imagesWrap.length;i< ILen;i++){
                                    $(imagesWrap[i]).addClass('all-images-wrap' + (i + 1)).attr('data-index',i+1);
                                    if(!$(imagesWrap[i]).find('.swiper-wrapper img').get(0)){
                                        $(imagesWrap[i]).hide();
                                    }else{
                                        $(imagesWrap[i]).find('.swiper-wrapper').css('transform','translate3d(0px, 0px, 0px)');
                                        $(imagesWrap[i]).find('.swiper-wrapper').css('-webkit-transform','translate3d(0px, 0px, 0px)');
                                        PEBASE.swiperInitItem($('.add-paper-has-item-wrap'),i+1);
                                    }
                                }

                                var typeObj = {};
                                var types = [];
                                var totalCount = 0;
                                var totalMark = 0;
                                $.each(['SINGLE_SELECTION', 'MULTI_SELECTION', 'INDEFINITE_SELECTION', 'JUDGMENT', 'FILL', 'QUESTIONS'], function (index, value) {
                                    if (!data[value] || data[value].length <= 0) {
                                        return;
                                    }

                                    $('.show-now-save').css('display', '');
                                    var typeName = '问答题';
                                    if (value == 'SINGLE_SELECTION') {
                                        typeName = '单选题';
                                    } else if (value == 'MULTI_SELECTION') {
                                        typeName = '多选题';
                                    } else if (value == 'INDEFINITE_SELECTION') {
                                        typeName = '不定项选择题';
                                    } else if (value == 'JUDGMENT') {
                                        typeName = '判断题';
                                    } else if (value == 'FILL') {
                                        typeName = '填空题';
                                    }

                                    totalCount = totalCount + data[value].length;
                                    types.push({typeName: typeName, 'count': data[value].length});
                                    $.each(data[value], function (index, item) {
                                        totalMark = totalMark + item.mark;
                                    });
                                });

                                typeObj.types = types;
                                typeObj.totalCount = totalCount;
                                typeObj.totalMark = totalMark;
                                $('.add-paper-item-type-wrap').html(_.template($('#showTotalTemp').html())({data: typeObj}));
                            <#if paperTemplate.templateEdit?? && paperTemplate.templateEdit>
                                if ($('.stop-item-style').length > 0) {
                                    $('.show-stop-item-info').slideDown('fast');
                                }
                            </#if>
                            }
                        });
                    },

                    init: function () {
                        $('.add-paper-has-item-wrap').delegate('.delete-must-item', 'click', function () {
                            var itemIds = [];
                            var  $thisParent= $(this).parents('.add-paper-question-item-wrap');
                            itemIds.push($thisParent.data('id'));
                            PEMO.DIALOG.confirmR({
                                content: '<div><h3 class="pe-dialog-content-head">确定删除该必考题吗？</h3></div>',
                                btn2: function () {
                                    PEBASE.ajaxRequest({
                                        url: pageContext.rootPath + '/ems/template/manage/deleteMustItem',
                                        data: {'templateId': '${(paperTemplate.id)!}', 'itemIds': JSON.stringify(itemIds)},
                                        success: function () {
                                            PEMO.DIALOG.tips({
                                                content: '删除成功',
                                                time: 1000,
                                                end: function () {
                                                    var param = {
                                                        templateEdit: '${(paperTemplate.templateEdit?string('true','false'))!}',
                                                        templateId: '${(paperTemplate.id)!}'
                                                    };
                                                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initMustPage', param);
                                                }
                                            });
                                        }
                                    });
                                },
                                btn1: function () {
                                    layer.closeAll();
                                }
                            });
                        });

                        $('.pe-step-next-btn').on('click', function () {
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initRandomPage?templateId=${(paperTemplate.id)!}');
                        });

                        $('.pe-step-pre-btn').on('click', function () {
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initBasicEditPage', {id: '${(paperTemplate.id)!}'});
                        });

                        $('.pe-step-back-btn').on('click', function () {
                            location.href = "#url=/pe/ems/template/manage/initPage&nav=examPaper";//如果出现返回后，表格中的某些按钮不能点击时，在来解决;
//                            history.back(-1);
                        });
                        $('.edit-step-state .edit-paper-basic').on('click', function () {
                            var param = {
                                templateEdit: '${(paperTemplate.templateEdit?string('true','false'))!}',
                                id: '${(paperTemplate.id)!}'
                            };
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initBasicEditPage', param);
                        });



                        $('.edit-step-state .edit-paper-random').on('click', function () {
                            var param = {
                                templateEdit: '${(paperTemplate.templateEdit?string('true','false'))!}',
                                templateId: '${(paperTemplate.id)!}'
                            };
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initRandomPage', param);
                        });

                        $('.edit-step-state .edit-paper-auth').on('click', function () {
                            var param = {
                                templateId: '${(paperTemplate.id)!}'
                            };
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initPaperAuth', param);
                        });

                        $('.pe-step-save-and-use').on('click', function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/template/manage/enableTemplate?templateId=${(paperTemplate.id)!}&continueEnable=true',
                                data: $('#randomSetForm').serialize(),
                                success: function (data) {
                                    if (data.success) {
                                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initPage', function () {
                                            PEBASE.publickHeader();
                                            //定义页面所有的checkbox，和radio的模拟点击事件
                                            PEBASE.peFormEvent('checkbox');
                                            PEBASE.peFormEvent('radio');
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

                        $('.pe-step-save-draft').on('click', function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/template/manage/updateStatus?templateId=${(paperTemplate.id)!}&status=DRAFT',
                                data: $('#randomSetForm').serialize(),
                                success: function (data) {
                                    if (data.success) {
                                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initPage', function () {
                                            PEBASE.publickHeader();
                                            //定义页面所有的checkbox，和radio的模拟点击事件
                                            PEBASE.peFormEvent('checkbox');
                                            PEBASE.peFormEvent('radio');
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

                        $('.pe-add-paper-main-content').delegate('.clear-stop-item', 'click', function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            e.preventDefault();
                            var itemIds = [];
                            $('.stop-item-style').each(function (index, ele) {
                                var id = $(ele).data('id');
                                if (!$.isEmptyObject(id)) {
                                    itemIds.push(id);
                                }
                            });

                            if (itemIds.length <= 0) {
                                return false;
                            }

                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/template/manage/deleteMustItem',
                                data: {'templateId': '${(paperTemplate.id)!}', 'itemIds': JSON.stringify(itemIds)},
                                success: function (data) {
                                    PEMO.DIALOG.tips({
                                        content: '清理成功',
                                        time: 1000,
                                        end: function () {
                                            var param = {
                                                templateEdit: '${(paperTemplate.templateEdit?string('true','false'))!}',
                                                templateId: '${(paperTemplate.id)!}'
                                            };
                                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initMustPage', param);
                                        }
                                    });
                                }
                            });
                        });

                        $('.pe-add-paper-main-content').delegate('.close-stop-item-msg', 'click', function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            e.preventDefault();
                            $('.show-stop-item-info').slideUp("fast");
                        });

                        $('.pe-add-paper-add-btn').click(function () {
                            PEMO.DIALOG.selectorDialog({
                                title: '添加必考题',
                                content: [pageContext.rootPath + '/ems/template/manage/addFixedItem?templateId=' + '${(paperTemplate.id)!}', 'no'],
                                area: ['945px', '565px'],
                                end: function () {
                                    var param = {
                                        templateEdit: '${(paperTemplate.templateEdit?string('true','false'))!}',
                                        templateId: '${(paperTemplate.id)!}'
                                    };
                                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/template/manage/initMustPage', param);
                                    PEBASE.swiperBindTimes = 0;
                                }
                            });
                        });

                        $('.add-paper-has-item-wrap').delegate('.add-paper-question-item-wrap', 'mouseenter', function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            e.preventDefault();
                            $(this).find('.paper-add-question-content').addClass('hoverItem');
                            $(this).find('.paper-add-item-opt-area').show();
                        });

                        $('.add-paper-has-item-wrap').delegate('.add-paper-question-item-wrap', 'mouseleave', function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            e.preventDefault();
                            $(this).find('.paper-add-question-content').removeClass('hoverItem');
                            $(this).find('.paper-add-item-opt-area').hide();
                        });
                        $('.add-paper-has-item-wrap').delegate('.paper-add-question-type .moveUp', 'click', function (e) {
                                    var e = e || window.event;
                                    e.stopPropagation();
                                    e.preventDefault();
                                    if ($(this).hasClass('disabled')) {
                                        return false;
                                    }

                                    var $this = $(this);
                                    var $thisParentDom = $this.parents('.add-paper-question-item-wrap');
                                    var itemId = $thisParentDom.data('id');
                                    PEBASE.ajaxRequest({
                                        url: pageContext.rootPath + '/ems/template/manage/moveMustItem',
                                        data: {'templateId': '${(paperTemplate.id)!}', 'itemId': itemId, 'up': true},
                                        success: function (data) {
                                            var $prevParentDom = $thisParentDom.prev('.add-paper-question-item-wrap').eq(0);
                                            if ($prevParentDom.get(0)) {

                                                var thisIndex = $thisParentDom.find('.paper-question-num').html();
                                                var prevIndex = $prevParentDom.find('.paper-question-num').html();
                                                $prevParentDom.before($thisParentDom);
                                                $thisParentDom.find('.paper-question-num').html(prevIndex);
                                                $prevParentDom.find('.paper-question-num').html(thisIndex);
                                            }

                                            $thisParentDom.find('.moveUp').removeClass('disabled');
                                            $thisParentDom.find('.moveDown').removeClass('disabled');
                                            $prevParentDom.find('.moveUp').removeClass('disabled');
                                            $prevParentDom.find('.moveDown').removeClass('disabled');
                                            if ($thisParentDom.index() === 1) {
                                                $thisParentDom.find('.moveUp').addClass('disabled');
                                            }

                                            if ($prevParentDom.index() === 1) {
                                                $prevParentDom.find('.moveUp').addClass('disabled');
                                            } else if ($prevParentDom.index() === $this.parents('.paper-add-question-type').find('.add-paper-question-item-wrap').length) {
                                                $prevParentDom.find('.moveDown').addClass('disabled');
                                            }
                                        }
                                    });
                                }
                        );
                        $('.add-paper-has-item-wrap').delegate('.paper-add-question-type .moveDown', 'click', function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            e.preventDefault();
                            if ($(this).hasClass('disabled')) {
                                return false;
                            }

                            var $this = $(this);
                            var $thisParentDom = $this.parents('.add-paper-question-item-wrap');
                            var itemId = $thisParentDom.data('id');
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/template/manage/moveMustItem',
                                data: {'templateId': '${(paperTemplate.id)!}', 'itemId': itemId, 'up': false},
                                success: function (data) {
                                    var $nextParentDom = $thisParentDom.next('.add-paper-question-item-wrap').eq(0);
                                    if ($nextParentDom.get(0)) {
                                        var thisIndex = $thisParentDom.find('.paper-question-num').html();
                                        var prevIndex = $nextParentDom.find('.paper-question-num').html();
                                        $nextParentDom.after($thisParentDom);
                                        $thisParentDom.find('.paper-question-num').html(prevIndex);
                                        $nextParentDom.find('.paper-question-num').html(thisIndex);
                                    }

                                    $thisParentDom.find('.moveDown').removeClass('disabled');
                                    $thisParentDom.find('.moveUp').removeClass('disabled');
                                    $nextParentDom.find('.moveUp').removeClass('disabled');
                                    $nextParentDom.find('.moveDown').removeClass('disabled');
                                    if ($thisParentDom.index() === $this.parents('.paper-add-question-type').find('.add-paper-question-item-wrap').length) {
                                        $thisParentDom.find('.moveDown').addClass('disabled');
                                    }

                                    if ($nextParentDom.index() === $this.parents('.paper-add-question-type').find('.add-paper-question-item-wrap').length) {
                                        $nextParentDom.find('.moveDown').addClass('disabled');
                                    } else if ($nextParentDom.index() === 1) {
                                        $nextParentDom.find('.moveUp').addClass('disabled');
                                    }
                                }
                            });
                        });

                        $('.add-paper-has-item-wrap').delegate('.paper-add-question-type .dele', 'click', function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            e.preventDefault();

                            var $thisParentDom = $(this).parents('.add-paper-question-item-wrap');
                            var $nextParentDom = $thisParentDom.next('.add-paper-question-item-wrap').eq(0);
                            var $prevParentDom = $thisParentDom.prev('.add-paper-question-item-wrap').eq(0);
                            $thisParentDom.remove();
                            if (!$nextParentDom.get(0)) {
                                if ($prevParentDom.get(0)) {
                                    $prevParentDom.find('.moveDown').addClass('disabled');
                                }
                            }

                            if (!$prevParentDom.get(0)) {
                                if ($nextParentDom.get(0)) {
                                    $nextParentDom.find('.moveUp').addClass('disabled');
                                }
                            }
                        });

                        //视频
                        $('.add-paper-has-item-wrap').delegate('.image-video','click',function(){
                            var thisVideoSrc = $(this).attr('data-src');
                            PEMO.VIDEOPLAYER(thisVideoSrc);
                        });
                        //音频
                        $('.add-paper-has-item-wrap').delegate('.image-audio','click',function(e){
                            var _this = $(this);
                            if($('.image-audio').not(_this).hasClass('audio-playing') || $('.image-audio').not($(this)).hasClass('audio-pause')){
                                PEMO.AUDIOOBJ.obj.player_.pause();
//                                PEMO.AUDIOOBJ.oldSrc = '';
                                var $audioPlayingDom =  $('.image-audio.audio-playing');
                                var $audioPauseDom =  $('.image-audio.audio-pause');
                                if($audioPlayingDom.get(0)){
                                    var playingSrc = $audioPlayingDom.attr('src').replace(/audio_playing.gif/ig,'default-music.png');
                                    $audioPlayingDom.attr('src',playingSrc);
                                }
                               if($audioPauseDom.get(0)){
                                   var pauseSrc = $audioPauseDom.attr('src').replace(/audio_pause.png/ig,'default-music.png');
                                   $audioPauseDom.attr('src',pauseSrc);
                               }
                                $audioPlayingDom.removeClass('audio-playing');
                                $audioPauseDom.removeClass('audio-pause');
                            }
                            var thisVideoSrc = _this.attr('data-src');
                            if(_this.hasClass('audio-playing')){
                                //已经在播放，这里执行暂停
                                PEMO.AUDIOPLAYER(thisVideoSrc,true);
                                _this.removeClass('audio-playing').addClass('audio-pause');
                                var newSrc = _this.attr('src').replace(/audio_playing.gif/ig,'audio_pause.png');
                                _this.attr('src',newSrc);
                            }else{
                                PEMO.AUDIOPLAYER(thisVideoSrc,false);
                                _this.addClass('audio-playing').removeClass('audio-pause');
                                var newSrc = _this.attr('src').replace(/audio_pause.png|default-music.png/ig,'audio_playing.gif');
                                _this.attr('src',newSrc);
                            }
                            /*监听音频播放结束*/
                            PEMO.AUDIOOBJ.obj.on('ended',function(){
                                $('.image-audio.audio-playing').removeClass('audio-playing audio-pause');
                                var newSrc = _this.attr('src').replace(/audio_pause.png|audio_playing.gif/ig,'default-music.png');
                                _this.attr('src',newSrc);
                            })
                        });

                    }
                };

        mustItem.initData();
        mustItem.init();
    })
    ;
</script>

