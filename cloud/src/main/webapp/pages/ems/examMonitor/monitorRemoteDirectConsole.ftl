<#assign ctx=request.contextPath/>
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<#--评卷头部-->
<div class="pe-public-top-nav-header ztj-monitor-list-header">
    <h3 class="monitor-header-title">
        <span class="long-monitor">[远程监控]&nbsp;<span class="iconfont icon-tree-dot">
        </span>&nbsp;</span>${(exam.examName)!}&nbsp;<#if exam.status == 'PROCESS'>[进行中]<#elseif exam.status =='OVER'>[已结束]<#else>未开始</#if>
    </h3>
</div>
<section class="exam-monitor-console-wrap">
    <div class="pe-manage-content-right paper-add-accredit-wrap ztj-monitor-list-wrap"
         style="background-color:#f4f6f9;">
        <div class="monitor-main-top long-monitor-top">
                <span class="tip-panel">考试时间&nbsp;:&nbsp;<span class="tip-panel-content">${(exam.startTime?string('yyyy-MM-dd HH:mm'))!}
                    -- ${(exam.endTime?string('yyyy-MM-dd HH:mm'))!}</span></span>
            <span class="tip-panel">当前时间&nbsp;:&nbsp;<span
                    class="tip-panel-content current-time-span">${(nowTime?string("yyyy-MM-dd HH:mm:ss"))!}</span></span>
            <#if exam.status == 'PROCESS'><span class="floatR">数据实时刷新<span style="color:#f00" class="refresh-span">5s</span></span></#if>
        </div>
    <#--表格包裹的div-->
        <div class="monitor-main-middle-wrap long-monitor-main">
            <div class="monitor-middle-top">
                <form id="remoteMonitorConsoleForm">
                    <input type="hidden" name="exam.id" value="${(exam.id)!}"/>
                    <div class="pe-stand-filter-form">
                        <div class="pe-stand-form-cell">
                            <label class="pe-form-label floatL" for="peMainKeyText">
                                <span class="pe-label-name floatL">关键字:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text" max-length="50"
                                       placeholder="批次名称" name="batchName">
                            </label>
                            <dl class="floatL">
                                <dt class="pe-label-name floatL">&emsp;状&emsp;态:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleDraft" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="exam.examStatus" value="NO_START">未开始
                                    </label>
                                    <label class="floatL pe-checkbox" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" checked="checked" type="checkbox"
                                               name="exam.examStatus" value="PROCESS">考试中
                                    </label>
                                    <label class="floatL pe-checkbox" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" type="checkbox" checked="checked"
                                               name="exam.examStatus" value="OVER">已结束
                                    </label>
                                </dd>
                            </dl>
                            <button type="button" class="pe-btn pe-btn-blue monitor-choosen-btn">筛选</button>
                            <span class="floatR">
                                <span class="monitor-states-circle">
                                    <span class="iconfont icon-filled-circle ing"></span>考试中
                                </span>
                                <span class="monitor-states-circle">
                                    <span class="iconfont icon-filled-circle over"></span>已结束
                                </span>
                            </span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="monitor-middle-main">
            </div>
        </div>

        <button class="pe-btn pe-btn-blue long-monitor-close-btn">关闭</button>
    </div>
</section>
<script type="text/template" id="peMonitorManaTemp">
    <ul class="monitor-all-item-wrap">
        <%if(examArranges.length !== 0){%>
        <%_.each(examArranges,function(examArrange){%>
        <li class="monitor-video-wrap">
            <%if (examArrange.status === 'NO_START') {%>
            <div class="video-wrap">
            <#--有1个摄像头-->
                <div class="item zero-item iconfont icon-camera">
                    <p class="tip" style="font-size: 20px;">考试时间未开始</p>
                </div>
                <%var monitorUserNames = '';_.each(examArrange.monitorUsers,function(monitorUser,index){ if (index != 0){monitorUserNames += ' ';} monitorUserNames += monitorUser.userName;%>
                <%});%>
            </div>
            <%} else {%>
            <div class="video-wrap">
            <#--有4个摄像头-->
                <%var monitorUserNames = '';_.each(examArrange.monitorUsers,function(monitorUser,index){%>
                <%if (index != 0){monitorUserNames += ' ';} monitorUserNames += monitorUser.userName;%>
                <div class="item <%if (examArrange.monitorUsers.length === 1) {%>only-one-item<%}%> <%if (examArrange.status === 'PROCESS') {%>arrange-monitor-cla<%}%>"
                     data-arrange="<%=examArrange.id%>" data-user="<%=monitorUser.id%>" data-count="0" data-monitorlength = "<%=examArrange.monitorUsers.length%>">
                    <%if (examArrange.status === 'PROCESS') {%>
                    <div class="monitor-linking"><img src="${resourcePath!}/web-static/proExam/images/monitor-linking.gif" style="width: 50%;<%if (examArrange.monitorUsers.length === 1) {%>padding-top: 40px;<%} else {%>padding-top: 12px;<%}%>"><p style="margin-top: 6px;<%if (examArrange.monitorUsers.length === 1) {%>font-size: 20px;<%}%>">监控正在连接中<span class="connect-ing">...<span class="connect-ing-up"></span></span></p></div>
                    <%} else if(monitorUser.coverPath) {%>
                    <div class="monitor-video-cla" data-arrange="<%=examArrange.id%>" data-user="<%=monitorUser.id%>" style="height: 100%;width: 100%;background:rgba(0,0,0,.9);">
                        <img src="<%=monitorUser.coverPath%>" class="monitor-view-back-image">
                        <div class="<%if (examArrange.monitorUsers.length === 1) {%>monitor-view-big-btn<%} else {%>monitor-view-min-btn<%}%> iconfont icon-pe-video">
                        </div>
                    </div>
                    <%} else {%>
                        <div class="iconfont icon-did-not-open-the-camera" style="height:98%;width:98%;<%if (examArrange.monitorUsers.length === 1) {%>font-size:200px;padding-top:20px;<%}%>m"><p class="tip" <%if (examArrange.monitorUsers.length === 1) {%>style="font-size: 20px;"<%}%>>监考员未开启摄像头</p></div>
                    <%}%>
                </div>
                <%});%>
                <%if (examArrange.monitorUsers.length === 3) {%>
                <div class="item iconfont icon-camera" style="border: 0;">
                    <p class="tip">该考场只有三个监控</p>
                </div>
                <%} else if (examArrange.monitorUsers.length === 2) {%>
                <div class="item two-item iconfont icon-camera">
                    <p class="tip">该考场只有两个监控</p>
                </div>
                <%}%>

            <#--考试状态小点的位置-->
                <%if (examArrange.status === 'PROCESS') {%>
                <div class="exam-states iconfont icon-filled-circle ing"></div>
                <%} else if (examArrange.status === 'OVER'){%>
                <div class="exam-states iconfont icon-filled-circle over"></div>
                <%}%>
            </div>
            <%}%>
            <div class="describe-text">
                <div class="describe-top">
                    <span class="exam-addr-wrap"><%=examArrange.batchName%></span>
                    <span class="floatR">
                                <a class=" fontC6 iconfont icon-monitoring-data" data-id="<%=examArrange.id%>" title="监控数据"></a>
                                <a class=" fontC6 iconfont icon-view-screenshots" data-id="<%=examArrange.id%>" title="查看截图"></a>
                            </span>
                </div>
                <div class="describe-under">
                    <div class="fontC7">考试时间:&nbsp;<%=moment(examArrange.startTime).format('YYYY-MM-DD HH:mm')%>~<%=moment(examArrange.endTime).format('YYYY-MM-DD HH:mm')%>
                    </div>
                    <div class="fontC7">基本情况:&nbsp;应到<%=examArrange.testCount%>人,&nbsp;<%if (examArrange.status !=
                        'NO_START') {%>实到<%=examArrange.joinedCount%>人,&nbsp;交卷<%=examArrange.submitCount%>人<%}%>
                    </div>
                    <div class="fontC7">监控人员:&nbsp;<%=monitorUserNames%></div>
                </div>
            </div>
        </li>
        <%});%>
        <%}%>
    </ul>
</script>
<script type="text/template" id="emptyMonitorTemp">
    <div class="monitor-linking" style="height:98%;width:98%;">
        <img src="${resourcePath!}/web-static/proExam/images/monitor-linking.gif" style="width: 60%;height: 60%;<%if (monitorlength === 1) {%>padding-top: 40px;<%} else {%>padding-top: 12px;<%}%>">
        <p style="margin-top: 6px;<%if (monitorlength === 1) {%>font-size: 20px;<%}%>"><%=message%></p>
    </div>
</script>
<script>
    $(function () {
        var monitorConsole = {
            examId: '${(exam.id)!}',
            repeatTime: 5,
            init: function () {
                var _this = this;
                _this.bind();
                _this.initData();
            },
            initArrange: function () {
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/examMonitor/manage/listArrange',
                    data: $('#remoteMonitorConsoleForm').serialize(),
                    success: function (data) {
                        $('.monitor-middle-main').html(_.template($('#peMonitorManaTemp').html())({examArranges: data}));
                    }
                })
            },

            bind: function () {
                $('.long-monitor-close-btn').on('click',function () {
                   window.close();
                });
                $('.img-item').on('click', function () {
                    var arrangeId = $(this).data('id');
                    window.open(pageContext.rootPath + '/ems/examMonitor/manage/initConsoleDetail?arrangeId=' + arrangeId, "CONSOLE_DETAIL");
                });
                //点击查询
                $(".monitor-choosen-btn").on('click', function () {
                    monitorConsole.initArrange();
                });

                $('.pe-step-next-btn').on('click', function () {
                    window.close();
                });

                $('.monitor-middle-main').delegate('.icon-monitoring-data', 'click', function () {
                    var id = $(this).data('id');
                    window.open(pageContext.rootPath + '/ems/examMonitor/manage/initMonitorDetailPage?arrangeId=' + id);
                });

                $('.monitor-middle-main').delegate('.icon-view-screenshots', 'click', function () {
                    var id = $(this).data('id');
                    window.open(pageContext.rootPath + '/ems/examMonitor/manage/initPrintScreenPage?arrangeId=' + id);
                });

                $('.monitor-middle-main').delegate('.arrange-monitor-process', 'click', function () {
                    var arrangeId = $(this).data('arrange');
                    var userId = $(this).data('user');
                    window.open(pageContext.rootPath + '/ems/examMonitor/manage/initConsoleDetail?arrangeId=' + arrangeId+'&userId='+userId,"CONSOLE_DETAIL");
                });

                $('.monitor-middle-main').delegate('.monitor-video-cla', 'click', function () {
                    var arrangeId = $(this).data('arrange');
                    var userId = $(this).data('user');
                    window.open(pageContext.rootPath + '/ems/examMonitor/manage/initVideoDetailPage?arrangeId=' + arrangeId+'&userId='+userId);
                });
            },
            initData: function () {
                var _this = this;
                var dateStr = moment('${(nowTime?string('yyyy-MM-dd HH:mm:ss'))!}').format('YYYY/MM/DD HH:mm:ss');
                var nowDate = new Date(dateStr);
                setInterval(function () {
                    nowDate.setSeconds(nowDate.getSeconds() + 1);
                    $('.current-time-span').text(moment(nowDate).format('YYYY-MM-DD HH:mm:ss'));
                }, 1000);
                <#if exam.status == 'PROCESS'>
                _this.refreshImage();
                </#if>
                _this.initArrange();
            },
            refreshImage: function () {
                var time = monitorConsole.repeatTime;
                $('.refresh-span').text(time + 's');
                setInterval(function () {
                    time--;
                    $('.refresh-span').text(time + 's');
                    if (time === 0) {
                        time = monitorConsole.repeatTime + 1;
                        $('.arrange-monitor-cla').each(function (i, e) {
                            var $this = $(e);
                            var arrangeId = $this.data('arrange');
                            var userId = $this.data('user');
                            var count = $this.attr('data-count');
                            var monitorlength = $this.data('monitorlength');
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/examMonitor/manage/getMonitorImage',
                                data: {arrangeId: arrangeId, userId: userId, examId: monitorConsole.examId},
                                success: function (data) {
                                    if (data.success) {
                                        $this.attr('data-count', '0');
                                        $this.addClass('arrange-monitor-process');
                                        $this.html('<img src="' + data.data + '" style="width: 100%;height: 100%;"/>');
                                        return false;
                                    }

                                    if($this.find('.monitor-linking') && $this.find('.monitor-linking').length>0){
                                        return false;
                                    }

                                    count =  parseInt(count) + 1;
                                    if(count <= 6){
                                        $this.attr('data-count', count);
                                        return false;
                                    }

                                    $this.removeClass('arrange-monitor-process');
                                    $this.html(_.template($('#emptyMonitorTemp').html())({message:'断开连接，正在重连...',monitorlength:monitorlength}));
                                }
                            })
                        });
                    }

                }, 1000);
            }
        };
        monitorConsole.init();
    });
</script>
</@p.pageFrame>