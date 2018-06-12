<style type="text/css">
    .pe-mock-sure-btn {
        font-size: 16px;
        color: #fff;
        outline: none;
        border: 1px solid #199ae2;
        background: #199ae2;
        cursor: pointer;
        padding: 10px 97px;
        border-radius: 3px;
    }

    .pe-mock-sure-btn:hover {
        background-color: #24a4ec;
    }

    .pe-mock-sure-btn:active {
        background-color: #128fd4;
    }

    .pe-mock-exam-content {
        width: 200px;
        float: left;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        padding-right: 16px;
        padding-top: 18px;
    }
</style>
<#assign ctx=request.contextPath/>
<div class="pe-dynamic-contain">
    <div class="pe-dynamic-empty-wrap pe-dynamic-error-wrap" style="display: none;">
        <div class="pe-dynamic-wrong-bg">
            <div class="pe-dynamic-text-wrap">
                <p class="pe-dynamic-page">404 ERROR PAGE</p>
                <p class="pe-dynamic-wrong-warn">哎呀……页面出错啦!</p>
                <p class="pe-dynamic-wrong-warn">估计是飞到火星躲避雾霾去了！</p>
            </div>
        </div>
    </div>
    <div class="pe-dynamic-empty-wrap pe-dynamic-no-data" style="display: none;">
        <p class="pe-dynamic-emperty">目前暂无考试安排，请等待管理员为您安排</p>
    </div>
    <div class="pe-recent-wrap">
        <div class="pe-recent-content" id="myExamDynamicDiv">
            <div class="user-exam-more-panel" style="display: none;">
            </div>
        </div>
    </div>
</div>
<script type="text/template" id="dynamicTemp">
    <div class="pe-recent-content">
        <%_.each(data,function(exam,index){%>
        <div class="pe-recent-item pe-recent-item-con pe-recent-pos">
            <div class="recent-border-item"></div>
            <div class="pe-recent-item-left" style="width: 256px;">
                <a class="pe-recent-title" href="javascript:;"><%=exam.examName%></a>
                <p class="pe-recent-item-con">
                    截止时间：
                    <span class="pe-recent-time"><%=exam.endTimeStr%></span>
                </p>
                <p class="pe-recent-item-con">
                    考试时长：
                    <%if(exam.examSetting.examLength!==undefined){%>
                    <span class="pe-recent-time"><%=exam.examSetting.examLength%></span>分钟
                    <%}else{%>
                    <span class="pe-recent-time">不限时长</span>
                    <%}%>
                </p>
                <p class="pe-recent-item-con">
                    满&emsp;&emsp;分：
                    <span class="pe-recent-time"><%=exam.totalScore%></span></p>
                <p class="pe-recent-item-con">
                    及&emsp;&emsp;格：
                    <span class="pe-recent-time"><%=exam.passScore%></span></p>
            </div>
            <div class="pe-mock-exam-content">
                <a class="pe-recent-title" href="javascript:;"></a>
                <p class="pe-recent-item-con">已参加：<span class="pe-recent-time"><%=exam.result.examCount%></span>次</p>
                <p class="pe-recent-item-con">通过率：<span class="pe-recent-time"><%if(exam.result.passRate==undefined){%>--<%}else{%><%=exam.result.passRate%>%<%}%></span>
                </p>
                <p class="pe-recent-item-con">最高分：<span class="pe-recent-time"><%if(exam.result.highestScore){%><%=parseFloat(exam.result.highestScore.toFixed(1),10)%><%}else{%>--<%}%></span>
                </p>
                <p class="pe-recent-item-con">最低分：<span class="pe-recent-time"><%if(exam.result.lowestScore){%><%=parseFloat(exam.result.lowestScore.toFixed(1),10)%><%}else{%>--<%}%></span>
                </p>
            </div>
            <div class="pe-recent-item-right recent-exam-btn">
                <div class="pe-recent-test">
                    <button type="button" class="pe-mock-sure-btn start-mock"
                            data-id="<%=exam.id%>">开始模拟
                    </button>
                    <button type="button" class="pe-mock-sure-btn score-analyze" data-id="<%=exam.id%>">成绩分析</button>
                    <button type="button" class="pe-mock-sure-btn view-answer" data-id="<%=exam.id%>">查看答卷</button>
                </div>
                <div>

                </div>
            </div>
        </div>
        <%});%>
    </div>
</script>
<script type="text/javascript">
    $(function () {
        var myExamDynamic = {
            initData: function () {
                var _this = this;
                myExamDynamic.initDynamic();
            },

            bind: function () {
                $('.pe-student-today-exam').delegate('.pe-join-btn', 'mouseover mouseout', function (e) {
                    var event = e || window.event;
                    if (event.type == "mouseover") {
                        $(this).parents('.pe-student-contain').find('.pe-student-img img').attr('src', '${ctx!}/web-static/proExam/images/pe-btn-hover.png');
                    } else if (event.type == "mouseout") {
                        $(this).parents('.pe-student-contain').find('.pe-student-img img').attr('src', '${ctx!}/web-static/proExam/images/pe-btn.png');
                    }
                });

                $('body').delegate('.pe-join-btn,.start-mock', 'click', function () {
                    var id = $(this).data('id');
                    window.open('${ctx!}/ems/simulationExam/client/processPaper?id=' + id);
                });
                $('body').delegate('.view-answer', 'click', function () {
                    var id = $(this).data('id');
                    window.open('${ctx!}/ems/simulationExam/client/viewMyPaper?examId=' + id);
                });

                $('body').delegate('.score-analyze', 'click', function () {
                    var id = $(this).data('id');
                    window.open('${ctx!}/ems/simulationExam/client/initUserResult?examId=' + id);
                });

            },

            initDynamic: function () {
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/simulationExam/client/searchExamDynamic',
                    success: function (data) {
                        if (data && data.length == 0) {
                            $('.pe-recent-wrap').hide();
                            $('.pe-dynamic-no-data').show();

                        } else {
                            $(".pe-student-today-exam").hide();
                            $(".pe-student-many").hide();
                            $(".pe-exam-warn-wrap").hide();
                            $('.pe-recent-content').show();
                            $('.user-exam-more-panel').show();
                        }
                        $('.user-exam-more-panel').html('');
                        if ($.isEmptyObject(data)) {
                            return false;
                        }

                        $('.user-exam-more-panel').html(_.template($('#dynamicTemp').html())({data: data}));
                        myExamDynamic.rollingDynamicTime();
                        /*卡片的hover效果处理*/
                        $('.pe-recent-content .pe-recent-item').hover(
                                function (e) {
                                    var e = e || window.event;
                                    e.stopPropagation();
                                    $(this).addClass('recent-hover');
                                },
                                function (e) {
                                    var e = e || window.event;
                                    e.stopPropagation();
                                    $(this).removeClass('recent-hover');
                                }
                        );
                    }
                });
            },

            rollingDynamicTime: function () {
                $('.residual-second-span').each(function (index, ele) {
                    var second = parseInt($(ele).text());
                    var timeInterval = setInterval(function () {
                        if (second === 0) {
                            var $minute = $(ele).siblings('.residual-minute-span');
                            if ($minute.length <= 0) {
                                clearInterval(timeInterval);

                                $(ele).parents('.pe-recent-item').find('.recent-exam-btn .pe-recent-test').show();
                                $(ele).parents('.pe-recent-item').find('.recent-exam-btn .pe-recent-ing').show();
                                $(ele).parents('.pe-recent-item').find('.recent-exam-btn .pe-recent-item-right').remove();
                                return false;
                            }
                            var minute = parseInt($minute.text());
                            if (minute === 1) {
                                $minute.remove();
                            } else {
                                $minute.text(minute - 1);
                            }

                            second = 60;
                        }

                        $(ele).text(--second);
                    }, 1000);
                });
            },

            rollingTime: function ($this, time) {
                var timeArr = [];
                timeArr.push(Math.floor(time / 60 / 60));
                timeArr.push(Math.floor((time - timeArr[0] * 60 * 60) / 60));
                timeArr.push(time - timeArr[0] * 60 * 60 - timeArr[1] * 60);
                for (var i = 0; i < timeArr.length; i++) {
                    if (timeArr[i] < 10) {
                        timeArr[i] = "0" + timeArr[i];
                    }
                }

                $this.html(timeArr.join(':'));
            },

            init: function () {
                var _this = this;
                _this.initData();
                _this.bind();
            }
        };
        myExamDynamic.init();

        //点击更多信息按钮点击事件
        $('.pe-add-question-more-con').click(function () {
            $(".pe-student-today-exam").slideUp();
            $(".pe-student-many").hide();
            $(".pe-exam-warn-wrap").hide();
            if ($(this).find('.iconfont').hasClass('icon-show')) {
                $('.user-exam-more-panel').slideDown();
                if ($('.user-exam-more-panel').find('.pe-recent-item').length <= 0) {
                    myExamDynamic.initDynamic();
                }

                $(this).find('.iconfont').removeClass('icon-show').addClass('icon-pack');
            } else if ($(this).find('.iconfont').hasClass('icon-pack')) {
                $('.user-exam-more-panel').slideUp();
                $(this).find('.iconfont').removeClass('icon-pack').addClass('icon-show');
            }
        });

        $(".pe-student-warn").hover(function () {
            $(".pe-student-start").show();
        })

        //点击更多科目点击事件
        $('.pe-dynamic-contain').on('click', 'i.pe-dynamic-icon', function () {
            if ($(this).hasClass('icon-thin-arrow-down')) {
                $(this).parents('.pe-recent-item').next('.pe-recent-step-con').eq(0).slideDown();
                $(this).removeClass('icon-thin-arrow-down').addClass('icon-thin-arrow-up');
            } else if ($(this).hasClass('icon-thin-arrow-up')) {
                $(this).parents('.pe-recent-item').next('.pe-recent-step-con').eq(0).slideUp();
                $(this).removeClass('icon-thin-arrow-up').addClass('icon-thin-arrow-down');
            }
        });

        /*if($(".pe-dynamic-contain").length<=0){
            $(".pe-dynamic-emperty-wrap").show();
        }*/

        $('.pe-dynamic-contain').on('click', '.rank-link', function (e) {
            var e = e || window.event;
            e.stopPropagation();
            var examId = $(this).data('id');
            PEMO.DIALOG.selectorDialog({
                content: [pageContext.rootPath + '/ems/resultReport/client/initRankPage?examId=' + examId, 'no'],
                area: ['420px', '610px']
            });
        });


        window.addEventListener("storage", function (e) {
            if (!e.newValue) {
                return;
            }

            if (e.key === 'SUBMIT_EXAM_STORAGE') {
                location.reload();
                localStorage.removeItem(e.key);
            }
        });
    });
</script>