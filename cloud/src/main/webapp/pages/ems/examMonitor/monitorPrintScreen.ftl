<#assign ctx=request.contextPath/>
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header">
    <div class="pe-detail-top-head over-flow-hide">
        <div class="pe-top-nav-container">
            <h2 class="pe-for-grading">查看截图</h2>
        </div>
    </div>
</div>
<div class="pe-main-wrap">
    <section class="pe-main-content monitor-main-wrap">
        <div class="view-cut-img-wrap" style="min-height: 600px;">

        </div>
    </section>

    <button class="pe-btn pe-btn-blue view-cut-img-btn">关闭</button>

</div>
<script type="text/template" id="printImageTemp">
    <%if (!data || data.length <= 0) {%>
    <div class="pe-result-no-date" style="margin-top: 100px;"></div>
    <p class="pe-result-date-warn" style="text-align: center;">暂无截图数据</p>
    <%} else {%>
    <%_.each(data,function(examMonitorData){%>
    <div class="cut-img-panel">
        <div class="cut-img-top">
            <img src="<%=examMonitorData.filePath%>" width="100%" height="100%" alt="监控截图">
            <span class="cut-time"><%=moment(examMonitorData.createTime).format('YYYY-MM-DD HH:mm:ss')%></span>
        </div>
        <div class="cut-img-down">
            <span class="floatL"><%=examMonitorData.createUser.userName%>：</span><%=examMonitorData.comment%>
        </div>
    </div>
    <%});}%>
</script>
<script type="text/javascript">
    $(function(){
        PEBASE.ajaxRequest({
            url : pageContext.rootPath + '/ems/examMonitor/manage/listPrintImage',
            data:{arrangeId:'${(arrangeId)!}',userId:'${(userId)!}'},
            success:function (data) {
                $('.view-cut-img-wrap').html(_.template($('#printImageTemp').html())({data:data}));
            }
        });

        $('.view-cut-img-btn').on('click',function () {
           window.close();
        });

        $('.go-top-btn').css('marginLeft','700px');
        $(window).scroll(function(){
            /*回到顶部*/
            if($(window).scrollTop() >= 600){
                $('.go-top-btn').fadeIn();
            }else{
                $('.go-top-btn').fadeOut();
            }
        });
        /*回到头部*/
        $('.go-top-btn').click(function () {
            $(window).scrollTop(0);
        });

        /*如果此处的监控不支持ie，要不要给个提示*/
        var ua = navigator.userAgent.toLowerCase(), sUa = ua.match(/msie ([\d.]+)/);
        if (sUa) {
            if (parseInt(sUa[1]) == 9) {
                $('.cut-img-top .cut-time').css({'background':'rgba(255,255,255,.5)','color':'#666'});
            }
        }
    })
</script>
</@p.pageFrame>