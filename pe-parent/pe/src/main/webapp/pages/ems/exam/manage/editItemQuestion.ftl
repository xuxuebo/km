<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>选择器</title>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/iconfont.css" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css" type="text/css"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/js/peEditor/pe_editor.css" type="text/css">
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.webuploader.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.pagination.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.easydropdown.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-peGrid.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js"></script>
<#--<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/peUedit/ueditor.config.js"></script>-->
<#--<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/peUedit/ueditor.all.js"></script>-->
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.validate.js"></script>
    <script>
        var pageContext = {
            rootPath: '${ctx!}',
            resourcePath: '${resourcePath!}'
        }
    </script>
</head>
<body>
<section class="pe-add-question-wrap exam-edit-item-all-panel" style="width: auto;">
    <form id="editItemForm">
        <input type="hidden" value="${(itemId)!}" name="id"/>
        <div class="pe-question-top-head">
            <h2 class="pe-question-head-text">基本信息</h2>
        </div>
        <div class="pe-question-item-container item-edit-score">
            <label class="pe-table-form-label pe-main-input-tree  pe-question-label">
                 <span class="pe-input-tree-text floatL">
                    <span style="color:red;">*</span>试题分值:
                </span>
                <input class="pe-table-form-text pe-question-score-num required " type="text"
                       name="m">
                <span class="validate-form-cell">
                    <em class="error"></em>
                </span>
            </label>
        </div>
        <div class="pe-question-top-head">
            <h2 class="pe-question-head-text">试题内容</h2>
        </div>
        <div class="pe-question-item-container pe-add-qutestion-type-container">
            <div class="pe-question-content-wrap over-flow-hide">
                <span class="pe-input-tree-text floatL">
                    <span style="color:red;">*</span>选择题型:
                </span>
                <div class="pe-add-question-type-btn">
                <#if itemType == 'SINGLE_SELECTION'>
                    <button type="button"
                            class="pe-btn floatL pe-add-single curType"
                            data-type="SINGLE_SELECTION">单选题
                    </button>
                <#elseif itemType == 'MULTI_SELECTION'>
                    <button type="button"
                            class="pe-btn floatL pe-add-multiple curType"
                            data-type="MULTI_SELECTION">多选题
                    </button>
                <#elseif itemType == 'INDEFINITE_SELECTION'>
                    <button type="button"
                            class="pe-btn floatL pe-add-indefinite curType"
                            data-type="INDEFINITE_SELECTION">多选题
                    </button>
                <#elseif itemType == 'JUDGMENT'>
                    <button type="button"
                            class="pe-btn floatL pe-add-judgment curType"
                            data-type="JUDGMENT">判断题
                    </button>
                <#elseif itemType == 'FILL'>
                    <button type="button"
                            class="pe-btn floatL pe-add-fill curType"
                            data-type="FILL">填空题
                    </button>
                <#elseif itemType == 'QUESTIONS'>
                    <button type="button"
                            class="pe-btn floatL pe-add-question curType"
                            data-type="QUESTIONS">问答题
                    </button>
                </#if>
                </div>
            </div>
            <div class="pe-question-add-item-type">
                <div class="pe-add-question-single-container pe-add-type-wrap">
                    <div class="pe-add-question-tip">（只有一个选项是正确答案）</div>
                    <div class="pe-question-item-rich-wrap">
                        <div class="pe-rich-text-wrap">
                            <div class="pe-rich-text-item-area">
                                <div id="containerContent" class="option pe-simple-editor">

                                </div>
                            </div>
                        </div>
                        <button type="button" class="pe-add-rich-area-btn">增加选项</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="pe-add-question-more-choosen-wrap">
            <div class="pe-question-item-container" style="position:relative;">
                <div class="pe-rich-text-more-item-area">
                    <div id="containerMoreMsg" class="option pe-simple-editor">
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div class="pe-mask-listen"></div>
</section>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/peEditor/pe_simple_editor.js"></script>
<script type="text/template" id="judgeTemp">
    <div class="pe-add-question-true-answer-wrap option-text-wrap">
        <h3 class="pe-add-true-answer-head">正确答案</h3>
        <div class="pe-add-true-answer-item">
            <label class="pe-radio judgeAnswer">
                <span class="iconfont icon-checked-radio"></span>
                <span class="pe-select-true-answer"><input class="pe-form-ele" checked="checked" type="radio"
                                                           value="true" name="judgeAnswer"/>正确</span>
            </label>
            <label class="pe-radio judgeAnswer">
                <span class="iconfont icon-unchecked-radio"></span>
                <span class="pe-select-true-answer"><input class="pe-form-ele" type="radio" value="false"
                                                           name="judgeAnswer"/>错误</span>
            </label>
        </div>
    </div>
</script>
<script type="text/template" id="questionTemp">
    <div class="pe-add-question-true-answer-wrap option-text-wrap">
        <h3 class="pe-add-true-answer-head">标准答案</h3>
        <div class="pe-add-true-answer-item">
            <span class="validate-form-cell">
                 <em class="error"></em>
             </span>
            <textarea class="pe-add-question-text-answer"></textarea>
        </div>
    </div>
</script>

<script type="text/template" id="fillTemp">
    <div class="pe-add-question-true-answer-wrap option-text-wrap" style="border:none;height:auto;min-height:108px;">
        <h3 class="pe-add-true-answer-head">参考答案</h3>
        <div class="pe-add-true-answer-item fill-item-true-answer-wrap">
        <#--<textarea class="pe-add-fill-text-answer"></textarea>-->
        </div>
    </div>
</script>
<script type="text/template" id="radioTemp">
    <div class="pe-rich-text-wrap option-text-wrap">
        <div class="pe-rich-text-item-area">
            <div id="<%=containerDom%>" class="option pe-simple-editor">
            </div>
        </div>
        <div class="pe-uedit-opt floatL">
            <label class="pe-radio isRadioOpt">
                <span class="iconfont icon-unchecked-radio"></span>
                <span class="pe-select-true-answer">
                    <input class="pe-form-ele" type="radio" name="answer"/>设置为正确答案</span>
            </label>
            <ul class="pe-uedit-opt-move over-flow-hide">
                <%if (first){%>
                <li class="uedit-move-up iconfont disabled icon-up floatL"></li>
                <%}else{%>
                <li class="uedit-move-up iconfont icon-up floatL"></li>
                <%}%>
                <%if (last){%>
                <li class="uedit-move-down iconfont disabled icon-down floatL"></li>
                <%}else{%>
                <li class="uedit-move-down iconfont icon-down floatL"></li>
                <%}%>
                <li class="uedit-dele iconfont icon-delete floatL"></li>
            </ul>
        </div>
    </div>
</script>

<script type="text/template" id="fillAnswerTemplate">
    <label class="pe-question-label" data-index="ill<%=data.index%>">
                 <span class="pe-input-tree-text floatL">
                    填空<%=data.index%>:
                </span>
        <input class="pe-stand-filter-form-input" type="text" value="<%=data.a%>" maxlength="50"
               name="fillItemAnswer" placeholder="请输入第<%=data.index%>个填空的答案">
        <em id="fillItemAnswer<%=data.index%>-error error-em" style="display:none;" class="error">答案不能为空</em>
    </label>
</script>
<script type="text/template" id="checkboxTemp">
    <div class="pe-rich-text-wrap option-text-wrap">
        <div class="pe-rich-text-item-area">
            <div id="<%=containerDom%>" class="option pe-simple-editor">
            </div>
        </div>
        <div class="pe-uedit-opt floatL">
            <label class="pe-checkbox">
                <span class="iconfont icon-unchecked-checkbox"></span>
                <span class="pe-select-true-answer"><input class="pe-form-ele" type="checkbox"
                                                           name="answer"/>设置为正确答案</span>
            </label>
            <ul class="pe-uedit-opt-move over-flow-hide">
                <%if (first){%>
                <li class="uedit-move-up iconfont disabled icon-up floatL"></li>
                <%}else{%>
                <li class="uedit-move-up iconfont icon-up floatL"></li>
                <%}%>
                <%if (last){%>
                <li class="uedit-move-down iconfont disabled icon-down floatL"></li>
                <%}else{%>
                <li class="uedit-move-down iconfont icon-down floatL"></li>
                <%}%>
                <li class="uedit-dele iconfont icon-delete floatL"></li>
            </ul>
        </div>
    </div>
</script>
<script type="text/javascript">
    var matchOldArray = '';
    var subscriptMap = {
        '0': 'A', '1': 'B', '2': 'C', '3': 'D', '4': 'E', '5': 'F', '6': 'G', '7': 'H', '8': 'I', '9': 'J'
        , '10': 'K', '11': 'L', '12': 'M', '13': 'N', '14': 'O', '15': 'P', '16': 'Q', '17': 'R', '18': 'S', '19': 'T'
        , '20': 'U', '21': 'V', '22': 'W', '23': 'X', '24': 'Y', '25': 'Z'
    };
    var type = '${(itemType)!}';
    function submitForm() {
        var ic = {};
        ic.id = $('input[name="id"]').val();
        ic.m = $('input[name="m"]').val();
        if (!ic.m) {
            $('.item-edit-score .validate-form-cell em.error').html('请填写有效的分数值');
            return false;
        } else {
            $('.item-edit-score .validate-form-cell em.error').html('');
        }
        var hasContent = $('#containerContent').peEditor('hasContent');
        if (!hasContent) {
            PEMO.DIALOG.alert({
                content: "题干内容不能为空！",
                btn: ['我知道了'],
                shadow: 0,
                yes: function () {
                    layer.closeAll();
                }
            });
            return false;
        }

        ic.ct = $('#containerContent').peEditor('getContent');
        if (type === 'SINGLE_SELECTION' || type === 'MULTI_SELECTION' || type === 'INDEFINITE_SELECTION') {
            var errMsg = itemPage.getIos(ic, type);
            if (errMsg) {
                PEMO.DIALOG.tips({
                    content: errMsg
                });
                return false;
            }

        } else if (type === 'JUDGMENT') {
            ic.t = $('input[name="judgeAnswer"]:checked').val();
            if (!ic.t) {
                PEMO.DIALOG.tips({
                    content: '选项不可为空！'
                });
                return false;
            }

        } else if (type === 'FILL') {
            var fillAnswerInput = $('.fill-item-true-answer-wrap').find('input');
            var isVal = true;
            for(var i=0,iLen=fillAnswerInput.length;i<iLen;i++){
                if(!$.trim($(fillAnswerInput[i]).val())){
                    $(fillAnswerInput[i]).addClass('error');
                    $(fillAnswerInput[i]).next('em').text('请填写答案');
                    $(fillAnswerInput[i]).next('em').eq(0).show();
                    isVal = false;
                }
            }

            if(!isVal){
                return false;
            }

            var answer = [],val = true;
            $('input[name="fillItemAnswer"]').each(function(i,v){
                if(!$(v).val()){
                    val = false;
                }

                answer.push($(v).val());
            });

            if (!val) {
                PEMO.DIALOG.alert({
                    content: '参考答案不可为空！',
                    btn: ['我知道了'],
                    yes: function () {
                        layer.closeAll();
                    }
                });
                return false;
            }

            ic.a = answer.join('、');
        } else if (type === 'QUESTIONS') {
            var $questionAnswer = $('.pe-add-question-text-answer');
            ic.a = $questionAnswer.val();
            if (!ic.a) {
                PEMO.DIALOG.alert({
                    content: '参考答案不可为空！',
                    btn: ['我知道了'],
                    yes: function () {
                        layer.closeAll();
                    }
                });
                return false;
            }

        } else {
            return false;
        }

        ic.ep = $('#containerMoreMsg').peEditor('getContent');
        PEBASE.ajaxRequest({
            url: pageContext.rootPath + "/ems/exam/manage/savePaperItem",
            data: {'content': JSON.stringify(ic), paperId: '${(paperId)!}'},
            success: function () {
                parent.location.reload();
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
            }
        });
    }

    var itemPage = {
        bind:function () {
            $('#editItemForm').validate({
                debug: true,
                rules: {
                    'mark': {
                        required: true
                    }
                },
                messages: {
                    'mark': {
                        required: '必填项'
                    }
                }
            });

            var thisRichAllWrap = $('.pe-question-item-rich-wrap');
            //题型上下移动函数;
            thisRichAllWrap.delegate('.uedit-move-down', 'click', function () {
                if ($(this).hasClass('disabled')) {
                    return false;
                } else {
                    var $thisRichWrap = $(this).parents('.pe-rich-text-wrap'),
                            $thisOpt = $thisRichWrap.find('.pe-uedit-opt'),
                            thisUeId = $thisRichWrap.find('.pe-simple-editor').attr('id'),
                            thisOptHtml = $thisOpt.html(),
                            $nextRichWrap = $(this).parents('.pe-rich-text-wrap').next('.pe-rich-text-wrap').eq(0),
                            $nextOpt = $nextRichWrap.find('.pe-uedit-opt'),
                            nextUeId = $nextRichWrap.find('.pe-simple-editor').attr('id'),
                            nextOptHtml = $nextOpt.html(),
                            thisUEContent = $('#' + thisUeId).peEditor('getContent'),
                            nextUEContent = $('#' + nextUeId).peEditor('getContent');
                    $thisOpt.html(nextOptHtml);
                    $nextOpt.html(thisOptHtml);
                    if ($thisRichWrap.index() === 1) {
                        $thisRichWrap.find('.uedit-move-up').addClass('disabled');
                    }
                    $thisRichWrap.find('.uedit-move-down').removeClass('disabled');

                    if ($nextRichWrap.index() === (thisRichAllWrap.find('.pe-rich-text-wrap').length - 1)) {
                        $nextRichWrap.find('.uedit-move-down').addClass('disabled');
                    }
                    $nextRichWrap.find('.uedit-move-up').removeClass('disabled');
                    $('#' + thisUeId).peEditor('setContent', nextUEContent);
                    $('#' + nextUeId).peEditor('setContent', thisUEContent);
                    PEBASE.peFormEvent('radio');
                    PEBASE.peFormEvent('checkbox');
                }
            });

            //题型选项删除函数;
            thisRichAllWrap.delegate('.uedit-dele', 'click', function () {
                if ($(this).hasClass('disabled')) {
                    return false;
                }

                var optionDoms = thisRichAllWrap.find('.option-text-wrap');
                if (optionDoms.length < 3) {
                    thisRichAllWrap.find('.uedit-dele').addClass('disabled');
                    return false;
                }

                if (optionDoms.length === 3) {
                    thisRichAllWrap.find('.uedit-dele').addClass('disabled');
                }

                $(this).parents('.pe-rich-text-wrap').remove();
                thisRichAllWrap.find('.option-text-wrap').each(function (index) {
                    $(this).find('.self-toolbar-left').html('选项' + subscriptMap[index]);
                });

                thisRichAllWrap.find('.option-text-wrap').last().find('.uedit-move-down').addClass('disabled');
                $('.pe-add-rich-area-btn').show();
            });

            thisRichAllWrap.delegate('.uedit-move-up', 'click', function () {
                if ($(this).hasClass('disabled')) {
                    return false;
                } else {
                    var $thisRichWrap = $(this).parents('.pe-rich-text-wrap'),
                            $thisOpt = $thisRichWrap.find('.pe-uedit-opt'),
                            thisUeId = $thisRichWrap.find('.pe-simple-editor').attr('id'),
                            thisOptHtml = $thisOpt.html(),
                            $prevRichWrap = $(this).parents('.pe-rich-text-wrap').prev('.pe-rich-text-wrap').eq(0),
                            $nextOpt = $prevRichWrap.find('.pe-uedit-opt'),
                            nextUeId = $prevRichWrap.find('.pe-simple-editor').attr('id'),
                            nextOptHtml = $nextOpt.html(),
                            thisUEContent = $('#' + thisUeId).peEditor('getContent'),
                            nextUEContent = $('#' + nextUeId).peEditor('getContent');
                    $thisOpt.html(nextOptHtml);
                    $nextOpt.html(thisOptHtml);

                    if ($thisRichWrap.index() === (thisRichAllWrap.find('.pe-rich-text-wrap').length - 1)) {
                        $thisRichWrap.find('.uedit-move-down').addClass('disabled');
                    }
                    $thisRichWrap.find('.uedit-move-up').removeClass('disabled');

                    if ($prevRichWrap.index() === 1) {
                        $prevRichWrap.find('.uedit-move-up').addClass('disabled');
                    }
                    $prevRichWrap.find('.uedit-move-down').removeClass('disabled');
                    $('#' + thisUeId).peEditor('setContent', nextUEContent);
                    $('#' + nextUeId).peEditor('setContent', thisUEContent);
                }
            });

            //新增题目按钮点击事件
            $('.pe-add-rich-area-btn').click(function () {
                var type = $('.pe-add-question-type-btn').find('.curType.pe-btn').data('type');
                //克隆还是模板，待定,一下注释误删！
                var beforeLast = thisRichAllWrap.find('.pe-rich-text-wrap').last();
                var thisWrapRichDoms = thisRichAllWrap.find('.pe-rich-text-wrap');
                var hasRichNum = $('.pe-question-item-rich-wrap  .pe-rich-text-wrap').length - 1;
                var containerDom = 'container' + hasRichNum + type;
                if (type === 'SINGLE_SELECTION') {
                    beforeLast.after(_.template($('#radioTemp').html())({
                        containerDom: containerDom,
                        first: false,
                        last: true,
                        subscript: '选项' + subscriptMap[hasRichNum]
                    }));
                    itemPage.renderUedit(containerDom, '选项' + subscriptMap[hasRichNum], '');
                    PEBASE.peFormEvent('radio');
                } else {
                    beforeLast.after(_.template($('#checkboxTemp').html())({
                        containerDom: containerDom,
                        first: false,
                        last: true,
                        subscript: '选项' + subscriptMap[hasRichNum]
                    }));
                    itemPage.renderUedit(containerDom, '选项' + subscriptMap[hasRichNum], '');
                    PEBASE.peFormEvent('checkbox');
                }

                if (thisWrapRichDoms.length >= 10) {
                    $('.pe-add-rich-area-btn').hide();
                }

                beforeLast.find('.uedit-move-down').removeClass('disabled');
            });


            //试题分值输入检测函数
            var score = 1;
            $('.pe-question-score-num').keyup(function (e) {
                var e = e || window.event;
                var eKeyCode = e.keyCode;
                var thisVal = this.value;
                if ((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || eKeyCode === 110 || eKeyCode === 190 || eKeyCode === 8 || eKeyCode === 108 || eKeyCode === 46) {
                    if (!(thisVal.indexOf('.') === 0)) {
                        if (parseFloat(thisVal) > 99.9) {
                            this.value = 99.9;
                        } else {
                            if ((thisVal.indexOf('.') !== -1) && (thisVal.indexOf('.') !== thisVal.lastIndexOf('.'))) {
                                this.value = thisVal.substring(0, thisVal.lastIndexOf('.'));
                            }
                            if (thisVal.length >= 4 && (thisVal.indexOf('.') !== -1)) {
                                this.value = thisVal.substring(0, thisVal.indexOf('.') + 2);
                            }
                        }
                    } else {
                        this.value = 1;
                    }

                } else {
                    if (!Number(thisVal)) {
                        this.value = score;
                    } else {
                        this.value = thisVal;
                        score = thisVal;
                    }
                    return false;
                }
            }).keydown(function (e) {
                var e = e || window.event;
                var eKeyCode = e.keyCode;
                var thisVal = this.value;
                if (!((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || eKeyCode === 110 || eKeyCode === 190 || eKeyCode === 8 || eKeyCode === 108 || eKeyCode === 46)) {
                    if (!Number(thisVal)) {
                        this.value = score;
                    } else {
                        this.value = thisVal;
                        score = thisVal;
                    }

                    return false;
                }
            }).blur(function (e) {
                var e = e || window.event;
                var eKeyCode = e.keyCode;
                var thisVal = this.value;
                if ((thisVal.indexOf('0') === 0 && thisVal.indexOf('.') !== 1)) {
                    this.value = thisVal.substring(1);
                }
                if ((thisVal.indexOf('.') === 1 && thisVal.length === 2)) {
                    this.value = 1;
                }
                if (!Number(thisVal) || thisVal === 0) {
                    this.value = 1;
                }
            });
        },
        initUeScript: function (template, flag) {
            for (var i = 0; i < 4; i++) {
                var beforeLast = $('.pe-question-item-rich-wrap').find('.pe-rich-text-wrap').last();
                var first = i === 0;
                var last = i === 3;
                var containerDom = 'container' + i + flag;
                beforeLast.after(_.template($('#' + template).html())({
                    containerDom: containerDom,
                    first: first,
                    last: last,
                    subscript: '选项' + subscriptMap[i]
                }));
                itemPage.renderUedit(containerDom, '选项' + subscriptMap[i], '');
            }
        },

        typeTabChange: function (chooseType) {
            var thisContainer = $('.pe-add-question-single-container');
            var beforeLast = $('.pe-question-item-rich-wrap').find('.pe-rich-text-wrap').last();
            $('.option-text-wrap').remove();
            if (chooseType === 'JUDGMENT') {
                beforeLast.after(_.template($('#judgeTemp').html())({}));
                thisContainer.find('.pe-add-question-tip').html('(判断题干中描述内容是正确或者错误)');
                $('input[name="type"]').val('JUDGMENT');
                $('.pe-add-rich-area-btn').css({'display': 'none'});
                PEBASE.peFormEvent('radio');
            } else if (chooseType === 'FILL') {
                beforeLast.after(_.template($('#fillTemp').html())({}));
                $('input[name="type"]').val('FILL');
                $('.pe-add-rich-area-btn').css({'display': 'none'});
            } else if (chooseType === 'QUESTIONS') {
                beforeLast.after(_.template($('#questionTemp').html())({}));
                thisContainer.find('.pe-add-question-tip').html('(判断题干中描述内容是正确或者错误)');
                $('input[name="type"]').val('QUESTIONS');
                $('.pe-add-rich-area-btn').css({'display': 'none'});
            }
        },

        renderUedit: function (name, selfLeftContent, frameContent) {
            //渲染简单富文本编辑器;
            $('#' + name).peEditor({
                name: name,
                initFrameWidth: 788,
                initFrameHeight: 122,
                toolLeftContent: selfLeftContent,
                baseUrl: pageContext.rootPath,
                imageUrl: '',
                videoUrl: '',
                audioUrl: '',
                initContent: frameContent,
                toolBar: [['image', 'video', 'music', 'magnify']],
                onLoad: function (d, t) {
                    var afterRenderEditorDom = $(d.peEditor);
                    var ua = navigator.userAgent.toLowerCase();
                    var s = ua.match(/msie ([\d.]+)/);
                    if (s && parseInt(s[1]) == 9) {
                        $.fn.ieChangeListen = function () {
                            return this.each(function () {
                                var $this = $(this);
                                var htmlold = $this.html();
                                $this.bind('blur keyup paste copy cut mouseup', function () {
                                    var htmlnew = $this.html();
                                    if (htmlold !== htmlnew) {
                                        eidtorContetnChange($(this));
                                    }
                                })
                            })
                        }
                        $(afterRenderEditorDom).ieChangeListen();
                    } else {
                        $(afterRenderEditorDom)[0].oninput = $(afterRenderEditorDom)[0].onpropertychange = function (e) {
                            var e = e || window.event;
                            eidtorContetnChange($(this));
                        };
                    }
                }
            });
        },

        getIos: function (ic, type) {
            var ios = [];
            var currentNum = 0;
            $('.option-text-wrap').each(function (index, optionDom) {
                var idDom = $(optionDom).find('.option').attr('id');
                var hasContent = $('#' + idDom).peEditor('hasContent');
                if (!hasContent) {
                    return;
                }

                var io = {};
                io.ct = $('#' + idDom).peEditor('getContent');
                var answer;
                if (type === 'SINGLE_SELECTION') {
                    answer = $('#' + idDom).parents('.pe-rich-text-wrap').find('.icon-checked-radio').hasClass('peChecked');
                } else {
                    answer = $('#' + idDom).parents('.pe-rich-text-wrap').find('.icon-checked-checkbox').hasClass('peChecked');
                }

                if (answer) {
                    io.t = true;
                    currentNum = currentNum + 1;
                }

                ios.push(io);
            });

            if (ios.length < 2) {
                return "至少2个选项！";
            }

            if (currentNum === 0) {
                return "至少有一个选项是正确答案！";
            }

            if (type === 'SINGLE_SELECTION' && currentNum != 1) {
                return "只有一个选项是正确答案！";
            }

            if (type === 'MULTI_SELECTION' && currentNum < 2) {
                return "至少有两个选项是正确答案！";
            }

            ic.ios = ios;
        }
    };

    //富文本编辑器内容动态变化调用方法
    function eidtorContetnChange(eidtorDom) {
        if ($(eidtorDom).attr('id') === 'containerMoreMsg') {
            return false;
        }
        if ($('.pe-add-fill').hasClass('curType')) {
            var eidtorContent = eidtorDom.peEditor('getContent');
            var blanReg = /name="insertPeSimpleBlankValueByTomFill\d+"/ig;
            var matchArray = eidtorContent.match(blanReg);
            if (matchOldArray && matchArray && matchArray.length !== 0) {
                if (matchArray.length !== matchOldArray.length) {
                    var fillAnswerDom = $('.fill-item-true-answer-wrap').find('.pe-question-label');
                    var isHasMatch = 0;
                    for (var i = 0, iLen = fillAnswerDom.length; i < iLen; i++) {
                        for (var j = 0, jLen = matchArray.length; j < jLen; j++) {
                            if (matchArray[j].indexOf($(fillAnswerDom[i]).attr('data-index')) > 0) {
                                isHasMatch++;
                            }
                        }
                        if (isHasMatch) {
                            isHasMatch = 0;
                        } else {
                            $(fillAnswerDom[i]).remove();
                            var newFillAnswer = $('.fill-item-true-answer-wrap').find('.pe-question-label');
                        }
                    }
                    for (var k = 0, kLen = newFillAnswer.length; k < kLen; k++) {
                        $(newFillAnswer[k]).find('.pe-input-tree-text').html('填空' + (k + 1) + ':');
                        $(newFillAnswer[k]).find('.pe-stand-filter-form-input').attr('name', 'fillItemAnswer' + (k + 1));
                    }
                    iLen--;
                }
            } else if (!matchArray) {
                $('.fill-item-true-answer-wrap').find('.pe-question-label').remove();
            }
            matchOldArray = matchArray;
        }
    }

    /*填空题添加空格函数*/
    function fillAddBlank() {
        var hasFillAnswerNum = $('.fill-item-true-answer-wrap').find('.pe-question-label').length + 1;
        if (hasFillAnswerNum > 20) {
            PEMO.DIALOG.tips({
                content: '最多添加20个空格'
            });
            return false;
        } else {
            /*此处的inputDom包括其属性等都要在ueditor的config.js中添加到过滤的白名单中(whitList)，否则无效;*/
            var inputDom = '<input type="text" data-index="fill' + hasFillAnswerNum + '" class="insert-blank-item" readonly="true" name="" data-name="insertPeSimpleBlankValueByTomFill' + hasFillAnswerNum + '" style="border:none;border-bottom: 1px solid #333;margin-right:6px;color:#6d9ed9;width:100px;"/>';
            $('#containerContent').peEditor('insertHtml', inputDom);
            $('.fill-item-true-answer-wrap').append(_.template($('#fillAnswerTemplate').html())({data: {index: hasFillAnswerNum}}));
            var eidtorContent = $('#containerContent').peEditor('getContent');
            var blanReg = /name="insertPeSimpleBlankValueByTomFill\d+"/ig;
            matchOldArray = eidtorContent.match(blanReg);
        }
    }


    function findFillInputAddName(){
        var fillContent = $('#containerContent').peEditor('getContent');
        var matchFill = fillContent.split('<input type="text" class="insert-blank-item" readonly="true">');
        var newFillStr = '';
        for(var j=0,jLen = matchFill.length -1;j < jLen; j++){
            var newInputName = '<input type="text" data-index="fill'+ (j +1)+'" class="insert-blank-item" readonly="true"  name="insertPeSimpleBlankValueByTomFill'+ (j+1) +'" />';
            newFillStr += matchFill[j] + newInputName;
        }
        if(newFillStr){
            $('#containerContent').peEditor('setContent',newFillStr);
        }
    }
    $(function () {
                itemPage.bind();
                PEBASE.ajaxRequest({
                    url: '${ctx!}/ems/exam/manage/getItemDetail',
                    data: {paperId: '${(paperId)!}', itemId: '${(itemId)!}'},
                    success: function (data) {
                        if(!data){
                            return false;
                        }

                        var ic = data;
                        $('input[name="m"]').val(ic.m);
                        itemPage.renderUedit('containerMoreMsg', '试题解析', ic.ep);
                        itemPage.renderUedit('containerContent', '题干内容', ic.ct);
                        if ('${(itemType)!}' === 'JUDGMENT') {
                            itemPage.typeTabChange('JUDGMENT');
                            $('.judgeAnswer').each(function (index, ele) {
                                $(this).find('input[name="judgeAnswer"]').removeProp('checked');
                                var hasClass = $(this).find('.iconfont').hasClass('icon-checked-radio');
                                if (hasClass) {
                                    $(this).find('.iconfont').addClass('icon-unchecked-radio');
                                    $(this).find('.iconfont').removeClass('icon-checked-radio');
                                }
                            });
                            var judgeAnswerDom = $('.judgeAnswer');
                            var icT = ic.t;
                            if (icT) {
                                $(judgeAnswerDom[0]).find('input[name="judgeAnswer"]').prop('checked', 'checked');
                                $(judgeAnswerDom[0]).find('.iconfont').addClass('icon-checked-radio');
                            } else {
                                $(judgeAnswerDom[1]).find('input[name="judgeAnswer"]').prop('checked', 'checked');
                                $(judgeAnswerDom[1]).find('.iconfont').addClass('icon-checked-radio');
                            }

                        } else if ('${(itemType)!}' === 'FILL') {
                            itemPage.typeTabChange('FILL');
                            $('.pe-question-fill-rich-wrap').html(_.template($('#fillTemp').html())({}));
                            $.each(ic.a.split('|'), function (i, v) {
                                $('.fill-item-true-answer-wrap').append(_.template($('#fillAnswerTemplate').html())({
                                    data: {
                                        index: (i + 1),
                                        a: v
                                    }
                                }));
                            });
                            $('#containerContent .insert-fill-blank').show();
                            $('.pe-add-rich-area-btn').hide();
                            findFillInputAddName();
                            var editStateEidtorContent = $('#containerContent').peEditor('getContent'),
                                    blanReg = /name="insertPeSimpleBlankValueByTomFill\d+"/ig,
                                    editStateMatchArray = editStateEidtorContent.match(blanReg);
                            matchOldArray = editStateMatchArray;
                            $('.insert-fill-blank').click(function () {
                                fillAddBlank();
                            });
                        } else if ('${(itemType)!}' === 'QUESTIONS') {
                            itemPage.typeTabChange('QUESTIONS');
                            $('.pe-add-question-text-answer').val(ic.a);
                        } else if (ic.ios && ic.ios.length > 0) {
                            if(ic.ios.length >=10){
                                $('.pe-add-rich-area-btn').hide();
                            }

                            $.each(ic.ios, function (i, ios) {
                                var beforeLast = $('.pe-question-item-rich-wrap').find('.pe-rich-text-wrap').last(),
                                        index = parseInt(i),
                                        first = index === 0,
                                        last = index === parseInt(ic.ios.length) - 1,
                                        containerDom = 'container' + index + '${(itemType)!}',
                                        checkedDom = 'icon-unchecked-radio',
                                        addClass = 'icon-checked-radio',
                                        template = 'radioTemp';
                                if ('${(itemType)!}' !== 'SINGLE_SELECTION') {
                                    template = 'checkboxTemp';
                                    checkedDom = 'icon-unchecked-checkbox';
                                    addClass = 'icon-checked-checkbox';
                                }

                                beforeLast.after(_.template($('#' + template).html())({
                                    containerDom: containerDom,
                                    first: first,
                                    last: last,
                                    subscript: '选项' + subscriptMap[index]
                                }));

                                itemPage.renderUedit(containerDom, '选项' + subscriptMap[index], ios.ct);
                                var t = ios.t;
                                if (t) {
                                    $('#' + containerDom).parents('.pe-rich-text-wrap').find('.' + checkedDom).addClass('peChecked');
                                    $('#' + containerDom).parents('.pe-rich-text-wrap').find('.' + checkedDom).addClass(addClass);
                                    $('#' + containerDom).parents('.pe-rich-text-wrap').find('.' + checkedDom).removeClass(checkedDom);
                                    $('#' + containerDom).parents('.pe-rich-text-wrap').find('input[name="answer"]').prop('checked', 'checked');
                                }
                            });
                        }
                        PEBASE.peFormEvent('checkbox');
                        PEBASE.peFormEvent('radio');
                    }
                });
            }
    )
</script>
</body>