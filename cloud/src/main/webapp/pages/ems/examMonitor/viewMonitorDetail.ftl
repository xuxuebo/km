<#assign ctx=request.contextPath/>
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<#--公用头部-->
<div class="pe-public-top-nav-header" data-id="">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="pe-monitor-detail">
            <#--  <a class="pe-for-check floatL" target="_blank"
                                           href="${ctx!}/ems/examMonitor/manage/initDetail?examId=${(examMonitor.exam.id)!}&userId=${(user.id)!}"><i
                  class="iconfont icon-preview"></i>查看监控详情</a>-->
                <span class="pre-bank-items-name floatL" style="font-size: 18px;">查看监控详情</span>
            </li>
        </ul>
    </div>
</div>
<section class="pe-main-content">
    <div class="pe-monitor-item">
         <div class="pe-monitor-item-con">
              <div class="pe-monitor-item-left">
                   <div class="pe-monitor-img">
                       <img onerror="javascript:this.src='${resourcePath!}/web-static/proExam/images/default/default_face.png'" src="${(user.facePath)!'${resourcePath!}/web-static/proExam/images/default_face.png'}">
                   </div>
                   <div class="pe-monitor-show">
                       <h2 class="pe-view-monitor-title">${(user.userName)!}</h2>
                        <#if user.mobile??>
                       <dl>
                           <dt>手&emsp;机：</dt>
                           <dd>${(user.mobile)!}</dd>
                       </dl>
                        </#if>
                       <#if user.idCard??>
                           <dl>
                               <dt>身份证：</dt>
                               <dd>${(user.idCard)!}</dd>
                           </dl>
                       </#if>
                       <#if examMonitor.ticket??>
                           <dl>
                               <dt>准考证：</dt>
                               <dd>${(examMonitor.ticket)!}</dd>
                           </dl>
                       </#if>
                   </div>
              </div>
              <div class="pe-monitor-item-right">
                  <ul>
                      <li class="pe-view-monitor-item">
                          <#if !(examMonitor.exitTimes??) || examMonitor.exitTimes ==0>
                              <p class="pe-view-monitor-zero">0</p>
                          <#else>
                              <p class="pe-view-monitor-num">${(examMonitor.exitTimes)!}</p>
                          </#if>
                          <p class="pe-view-monitor-status">异常退出</p>
                      </li>
                      <li class="pe-view-monitor-item">
                          <#if !(examMonitor.cutScreenCount??) || examMonitor.cutScreenCount ==0>
                              <p class="pe-view-monitor-zero">0</p>
                          <#else>
                              <p class="pe-view-monitor-num">${(examMonitor.cutScreenCount)!}</p>
                          </#if>
                          <p class="pe-view-monitor-status">切屏次数</p>
                      </li>
                      <li>
                          <#if !(examMonitor.illegalCount??) || examMonitor.illegalCount ==0>
                              <p class="pe-view-monitor-zero">0</p>
                          <#else>
                          <p class="pe-view-monitor-num">${(examMonitor.illegalCount)!}</p>
                          </#if>
                          <p class="pe-view-monitor-status">违纪次数</p>
                      </li>
                  </ul>
              </div>
         </div>
    </div>
    <div class="pe-monitor-item">
        <div class="pe-view-monitor-wrap">
             <ul>
                 <li class="pe-view-monitor-iteming">
                     <h3 class="pe-view-monitor-test-title">考试过程</h3>
                     <ul>
                         <#if examMonitor.ugs?? && (examMonitor.ugs?size>0)>
                             <#list examMonitor.ugs as ug>
                                 <li class="pe-monitor-contain">
                                     <span class="pe-monitor-time">${(ug.s?string('MM.dd HH:mm:ss'))!}</span>
                                 <span class="pe-monitor-line">
                                     <em class="iconfont icon-tree-dot pe-monitor-pointer"></em>
                                 </span>
                                     <strong class="pe-monitor-enter">进入考试</strong>
                                 </li>
                                <#if ug.e?? && (ug_index+1 < (examMonitor.ugs?size))>
                                    <li class="pe-monitor-contain">
                                        <span class="pe-monitor-time">${(ug.e?string('MM.dd HH:mm:ss'))!}</span>
                                         <span class="pe-monitor-line">
                                             <em class="iconfont icon-tree-dot pe-monitor-pointer-red"></em>
                                         </span>
                                        <strong class="pe-monitor-enter"><#if (ug_index+1 == (examMonitor.ugs?size)) && examMonitor.answerStatus?? && examMonitor.answerStatus == 'SUBMIT_EXAM' >提交试卷<#else>异常退出</#if></strong>
                                    </li>
                                </#if>
                                <#if (ug_index+1 == (examMonitor.ugs?size)) && ((examMonitor.answerStatus?? && examMonitor.answerStatus == 'SUBMIT_EXAM') || (ug.t?? && ug.t == 'EO'))>
                                    <li class="pe-monitor-contain">
                                        <span class="pe-monitor-time">${(ug.e?string('MM.dd HH:mm:ss'))!}</span>
                                        <span class="pe-monitor-line">
                                             <em class="iconfont icon-tree-dot pe-monitor-pointer-red"></em>
                                         </span>
                                        <strong class="pe-monitor-enter"><#if (examMonitor.answerStatus?? && examMonitor.answerStatus == 'SUBMIT_EXAM')>提交试卷<#else>异常退出</#if></strong>
                                    </li>
                                </#if>
                             </#list>
                             <li class="pe-monitor-contain">
                             <span class="pe-monitor-line-con">
                             </span>
                             </li>
                         </#if>
                     </ul>
                 </li>
                 <#if illegalRecords?? && (illegalRecords?size>0)>
                     <li class="pe-view-monitor-iteming">
                         <h3 class="pe-view-monitor-test-title">违纪处理</h3>
                         <ul style="overflow: hidden;">
                             <#list illegalRecords as illegalRecord>
                                 <li>
                                     <div class="pe-monitor-handle-wrap">
                                         <p class="pe-monitor-handle-time"><span class="pe-monitor-array">${(illegalRecord_index+1)}</span>${(illegalRecord.createTime?string('yyyy-MM-dd HH:mm'))}</p>
                                         <dl>
                                             <dt>违纪情况：</dt>
                                             <dd>${(illegalRecord.illegalContent)!}</dd>
                                         </dl>
                                         <dl>
                                             <dt>处理人：</dt>
                                             <dd>${(illegalRecord.processUser.userName)!}</dd>
                                         </dl>
                                     </div>
                                 </li>
                             </#list>
                         </ul>
                     </li>
                 </#if>
                 <li class="pe-view-monitor-iteming" style="border-bottom: none;">
                     <h3 class="pe-view-monitor-test-title">抓拍详情</h3>
                     <ul class="pe-view-monitor-des">
                         <li>
                             <div class="pe-view-monitor-img monitor-header-img">
                                 <img onerror="javascript:this.src='${resourcePath!}/web-static/proExam/images/default/default_face.png'" src="${(user.facePath)!'${resourcePath!}/web-static/proExam/images/default_face.png'}"
                                      style="border-radius: 50%;"/>
                             </div>
                             <p class="pe-monitor-images ">个人头像</p>
                         </li>
                         <#if examMonitor.images?? && (examMonitor.images?size>0)>
                             <#list examMonitor.images as em>
                                 <li class="pe-monitor-img-con">
                                     <div class="pe-view-monitor-img pe-monitor-catch-img">
                                         <img src="${(em.iu)!}"/>
                                     </div>
                                     <p class="pe-monitor-images ">${(em.ct?string('yyyy-MM-dd HH:mm:ss'))!}</p>
                                 </li>
                             </#list>
                         </#if>
                     </ul>
                 </li>
             </ul>
        </div>
    </div>
    <div class="pe-monitor-btn">
        <button class="pe-btn pe-btn-blue pe-btn-save">关闭</button>
    </div>
</section>
<script>
    $(function(){
        $('.pe-btn-save').on('click',function(){
            window.close();
        })
    });
</script>
</@p.pageFrame>