<#assign ctx=request.contextPath/>
<div class="pe-main-wrap">
    <div class="pe-main-content">
        <div class="pe-break-nav-tip-container">
            <ul class="pe-break-nav-ul">
                <li class="pe-brak-nav-items">评卷</li>
                <li class="pe-brak-nav-items iconfont icon-bread-arrow">评卷管理</li>
            </ul>
        </div>
        <div class="exam-manage-all-wrap pe-mark-wrap">
            <div class="pe-manage-panel pe-manage-default" style="border: none;background: none;">
                <div class="pe-nav pe-payment-tabs pe-manage-tab">
                    <ul class="pe-nav-bar">
                        <li class="pe-nav-list pe-nav-active" data-url="${ctx!}/ems/judge/manage/initWaitPage">待评卷</li>
                        <li class="pe-nav-list" data-url="${ctx!}/ems/judge/manage/initMarkedPage">已评卷</li>
                    </ul>
                    <div class="pe-nav-pane pe-nav-active pe-manage-pane">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        var managePage = {
            init: function () {
                var _this = this;
                _this.bind();
                _this.initData();
            },

            initData: function () {
                var url = $('.pe-nav-list.pe-nav-active').data('url');
                $('.pe-nav-pane').load(url);
            },

            bind: function () {
               $('.pe-payment-tabs').find('.pe-nav-list').bind('click', function (e) {
                   var e = e || window.event;
                    e.stopPropagation();
                    $(this).addClass('pe-nav-active').siblings().removeClass('pe-nav-active');
                    var url = $(this).data('url');
                    $('.pe-nav-pane').load(url);
                });
            }
        };

        managePage.init();
    });
</script>