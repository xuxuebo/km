<aside class="y-aside" id="YAside">
    <div class="y-aside__title">
        <span class="yfont-icon">&#xe650;</span><span class="txt">菜单</span>
    </div>
    <ul id="orgTreeAndUsers" class="tree-and-users-default ztree pe-tree-container"></ul>
</aside>
<section class="y-content">
    <div class="y-share-project">
        <h4 class="y-content__title y-share-project-header show-org-name">分享</h4>
        <div class="y-share-project-content">
            <div class="y-share-project-type">
                <dl class="y-share-project-type-list js-major">
                    <dt>专业:</dt>
                    <dd id="specialty-dd">
                        <span class="y-share-project-type-item-first y-active" data-typeid = ''>全部</span>
                    </dd>
                </dl>
                <dl class="y-share-project-type-list js-project">
                    <dt>项目:</dt>
                    <dd id="project-dd">
                        <span class="y-share-project-type-item-first  y-active" data-typeid = ''>全部</span>
                    </dd>
                </dl>
                <dl class="y-share-project-type-list js-label">
                    <dt>标签:</dt>
                    <dd id="label-dd">
                        <span class="y-share-project-type-item-first y-active" data-typeid = ''>全部</span>
                    </dd>
                </dl>
            </div>
            <div class="y-content__opt__bar">
                <div class="y-share-bar">
                    <button class="y-btn y-btn__blue" id="filePicker" type="button">分享</button>
                    <div class="y-content__share__list">
                        <span class="arrow-top"></span>
                        <ul class="js-share-list">
                            <li class="js-share-local">从本地分享</li>
                            <li class="js-share-y">从云库分享</li>
                        </ul>
                    </div>
                </div>
                <button class="y-btn y-btn__green js-download" type="button">下载</button>
                <button class="y-btn y-btn__orange js-copy" type="button">复制</button>
                <div id="theList"></div>
            </div>
            <div class="y-share-table-main-panel">
                <div class="y-content__table" id="shareTable">
                    <div class="pe-stand-table-pagination"></div>
                </div>
            </div>
        </div>
    </div>
</section>
<#--表格模板-->
<script type="text/template" id="tplShareTable">
    <table class="y-table">
        <thead class="y-table__header">
        <tr>
            <th class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </th>
            <th class="y-table__td name">
                <span class="">文件名</span>
            </th>
            <th class="y-table__td user-name">
                <span class="">分享人</span>
            </th>
            <th class="y-table__td size">
                <span class="">大小</span>
            </th>
            <th class="y-table__td create-time">
                <span class="">上传时间</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <%if(list.length !== 0){%>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr js-opt-dbclick" data-shareid="<%=item.shareId%>" data-fileid = "<%=item.fileId%>" data-folder = "<%=item.folder%>" data-id="<%=item.id%>">
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div class="y-table__opt__bar">
                    <button type="button" title="点击下载" data-id="<%=item.id%>" class="yfont-icon opt-item js-opt-download">&#xe64f;</button>
                    <%if(item.canDelete){%>
                    <button type="button" title="删除" data-id="<%=item.relId%>" class="yfont-icon opt-item js-opt-delete">&#xe65c;</button>
                    <%}%>
                </div>
                <div class="y-table__filed_name type-<%=item.knowledgeType%>">
                    <%=item.knowledgeName%>
                </div>
            </td>
            <td class="y-table__td user-name">
                <%=item.userName%>
            </td>
            <td class="y-table__td size">
                <%=item.knowledgeSize%>
            </td>
            <td class="y-table__td upload-time">
                <%=item.createTimeStr%>
            </td>
        </tr>
        <%})}%>
        </tbody>
    </table>
    <%if(list.length === 0){%>
    <div class="table__none">--暂无数据--</div>
    <%}%>
</script>
<#--专业,项目-->
<script type="text/template" id="tplSpecialtyTable">
    <span class="y-share-project-type-item-first y-active" data-typeid = ''>全部</span>
    <%if(list.length !== 0){%>
    <%_.each(list,function(item,i){%>
    <span class="y-share-project-type-item" data-typeid='<%=item.id%>'><%=item.name%></span>
    <%})}%>
</script>
<#--专业-->
<script type="text/template" id="tplLabelTable">
    <span class="y-share-project-type-item-first y-active" data-typeid = ''>全部</span>
    <%if(list.length !== 0){%>
    <%_.each(list,function(item,i){%>
    <span class="y-share-project-type-item" data-typeid='<%=item.id%>'><%=item.labelName%></span>
    <%})}%>
</script>
<#--分享至公共库-->
<script type="text/template" id="shareToPublic">
    <input name="shareLibraryId" type="hidden">
    <div class="pe-select-tree-wrap pe-input-tree-wrap-drop">
        <ul id="editOrgTree" class="ztree pe-tree-container"></ul>
    </div>
</script>
<script type="text/template" id="tplYunTable">
    <table class="y-table">
        <thead class="y-table__header">
        <tr>
            <th class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </th>
            <th class="y-table__td name">
                <span class="">文件名</span>
            </th>
            <th class="y-table__td size">
                <span class="">大小</span>
            </th>
            <th class="y-table__td size">
                <span class="">上传时间</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <%if(list.length !== 0){%>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr js-opt-dbclick" data-fileid = "<%=item.fileId%>" data-folder = "<%=item.folder%>" data-id="<%=item.id%>">
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div title="<%=item.knowledgeName%>" class="y-table__filed_name type-<%=item.knowledgeType%>"
                     style="margin-right: 10px;overflow: hidden;text-overflow:ellipsis;">
                    <%=item.knowledgeName%>
                </div>
            </td>
            <td class="y-table__td size">
                <%=item.knowledgeSize%>
            </td>
            <td class="y-table__td size">
                <%=item.createTimeStr%>
            </td>
        </tr>
        <%})}%>
        </tbody>
    </table>
    <%if(list.length === 0){%>
    <div class="table__none">--暂无数据--</div>
    <%}%>
</script>
<script src="${resourcePath!}/web-static/proExam/index/js/share.js"></script>
