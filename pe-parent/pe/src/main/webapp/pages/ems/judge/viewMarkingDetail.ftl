<#assign ctx=request.contextPath/>
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
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
        <div class="pe-complete-left view-marking-detail">
            <h2 class="pe-answer-title pe-marking-title">${(exam.examName)!}</h2>
            <#if user?? && user.userName??>
                <div class="pe-marking-item over-flow-hide">
                    <div class="floatL">
                        <span class="pe-marking-wrap" style="padding-left:0;">姓名：&nbsp;</span>
                        <span style="color:#666;" title="${(user.userName)!}">${(user.userName)!}</span>
                    </div>
                    <#if user.idCard??>
                        <div class="floatL">
                            <span class="pe-marking-wrap">身份证号：&nbsp;</span>
                            <span style="color:#666;" title="${(user.idCard)!}">${(user.idCard)!}</span>
                        </div>
                    </#if>
                    <div class="floatL">
                        <span class="pe-marking-wrap">部门：&nbsp;</span>
                        <span style="color:#666;" title="${(user.organize.organizeName)!}">${(user.organize.organizeName)!}</span>
                    </div>
                    <#if user.positionName??>
                        <div class="floatL">
                            <span class="pe-marking-wrap floatL">岗位：&nbsp;</span>
                            <span style="color:#666;" class="pe-viewing-job floatL" title="${(user.positionName)!}">${(user.positionName)!}</span>
                        </div>
                    </#if>
                </div>
            </#if>
        </div>
        <div class="pe-complete-right">
            <a class="pe-for-check floatR" target="_blank"
               href="${ctx!}/ems/examMonitor/manage/initDetail?examId=${(exam.id)!}&userId=${(user.id)!}"><i
                    class="iconfont icon-preview"></i>查看监控详情</a>
            <#--<a class="pe-for-check floatR"><i class="iconfont icon-preview"></i>查看监控详情</a>-->
        </div>
    </div>
    <div class="pe-for-container">
        <div class="pe-for-con">
            <#list ['FILL','QUESTIONS'] as itemType>
                <#assign paperContent=examResult.paper.paperContent.prm/>
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
                                            <span class="text-red pe-view-score">${(userExamRecordMap[ic.id].realScore)!}</span>
                                            <#if reviewJuRecord?? && userExamRecordMap[ic.id].realScore != markJuRecord.markDetail.m[ic.id].rs>
                                                <span class="pe-view-tip"><i class="iconfont">
                                                    &#xe640;</i>${(markJuRecord.markUser.userName)!}对该题的评分是 <span style="font-weight: bolder;">${(markJuRecord.markDetail.m[ic.id].rs)!}</span> 分，管理员 : ${(reviewJuRecord.markUser.userName)!} 对该题进行了复评，最终得分 <span style="font-weight: bolder;">${(userExamRecordMap[ic.id].realScore)}</span> 分</span>
                                            </#if>
                                        </p>
                                        <div class="paper-question-stem pe-for-stem">
                                            <span class="pe-question-score">(${(ic.m)!'0'}分）</span>
                                            <div class="paper-item-detail-stem" <#if itemType == 'FILL'>data-answer="${(userExamRecordMap[ic.id].answer)!}"</#if>>
                                                ${(ic.ct)!}
                                                    <#if ic.ctImgUrls?? && (ic.ctImgUrls?size>0)>
                                                        <ul class="image-small-icon-wrap">
                                                            <#list ic.ctImgUrls as ctImgUrl>
                                                                <li class="icon-picture-icon iconfont content-image-icon" data-index="content${ctImgUrl_index}"></li>
                                                            </#list>
                                                        </ul>
                                                    </#if>
                                            </div>
                                            <div class="all-images-wrap all-images-wrap0">
                                                <div class="swiper-container">
                                                    <ul class="itemImageViewWrap swiper-wrapper">
                                                    <#--题干的图片部分-->
                                                        <#if ic.ctImgUrls?? && (ic.ctImgUrls?size>0)>
                                                            <#list ic.ctImgUrls as ctImgUrl>
                                                                <li class="pe-view-question-detail-img-wrap over-flow-hide swiper-slide" data-index="content${ctImgUrl_index}" style="display:inline-block;">
                                                                    <img class="pe-question-detail-img-item" data-original="${(ctImgUrl)!}"  src="${(ctImgUrl)!}" width="auto" height = "125px"/>
                                                                </li>
                                                            </#list>
                                                        </#if>
                                                        <div class="pagination"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <#if itemType != 'FILL'>
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
        </div>
    </div>
    <div class="pe-for-total">
        <dl class="pe-view-item">
            <dt class="pe-view-final">该考生最终成绩：</dt>
            <dd class="pe-view-num pe-view-score-con"><span
                    class="text-red pe-view-get-score">${(examResult.score)!'0'}&nbsp;</span>分
            </dd>
        </dl>
        <dl class="clear"></dl>
        <dl class="pe-view-item">
            <#if markJuRecord.season??>
                <dt>${(markJuRecord.createTime?string("yyyy-MM-dd HH:mm"))!}</dt></#if>
            <dd class="pe-view-num">
                <div><#if markJuRecord.season??>系统自动折合成绩原为 ${(markJuRecord.markDetail.s!0 + objectiveMark!0)!} 分，</#if>
                    其中主观题 ${(markJuRecord.markDetail.s)!''} 分，客观题 ${(objectiveMark)!'0'} 分</div>
                <#if markJuRecord.season??>
                    <div>${(markJuRecord.markUser.userName)!} 将成绩修改成 ${(markJuRecord.score)}
                        分，理由：${(markJuRecord.season)!}</div>
                </#if>
            </dd>
        </dl>
        <#if reviewJuRecord?? && reviewJuRecord.markUser?? && reviewJuRecord.markUser.userName??>
            <dl class="clear"></dl>
            <dl class="pe-view-item">
                <dt>${(reviewJuRecord.createTime?string("yyyy-MM-dd HH:mm"))!}</dt>
                <dd class="pe-view-num">${(reviewJuRecord.markUser.userName)!} 进行了复评，考试成绩变为<span
                        class="text-red pe-view-eight">${(examResult.score)!'0'}</span>分
                </dd>
            </dl>
            <dl class="clear"></dl>
        </#if>
    </div>
    <div class="pe-for-btn">
        <#if isHasPre>
            <button type="button" class="pe-btn pe-btn-purple pe-for-continue">上一份</button>
        </#if>
        <#if isHasNext>
            <button type="button" class="pe-btn pe-btn-blue pe-for-submit">下一份</button>
        </#if>
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
<script>
    $(function () {
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

        $('.pe-for-item-wrap').each(function(i,wrapDom){
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
                PEBASE.swiperInitItem($('body'),i+1,true);
            }
        }
        var viewMarking = {
            page: '${(page)!'2'}',
            examId : '${(exam.id)!''}',
            init: function () {
                var _this = this;
                _this.bind();
            },

            bind: function () {
                var _this = this;
                $('.pe-btn-purple').on('click',function(){
                    var page = parseInt(_this.page) -1;
                    location.href = pageContext.rootPath+"/ems/judge/manage/initViewMarkingPage?examId="+_this.examId+"&page="+page;
                });

                $('.pe-btn-blue').on('click',function(){
                    var page = parseInt(_this.page) +1;
                    location.href = pageContext.rootPath+"/ems/judge/manage/initViewMarkingPage?examId="+_this.examId+"&page="+page;
                });

                $('.pe-for-close').on('click',function(){
                    window.close();
                });

            }
        };

        viewMarking.init();
    });
</script>
</@p.pageFrame>