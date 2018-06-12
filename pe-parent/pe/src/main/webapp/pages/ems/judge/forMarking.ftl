<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
    <#assign ctx=request.contextPath/>
<#--评卷头部-->
<div class="pe-public-top-nav-header">
    <div class="pe-detail-top-head over-flow-hide">
        <div class="pe-top-nav-container">
            <h2 class="pe-for-grading">评卷</h2>
            <div class="pe-for-item">
                <dl class="pe-for-item-con">
                    <dt>已评:</dt>
                    <dd><span class="text-orange pe-for-text">${(exam.markedPaperCount)!'0'}</span>份试卷</dd>
                </dl>
                <dl>
                    <dt>待评:</dt>
                    <dd><span class="text-orange pe-for-text">${(exam.waitPaperCount)!'0'}</span>份试卷</dd>
                </dl>
            </div>
        </div>
    </div>
</div>
<div class="pe-container-main for-marking-paper">

    <div class="pe-for-nav-top">
        <div class="pe-complete-left" style="width:70%">
            <h2 class="pe-answer-title pe-marking-title">${(exam.examName)!}</h2>
            <#if user?? && user.userName??>
                <div class="pe-marking-item over-flow-hide">
                    <div class="floatL">
                        <span class="pe-marking-wrap" style="padding-left:0;">姓名：&nbsp;</span>
                        <span style="color:#666;">${(user.userName)}</span>
                    </div>
                    <#if user.idCard??>
                        <div class="floatL">
                            <span class="pe-marking-wrap">身份证号：&nbsp;</span>
                            <span style="color:#666;">${(user.idCard)!}</span>
                        </div>
                    </#if>
                    <div class="floatL">
                        <span class="pe-marking-wrap">部门：&nbsp;</span>
                        <span style="color:#666;">${(user.organize.organizeName)!}</span>
                    </div>
                    <#if user.positionName??>
                        <div class="floatL">
                            <span class="pe-marking-wrap floatL">岗位：&nbsp;</span>
                            <span class="pe-viewing-job floatL" title="${(user.positionName)!}" style="color:#666;">${(user.positionName)!}</span>
                        </div>
                    </#if>
                </div>
            </#if>
        </div>
        <#if js.vi??&&js.vi>
        <div class="pe-complete-right">
            <a class="pe-for-check floatR" target="_blank"
               href="${ctx!}/ems/examMonitor/manage/initDetail?examId=${(exam.id)!}&userId=${(user.id)!}"><i
                    class="iconfont icon-preview"></i>查看监控详情</a>
        </div>
        </#if>
    </div>
    <div class="pe-for-container">
        <div class="pe-for-con">
            <form id="forMarkForm">
                <input type="hidden" name="exam.id" value="${(exam.id)!}"/>
                <input type="hidden" name="user.id" value="${(user.id)!}"/>
                <#list ['FILL','QUESTIONS'] as itemType>
                    <#if paperContent?? && paperContent[itemType]?? >
                        <#assign pr = paperContent[itemType]/>
                        <div class="pe-paper-preview-content pe-for-preview">
                            <div class="pe-question-top-head">
                                <h2 class="pe-question-head-text">
                                    <a href="javascript:;" class="anchor" name="single"></a>
                                    <#if itemType == 'FILL'>填空题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：在对应的空格中填写答案。）<#elseif itemType == 'QUESTIONS'>问答题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：在输入框中填写答案。）</#if>
                                </h2>
                            </div>
                            <#list pr.ics as ic>
                                <div class="pe-for-item-wrap">
                                    <div class="paper-add-question-content">
                                        <div class="pe-for-question-stem">
                                            <p class="pe-for-get">
                                                <label>得分：</label>
                                                <input class="pe-for-score" name="markScoreMap[${(ic.id)}]"
                                                       data-mark="${(ic.m)!'0'}"/>
                                            </p>
                                            <div class="paper-question-stem pe-for-stem">
                                                <span class="pe-question-score">(${(ic.m)!'0'}分）</span>
                                                <div class="paper-item-detail-stem"
                                                     <#if itemType == 'FILL'>data-answer="${(userExamRecordMap[ic.id].answer)!}"</#if>>${(ic.ct)!}</div>
                                                <div class="all-images-wrap">
                                                    <div class="swiper-container">
                                                        <ul class="itemImageViewWrap swiper-wrapper">
                                                        </ul>
                                                        <div class="pagination"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <#if itemType == 'QUESTIONS'>
                                                <p class="pe-for-question">
                                                    <label>考生答案：</label>
                                                <textarea placeholder=""
                                                          disabled="disabled">${(userExamRecordMap[ic.id].answer)!}</textarea>
                                                </p>
                                            </#if>
                                            <p class="pe-for-key">正确答案：${(ic.a)!}</p>
                                        </div>
                                    </div>
                                </div>
                            </#list>
                        </div>
                    </#if>
                </#list>
            </form>
            <div class="pe-for-total">
                <dl>
                    <dt>系统折合成绩：</dt>
                    <dd><span class="text-orange convert-item-mark">${(objectiveMark)!'0'}</span>（满分：<span
                            class="convert-total-mark">${(convertTotalMark)!'0'}</span>）
                    </dd>
                </dl>
                <dl class="pe-for-subject">
                    <dt>主观题得分：</dt>
                    <dd><span class="text-orange subjective-item-mark">0</span>，</dd>
                </dl>
                <dl>
                    <dt>客观题得分：</dt>
                    <dd><span class="text-orange objective-item-mark">${(objectiveMark)!'0'}</span></dd>
                </dl>
            </div>
        </div>
    </div>
    <div class="pe-for-btn">
    <#--<button type="button" class="pe-btn pe-btn-purple pe-for-continue">提交并继续</button>-->
        <button type="button" class="pe-btn pe-btn-blue pe-for-submit">提交</button>
        <button type="button" class="pe-btn pe-for-close pe-btn-white">关闭</button>
    </div>
</div>
<script type="text/template" id="imageTemp">
    <%_.each(data,function(imageUrl,index){%>
    <li class="pe-view-question-detail-img-wrap swiper-slide over-flow-hide" data-index="<%=index%>"
        style="display:inline-block;">
        <img class="pe-question-detail-img-item" data-original="<%=imageUrl%>" src="<%=imageUrl%>" width="auto"
             height="100%"/>
    </li>
    <%});%>
</script>
<script type="text/template" id="submitMarkingTemp">
    <p>试卷最终折合成绩&nbsp;<input value="<%=convertMark%>" name="score" data-total="${(convertTotalMark)!'0'}" class="pe-forMark-submit-input forMark-convert"/>&nbsp;分，确认提交吗？
    </p>
    <p class="update-reason" style="margin-top: 15px;display: none;" class=""><span
            style="color: red;">*</span>修改理由：<input class="pe-forMark-submit-input" name="season" maxlength="50"
                                                    style="width: 230px;"/></p>
</script>
<script>
    $(function () {
        $('.pe-for-item-wrap').each(function (i, wrapDom) {
            var imageUrls = [];
            $(wrapDom).find('img.upload-img').each(function (i, e) {
                imageUrls.push($(e).data('src'));
                $(e).attr('data-index', i);
            });

            var imagesWrap = $(wrapDom).find('.all-images-wrap');
            if (imageUrls.length > 0) {
                $(wrapDom).find('.itemImageViewWrap').html(_.template($('#imageTemp').html())({data: imageUrls}));
                imagesWrap.show();
            }
        });

        var imagesWrap = $('.all-images-wrap');
        for (var i = 0, ILen = imagesWrap.length; i < ILen; i++) {
            $(imagesWrap[i]).addClass('all-images-wrap' + (i + 1)).attr('data-index', i + 1);
            if (!$(imagesWrap[i]).find('.swiper-wrapper img').get(0)) {
                $(imagesWrap[i]).hide();
            } else {
                $(imagesWrap[i]).find('.swiper-wrapper').css('transform', 'translate3d(0px, 0px, 0px)');
                $(imagesWrap[i]).find('.swiper-wrapper').css('-webkit-transform', 'translate3d(0px, 0px, 0px)');
                PEBASE.swiperInitItem($('body'), i + 1);
            }
        }
        var userId = '${(user.id)!}', examId = '${(exam.id)!}', totalMark = '${(totalMark)!}';
        var forMarking = {
            init: function () {
                var _this = this;
                _this.bind();
                _this.initData();
            },

            initData: function () {
                $('.paper-item-detail-stem').each(function (i, e) {
                    var answer = $(e).data('answer');
                    if (!answer) {
                        return;
                    }

                    var answerStr = answer.toString().split('|');
                    for (var i = 0; i < answerStr.length; i++) {
                        $(e).find('.insert-blank-item:eq(' + i + ')').val(answerStr[i]);
                    }
                });
            },

            bind: function () {
                var _this = this;
                //视频
                $('.image-video').on('click', function () {
                    var thisVideoSrc = $(this).attr('data-src');
                    PEMO.VIDEOPLAYER(thisVideoSrc);
                });
                //音频
                $('.image-audio').on('click', function (e) {
                    var _this = $(this);
                    if($('.image-audio').not(_this).hasClass('audio-playing') || $('.image-audio').not($(this)).hasClass('audio-pause')){
                        PEMO.AUDIOOBJ.obj.player_.pause();
//                PEMO.AUDIOOBJ.oldSrc = '';
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

                $('.pe-for-close').on('click', function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + "/ems/judge/manage/deleteMarkRecord",
                        data: {examId: examId},
                        success: function () {
                            localStorage.setItem("EXAM_FOR_MARKING_USER", userId);
                            window.close();
                        }
                    });
                });

                $('.pe-for-score').on('blur', function () {
                    var itemMark = $(this).data('mark'), mark = $(this).val(), convertMark = $('.convert-total-mark').text(), subTotalMark = 0;
                    if (!mark) {
                        return false;
                    }
                    mark = mark.replace(/\b(0+)/gi, "");
                    var point = mark.substr(0, 1);
                    if (point === ".") {
                        mark = "0" + mark;
                    }
                    mark = _this.formatNumber(mark);
                    if (mark > itemMark) {
                        mark = itemMark;
                    }

                    $(this).val(mark);
                    $('.pe-for-score').each(function (index, ele) {
                        var m = $(ele).val();
                        if (m) {
                            subTotalMark += Number(m);
                        }
                    });

                    subTotalMark = _this.formatNumber((subTotalMark * Number(convertMark)) / totalMark);
                    $('.subjective-item-mark').text(subTotalMark);
                    subTotalMark = Number(subTotalMark) + Number($('.objective-item-mark').text());
                    $('.convert-item-mark').text(parseFloat(subTotalMark).toFixed(1));
                });

                $('.pe-for-submit').on('click', function () {
                    var noMarkCount = 0, convertMark = $('.convert-item-mark').text();
                    $('.pe-for-score').each(function (index, ele) {
                        var m = $(ele).val();
                        if (!m) {
                            noMarkCount++;
                        }
                    });

                    if (noMarkCount > 0) {
                        PEMO.DIALOG.alert({
                            content: '<p>当前试卷还有<strong style="color: red;">' + noMarkCount + '</strong>道题未评，</p><p>请确保所有试题走评阅完毕后再提交！</p>',
                            btn: ['继续评卷'],
                            yes: function (shiIndex) {
                                layer.close(shiIndex);
                            }
                        });

                        return false;
                    }

                    if (Number(convertMark) > 100) {
                        convertMark = 100;
                    }

                    PEMO.DIALOG.confirmR({
                        content: _.template($('#submitMarkingTemp').html())({convertMark: convertMark}),
                        btn1: function () {
                            layer.closeAll();
                        },
                        btn2: function (shiIndex) {
                            var isUpdate = _this.validateUpdateMark($('input[name="score"]').val());
                            if (isUpdate && !($('input[name="season"]').val())) {
                                $('.update-reason').show();
                                return false;
                            }

                            var params = {
                                score: $('input[name="score"]').val(),
                                season: $('input[name="season"]').val()
                            };
                            _this.submitForm(params);
                        }
                    });
                });

                $('body').delegate('.forMark-convert', 'blur', function () {
                    var currentVal = $(this).val();
                    if(!currentVal || parseInt(currentVal) < 0){
                        currentVal = 0;
                    }

                    var totalScore = $(this).data('total');
                    if(totalScore && parseInt(currentVal) > parseInt(totalScore)){
                        currentVal = totalScore;
                    }

                    $(this).val(currentVal);
                    var isUpdate = _this.validateUpdateMark($(this).val());
                    $('input[name="season"]').text('');
                    if (!isUpdate) {
                        $('.update-reason').hide();
                        return false;
                    }

                    $('.update-reason').show();
                });
//                PEBASE.swiperInitItem($('body'));
            },

            submitForm: function (params) {
                params['exam.id'] = examId;
                params['user.id'] = userId;
                var formData = PEBASE.serializeObject($('#forMarkForm'));
                params = $.extend(false, formData, params);
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/judge/manage/submitMarkExam',
                    data: params,
                    success: function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '完成评卷',
                                time: 2000,
                                end: function () {
                                    localStorage.setItem("EXAM_FOR_MARKING_USER", userId);
                                    window.close();
                                }
                            });

                            return false;
                        }

                        if (data.data) {
                            PEMO.DIALOG.alert({
                                content: '试卷已被【' + data.data.markUser.userName + '】评过，最终折合成绩：' + data.data.score + '分。',
                                btn: ['我知道了'],
                                yes: function (shiIndex) {
                                    layer.close(shiIndex);
                                }
                            });

                            return false;
                        }

                        PEMO.DIALOG.alert({
                            content: '出现异常，请重新提交评卷信息。',
                            btn: ['我知道了'],
                            yes: function (shiIndex) {
                                layer.close(shiIndex);
                            }
                        });
                    }
                });
            },

            validateUpdateMark: function (updateMark) {
                if (!updateMark) {
                    $('.forMark-convert').val(0);
                    updateMark = 0;
                }

                var convertMark = $('.convert-item-mark').text();
                return Number(updateMark) != Number(convertMark);
            },

            formatNumber: function (mark) {
                var reg = /^\d+$/;
                var regFloat = /^\d+.?\d*$/;
                if (reg.test(mark)) {
                    return mark;
                } else if (regFloat.test(mark)) {
                    return String(mark).split('.')[0] + '.' + String(mark).split('.')[1].substr(0, 1);
                }

                return 0;
            }
        };

        forMarking.init();
    });
</script>
</@p.pageFrame>