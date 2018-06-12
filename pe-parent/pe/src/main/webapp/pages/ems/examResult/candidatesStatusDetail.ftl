<#assign ctx=request.contextPath/>
<#--todo开发开始做这个页面的跳转时记得把下面的import和p.pageFrame删除-->
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<#--考生状态明细头部-->
<header class="pe-public-top-nav-header" data-id="">
    <div class="pe-top-nav-container">
        <ul class="clearF pe-status-item">
            <li class="pe-result-detail floatL">${(exam.examName)!}</li>
        </ul>
    </div>
</header>
<div class="pe-container-main">
    <div class="pe-manage-panel" style="background: none;margin-top: 20px;border: none;">
        <div class="pe-nav pe-nav-line" style="background: none">
            <ul class="pe-nav-bar">
                <li class="pe-nav-list pe-nav-active" data-url="${ctx!}/ems/examResult/manage/initAllDetailPage">应考</li>
                <li class="pe-nav-list" data-url="${ctx!}/ems/examResult/manage/initReleasePage">已发布成绩</li>
                <li class="pe-nav-list" data-url="${ctx!}/ems/examResult/manage/initMarkingPage">评卷中</li>
                <li class="pe-nav-list" data-url="${ctx!}/ems/examResult/manage/initProcessPage">考试中</li>
                <li class="pe-nav-list" data-url="${ctx!}/ems/examResult/manage/initWaitReleasePage">待发布</li>
                <#if exam.status == 'OVER' && exam.examType != 'OFFLINE'>
                    <li class="pe-nav-list" data-url="${ctx!}/ems/examResult/manage/initMissPage">缺考</li>
                </#if>
            </ul>
            <div class="pe-manage-content-right release-detail-panel" style="margin-top: 20px;margin-left: 0;">

            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        var $navLine = $('.pe-nav-line');
        var examId = '${(exam.id)!}';
        var detailExam = {
            init: function () {
                this.bind();
                this.initData();
            },

            initData: function () {
                var defaultUrl = $('.pe-nav-list').eq(0).data('url');
                $('.release-detail-panel').load(defaultUrl, {examId: examId});
            },

            bind: function () {
                $navLine.find('.pe-nav-list').each(function (index) {
                    $(this).attr('data-index', index);
                });
                $navLine.find('.pe-nav-list').bind('click', function (e) {
                    $(this).addClass('pe-nav-active').siblings().removeClass('pe-nav-active');
                    $navLine.find('.pe-nav-pane').removeClass('pe-nav-active');
                    var url = $(this).data('url');
                    $('.release-detail-panel').load(url, {examId: examId});
                });
            }
        };

        detailExam.init();

    });
</script>
</@p.pageFrame>