<#assign ctx=request.contextPath/>
<#--todo开发开始做这个页面的跳转时记得把下面的import和p.pageFrame删除-->
<#import "../../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-container-main">
    <div class="pe-manage-panel" style="background: none;margin-top: 20px;border: none;">
        <div class="pe-nav pe-nav-line" style="background: none">
            <ul class="pe-nav-bar">
                <li class="pe-nav-list pe-nav-active" data-template="basicTemp">基本配置
                </li>
                <li class="pe-nav-list" data-template="checkExamTemp">查询缓存考试信息</li>
                <li class="pe-nav-list" data-template="submitExamTemp">手动提交考试</li>
            </ul>
            <div class="pe-manage-content-right release-detail-panel" style="margin-top: 20px;margin-left: 0;">

            </div>
        </div>
    </div>
</div>
<script type="text/template" id="basicTemp">
    <div class="pe-add-user-item-wrap over-flow-hide" style="min-height: 300px;">
        <div class="pe-user-msg-detail" style="margin-top: 20px;">
            <label class="pe-question-label">
                <span class="pe-input-tree-text" style="width: 150px;text-align: right;">静态资源版本号:</span>
                <input class="pe-stand-filter-form-input pe-question-score-num" type="text"
                       value="${(resourceVersion)!}"
                       name="version">
            </label>
        </div>
    </div>
    <div class="pe-btns-wrap">
        <button class="pe-btn pe-btn-blue pe-btn-save save-basic-btn" type="button" style="margin-left:89px;">保存
        </button>
    </div>
</script>

<script type="text/template" id="checkExamTemp">
    <div class="pe-stand-filter-form" style="padding-top: 20px;padding-left: 20px;">
        <div class="pe-stand-form-cell">
            <label class="pe-form-label floatL">
                <span class="pe-label-name floatL">考试ID:</span>
                <input id="peMainKeyText" class="pe-stand-filter-form-input"
                       type="text" placeholder="请输入考试ID"
                       name="examId">
            </label>
            <label class="pe-form-label floatL">
                <span class="pe-label-name floatL">考生ID:</span>
                <input id="peMainKeyText" class="pe-stand-filter-form-input"
                       type="text" placeholder="考生ID"
                       name="userId">
            </label>
            <button type="button" class="pe-btn pe-btn-blue pe-question-choosen-btn check-exam-result-btn"
                    style="margin: 0; margin-left: 10px;">筛选
            </button>
        </div>
        <div class="pe-stand-form-cell">
            <textarea style="width: 90%;height: 600px;border: 1px solid #e0e0e0;" readonly name="examAnswer"></textarea>
        </div>

    </div>
</script>

<script type="text/template" id="submitExamTemp">
    <div class="pe-stand-filter-form" style="padding-top: 20px;padding-left: 20px;">
        <div class="pe-stand-form-cell simple-temp-cla" >
            <label class="pe-form-label floatL">
                <span class="pe-label-name floatL">企业ID:</span>
                <input id="peMainKeyText" class="pe-stand-filter-form-input"
                       type="text" placeholder="请输入企业ID"
                       name="corpCode">
            </label>
            <label class="pe-form-label floatL">
                <span class="pe-label-name floatL">考试ID:</span>
                <input id="peMainKeyText" class="pe-stand-filter-form-input"
                       type="text" placeholder="请输入考试ID"
                       name="examId">
            </label>
            <label class="pe-form-label floatL" style="margin-left: 15px;">
                <span class="pe-label-name floatL">考生ID:</span>
                <input id="peMainKeyText" class="pe-stand-filter-form-input"
                       type="text" placeholder="考生ID"
                       name="userId">
            </label>
            <button type="button" class="pe-btn pe-btn-blue pe-question-choosen-btn submit-exam-btn"
                    style="margin: 0; margin-left: 10px;">提交
            </button>
        </div>

        <div class="pe-stand-form-cell" style="margin-top: 20px;">
            <textarea style="width: 90%;height: 300px;border: 1px solid #e0e0e0;" name="urString"></textarea>
        </div>


    </div>
</script>

<script type="text/javascript">
    $(function () {
        var $navLine = $('.pe-nav-line');
        var detailExam = {
            init: function () {
                this.bind();
                this.initData();
            },

            initData: function () {
                $('.release-detail-panel').html(_.template($('#basicTemp').html())({}));
            },

            bind: function () {
                $navLine.find('.pe-nav-list').each(function (index) {
                    $(this).attr('data-index', index);
                });
                $navLine.find('.pe-nav-list').bind('click', function (e) {
                    $(this).addClass('pe-nav-active').siblings().removeClass('pe-nav-active');
                    $navLine.find('.pe-nav-pane').removeClass('pe-nav-active');
                    var templateName = $(this).data('template');
                    $('.release-detail-panel').html(_.template($('#'+templateName).html())({}));
                });

                $navLine.delegate('.save-basic-btn', 'click', function () {
                    var version = $('input[name="version"]').val();
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/bg/manage/saveVersion',
                        data: {version: version},
                        success: function (data) {
                            if (!data.success) {
                                PEMO.DIALOG.tips({
                                    content: data.message,
                                    time: 1000
                                });

                                return false;
                            }

                            PEMO.DIALOG.tips({
                                content: '保存成功',
                                time: 1000
                            });
                        }
                    })
                });

                $navLine.delegate('.check-exam-result-btn', 'click', function () {
                    var examId = $('input[name="examId"]').val();
                    var userId = $('input[name="userId"]').val();
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/bg/manage/getExamResult',
                        data: {examId: examId, userId: userId},
                        success: function (data) {
                            $('textarea[name="examAnswer"]').val(data);
                        }
                    })
                });

                $navLine.delegate('.submit-exam-btn', 'click', function () {
                    var examId = $('input[name="examId"]').val();
                    var userId = $('input[name="userId"]').val();
                    var corpCode = $('input[name="corpCode"]').val();
                    var urString = $('textarea[name="urString"]').val();
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/bg/manage/submitExam',
                        data: {examId: examId, userId: userId, corpCode: corpCode, urString: urString},
                        success: function (data) {
                            PEMO.DIALOG.tips({
                                content: '评卷成功',
                                time: 1000
                            });
                        }
                    })
                });
            }
        };

        detailExam.init();

    });
</script>
</@p.pageFrame>