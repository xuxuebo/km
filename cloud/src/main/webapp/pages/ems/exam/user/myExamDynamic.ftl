<#assign ctx=request.contextPath/>
<div class="pe-dynamic-contain user-main-right-panel" >
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
        <div class="wrap">
            <div class="user-exam-no-data"></div>
            <p class="pe-dynamic-empty">目前暂无考试，请等待管理员为您安排</p>
        </div>
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
            <%if (exam.examType === 'COMPREHENSIVE') {%>
            <div class="pe-recent-item  clearF pe-recent-comprehensive" >
                <div class="recent-shadow-uper">
                <div class="recent-shadow-stack stack-first"></div>
                <div class="recent-shadow-stack stack-second"></div>
                <div class="recent-border-item"></div>
                <%if (exam.examResult && exam.examResult.status === 'MISS_EXAM'){%>
                <div class="pe-recent-ing">缺考</div>
                <%}%>
                <%if (exam.examResult && exam.examResult.status === 'RELEASE') { if(exam.examResult.pass) {%><span class="iconfont pe-recent-pass">&#xe757;</span><%} else {%>
                <span class="iconfont pe-recent-pass" style="color: #fc4e51;">&#xe758;</span><%}}%>
                <div class="pe-recent-item-left">
                    <a class="pe-recent-title" href="javascript:;" title="<%=exam.examName%>"><%=exam.examName%></a>
                    <p class="">
                        <i class="iconfont pe-recent-online" style="margin-top:-2px;">&#xe756;</i>
                        <span class="pe-recent-subject"><%=exam.subjects.length%>科目<i class="iconfont icon-thin-arrow-down pe-dynamic-icon"></i></span>
                    </p>
                </div>
                <%if (exam.examResult && (exam.examResult.score || exam.examResult.score === 0) && exam.examResult.status === 'RELEASE') {%>
                <div class="pe-recent-item-right recent-exam-btn">
                    <div class=" pe-recent-rank-content pe-recent-ranking pe-recent-ing">
                        <dl class="pe-exam-dym">
                            <dt>
                            <div class="pe-pe-exam-item">
                                <p class="pe-resulting-item">成绩</p>
                            </div>
                            </dt>
                            <dd class="pe-iteming" style="cursor:default;"><%=parseFloat(exam.examResult.score.toFixed(1),10)%></dd>
                        </dl>
                        <%if (exam.examSetting && exam.examSetting.rankSetting && exam.examSetting.rankSetting.rst != 'NO_SHOW') {%>
                        <dl class="pe-recent-rank">
                            <dt>
                            <div class="pe-pe-exam-item">
                                <p class="pe-ranking-itemed">排名</p>
                            </div>
                            </dt>
                            <dd class="rank-link pe-iteming" data-id="<%=exam.id%>"><%=exam.examResult.rankCount%></dd>
                        </dl>
                        <%}%>
                        <dl class="clear"></dl>
                    </div>
                </div>
                <%}%>
                </div>
                <div class="pe-recent-step-con" style="display:none;">
                    <%_.each(exam.subjects,function(subject,index){%>
                    <div class="pe-recent-extent">
                        <div class="pe-recent-wrapper" style="margin:0;">
                            <%if (subject.examResult && subject.examResult.status === 'RELEASE') { if(subject.examResult.pass) {%><span class="iconfont pe-recent-pass">&#xe757;</span><%} else {%>
                            <span class="iconfont pe-recent-pass" style="color: #fc4e51;">&#xe758;</span><%}}%>
                            <div class="pe-recent-step"><%=index+1%></div>
                            <div class="pe-recent-item-left">
                                <a class="pe-recent-title" href="javascript:;" title="<%=subject.examName%>"><%=subject.examName%></a>
                                <p class="">
                                    <i class="iconfont pe-recent-online" style="margin-top:-2px;"><%if (subject.examType === 'ONLINE') {%>&#xe741;<%} else {%>&#xe755;<%}%></i>
                                    <span class="pe-recent-time"><i class="iconfont">&#xe740;</i><%=moment(subject.startTime).format('YYYY-MM-DD HH:mm')%> ~ <%=moment(subject.endTime).format('YYYY-MM-DD HH:mm')%></span>
                                </p>
                            </div>
                            <div class="pe-recent-item-right recent-exam-btn">
                                <%if (subject.status === 'PROCESS' && subject.examType === 'ONLINE' && !subject.examResult) {%>
                                <div class="pe-recent-test">
                                    <button type="button" class="pe-answer-sure-btn"
                                            data-id="<%=subject.id%>">参加考试
                                    </button>
                                </div>
                                <div class="pe-recent-ing"><em>考试正在进行中</em></div>
                                <%} else if(subject.status === 'NO_START'){%>
                                <%if (subject.examType === 'ONLINE') {%>
                                <div class="pe-recent-test" style="display: none;">
                                    <button type="button" class="pe-answer-sure-btn"
                                            data-id="<%=subject.id%>">参加考试
                                    </button>
                                </div>
                                <%}%>
                                <div class="pe-recent-ing" style="display: none;"><em>考试正在进行中</em></div>
                                <div class="pe-recent-item-right">
                                    <div class="pe-recent-ing pe-recent-distance">离考试开始还有
                                        <p>
                                            <%if(subject.residualTime - 31536000 >0){%>
                                            <span class="text-orange pe-recent-item-num"><%=Math.floor(subject.residualTime/31536000)%></span>年
                                            <%} else if(subject.residualTime - 2592000 >0) {%>
                                            <span class="text-orange pe-recent-item-num"><%=Math.floor(subject.residualTime/2592000)%></span>月
                                            <%} else if(subject.residualTime - 86400 >0) {%>
                                            <span class="text-orange pe-recent-item-num"><%=Math.floor(subject.residualTime/86400)%></span>天
                                            <%} else if(subject.residualTime - 3600>0) {%>
                                            <span class="text-orange pe-recent-item-num"><%=Math.floor(subject.residualTime/3600)%></span>小时
                                        <#--<span class="text-orange pe-recent-item-num"><%=Math.floor((subject.residualTime%3600)/60)%></span>分-->
                                            <%} else if(subject.residualTime-60>0) {%>
                                            <span class="text-orange pe-recent-item-num residual-minute-span"><%=Math.floor(subject.residualTime/60)%></span><span class="residual-minute-text">分</span>
                                            <span class="text-orange pe-recent-item-num residual-second-span"><%=Math.floor(subject.residualTime%60)%></span>秒
                                            <%} else if(subject.residualTime>0) {%>
                                            <span class="text-orange pe-recent-item-num residual-second-span"><%=Math.floor(subject.residualTime)%></span>秒
                                            <%}%>
                                        </p>
                                    </div>
                                </div>
                                <%} else if(subject.examResult && (subject.examResult.status === 'MARKING' || subject.examResult.status === 'WAIT_RELEASE')) {%>
                                <div class="pe-recent-ing">评卷中</div>
                                <%} else if(subject.examResult && subject.examResult.status === 'MISS_EXAM') {%>
                                <div class="pe-recent-ing">缺考</div>
                                <%if (subject.examResult && subject.examResult.needMakeUp) {%>
                                <span class="pe-recent-test pe-recent-exam"><button type="button" data-id="<%=subject.id%>" class="pe-answer-sure-btn pe-join-btn pe-btn pe-btn-blue">立即补考</button></span>
                                <%}%>
                                <%} else if(subject.examResult && subject.examResult.status === 'RELEASE') {%>
                                <%if (subject.examResult && subject.examResult.needMakeUp) {%>
                                <span class="pe-recent-test pe-recent-testing pe-recent-exam "><button type="button" data-id="<%=subject.id%>" class="pe-answer-sure-btn">立即补考</button></span>
                                <%}%>
                                <div class="pe-recent-rank-content pe-recent-ranking pe-recent-ing">
                                    <dl class="pe-exam-dym">
                                        <dt>
                                        <div class="pe-pe-exam-item">
                                            <p class="pe-resulting-item">成绩</p>
                                        </div>
                                        </dt>
                                        <dd class="pe-iteming" style="cursor:default;"><%=parseFloat(subject.examResult.score.toFixed(1),10)%></dd>
                                    </dl>
                                    <%if (subject.examSetting && subject.examSetting.rankSetting && subject.examSetting.rankSetting.rst != 'NO_SHOW') {%>
                                    <dl class="pe-recent-rank">
                                        <dt>
                                        <div class="pe-pe-exam-item">
                                            <p class="pe-ranking-itemed">排名</p>
                                        </div>
                                        </dt>
                                        <dd class="rank-link pe-iteming" data-id="<%=subject.id%>"><%=subject.examResult.rankCount%></dd>
                                    </dl>
                                    <%}%>
                                    <dl class="clear"></dl>
                                </div>
                                <%}%>
                            </div>
                        </div>
                    </div>
                    <%});%>
                </div>
            </div>

            <%} else {%>
            <div class="pe-recent-item">
                <#--<div class="pe-dynamic-border"></div>-->
                    <div class="recent-border-item"></div>
                <div class="pe-recent-item-left">
                    <a class="pe-recent-title" href="javascript:;" title="<%=exam.examName%>"><%=exam.examName%></a>
                    <p class="">
                        <i class="iconfont pe-recent-online" style="margin-top:-2px;"><%if (exam.examType === 'ONLINE') {%>&#xe741;<%} else {%>&#xe755;<%}%></i>
                        <span class="pe-recent-time"><i class="iconfont">
                            &#xe740;</i><%=moment(exam.startTime).format('YYYY-MM-DD HH:mm')%> ~ <%=moment(exam.endTime).format('YYYY-MM-DD HH:mm')%></span>
                    </p>
                </div>
                <div class="pe-recent-item-right recent-exam-btn">
                    <%if (exam.status === 'PROCESS' && exam.examType === 'ONLINE' && !exam.examResult) {%>
                    <div class="pe-recent-test">
                        <button type="button" class="pe-answer-sure-btn" data-id="<%=exam.id%>">
                            参加考试
                        </button>
                    </div>
                    <div class="pe-recent-ing"><em>考试正在进行中</em></div>
                    <%} else if(exam.status === 'NO_START'){if(exam.examType=='ONLINE'){%>
                    <div class="pe-recent-test" style="display: none;">
                        <button type="button" class="pe-answer-sure-btn" data-type="<%=exam.examType%>" data-id="<%=exam.id%>">
                            参加考试
                        </button>
                    </div>
                    <%}%>
                    <div class="pe-recent-ing" style="display: none;"><em>考试正在进行中</em></div>
                    <div class="pe-recent-item-right">
                        <div class="pe-recent-ing pe-recent-distance">离考试开始还有
                            <p>
                                <%if(exam.residualTime - 31536000 >0){%>
                                <span class="text-orange pe-recent-item-num"><%=Math.floor(exam.residualTime/31536000)%></span>年
                                <%} else if(exam.residualTime - 2592000 >0) {%>
                                <span class="text-orange pe-recent-item-num"><%=Math.floor(exam.residualTime/2592000)%></span>月
                                <%} else if(exam.residualTime - 86400 >0) {%>
                                <span class="text-orange pe-recent-item-num"><%=Math.floor(exam.residualTime/86400)%></span>天
                                <%} else if(exam.residualTime - 3600>0) {%>
                                <span class="text-orange pe-recent-item-num"><%=Math.floor(exam.residualTime/3600)%></span>小时
                                <#--<span class="text-orange pe-recent-item-num"><%=Math.floor((exam.residualTime%3600)/60)%></span>分-->
                                <%} else if(exam.residualTime-60>0) {%>
                                <span class="text-orange pe-recent-item-num residual-minute-span"><%=Math.floor(exam.residualTime/60)%></span><span class="residual-minute-text">分</span>
                                <span class="text-orange pe-recent-item-num residual-second-span"><%=Math.floor(exam.residualTime%60)%></span>秒
                                <%} else if(exam.residualTime>0) {%>
                                <span class="text-orange pe-recent-item-num residual-second-span" data-type="<%=exam.examType%>"><%=Math.floor(exam.residualTime)%></span>秒
                                <%}%>
                            </p>
                        </div>
                    </div>
                    <%} else if(exam.examResult && (exam.examResult.status === 'MARKING' || exam.examResult.status === 'WAIT_RELEASE')) {%>
                    <div class="pe-recent-ing">评卷中</div>
                    <%} else if(exam.examResult && exam.examResult.status === 'MISS_EXAM') {%>
                    <div class="pe-recent-ing">缺考</div>
                    <%if (exam.examResult && exam.examResult.needMakeUp) {%>
                    <span class="pe-recent-test pe-recent-testing pe-recent-exam"><button type="button" data-id="<%=exam.id%>" class="pe-answer-sure-btn">立即补考</button></span>
                    <%}%>
                    <%} else if(exam.examResult && exam.examResult.status === 'RELEASE') {%>
                    <%if(exam.examResult.pass) {%><span class="iconfont pe-recent-pass">&#xe757;</span><%} else {%>
                    <span class="iconfont pe-recent-pass" style="color: #fc4e51;">&#xe758;</span><%}%>
                    <%if (exam.examResult && exam.examResult.needMakeUp) {%>
                    <span class="pe-recent-test pe-recent-testing pe-recent-exam"><button type="button" data-id="<%=exam.id%>" class="pe-answer-sure-btn">立即补考</button></span>
                    <%}%>
                    <div class="pe-recent-rank-content pe-recent-ranking pe-recent-ing">
                        <dl class="pe-exam-dym">
                            <dt>
                            <div class="pe-pe-exam-item">
                                <p class="pe-resulting-item">成绩</p>
                            </div>
                            </dt>
                            <dd class="pe-iteming" style="cursor:default;"><%=parseFloat(exam.examResult.score.toFixed(1),10)%></dd>
                        </dl>
                        <%if (exam.examSetting && exam.examSetting.rankSetting && exam.examSetting.rankSetting.rst != 'NO_SHOW') {%>
                        <dl class="pe-recent-rank">
                            <dt>
                            <div class="pe-pe-exam-item">
                                <p class="pe-ranking-itemed">排名</p>
                            </div>
                            </dt>
                            <dd class="rank-link pe-iteming" data-id="<%=exam.id%>"><%=exam.examResult.rankCount%></dd>
                        </dl>
                        <%}%>
                        <dl class="clear"></dl>
                    </div>
                    <%}%>
                </div>
            </div>
            <%}%>
            <%});%>
        </div>
    </script>
    <script type="text/template" id="todayExamTemp">
        <%_.each(data,function(exam,index){%>
        <div class="pe-student-wrap">
            <div class="pe-student-contain">
                <p class="pe-student-img">
                    <img src="${resourcePath!}/web-static/proExam/images/pe-btn.png">
                </p>

                <%if (exam.examType ==='COMPREHENSIVE') {%>
                <%if (exam.subjects[0].status === 'PROCESS'){%>
                <div class="pe-student-btn">
                    <button class="pe-btn pe-join-btn pe-btn-blue" data-id="<%=exam.subjects[0].id%>">参加考试</button>
                </div>
                <%} else {%>
                <div class="pe-student-btn">
                    <button class="pe-btn pe-join-btn pe-btn-blue" style="display: none;"
                            data-id="<%=exam.subjects[0].id%>">参加考试
                    </button>
                                                            <div class="pe-student-warn">
                                                                <i class="pe-student-time"
                                                                   data-time="<%=exam.subjects[0].examTimeLength%>"><%=exam.subjects[0].scrollTime%></i>
                                                                <span class="pe-student-start" style="display: none;">考试即将开始，请耐心等待</span>
                                                            </div>
                </div>
                <%}%>
                <h1 class="pe-student-caption" title="<%=exam.examName%>"><%=exam.examName%></h1>
                <p class="pe-student-subject">科目<%=exam.subjects[0].showOrder%>
                    <span><%=exam.subjects[0].examName%></span></p>
                <%} else {%>
                <%if (exam.status === 'PROCESS'){%>
                <div class="pe-student-btn">
                    <button class="pe-btn pe-join-btn pe-btn pe-btn-blue" data-id="<%=exam.id%>">参加考试</button>
                </div>
                <%} else {%>
                <div class="pe-student-btn">
                    <button class="pe-btn pe-join-btn pe-btn-blue" style="display: none;" data-id="<%=exam.id%>">参加考试
                    </button>
                                                                    <div class="pe-student-warn">
                                                                        <i class="pe-student-time"
                                                                           data-time="<%=exam.examTimeLength%>"><%=exam.scrollTime%></i>
                                                                        <span class="pe-student-start" style="display: none;">考试即将开始，请耐心等待</span>
                                                                    </div>
                </div>
                <%}%>
                <h1 class="pe-student-caption" title="<%=exam.examName%>"><%=exam.examName%></h1>
                <%}%>
            </div>
        </div>
        <%});%>
    </script>
    <script type="text/javascript">
        $(function () {
            userControl.myExamDynamic.init();
        });
    </script>