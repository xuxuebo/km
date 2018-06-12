<#assign ctx=request.contextPath/>
<section class="pe-main-content" style="padding-bottom: 70px;">
    <ul>
        <li>
            <h2 class="pe-setting-title"><i class="iconfont"></i>待办事项</h2>
            <ul class="pe-setting-todo">
                <li class="pe-setting-todo-item">
                    <div class="pe-todo-top"><i class="wait-paper-count-more">待评卷</i><span
                            class="wait-paper-count">0</span><a
                            href="javascript:void(0)" class="wait-paper-count-more">更多</a></div>
                    <div class="pe-todo-wrap">
                        <ul class="wait-paper-list">
                        </ul>
                    </div>
                </li>
                <@authVerify authCode="VERSION_OF_TODO_MONITOR">
                    <li class="pe-setting-todo-item pe-todo-item">
                        <div class="pe-todo-top"><i class="monitor-count-more">考试监控</i><span
                                class="monitor-count">0</span><a href="javascript:void (0);"
                                                                 class="monitor-count-more">更多</a></div>
                        <div class="pe-todo-wrap">
                            <ul class="monitor-list">
                            </ul>
                        </div>
                    </li>
                </@authVerify>
                <li class="pe-setting-todo-item pe-todo-item">
                    <div class="pe-todo-top"><i class="publish-result-more">发布成绩</i><span
                            class="publish-result-count">0</span><a href="javascript:void(0);"
                                                                    class="publish-result-more">更多</a></div>
                    <div class="pe-todo-wrap">
                        <ul class="publish-result-list">

                        </ul>
                    </div>
                </li>
            </ul>
        </li>
    </ul>
    <script type="text/template" id="waitPaperTemp">
        <%_.each(data,function(exam){%>
        <li>
            <div class="pe-todo-left">
                <span class="todo-left-name" title="<%=exam.examName%>">
                    <%=((exam.examName.length > 14)?(exam.examName.substring(0,14) + '...'):(exam.examName))%></span>
            </div>
            <div class="pe-todo-right">
                <a class="pe-todo-enter enter-mark-exam" data-id="<%=exam.id%>" href="javascript:;">
                    <div class="todo-enter-num"><%=exam.waitPaperCount%></div>
                    进入评卷>
                </a>
            </div>
        </li>
        <%});%>
    </script>

    <script type="text/template" id="publishResultTemp">
        <%_.each(data,function(exam,index){ if (index>1){return false;}%>
        <li>
            <div class="pe-todo-left">
                <span class="todo-left-name" title="<%=exam.examName%>">
                    <%=((exam.examName.length > 14)?(exam.examName.substring(0,14)):(exam.examName))%>
                </span>
            </div>
            <div class="pe-todo-right">
                <a class="pe-todo-enter" href="${ctx!}/ems/examResult/manage/initReleaseResultPage?examId=<%=exam.id%>"
                   target="_blank">
                    <div class="todo-enter-num"><%=exam.releaseCount%></div>
                    发布成绩>
                </a>
            </div>
        </li>
        <%});%>
    </script>
    <script type="text/template" id="monitorTemp">
        <%_.each(data,function(exam){%>
        <li class="todo-arrange-li">
            <div class="pe-todo-left">
                        <span class="todo-left-name">
                            <%if(exam.isSameExam){%>
                                <%if (exam.subject){%>
                                    <%=((exam.subject.examName.length > 14)?(exam.subject.examName.substring(0,14)):(exam.subject.examName))%>
                                <%} else{%>
                                    <%=((exam.batchName.length > 14)?(exam.batchName.substring(0,14)):(exam.batchName))%>
                                <%}%>
                            <%}else{%>
                               <%=((exam.examName.length > 14)?(exam.examName.substring(0,14)):(exam.examName))%>
                            <%}%>
                        </span>
            </div>
            <div class="pe-todo-right">
                <a class="pe-todo-enter" data-id="<%=exam.id%>">
                    <div class="todo-enter-num"><%=exam.joinedNums?exam.joinedNums:0%></div>
                    进入监控>
                </a>
            </div>
        </li>
        <%})%>
    </script>
    <script>
        $(function () {
            $(window).resize(function(){
                var thisShouldBe = $(window).height() - 40-64-60;
                $('.pe-main-wrap').css('minHeight',thisShouldBe);
            })
            var thisShouldBe = $(window).height() - 40-64-60;
            $('.pe-main-wrap').css('minHeight',thisShouldBe);
            var manageIndex = {
                init: function () {
                    var _this = this;
                    _this.initData();
                    _this.bind();
                },

                bind: function () {
                    window.addEventListener("storage", function (e) {
                        if (!e.newValue) {
                            return;
                        }

                        if (e.key === 'EXAM_RESULT_RELEASE') {
                            manageIndex.initPublishResult();
                            localStorage.removeItem(e.key);
                        }

                        if (e.key === 'EXAM_FOR_MARKING_USER') {
                            manageIndex.initWaitPaper();
                            localStorage.removeItem(e.key);
                        }
                    });

                    $('.wait-paper-count-more').on('click', function () {
                        location.href = '#url=${ctx!}/ems/judge/manage/initPage&nav=mark';
                    });

                    $('.monitor-count-more').on('click', function () {
                        location.href = '#url=${ctx!}/ems/examMonitor/manage/initPage&nav=monitor';
                    });

                    $('.publish-result-more').on('click', function () {
                        location.href = '#url=${ctx!}/ems/examResult/manage/initResultPage&nav=result';
                    });

                    $('.monitor-list').delegate('.pe-todo-enter', 'click', function () {
                        var id = $(this).data('id');
                        window.open(pageContext.rootPath + '/ems/examMonitor/manage/initMonitorDetailPage?arrangeId=' + id);
                    });
                },

                initData: function () {
                    var _this = this;
                    _this.initWaitPaper();
                    _this.initPublishResult();
                    _this.initMonitor();
                },

                initWaitPaper: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + "/ems/judge/manage/searchWait",
                        data: {page: 1, pageSize: 2},
                        success: function (data) {
                            var $waitWrap = $('.wait-paper-list');
                                $waitWrap.delegate('.enter-mark-exam','click',function(){
                                    var _thisId = $(this).attr('data-id');
                                    window.open("${ctx!}/ems/judge/manage/initForMarking?examId=" + _thisId,'');
                                });
                            if (data.total > 0) {
                                $('.wait-paper-count').html(data.total);
                            } else {
                                $('.wait-paper-count').hide();
//                                $('.wait-paper-count-more').hide();
                            }
                            $waitWrap.html('');
                            if (data.rows != null && data.rows.length <= 0) {
                                $waitWrap.addClass('no-data');
                                $waitWrap.html('暂无待评卷数据');
                                return false;
                            }
                            $waitWrap.html(_.template($('#waitPaperTemp').html())({data: data.rows}));

                        }
                    });
                },

                initPublishResult: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/examResult/manage/listReleaseExam',
                        success: function (data) {
                            var $ublishWrap = $('.publish-result-list');
                            $ublishWrap.html('');
                            if (data.length <= 0) {
                                $ublishWrap.html('暂无待发布成绩数据');
                                $ublishWrap.addClass('no-data');
                                $('.publish-result-count').hide();
                                return false;
                            }

                            var exams = [];
                            $.each(data, function (i, v) {
                                if (v.releaseCount > 0) {
                                    exams.push({examName: v.examName, id: v.id, releaseCount: v.releaseCount});
                                }
                            });

                            if (exams.length > 0) {
                                $('.publish-result-count').html(exams.length);
                            } else {
                                $ublishWrap.html('暂无待发布成绩数据');
                                $ublishWrap.addClass('no-data');
                                $('.publish-result-count').hide();
//                                $('.publish-result-more').hide();
                            }

                            if (exams.length <= 0) {
                                return false;
                            }
                            $ublishWrap.html(_.template($('#publishResultTemp').html())({data: exams}));
                        }
                    });
                },

                initMonitor: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + "/ems/examMonitor/manage/searchExam",
                        data: {page: 1, pageSize: 2,examStatus:'PROCESS'},
                        success: function (data) {
                            var $monitorWrap = $('.monitor-list');
                            if (data.total > 0) {
                                $('.monitor-count').html(data.total);
                            } else {
                                $('.monitor-count').hide();
                            }

                            $monitorWrap.html('');
                            if (data.rows != null && data.rows.length <= 0) {
                                $monitorWrap.html('暂无待监控数据');
                                $monitorWrap.addClass('no-data');
                                return false;
                            }

                            var lastTwoRanges = manageIndex.changeLastMonitor(data.rows);
                            $monitorWrap.html(_.template($('#monitorTemp').html())({data: lastTwoRanges}));
                        }
                    });
                },
                changeLastMonitor: function (data) {
                    var dataArry = [], lastTwoArry = [];
                    $.each(data, function (i, d) {
                        var dRanges = d.examArranges;
                        if ($.isArray(dRanges)) {
                            for (var k = 0, kLen = dRanges.length; k < kLen; k++) {
                                dRanges[k].examCode = d.examCode;
                                dRanges[k].examName = d.examName;
                                dRanges[k].joinedNums = d.joinedNums;
                            }
                            dataArry = dataArry.concat(d.examArranges);
                        }
                    });
                    if (dataArry.length !== 0) {
                        if (dataArry.length === 2) {
                            lastTwoArry = dataArry;
                            if (lastTwoArry[0].examCode === lastTwoArry[1].examCode) {
                                lastTwoArry[0].isSameExam = true;
                                lastTwoArry[1].isSameExam = true;
                            } else {
                                lastTwoArry[0].isSameExam = false;
                                lastTwoArry[1].isSameExam = false;
                            }
                        } else if(dataArry.length > 2){
                            dataArry.sort(manageIndex.compareArry);
                            lastTwoArry = dataArry.slice(0, 2);
                            if (lastTwoArry[0].examCode === lastTwoArry[1].examCode) {
                                lastTwoArry[0].isSameExam = true;
                                lastTwoArry[1].isSameExam = true;
                            } else {
                                lastTwoArry[0].isSameExam = false;
                                lastTwoArry[1].isSameExam = false;
                            }
                        }else if(dataArry.length === 1){
                            lastTwoArry = dataArry;
                        }

                        return lastTwoArry;
                    }
                },
                compareArry: function (a, b) {
                    var thisA = moment(a.startTimeStr).valueOf();
                    var thisB = moment(b.startTimeStr).valueOf();
                    return thisA - thisB;
                }
            };

            manageIndex.init();
        });
    </script>
</section>