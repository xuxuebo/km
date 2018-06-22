<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <#--<ul class="pe-break-nav-ul">-->
        <#--<li class="pe-brak-nav-items">用户</li>-->
        <#--<li class="pe-brak-nav-items iconfont icon-bread-arrow">用户管理</li>-->
     <#--&lt;#&ndash;   <li class="pe-brak-nav-items" style="float: right">-->
            <#--<button type="button" class="pe-btn pe-btn-blue pe-question-choosen-btn pe-user-msg-setting">消息设置</button>-->
        <#--</li>&ndash;&gt;-->
    <#--</ul>-->
</div>
<div class="pe-user-manage-all-wrap ">
    <form name="peFormSub" id="peFormSub" class="">
    <#--树状布局开始,可复用,记得调用下面的初始化函数;-->
        <div class="pe-manage-content-left floatL">
            <div class="pe-classify-wrap floatL">
                <div class="pe-classify-top over-flow-hide pe-form">
                    <span class="floatL pe-classify-top-text">按部门筛选</span>
                    <#--<button type="button" title="收起类别面板" data-type="userManage" class="floatR iconfont icon-set"></button>-->
                    <label class="floatR pe-checkbox item-category-include pe-check-by-list" for="peFormEle5">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input class="pe-form-ele" name="organize.include" value="true" checked="checked"
                               type="checkbox"/><span class="include-subclass" style="margin-right:36px;">包含子类</span>
                    </label>
                </div>
                <div class="pe-classify-tree-wrap">
                    <div class="pe-tree-search-wrap">
                    <#--复用时，保留下面的input单独classname 'pe-tree-form-text'-->
                        <input class="pe-tree-form-text" type="text" placeholder="请输入部门名称">
                    <#--<span class="pe-placeholder">请输入题库名称</span>--><#--备用,误删-->
                        <span class="iconfont pe-tree-search-btn icon-search-magnifier"></span>
                    </div>
                    <div class="pe-tree-content-wrap">
                        <div class="pe-tree-main-wrap">
                            <div class="node-search-empty">暂无</div>
                        <#--pe-no-manage-tree为非管理树类添加的样式，是管理类的树，无需此class-->
                            <ul id="peZtreeMain" class="ztree pe-tree-container" data-type="km"></ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <#--树状布局 结束,可复用-->
    <#--右侧表格主题部分开始-->
        <div class="pe-manage-content-right">
            <div class="pe-manage-panel pe-manage-default">
                <div class="pe-manage-panel-head">
                    <div class="pe-stand-filter-form">
                    </div>
                </div>
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel" style="font-size:0;">
                        <@authVerify authCode="USER_MANAGE_ADD">
                        <button type="button" class="pe-btn pe-btn-green pe-new-question-btn"
                                style="margin-right:14px;">新增用户
                        </button>
                        </@authVerify>
                        <button type="button" class="pe-btn pe-btn-white pe-upload-btn">导入</button>

                        <div class="pe-btn all-edit-btn">批量编辑
                            <span class="iconfont icon-btn-arrow-down"></span>
                            <div class="btn-drop-down">
                                <a href="javascript:;" class="drop-item edit-org-btn">部门调动</a>
                                <a href="javascript:;" class="drop-item edit-position-btn">岗位调动</a>
                            </div>
                        </div>
                        <button type="button" class="pe-btn pe-btn-white " id="forbiddenBtn">冻结</button>
                        <button type="button" class="pe-btn pe-btn-white " id="enableBtn">激活</button>
                        <button type="button" class="pe-btn pe-btn-white reset-btn" id="resetPswBtn">重置密码</button>
                        <@authVerify authCode="VERSION_OF_USER_EXPORT">
                        <@authVerify authCode="USER_MANAGE_EXPORT">
                        <div type="button" class="pe-btn export-btn">导出
                            <span class="iconfont icon-btn-arrow-down"></span>
                            <div class="btn-drop-down">
                                <a href="javascript:;" class="drop-item export-all-user">导出全部</a>
                                <a href="javascript:;" class="drop-item export-choose-user">导出选中</a>
                            </div>
                        </div>
                        </@authVerify>
                        </@authVerify>
                        <#--<@authVerify authCode="USER_MANAGE_UPDATE_EXPORT">-->
                        <#--<button type="button" class="pe-btn pe-btn-white modify-import-btn">修改导入</button>-->
                        <#--</@authVerify>-->
                        <a href="javascript:;" class="pe-table-tip set-line-show-item floatR">设置列表显示项</a>
                        <input type="hidden" name="">
                    </div>
                <#--表格包裹的div-->
                    <div class="pe-stand-table-main-panel" style="position:relative;">
                        <div class="pe-scrollTable-wrap userManage-scroll-table">
                            <div class="pe-stand-table-wrap" style="padding:0;"></div>
                        </div>
                        <div class="pe-stand-table-pagination"></div>
                    </div>
                </div>
            </div>
        </div>
    <#--部门节点Id-->
        <input type="hidden" name="organize.id" value="${(organize.id)!}"/>
    <#--岗位Id-->
        <#--<input type="hidden" name="positionId"/>-->
    </form>
    <#--<div class="pe-mask-listen"></div>-->
</div>
<#--简单筛选模板-->
<script type="text/template" id="simpleTemp">
    <div class="simple-form-cell-wrap simaple-form-cell">
        <div class="pe-stand-form-cell">
            <label class="pe-form-label floatL" for="peMainKeyText" style="margin-right:20px">
                <span class="pe-label-name floatL" style="margin-right:5px;">关键字:</span>
                <input id="peMainKeyText" class="pe-stand-filter-form-input pe-table-form-text"
                       type="text" placeholder="姓名/用户名/工号/手机号"
                       name="keyword">
            </label>
            <div id="peMainKmText" class="floatL" style="margin-right:20px;">
                <span class="pe-label-name floatL" style="margin-right:5px;">岗位:</span>
                <div class="pe-position-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                    <input class="pe-tree-show-name show-position-name" value="<%=positionName?positionName:''%>" type="text"/>
                    <input type="hidden" name="positionId"/>
                    <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                    <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop" style="display:none;">
                        <ul id="positionTree" class="ztree pe-tree-container"></ul>
                    </div>
                </div>
            </div>
            <dl class="floatL">
                <dt class="pe-label-name floatL">状态:</dt>
                <dd class="pe-stand-filter-label-wrap">
                    <%if (!status){%>
                    <label class="floatL pe-checkbox pe-uc-state-checkbox" for=""
                           style="margin-right:15px;">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input id="peFormEleStart" class="pe-form-ele enable" checked="checked"
                               type="checkbox"
                               name="userStatusList" value="ENABLE"/>激活
                    </label>
                    <label class="floatL pe-checkbox pe-uc-freeze-checkbox" for="">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input id="peFormEleStop" class="pe-form-ele forbidden" type="checkbox" checked="checked"
                               name="userStatusList"
                               value="FORBIDDEN"/>冻结
                    </label>
                    <%} else if (status == 'ENABLE'){%>
                    <label class="floatL pe-checkbox pe-uc-state-checkbox" for=""
                           style="margin-right:15px;">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input id="peFormEleStart" class="pe-form-ele enable" checked="checked"
                               type="checkbox"
                               name="userStatusList" value="ENABLE"/>激活
                    </label>
                    <label class="floatL pe-checkbox pe-uc-freeze-checkbox" for="">
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <input id="peFormEleStop" class="pe-form-ele forbidden" type="checkbox"
                               name="userStatusList"
                               value="FORBIDDEN"/>冻结
                    </label>
                    <%} else {%>
                    <label class="floatL pe-checkbox pe-uc-state-checkbox" for=""
                           style="margin-right:15px;">
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <input id="peFormEleStart" class="pe-form-ele enable"
                               type="checkbox"
                               name="userStatusList" value="ENABLE"/>激活
                    </label>
                    <label class="floatL pe-checkbox pe-uc-freeze-checkbox" for="">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input id="peFormEleStop" class="pe-form-ele forbidden" type="checkbox" checked="checked"
                               name="userStatusList"
                               value="FORBIDDEN"/>冻结
                    </label>
                    <%}%>
                </dd>
            </dl>
            <div class="pe-choosen-btn-wrap">
                <button type="button" class="pe-btn pe-btn-blue pe-question-choosen-btn">筛选</button>
                <a href="javascript:;" class="choosen-advace-opt-type">高级筛选</a>
            </div>

        </div>
    </div>
</script>
<#--高级筛选模板-->
<script type="text/template" id="advaceTemp">
    <div class="simple-form-cell-wrap advace-form-cell">
        <div class="pe-stand-form-cell" >
        <#--高级岗位-->
            <div class="floatL" style="margin-right:30px;">
                <span class="pe-label-name floatL">岗&emsp;位:</span>
                <div class="pe-position-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                    <input class="pe-tree-show-name show-position-name" value="<%=positionName?positionName:''%>"/>
                    <input type="hidden" name="positionId"/>
                    <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                    <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop" style="display:none;">
                        <ul id="positionTree" class="ztree pe-tree-container"></ul>
                    </div>
                </div>
            </div>
            <label class="pe-form-label floatL" for="peMainKeyText" style="margin-right:30px;">
                <span class="pe-label-name floatL">&emsp;姓&emsp;名:</span>
                <input id="peMainKeyText" class="pe-stand-filter-form-input pe-table-form-text"
                       type="text" placeholder="姓名"
                       name="userName">
            </label>
            <label class="pe-form-label">
                <span class="pe-label-name floatL">用户名:</span>
                <input id="peMainKeyText" class="pe-stand-filter-form-input pe-table-form-text"
                       type="text" placeholder="用户名"
                       name="loginName">
            </label>
        </div>
        <div class="pe-stand-form-cell" >
            <label class="pe-form-label floatL" for="peMainKeyText">
                <span class="pe-label-name floatL">手机号:</span>
                <input id="peMainKeyText" class="pe-stand-filter-form-input pe-table-form-text"
                       type="text" placeholder="手机号"
                       name="mobile">
            </label>
            <label class="pe-form-label floatL" for="peMainKeyText" style="margin-right:30px;">
                <span class="pe-label-name">&emsp;工&emsp;号:</span>
                <input id="peMainKeyText" class="pe-stand-filter-form-input pe-table-form-text"
                       type="text" placeholder="工号"
                       name="employeeCode">
            </label>
            <label class="pe-form-label" for="peMainKeyText">
                <span class="pe-label-name">身份证:</span>
                <input id="peMainKeyText" class="pe-stand-filter-form-input pe-table-form-text"
                       type="text" placeholder="身份证"
                       name="idCard">
            </label>
        </div>
        <div class="pe-stand-form-cell" >
            <label class="pe-form-label floatL" >
                <span class="pe-label-name">邮&emsp;箱:</span>
                <input id="peMainKeyText" class="pe-stand-filter-form-input pe-table-form-text"
                       type="text" placeholder="邮箱"
                       name="email">
            </label>
            <label class="pe-form-label" for="peMainKeyText" style="margin-right:30px;">
                <span class="pe-label-name floatL">入职日期:</span>
                <input data-toggle="datepicker" style="width:152px;" class="pe-table-form-text laydate-icon pe-stand-filter-form-input pe-time-text pe-start-time"
                       type="text" name="entryTime">
            </label>
        </div>
        <div class="pe-stand-form-cell" style="overflow:visible;margin-bottom: 0;">
            <div class="pe-form-label pe-form-select floatL" style="margin-right:38px;">
                <span class="pe-label-name floatL">状&emsp;态:</span>
                <select class="select-status dropdown" name="userStatusList">
                    <%if (!status || status.length>1) {%>
                    <option value="" selected>全部</option>
                    <%} else {%>
                    <option value="">全部</option>
                    <%}%>
                    <%if (status && status.length ==1 && _.contains(status,'ENABLE')) {%>
                    <option value="ENABLE" selected>激活</option>
                    <%} else {%>
                    <option value="ENABLE">激活</option>
                    <%}%>
                    <%if (status && status.length ==1 && _.contains(status,'FORBIDDEN')) {%>
                    <option value="FORBIDDEN" selected>冻结</option>
                    <%} else {%>
                    <option value="FORBIDDEN">冻结</option>
                    <%}%>
                </select>
            </div>

            <div class="pe-form-label floatL pe-form-select" style="margin-right:38px;">
                 <span class="pe-label-name floatL">性&emsp;别:</span>
                <select class="select-sex dropdown" name="sexType">
                    <option value="" selected>全部</option>
                    <option value="MALE">男</option>
                    <option value="FEMALE">女</option>
                    <option value="SECRECY">保密</option>
                </select>
            </div>
            <#if roles?? && (roles?size>0)>
                <div class="pe-form-label floatL pe-form-select pe-user-select">
                    <span class="pe-label-name floatL">角&emsp;色:</span>
                    <select class="select-role dropdown" name="roleId">
                        <option value="" selected>全部</option>
                        <#list roles as role>
                            <option value="${(role.id)!}">${(role.roleName)!}</option>
                        </#list>
                    </select>
                </div>
            </#if>
            <div class="pe-choosen-btn-wrap" style="margin-left: 82px;">
                <button type="button" class="pe-btn pe-btn-blue pe-question-choosen-btn">筛选</button>
                <a href="javascript:;" class="choosen-simaple-opt-type">简单筛选</a>
            </div>
        </div>
    </div>
</script>
<#--右侧表格主题部分结束-->
<#--渲染非固定表格部分模板-->
<script type="text/template" id="peQuestionTableTep">
    <table class="pe-stand-table pe-stand-table-default checkbox-table">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i<lenI;i++){%>
            <%if (peData.tableTitles[i].checked){%>
                 <%if(peData.tableTitles[i].columnName === 'sexType'|| peData.tableTitles[i].columnName === 'employeeCode'){%>
                    <th style="width:36px;">
                 <%}else if(peData.tableTitles[i].columnName === 'status' ){%>
                   <th style="width:30px;">
                 <%}else if(peData.tableTitles[i].columnName === 'entryTime'){%>
                    <th style="width:90px;">
                 <%}else if(peData.tableTitles[i].columnName === 'mobile'){%>
                    <th style="width:80px;">
                 <%}else if(peData.tableTitles[i].columnName === 'positionName' || peData.tableTitles[i].columnName === 'email'|| peData.tableTitles[i].columnName === 'organizeName'){%>
                    <th style="width:136px;">
                 <%}else if(peData.tableTitles[i].columnName === 'idCard'){%>
                    <th style="width:150px;">
                 <%}%>
                <%if(peData.tableTitles[i].columnName !== 'checkbox' && peData.tableTitles[i].columnName !== 'opt'&& peData.tableTitles[i].columnName !== 'userName'&& peData.tableTitles[i].columnName !== 'loginName'){%>
                    <div class="pe-ellipsis" title="<%=peData.tableTitles[i].columnTitle%>"><%=peData.tableTitles[i].columnTitle%></div>
                <%}%>
                </th>
            <%}}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
        <tr data-id="<%=peData.rows[j].id%>">
            <%_.each(peData.tableTitles,function(titleColumn){ if (titleColumn.checked) {%>
          <%if (titleColumn.columnName == 'status'){ if(peData.rows[j].status === 'FORBIDDEN'){%>
                <td style="color:#fc4e51;">冻结</td>
                <%}else if(peData.rows[j].status === 'ENABLE'){%>
                <td>激活</td>
                <%}else {%>
                <td></td>
                <%}%>
            <%} else if (titleColumn.columnName == 'sexType') { if (peData.rows[j].sexType === 'MALE') {%>
            <td>男</td>
            <%} else if(peData.rows[j].sexType === 'FEMALE') {%>
            <td>女</td>
            <%} else {%>
            <td>保密</td>
            <%}%>
            <%}else if(titleColumn.columnName == 'userName'){%>

            <%}else {%>
            <%if(titleColumn.columnName !== 'checkbox' && titleColumn.columnName !== 'opt'&& titleColumn.columnName !== 'userName'&& titleColumn.columnName !== 'loginName'){%>
                <%if (titleColumn.columnName === 'entryTime' && peData.rows[j][titleColumn.columnName]) {%>
                <td><div class="pe-ellipsis" title="<%=moment(peData.rows[j][titleColumn.columnName]).format('YYYY-MM-DD')%>"><%=moment(peData.rows[j][titleColumn.columnName]).format('YYYY-MM-DD')%></div></td>
                <%} else {%>
                <td><div class="pe-ellipsis" title="<%=peData.rows[j][titleColumn.columnName]%>"><%=peData.rows[j][titleColumn.columnName]%></div></td>
                <%}%>
            <%}%>
            <%}}});%>
        <#--操作-->
        </tr>
        <%}%>
        <%}else{%>
        <tr>
            <td class="pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
                <div class="pe-result-no-date"></div>
                <p class="pe-result-date-warn">暂无数据</p>
            </td>
        </tr>
        <%}%>
        </tbody>
    </table>
</script>
<#--渲染左边“操作栏”固定表格部分模板-->
<script type="text/template" id="peQuestionLeftFixedTableTep">
    <table class="pe-stand-table pe-stand-table-default checkbox-table userMana-left-fixed-table pe-fixed-table-panel floatR">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i<lenI;i++){%>
            <%if(peData.tableTitles[i].columnTitle === 'checkbox') {%>
            <th style="width:16px">
                <label class="pe-checkbox pe-paper-all-check">
                    <span class="iconfont icon-unchecked-checkbox"></span>
                    <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheckAll"/>
                </label>
            </th>
            <%}else{%>
                 <%if(peData.tableTitles[i].columnName === 'userName'){%>
                    <th style="width:70px;">
                 <%}else if(peData.tableTitles[i].columnName === 'loginName'){%>
                     <th style="width:98px">
                 <%}%>
                <%if(peData.tableTitles[i].columnName === 'userName'|| peData.tableTitles[i].columnName === 'loginName'){%>
                    <div class="pe-ellipsis" title="<%=peData.tableTitles[i].columnTitle%>"><%=peData.tableTitles[i].columnTitle%></div>
                <%}%>
                  </th>
            <%}%>
           <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
            <tr data-id="<%=peData.rows[j].id%>">
                <%_.each(peData.tableTitles,function(titleColumn,titleIndex){ %>
                <%if(titleColumn.columnName === 'checkbox'){%>
                    <%if(j === peData.rows.length -1){%>
                        <td style="border-bottom:1px solid #e0e0e0;">
                            <%}else{%>
                        <td>
                    <%}%>
                            <label class="pe-checkbox pe-paper-check" data-id="<%=peData.rows[j].id%>">
                                <span class="iconfont icon-unchecked-checkbox"></span>
                                <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheck"/>
                            </label>
                        </td>
                <%}else if(titleColumn.columnName === 'userName'){%>
                    <%if(j === peData.rows.length -1){%>
                        <td style="border-bottom:1px solid #e0e0e0;">
                            <%}else{%>
                        <td>
                    <%}%>
                        <a class="pe-stand-table-alink pe-dark-font pe-ellipsis" title=" <%=peData.rows[j][titleColumn.columnName]%>"
                           href="${ctx!}/uc/user/manage/initViewUserPage?id=<%=peData.rows[j].id%>" target="_blank">
                            <%=peData.rows[j][titleColumn.columnName]%>
                        </a>
                    </td>
                <%}else if(titleColumn.columnName === 'loginName'){%>
                    <%if(j === peData.rows.length -1){%>
                        <td style="border-bottom:1px solid #e0e0e0;">
                     <%}else{%>
                        <td>
                    <%}%>
                        <div class="pe-ellipsis" title="<%=peData.rows[j][titleColumn.columnName]%>"><%=peData.rows[j][titleColumn.columnName]%></div>
                    </td>
                <%}%>
                <%});%>
            </tr>
            <%}%>
            <%}else{%>
            <tr>
                <td class="pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">

                </td>
            </tr>
            <%}%>
        </tbody>
    </table>
</script>
<#--渲染右边“操作栏”固定表格部分模板-->
<script type="text/template" id="peQuestionRightFixedTableTep">
    <table class="pe-stand-table pe-stand-table-default userMana-right-fixed-table pe-fixed-table-panel floatR">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i<lenI;i++){%>
            <%if(peData.tableTitles[i].columnName === 'opt'){%>
                <th style="width:76px;">
                    <div class="pe-ellipsis" title="<%=peData.tableTitles[i].columnTitle%>"><%=peData.tableTitles[i].columnTitle%></div>
                </th>
            <%}}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%for(var j =0,lenJ = peData.rows.length;j<lenJ ;j++){%>
            <tr data-id="<%=peData.rows[j].id%>">
                <%_.each(peData.tableTitles,function(titleColumn,titleIndex){ %>
                   <%if (titleColumn.columnName == 'opt') {%>
                        <%if(j === peData.rows.length -1){%>
                            <td style="border-bottom:1px solid #e0e0e0;">
                        <%}else{%>
                            <td>
                         <%}%>
                        <div class="pe-stand-table-btn-group">
                            <span class="pe-table-edit-btn pe-icon-btn iconfont icon-edit" title="编辑"
                                  data-id="<%=peData.rows[j].id%>"></span>
                            <%if(peData.rows[j].status === 'ENABLE'){%>
                            <span class="pe-table-stop-btn pe-icon-btn iconfont icon-freeze freezeUser" title="冻结"
                                  data-id="<%=peData.rows[j].id%>"></span>
                            <%}else if(peData.rows[j].status === 'FORBIDDEN'){%>
                            <span class="pe-table-start-btn pe-icon-btn iconfont icon-activate enableUser" title="激活"
                                  data-id="<%=peData.rows[j].id%>"></span>
                            <%}%>
                            <span class="pe-table-dele-btn pe-icon-btn iconfont icon-delete <%if (!peData.rows[j].disableDelete) {%>deleteUser<%}%>" title="删除" <%if (peData.rows[j].disableDelete) {%>disabled<%}%>
                                  data-id="<%=peData.rows[j].id%>"></span>
                        </div>
                    </td>
                    <%}%>
                <%});%>
            </tr>
            <%}%>
            <%}else{%>
            <tr>
                <#--<td class="pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">-->

                <#--</td>-->
            </tr>
            <%}%>
        </tbody>
    </table>
</script>
<#--部门调动里的部门输入框模板-->
<script type="text/template" id="orgConfirmDialogTemp">
    <span class="pe-label-name floatL">部门名称:</span>
    <div class="pe-input-tree-wrap pe-stand-filter-form-input org-tree-wrap">
        <input class="pe-tree-show-name show-org-name" readonly>
        <input class="pe-tree-show-id" type="hidden" name="organizeId">
        <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
        <div class="pe-select-tree-wrap pe-input-tree-wrap-drop">
            <ul id="editOrgTree" class="ztree pe-tree-container"></ul>
        </div>
    </div>
</script>
<#--岗位输入框模板-->
<script type="text/template" id="positionConfirmDialogTemp">
    <span class="pe-label-name floatL">岗位名称:</span>
    <div class="pe-input-tree-content pe-position-input-tree" style="width:413px;">
        <label class="input-tree-choosen-label" style="max-width:345px;">
            <input class="pe-tree-show-name" value="" name="positionName" style="width:2px;"></input>
        </label>
        <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"
              style="height:34px;line-height:34px;"></span>
        <span class="iconfont icon-inputDele position-input-tree-dele input-icon"
              style="display:none;"></span>
        <div class="pe-select-tree-wrap pe-input-tree-wrap-drop pe-input-tree-drop-two" style="height: 270px!important;width: 425px!important;">
            <ul id="postTreeData" class="ztree pe-tree-container floatL" style="height: 235px!important;"></ul>
            <ul id="bankTreeChildren" class="pe-input-tree-children-container"
                style="overflow: auto;width: 166px!important;height: 235px!important;"></ul>
        </div>
        <input type="hidden" name="positionId"/>
    </div>
</script>
<#--自定义列表显示选项弹框模板-->
<script type="text/template" id="customColumnsTemp">
    <table style="width: 100%;">
        <%for(var index = 0;index < data.length;index++ ) {if(index % 4 ==0){ if (index != 0){%>
        </td><%}%>
        <tr style="height: 30px;">
            <%} if (data[index].columnName == 'userName' || data[index].columnName == 'loginName' || data[index].columnName == 'organizeName') {%>
            <td style="width: 25%;color:#999;"><label class="floatL pe-checkbox pe-uc-freeze-checkbox">
                <span class="iconfont icon-checked-checkbox peChecked" style="color:#8cccf0;"></span>
                <input id="peFormEleStop" class="pe-form-ele" type="checkbox" checked="checked"
                       value="<%=data[index].columnName%>" disabled="disabled"/><%=data[index].columnTitle%>
            </label>
            </td>
            <%} else if (data[index].checked){%>
            <td style="width: 25%;"><label class="floatL pe-checkbox pe-uc-freeze-checkbox">
                <span class="iconfont icon-checked-checkbox peChecked"></span>
                <input id="peFormEleStop" class="pe-form-ele" type="checkbox" checked="checked" name="columnName"
                       value="<%=data[index].columnName%>" title="<%=data[index].columnTitle%>"/><%=data[index].columnTitle%>
            </label>
            </td>
            <%} else {%>
            <td style="width: 25%;"><label class="floatL pe-checkbox pe-uc-freeze-checkbox">
                <span class="iconfont icon-unchecked-checkbox"></span>
                <input id="peFormEleStop" class="pe-form-ele" type="checkbox" name="columnName"
                       value="<%=data[index].columnName%>" title="<%=data[index].columnTitle%>"/><%=data[index].columnTitle%>
            </label>
            </td>
            <%}%>
            <%}%>
    </table>
</script>
<script type="text/template" id="positionTemplate">
    <%if(data.length !== 0){%>
    <%_.each(data, function(position) {%>
    <li class="pe-search-children-nodes">
        <label class="pe-checkbox">
            <%if(_.contains(positionIds,position.id)){%>
            <span class="iconfont icon-checked-checkbox"></span>
            <input class="pe-form-ele" type="checkbox" data-id="<%=position.id%>" checked="checked"
                   title="<%=position.positionName%>" value=""/><%=position.positionName%>
            <%}else{%>
            <span class="iconfont icon-unchecked-checkbox"></span>
            <input class="pe-form-ele" type="checkbox" data-id="<%=position.id%>" title="<%=position.positionName%>"
                   value=""/><%=position.positionName%>
            <%}%>
        </label>
    </li>
    <%});%>
    <%}else{%>
    <div class="input-tree-no-data-tip">此类别下暂无数据</div>
    <%}%>
</script>

<script>
    $(function () {
        //ie9不支持Placeholder问题
//        PEBASE.isPlaceholder();
        var columnsSetting = [{'columnName': 'userName', 'columnTitle': '姓名','checked':true},
            {'columnName': 'loginName', 'columnTitle': '用户名', 'checked':true},
            {'columnName': 'organizeName', 'columnTitle': '部门', 'checked': false},
            {'columnName': 'employeeCode', 'columnTitle': '工号', 'checked':true},
            {'columnName': 'mobile', 'columnTitle': '手机号', 'checked': true},
            {'columnName': 'positionName', 'columnTitle': '岗位', 'checked': true},
            {'columnName': 'status', 'columnTitle': '状态', 'checked': true},
            {'columnName': 'idCard', 'columnTitle': '身份证', 'checked': false},
            {'columnName': 'email', 'columnTitle': '邮箱', 'checked': false},
            {'columnName': 'sexType', 'columnTitle': '性别', 'checked': false},
            {'columnName': 'entryTime', 'columnTitle': '入职日期', 'checked': false}];
        var userManage = {
            init: function () {
                $('.set-line-show-item').on('click', function () {
                    PEMO.DIALOG.confirmR({
                        content: _.template($('#customColumnsTemp').html())({data: columnsSetting}),
                        area: '468px',
                        btn: ['取消','保存'],
                        title: '设置列表展示',
                        btn2: function () {
                            columnsSetting = [{'columnTitle': '姓名', 'columnName': 'userName','checked': true},
                                {'columnTitle': '用户名', 'columnName': 'loginName','checked': true},
                                {'columnTitle': '部门', 'columnName': 'organizeName','checked': true}];
                            $('input[name="columnName"]').each(function (index, ele) {
                                if($(ele).is(':checked')){
                                    columnsSetting.push({'columnTitle': $(ele).attr('title'), 'columnName': $(ele).val(),checked:true});
                                }else{
                                    columnsSetting.push({'columnTitle': $(ele).attr('title'), 'columnName': $(ele).val()});
                                }
                            });

                                if($('.category-show-btn:visible').get(0)){
                                    userManage.initTable(true);
                                }else{
                                    userManage.initTable(false);
                                }
                                layer.closeAll();

                        },
                        btn1: function () {
                            layer.closeAll();
                        },
                        success: function () {
                            PEBASE.peFormEvent('checkbox');
                            $('.layui-layer-content').width(340);
                        }
                    });
                });

                $('.edit-position-btn').on('click', function () {
                    var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                    if (!rows || rows.length <= 0) {
                        PEMO.DIALOG.alert({
                            content: '请至少先选择一项！',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });

                        return false;
                    }

                    PEMO.DIALOG.confirmL({
                        content: _.template($('#positionConfirmDialogTemp').html())({}),
                        area: ['620px','450px'],
                        title: '岗位调动',
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        skin: 'columns-layer-confirm position-change-layer',
                        btn1: function () {
                            var positionId = [];
                            $('input[name="updatePositionId"]').each(function(index,ele){
                                positionId.push($(ele).val());
                            });

                            if (!positionId || positionId.length <= 0) {
                                PEMO.DIALOG.alert({
                                    content: '请选择岗位',
                                    btn: ['我知道了'],
                                    yes: function (index) {
                                        layer.close(index);
                                    }
                                });

                                return false;
                            }

                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/uc/user/manage/updatePosition',
                                data: {userId: JSON.stringify(rows), positionId: JSON.stringify(positionId)},
                                success: function (data) {
                                    if (data.success) {
                                        layer.closeAll();
                                        PEMO.DIALOG.tips({
                                            content: '操作成功',
                                            time: 1000,
                                            end: function () {
                                                $('.pe-stand-table-wrap').peGrid('refresh');
                                            }
                                        });

                                        return false;
                                    }

                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function () {
                                            layer.closeAll();
                                        }
                                    });
                                }
                            });
                        },
                        btn2: function () {
                            layer.closeAll();
                        },
                        success: function () {
                            var postTreeData = {
                                dataUrl: pageContext.rootPath + '/uc/position/manage/listTree',
                                clickNode: function (treeNode) {
                                    userManage.initPositionData(treeNode);
                                },
                                treePosition:'inputDropDown'
                            };

                            PEMO.ZTREE.initTree('postTreeData', postTreeData);
                            inputTreeKeyup($('.pe-position-input-tree'), 'postTreeData');
                            var treeObj = $.fn.zTree.getZTreeObj("postTreeData");
                            treeObj.expandAll(true);
                            var rootNode = treeObj.getNodesByFilter(function (node) { return node.level == 0 }, true);
                            userManage.initPositionData(rootNode);

                            //岗位调动删除小图标执行的函数
//                            $('.position-input-tree-dele').click(function (e) {
                            $('.layui-layer-content').delegate('.position-input-tree-dele','click',function(e){
                                var e = e || window.event;
                                e.stopPropagation();
                                e.preventDefault();
                                $(this).siblings('.input-tree-choosen-label').find('.search-tree-text').remove();
                                var thisCheckedBox = $(this).parent('div').find('.pe-input-tree-wrap-drop').find('.pe-input-tree-children-container').find('li .icon-checked-checkbox');
                                thisCheckedBox.removeClass('icon-checked-checkbox peChecked').addClass('icon-unchecked-checkbox').siblings('input').removeProp('checked');
                                $(this).hide().siblings('.icon-class-tree').show();
                                $('input[name="positionId"]').val('');
                            });
                        }
                    });
                });

                $('.edit-org-btn').on('click', function () {
                    var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                    if (!rows || rows.length <= 0) {
                        PEMO.DIALOG.alert({
                            content: '请至少先选择一项！',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });

                        return false;
                    }

                    PEMO.DIALOG.confirmL({
                        content: _.template($('#orgConfirmDialogTemp').html())({}),
                        area: ['468px','520px'],
                        title: '部门调动',
                        btn: ['确定', '取消'],
                        skin: 'pe-layer-confirm pe-layer-has-tree organize-change-layer',
                        resize:false,
                        btnAlign: 'c',
                        btn1: function () {
                            var organizeId = $('input[name="organizeId"]').val();
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/uc/user/manage/updateOrganize',
                                data: {userId: JSON.stringify(rows), organizeId: organizeId},
                                success: function (data) {
                                    if (data.success) {
                                        layer.closeAll();
                                        PEMO.DIALOG.tips({
                                            content: '操作成功',
                                            time: 1000,
                                            end: function () {
                                                $('.pe-stand-table-wrap').peGrid('refresh');
                                            }
                                        });

                                        return false;
                                    }

                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function () {
                                            layer.closeAll();
                                        }
                                    });
                                }
                            });
                        },
                        btn2: function () {
                            layer.closeAll();
                        },
                        success: function () {
                            //初始化部门类别树
                            var settingInputTree = {
                                isOpen:true,
                                dataUrl: pageContext.rootPath + '/uc/user/manage/listTree',
                                clickNode: function (treeNode) {
                                    if (!treeNode || !treeNode.pId) {
                                        return false;
                                    }

                                    $('input[name="organizeId"]').val(treeNode.id);
                                    $('.show-org-name').val(treeNode.name);
                                },
                                treePosition:'inputDropDown'
                            };

                            PEMO.ZTREE.initTree('editOrgTree', settingInputTree);
                            var treeObj = $.fn.zTree.getZTreeObj("editOrgTree");
                            treeObj.expandAll(true);
                        }
                    });
                });
                //导出全部人员
               $('.export-all-user').on('click',function(){
                    window.open("${ctx!}/uc/user/manage/exportUser",'')
                });
                //导出选中人员
               $('.export-choose-user').on('click',function(){
                    var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                    if (!rows || rows.length <= 0) {
                        PEMO.DIALOG.alert({
                            content: '请至少先选择一项！',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });
                        return false;
                    }
                   window.open("${ctx!}/uc/user/manage/exportUser?id="+rows.join(','),'')

                });
                $('.pe-stand-filter-form').delegate('.choosen-advace-opt-type', 'click', function () {
                    var positionName = $('.show-position-name').val();
                    var status = [];
                    $('input[name="userStatusList"]:checked').each(function (index, ele) {
                        status.push($(ele).val());
                    });

                    userManage.initAdvaceFilter({positionName: positionName, status: status});
                });

                //类别点击筛选事件
                $('.pe-check-by-list').off().click(function () {
                    var iconCheck = $(this).find('span.iconfont');
                    var thisRealCheck = $(this).find('input[type="checkbox"]');
                    if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                        iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                        thisRealCheck.prop('checked', 'checked');
                    } else {
                        iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisRealCheck.removeProp('checked');
                    }

                    $('.pe-stand-table-wrap').peGrid('load', $('#peFormSub').serializeArray());
                });

                $('.pe-stand-filter-form').delegate('.choosen-simaple-opt-type', 'click', function () {
                    var positionName = $('.show-position-name').val();
                    var status = $('select[name="userStatusList"]').val();
                    userManage.initSimpleFilter({positionName: positionName, status: status});
                });

                //冻结人员
                $('.pe-stand-table-main-panel').delegate('.freezeUser', 'click', function () {
                    var userId = $(this).data("id");
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要冻结该账户吗？</h3><p class="pe-dialog-content-tip">冻结后的账户将无法登录考试系统。</p></div>',
                        btn2: function () {
                            $.post(pageContext.rootPath + '/uc/user/manage/freeze', {'id': userId}, function (data) {
                                if (data.success) {
                                    //小型提示框，用于上面弹框确定后的弹框提示,不自动消失，需要的化传参数time
                                    PEMO.DIALOG.tips({
                                        content: '冻结成功',
                                        time: 1000,
                                        end: function () {
                                            $('.pe-stand-table-wrap').peGrid('refresh');
                                        }

                                    });

                                    return false;
                                }
                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn: ['我知道了'],
                                    yes: function () {
                                        layer.closeAll();
                                    }
                                });
                            }, 'json');
                        },
                        btn1: function () {
                            layer.closeAll();
                        }
                    });
                });

                //激活人员
                $('.pe-stand-table-main-panel').delegate('.enableUser', 'click', function () {
                    var userId = $(this).data("id");
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要激活该账户吗？</h3></div>',
                        resize:false,
                        btn2: function () {
                            $.post(pageContext.rootPath + '/uc/user/manage/enable', {'id': userId}, function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '激活成功',
                                        time: 1000,
                                        end: function () {
                                            $('.pe-stand-table-wrap').peGrid('refresh');
                                        }
                                    });

                                    return false;
                                }

                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn: ['我知道了'],
                                    yes: function () {
                                        layer.closeAll();
                                    }
                                });
                            }, 'json');
                        },
                        btn1: function () {
                            layer.closeAll();
                        }
                    });
                });

                //删除人员
                $('.pe-stand-table-main-panel').delegate('.deleteUser', 'click', function () {
                    var userId = $(this).data("id");
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要删除该账户吗？</h3><p class="pe-dialog-content-tip">删除的账户将无法登录考试系统，也无法再恢复。</p></div>',
                        btn2: function () {
                            $.post(pageContext.rootPath + '/uc/user/manage/delete', {'id': userId}, function (data) {
                                if (data.success) {
                                    //小型提示框，用于上面弹框确定后的弹框提示,不自动消失，需要的化传参数time
                                    PEMO.DIALOG.tips({
                                        content: '删除成功',
                                        time: 1000,
                                        end: function () {
                                            $('.pe-stand-table-wrap').peGrid('refresh');
                                        }

                                    });

                                    return false;
                                }

                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn: ['我知道了'],
                                    yes: function () {
                                        layer.closeAll();
                                    }
                                });
                            }, 'json');
                        },
                        btn1: function () {
                            layer.closeAll();
                        }
                    });
                });

                $('.pe-stand-table-main-panel').delegate('.pe-table-edit-btn', 'click', function () {
                    var userId = $(this).data("id");
                    location.href = '#url='+pageContext.rootPath + '/uc/user/manage/initEditPage?userId=' + userId+"&nav=user";
                });

                //批量冻结
                $('#forbiddenBtn').click(function () {
                    var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                    if (!rows || rows.length <= 0) {
                        PEMO.DIALOG.alert({
                            content: '请至少先选择一项！',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });

                        return false;
                    }

                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要冻结该账户吗？</h3><p class="pe-dialog-content-tip">冻结后的账户将无法登录考试系统。 </p></div>',
                        btn2: function () {
                            $.post(pageContext.rootPath + '/uc/user/manage/freeze', {'id': rows.join(',')}, function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '冻结成功',
                                        time: 1000,
                                        end: function () {
                                            $('.pe-stand-table-wrap').peGrid('refresh');
                                        }
                                    });

                                    return false;
                                }

                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn: ['我知道了'],
                                    yes: function () {
                                        layer.closeAll();
                                    }
                                });
                            }, 'json');
                        },
                        btn1: function () {
                            layer.closeAll();
                        }
                    });
                });

                //批量激活
                $('#enableBtn').click(function () {
                    var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                    if (!rows || rows.length <= 0) {
                        PEMO.DIALOG.alert({
                            content: '请至少先选择一项！',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });

                        return false;
                    }

                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要激活该账户吗？</h3></div>',
                        btn2: function () {
                            $.post(pageContext.rootPath + '/uc/user/manage/enable', {'id': rows.join(',')}, function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '激活成功',
                                        time: 1000,
                                        end: function () {
                                            $('.pe-stand-table-wrap').peGrid('refresh');
                                        }
                                    });

                                    return false;
                                }

                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn: ['我知道了'],
                                    yes: function () {
                                        layer.closeAll();
                                    }
                                });
                            }, 'json');
                        },
                        btn1: function () {
                            layer.closeAll();
                        }
                    });
                });
                //导入人员
                $('.pe-upload-btn').click(function(){
//                    location.href = "#url=" + pageContext.rootPath + '/uc/user/manage/openDownload';
                    window.open(pageContext.rootPath + '/uc/user/manage/openDownload','');
                });

                /* nput树类型的输入框在div里面左右移动删除功能;*/
                function inputTreeKeyup(wrapDom, treeId) {
                    wrapDom.find('.pe-tree-show-name').on('keyup', function (e) {
                        var treeObj;
                        if (!treeObj) {
                            treeObj = $.fn.zTree.getZTreeObj(treeId);
                        }

                        var keyCode = (e || event).keyCode;
                        var thisInput = $(this);
                        var thisVal = $.trim(thisInput.val());
                        var thisSpan;
                        var labelSpans = wrapDom.find('.search-tree-text');
                        if (keyCode === 8) {//Backspace
                            thisSpan = $(this).prev(".search-tree-text");
                            if (!thisVal && thisSpan && labelSpans) {
                                if (thisInput.attr('name') === 'roleName') {
                                    treeObj.checkNode(thisSpan.data('node'), false, true);
                                } else if (thisInput.attr('name') === 'positionName') {
                                    var positionId = thisSpan.data('id');
                                    var checkInput = $("input[data-id=" + positionId + "]");
                                    checkInput.removeProp('checked');
                                    checkInput.prev().removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                                }
                                thisSpan.remove();
                            }
                            if (wrapDom.find('.icon-inputDele').get(0) && !wrapDom.find('.search-tree-text').get(0)) {
                                wrapDom.find('.icon-inputDele').hide().siblings('.icon-class-tree').show();
                            }
                        }
                        if (keyCode === 37) {//left
                            thisSpan = $(this).prev(".search-tree-text");
                            if (!thisVal && thisSpan && labelSpans && labelSpans.index(thisSpan) >= 0) {
                                thisSpan.before($(this));
                                setTimeout(function () {
                                    thisInput.focus();
                                }, 500);

                            }
                        }
                        if (keyCode === 39) {//right
                            thisSpan = $(this).next(".search-tree-text");
                            if (!thisVal && thisSpan && labelSpans && (labelSpans.index(thisSpan) <= labelSpans.length - 1)) {
                                thisSpan.after($(this));
                                setTimeout(function () {
                                    thisInput.focus();
                                }, 500);
                            }
                        }
                        if (keyCode === 46) {//delete
                            thisSpan = $(this).next(".search-tree-text");
                            if (!thisVal && thisSpan.get(0)) {
                                if (thisInput.attr('name') === 'role') {
                                    treeObj.checkNode(thisSpan.data('node'), false, true);
                                } else {
                                    var positionId = thisSpan.data('id');
                                    var checkInput = $("input[data-id=" + positionId + "]");
                                    checkInput.removeProp('checked');
                                    checkInput.prev().removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                                }
                                thisSpan.remove();
                            }
                            if (wrapDom.find('.icon-inputDele').get(0) && !wrapDom.find('.search-tree-text').get(0)) {
                                wrapDom.find('.icon-inputDele').hide().siblings('.icon-class-tree').show();
                            }
                        }

                        $(this).width($(this).val().length > 0 ? $(this).val().length * 16 : 2);
                    });
                }
                //重置密码
                $('#resetPswBtn').click(function () {
                    var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                    if (!rows || rows.length <= 0) {
                        PEMO.DIALOG.alert({
                            content: '请至少先选择一项！',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });

                        return false;
                    }

                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要把密码重置为&nbsp;<input type="text" value="102030" id="resetPwsDialog" style="width: 75px;height: 20px;border: 1px solid #999;border-radius: 3px;"/>&nbsp;吗？</h3></div>',
                        btn2: function () {
                            var psw = $('#resetPwsDialog').val();
                            $.post(pageContext.rootPath + '/uc/user/manage/resetPsw', {
                                'id': rows.join(','),
                                'password': psw
                            }, function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '重置成功',
                                        time: 1000,
                                        end: function () {
                                            $('.pe-stand-table-wrap').peGrid('refresh');
                                        }
                                    });

                                    return false;
                                }

                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn: ['我知道了'],
                                    yes: function () {
                                        layer.closeAll();
                                    }
                                });
                            }, 'json');
                        },
                        btn1: function () {
                            layer.closeAll();
                        }
                    });
                });

                //筛选事件
                $('.pe-stand-filter-form').delegate('.pe-question-choosen-btn', 'click', function () {
                    var input = $('.show-position-name').val();
                    if(input === ''){
                        $('input[name="positionId"]').val(null);
                    }
                    $('.pe-stand-table-wrap').peGrid('load', $('#peFormSub').serializeArray());
                });
                /*批量编辑*/
                $('.all-edit-btn').hover(
                        function () {
                            $(this).addClass('hoverItem');
                            $(this).find('.btn-drop-down').show();
                        },
                        function () {
                            $(this).removeClass('hoverItem');
                            $(this).find('.btn-drop-down').hide();
                        }
                );
                /*批量编辑*/
                $('.export-btn').hover(
                        function () {
                            $(this).addClass('hoverItem');
                            $(this).find('.btn-drop-down').show();
                        },
                        function () {
                            $(this).removeClass('hoverItem');
                            $(this).find('.btn-drop-down').hide();
                        }
                );

                $('.pe-new-question-btn').on('click', function () {
                    var organizeId = $('input[name="organize.id"]').val();
                    location.href = '#url='+pageContext.rootPath + '/uc/user/manage/initEditPage?organizeId='+organizeId+"&nav=user";
                });
            },

            initData: function () {
                //初始化 筛选条件
                userManage.initSimpleFilter({positionName: '', status: 'ENABLE'});
                /*自定义表格头部数量及宽度*/
                userManage.initTable();
                //初始化部门类别树
                var settingInputTree = {
                    dataUrl: pageContext.rootPath + '/uc/user/manage/listTree',
                    clickNode: function (treeNode) {
                        if (treeNode) {
                            $('input[name="organize.id"]').val(treeNode.id);
                            $('input[name="organize.organizeName"]').val(treeNode.name);
                        }

                        $('.pe-stand-table-wrap').peGrid('load', $('#peFormSub').serializeArray());
                    }
                };

                PEMO.ZTREE.initTree('peZtreeMain', settingInputTree);
            },

            initPositionData : function(treeNode){
                var setting = {
                    url: pageContext.rootPath + '/uc/position/manage/listPosition',
                    data: {categoryId: treeNode.id},
                    success: function (data) {
                        $('#bankTreeChildren').html('');
                        var positionIds = [];
                        $('.pe-position-input-tree .input-tree-choosen-label').find('span').each(function (index, ele) {
                            positionIds.push($(ele).data('id'));
                        });

                        $('#bankTreeChildren').append(_.template($('#positionTemplate').html())({data: data,positionIds:positionIds}));
                        var obj = {'func2': userManage.choosePosition};
                        PEBASE.peFormEvent('checkbox', obj);
                    }
                };

                PEBASE.ajaxRequest(setting);
            },

            initTable:function(isExtend){
                var peTableTitle = [{'columnTitle': 'checkbox', 'columnName': 'checkbox',checked:true}];
                $.merge(peTableTitle,columnsSetting);
                peTableTitle.push({'columnTitle': '操作','columnName': 'opt',checked:true});
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/uc/user/manage/search',
                    formParam: $('#peFormSub').serializeArray(),//表格上方表单的提交参数
                    tempId: 'peQuestionTableTep',//表格模板的id
                    showTotalDomId: 'showTotal',
                    title: peTableTitle, //表格头部的数量及名称数组;
                    isTableScroll:true,
                    isUserExtend:isExtend,
                    tableScrollType:'userMana',
                    isTableHasFixed:true,
                    fixedTableTempId:['peQuestionRightFixedTableTep','peQuestionLeftFixedTableTep'],
                    onLoad:function(t){
                        if(t.data.rows && t.data.rows.length === 0){
                            if(!$('.user-manage-empty').get(0)){
                                var emptyDom =  '<div class="user-manage-empty"><div class="pe-result-no-date"></div>'
                                        +'<p class="pe-result-date-warn" style="text-align:center;">暂无数据</p></div>';
                                var $emptyDom = $('.pe-stand-table-main-panel .user-manage-empty');
                                if (!$emptyDom || $emptyDom.length === 0) {
                                    $('.pe-stand-table-main-panel').append(emptyDom);
                                }

                            }else{
                                $('.user-manage-empty').show();
                            }

                            $('.pe-scrollTable-wrap').hide();
                            $('.pe-stand-table-pagination').hide();
                            $('.userMana-right-fixed-table').hide();
                            $('.userMana-left-fixed-table').hide();
                        }else{
                            $('.user-manage-empty').hide();
                            $('.pe-scrollTable-wrap').show();
                            $('.pe-stand-table-pagination').show();
                            $('.userMana-right-fixed-table').show();
                            $('.userMana-left-fixed-table').show();

                            if(isExtend){
                                $('.pe-scrollTable-wrap').mCustomScrollbar('destroy').mCustomScrollbar({
                                    axis: "x",
                                    theme: "dark-3",
                                    scrollbarPosition: "inside",
                                    setWidth: '774px',
                                    advanced: {updateOnContentResize: true}
                                });
                                $('.pe-stand-table-main-panel').append(_.template($('#peQuestionRightFixedTableTep').html())({peData: t.data}));
                                $('.pe-stand-table-main-panel').append(_.template($('#peQuestionLeftFixedTableTep').html())({peData: t.data}));
                                PEBASE.peFormEvent('checkbox');
                                if($('.pe-stand-table-wrap').width() <= 774){
                                    $('.userMana-left-fixed-table').css('borderRight','none');
                                    $('.userMana-right-fixed-table').css('borderLeft','none');
                                }
                            }else{
                                $('.pe-scrollTable-wrap').mCustomScrollbar('destroy').mCustomScrollbar({
                                    axis: "x",
                                    theme: "dark-3",
                                    scrollbarPosition: "inside",
                                    setWidth: '500px',//此处关系到表格右边固定的距离;
                                    advanced: {updateOnContentResize: true}
                                });
                                $('.pe-stand-table-main-panel').append(_.template($('#peQuestionRightFixedTableTep').html())({peData: t.data}));
                                $('.pe-stand-table-main-panel').append(_.template($('#peQuestionLeftFixedTableTep').html())({peData: t.data}));
                                PEBASE.peFormEvent('checkbox');
                                if($('.pe-stand-table-wrap').width() <= 500){
                                    $('.userMana-left-fixed-table').css('borderRight','none');
                                    $('.userMana-right-fixed-table').css('borderLeft','none');
                                }
                            }
                            $('.userMana-right-fixed-table').css('left',$('.userManage-scroll-table').outerWidth());
                        }

                    }
                });
            },

            choosePosition: function (inputDom) {
                var id = inputDom.data('id');
                if (!id) {
                    return false;
                }

                var idDom;
                var thisLabel = $('.pe-position-input-tree .input-tree-choosen-label');
                thisLabel.find('span').each(function (index, ele) {
                    if ($(ele).data('id') === id) {
                        idDom = ele;
                        return false;
                    }
                });
                if (inputDom.prop('checked') && !idDom) {
                    thisLabel.append('<span class="search-tree-text" title="' + inputDom.attr('title') + '" data-id="' + id + '">' + inputDom.attr('title') + '<input type="hidden" name="updatePositionId" value="' + id + '"/></span>');
                    thisLabel.siblings('.icon-class-tree').hide().siblings('.icon-inputDele').show();
                } else if (!inputDom.prop('checked') && idDom) {
                    $(idDom).remove();
                    if (!thisLabel.find('span').get(0)) {
                        thisLabel.siblings('.icon-class-tree').show().siblings('.icon-inputDele').hide();
                    }
                }
            },

            initSimpleFilter: function (data) {
                $('.pe-stand-filter-form').html(_.template($('#simpleTemp').html())(data));
                //查询条件岗位类别树
                var settingInputPositionTree = {
                    dataUrl: pageContext.rootPath + '/uc/position/manage/listPositionTree',
                    clickNode: function (treeNode) {
                        if(treeNode.pId == null){
                            $('.show-position-name').val(null);
                        }

                        if (!treeNode || treeNode.isParent) {
                            return false;
                        }

                        $('input[name="positionId"]').val(treeNode.id);
                        $('.show-position-name').val(treeNode.name);
                    },
                    width:250
                };
                PEBASE.inputTree({
                    dom: '.pe-position-tree-wrap',
                    treeId: 'positionTree',
                    treeParam: settingInputPositionTree
                });
            },

            initAdvaceFilter: function (data) {
                $('.pe-stand-filter-form').html(_.template($('#advaceTemp').html())(data));
                //查询条件岗位类别树
                var settingInputPositionTree = {
                    dataUrl: pageContext.rootPath + '/uc/position/manage/listPositionTree',
                    clickNode: function (treeNode) {
                        if (!treeNode || treeNode.isParent) {
                            return false;
                        }

                        $('input[name="positionId"]').val(treeNode.id);
                        $('.show-position-name').val(treeNode.name);
                    }
                };
                PEBASE.inputTree({
                    dom: '.pe-position-tree-wrap',
                    treeId: 'positionTree',
                    treeParam: settingInputPositionTree
                });
                PEBASE.peSelect($('.select-status'), null, null);
                PEBASE.peSelect($('.select-sex'), null, null);
                PEBASE.peSelect($('.select-role'), null, null);
            }
        };

        userManage.init();
        userManage.initData();
    });
</script>