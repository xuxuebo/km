<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">用户</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">公司管理</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">公司详情</li>
    </ul>
</div>
<section class="pe-add-user-all-wrap">
    <form id="editItemForm" class="validate" action="javascript:;">
        <input type="hidden" name="id" value="${(corpInfo.id)!}"/>
        <div class="pe-add-user-item-wrap over-flow-hide">
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                 <span class="pe-input-tree-text" style="width: 90px;">
                     <span>企业ID:</span>
                </span>
                ${(corpInfo.corpCode)!}
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>公司名称:</span>
                    </span>
                ${(corpInfo.corpName)!}
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text flaotL clearF" style="width: 90px;">
                         <span>域名设置:</span>
                    </span>
                ${(corpInfo.domainName)!}
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>并发数:</span>
                    </span>
                ${(corpInfo.concurrentNum)!}
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>注册账号数:</span>
                    </span>
                ${(corpInfo.registerNum)!}
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>到期时间:</span>
                    </span>
                ${(corpInfo.endTime?string("yyyy-MM-dd"))!'--'}
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>短信功能:</span>
                    </span>
                <#if corpInfo.messageStatus?? && corpInfo.messageStatus=='OPEN'>开启<#else>未开启</#if>
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>付费项目:</span>
                    </span>
                    <#if corpInfo.payApps?? && corpInfo.payApps!=''> ${(corpInfo.payApps)!}<#else>暂无</#if>
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>公司地址:</span>
                    </span>
                ${(corpInfo.address)!'暂无'}
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>所属行业:</span>
                    </span>
                ${(corpInfo.industry)!'暂无'}
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>联系人:</span>
                    </span>
                ${(corpInfo.contacts)!'暂无'}
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>联系电话:</span>
                    </span>
                ${(corpInfo.contactsMobile)!'暂无'}
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>电子邮件:</span>
                    </span>
                ${(corpInfo.email)!'暂无'}
                </label>
            </div>
            <div class="pe-user-msg-detail" style="height: 100px;">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>备注:</span>
                    </span>
                ${(corpInfo.comments)!'暂无'}
                </label>
            </div>
            <div class="pe-btns-wrap" style="margin-top: 60px;margin-bottom: 94px;text-align:center;">
                <button class="pe-btn pe-btn-cancel" type="button">返回</button>
            </div>
        </div>
    </form>
</section>
<script>
    $(function () {
        $('.pe-btn-cancel').on('click', function () {
            location.href = '#url=' + pageContext.rootPath + '/corp/manage/initPage&nav=user';
        });
    });
</script>