<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">成绩</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">发布成绩</li>
        <li class="pe-viewing-warn floatR">*显示所有发布中的考试，依据设置的规则，分为自动发布和手动发布；必须是评卷后才能发布成绩。</li>
    </ul>
</div>
<div class="pe-paper-manage-all-wrap pe-publish-result-wrap">
    <div class="pe-manage-panel-head pe-viewing-header">
        <label class="pe-form-label floatL" for="peMainKeyText">
            <span class="pe-label-name floatL">关键字:</span>
            <input class="pe-stand-filter-form-input" type="text" placeholder="考试名称/编号" name="keyword">
        </label>
        <button type="button" class="pe-btn pe-btn-blue pe-viewing-btn">筛选</button>
    </div>
    <div class="pe-recent-content pe-viewing-contain">
    <#--<div class="node-search-empty">暂无</div>-->
    </div>
    <div class="pe-no-candidate-view" style="display:none;">
        <#--<div class="pe-result-no-date"></div>-->
        <p class="pe-dynamic-empty" style="height:20px;"></p>
        <p class="pe-result-date-warn" style="text-align:center;padding-bottom:60px;">暂无数据</p>
    </div>
    <button type="button" class="pe-btn pe-btn-primary go-top-btn iconfont icon-go-top" style="display:none;"></button>
</div>
<script type="text/template" id="releaseResultTemp">
    <ul>
        <%_.each(data,function(exam,index){ if(data==null || data.length === 0){%>
        <li>
            <div class="pe-result-no-date"></div>
            <p class="pe-dynamic-empty"></p>
            <p class="pe-result-date-warn">暂无数据</p>
        </li>

        <%}else if (exam.examType === 'COMPREHENSIVE'){%>
        <li>
            <div class="pe-recent-item-left">
                <div>
                    <h2 class="pe-recent-title"><%=exam.examName%></h2>
                    <p class="pe-recent-time pe-viewing-num">考试编号：<%=exam.examCode%></p>
                </div>
            </div>
            <div class="pe-viewing-item-right recent-exam-tip-wrap">
                <%if (exam.examSetting && exam.examSetting.scoreSetting.spt === 'SUBJECT_AUTO_PUBLISH') {%>
                <div class="pe-viewing-ing"><em class="pe-viewing-publish">所有科目的成绩全部发布后，自动发布综合考试的成绩</em></div>
                <%} else {%>
                <@authVerify authCode="VERSION_OF_PUBLISH_RESULT_BTN">
                    <div class="pe-recent-test pe-viewing-test">
                        <button type="button" class="pe-answer-sure-btn" style="margin-top:30px;" data-id="<%=exam.id%>"
                        <%if (exam.releaseCount === 0) {%>disabled="disabled"<%}%>>
                        发布成绩
                        </button>
                    </div>
                </@authVerify>
                <div class="pe-viewing-border"></div>
                <div class="pe-viewing-ing">
                    <%if (exam.examSetting && exam.examSetting.scoreSetting.spt === 'SUBJECT_EXAM_TOGETHER') {%>
                    <em class="pe-viewing-publish" style="display:none;">综合成绩和各科目的成绩一起发布</em>
                    <i class="publish-tip-round iconfont icon-much-inf"></i>
                    <%} else if (exam.examSetting && exam.examSetting.scoreSetting.spt === 'SUBJECT_MANUAL') {%>
                    <em class="pe-viewing-publish" style="display:none;">所有科目的成绩全部发布后，需要手动发布综合成绩</em>
                    <i class="publish-tip-round iconfont icon-much-inf"></i>
                    <%}%>
                    <#--感叹号提示标识-->
                    <em>可发布成绩：<span class="text-orange"><%=exam.releaseCount%>份</span></em>
                </div>
                <%}%>
            </div>
        </li>
        <%_.each(exam.subjects,function(subject,index){%>
        <li class="pe-view-item-wrapper">
            <h1 class="pe-viewing-number"><%=index+1%></h1>
            <div class="pe-recent-item-left">
                <div>
                    <h2 class="pe-recent-title release-exam-title" style="font-size:15px;" data-id="<%=subject.id%>"><%=subject.examName%></h2>
                    <p class="">
                        <i class="iconfont pe-recent-online <%if (subject.examType === 'ONLINE') {%>icon-on-line<%} else if(subject.examType === 'OFFLINE'){%>icon-online<%} else {%>icon-general<%}%>"></i>
                        <span class="pe-recent-time">考试日期：<%=moment(subject.startTime).format('YYYY-MM-DD HH:mm')%> ~ <%=moment(subject.endTime).format('YYYY-MM-DD HH:mm')%></span>
                    </p>
                </div>
            <#--<p class="pe-recent-time pe-viewing-num">考试编号：<%=subject.examCode%></p>-->
            </div>
            <div class="pe-viewing-item-right recent-exam-tip-wrap">
                <%if ((subject.examSetting && subject.examSetting.scoreSetting.spt == 'MANUAL' && exam.examSetting && exam.examSetting.scoreSetting.spt != 'SUBJECT_EXAM_TOGETHER') || subject.examType === 'OFFLINE') {%>
                <div class="pe-recent-test pe-viewing-test">
                    <%if(subject.examType === 'OFFLINE'){%>
                        <%if (exam.examSetting && exam.examSetting.scoreSetting.spt == 'SUBJECT_EXAM_TOGETHER') {%>
                           <button type="button" class="pe-viewing-export"  style="margin-top:30px;" data-id="<%=subject.id%>">导入成绩</button>
                        <%}else{%>
                          <button type="button" class="pe-viewing-export"  data-id="<%=subject.id%>">导入成绩</button>
                        <%}%>
                    <%}%>
                    <%if (exam.examSetting && exam.examSetting.scoreSetting.spt != 'SUBJECT_EXAM_TOGETHER') {%>
                    <@authVerify authCode="VERSION_OF_PUBLISH_RESULT_BTN">
                        <button type="button" class="pe-answer-sure-btn" data-id="<%=subject.id%>"
                        <%if (subject.releaseCount === 0) {%>disabled="disabled"<%}%> <%if(subject.examType !==
                        'OFFLINE'){%>style="margin-top:30px;"<%}%>>
                        发布成绩
                        </button>
                    </@authVerify>
                    <#--<%} else {%>-->
                    <#--<em class="pe-viewing-publish">评卷后自动发布成绩</em>-->
                    <#--<%}%>-->
                    <%}} else {%>
                    <div class="pe-viewing-ing"><em class="pe-viewing-publish">评卷后自动发布成绩</em></div>
                    <%}%>
                </div>
                 <%if(subject.examType === 'OFFLINE' || (exam.examSetting && exam.examSetting.scoreSetting.spt != 'SUBJECT_EXAM_TOGETHER' && subject.examSetting && subject.examSetting.scoreSetting.spt == 'MANUAL')){%>
                <div class="pe-viewing-border"></div>
                 <%}%>
                <div class="pe-viewing-ing">
                    <%if (exam.examSetting && exam.examSetting.scoreSetting.spt != 'SUBJECT_EXAM_TOGETHER' && subject.examSetting && subject.examSetting.scoreSetting.spt == 'MANUAL') {%>
                    <em>可发布成绩：<span class="text-orange"><%=subject.releaseCount%>份</span></em>
                    <%}%>
                </div>
                <#--<%}%>-->
            </div>
        </li>
        <%});%>
        <%} else {%>
        <li>
            <div class="pe-recent-item-left">
                <h2 class="pe-recent-title release-exam-title" data-id="<%=exam.id%>"><%=exam.examName%></h2>
                <p class="">
                    <i class="iconfont pe-recent-online <%if (exam.examType === 'ONLINE') {%>icon-on-line<%} else if(exam.examType === 'OFFLINE'){%>icon-online<%} else {%>icon-general<%}%>"></i>
                    <span class="pe-recent-time">考试日期：<%=moment(exam.startTime).format('YYYY-MM-DD HH:mm')%> ~ <%=moment(exam.endTime).format('YYYY-MM-DD HH:mm')%></span>
                </p>
                <p class="pe-recent-time pe-viewing-num">考试编号：<%=exam.examCode%></p>
            </div>
            <div class="pe-viewing-item-right recent-exam-tip-wrap">
                <%if (exam.examSetting.scoreSetting.spt === 'JUDGED_AUTO_PUBLISH') {%>
                <div class="pe-viewing-ing"><em class="pe-viewing-publish">评卷后自动发布成绩</em></div>
                <%} else {%>
                <div class="pe-recent-test pe-viewing-test">
                    <%if(exam.examType === 'OFFLINE'){%>
                        <button type="button" class="pe-viewing-export" data-id="<%=exam.id%>">导入成绩</button>
                    <%}%>
                    <@authVerify authCode="VERSION_OF_PUBLISH_RESULT_BTN">
                        <button type="button" class="pe-answer-sure-btn" data-id="<%=exam.id%>"
                        <%if(exam.examType !== 'OFFLINE'){%>style="margin-top:30px;"<%}%>
                        <%if (exam.releaseCount === 0) {%>disabled="disabled"<%}%>>
                        发布成绩
                        </button>
                    </@authVerify>
                </div>
                <div class="pe-viewing-border"></div>
                <div class="pe-viewing-ing"><em>可发布成绩：<span class="text-orange"><%=exam.releaseCount%>份</span></em>
                </div>
                <%}%>
            </div>
        </li>
        <%}});%>
    </ul>
</script>
<script>
    $(function () {
        var $viewContain = $('.pe-viewing-contain');
        var releaseResult = {
            init: function () {
                this.initData();
                this.bind();
            },

            initData: function () {
                //ie9不支持Placeholder问题
                PEBASE.isPlaceholder();
                var _this = this;
                _this.renderData();
            },
            bind: function () {
                $(window).scroll(function(){
                    if($(window).scrollTop() >= 1000){
                        $('.go-top-btn').fadeIn();
                    }else{
                        $('.go-top-btn').fadeOut();
                    }

                })
                /*回到头部*/
                $('.go-top-btn').click(function () {
                    $(window).scrollTop(0);
                });

                var _this = this;
                $viewContain.delegate('.release-exam-title', 'click', function () {
                    var examId = $(this).data('id');
                    window.open("${ctx}/ems/examResult/manage/initResultDetailPage?examId=" + examId,'');
                });

                $('.pe-viewing-btn').on('click', function () {
                    var keyword = $.trim($('input[name="keyword"]').val());
                    _this.renderData(keyword);
                });

                $viewContain.delegate('.pe-answer-sure-btn', 'click', function () {
                    var examId = $(this).data('id');
                    window.open("${ctx}/ems/examResult/manage/initReleaseResultPage?examId=" + examId,'');
                });

                $viewContain.delegate('.pe-viewing-export', 'click', function () {
                    var examId = $(this).data('id');
                    window.open("${ctx}/ems/examResult/manage/initImportTemplate?id=" + examId,'');
                });
            },

            renderData: function (keyword) {
                PEBASE.ajaxRequest({
                    url: '${ctx!}/ems/examResult/manage/listReleaseExam',
                    data: {keyword: keyword},
                    success: function (data) {
                        if ($.isEmptyObject(data) || data.length === 0) {
                            $viewContain.hide();
                            $('.pe-no-candidate-view').show();
                            return false;
                        }else{
                            $('.pe-no-candidate-view').hide();
                            $viewContain.show();
                        }
                        $viewContain.html('');
                        $viewContain.html(_.template($('#releaseResultTemp').html())({data: data}));
                        $('.pe-viewing-ing').find('.publish-tip-round').hover(
                                function(){
                                    var $thisParent =  $(this).parents('.pe-viewing-ing');
                                    $thisParent.addClass('tip-round');
                                    $thisParent.find('em').not('.pe-viewing-publish').hide();
                                    $thisParent.find('.pe-viewing-publish').show();
                                },
                                function(){
                                    var $thisParent =  $(this).parents('.pe-viewing-ing');
                                    $thisParent.removeClass('tip-round');
                                    $thisParent.find('em').not('.pe-viewing-publish').show();
                                    $thisParent.find('.pe-viewing-publish').hide();
                                }
                        )
                    }
                });
            }
        };

        releaseResult.init();
    });


</script>