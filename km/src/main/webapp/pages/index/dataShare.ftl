<aside class="y-aside" id="YAside">
    <div class="y-aside__title">
        <span class="yfont-icon">&#xe650;</span><span class="txt">菜单</span>
    </div>
    <ul id="orgTreeAndUsers" class="ztree pe-tree-container"></ul>
</aside>
<section class="y-content">
    <div class="y-major-project">
        <span class="y-major-project-header show-org-name"></span>
        <div class="y-share-project-content">
            <div class="y-share-project-type">
                <dl class="y-share-project-type-list js-major">
                    <dt>专业:</dt>
                    <dd>
                        <span class="y-share-project-type-item-first y-active" data-typeid = ''>全部</span>
                        <span class="y-share-project-type-item" data-typeid = '1'>继电保护</span>
                        <span class="y-share-project-type-item" data-typeid = '2'>输电线路</span>
                        <span class="y-share-project-type-item" data-typeid = '3'>配电线路</span>
                        <span class="y-share-project-type-item" data-typeid = '4'>变电运行</span>
                        <span class="y-share-project-type-item" data-typeid = '5'>变电检修</span>
                        <span class="y-share-project-type-item" data-typeid = '6'>营销专业</span>
                    </dd>
                </dl>
                <dl class="y-share-project-type-list js-project">
                    <dt>项目:</dt>
                    <dd>
                        <span class="y-share-project-type-item-first  y-active" data-typeid = ''>全部</span>
                        <span class="y-share-project-type-item" data-typeid = '8'>UPFC</span>
                        <span class="y-share-project-type-item" data-typeid = '9'>微网路由</span>
                        <span class="y-share-project-type-item" data-typeid = '10'>高温相变光热</span>
                    </dd>
                </dl>
                <dl class="y-share-project-type-list js-label">
                    <dt>标签:</dt>
                    <dd>
                        <span class="y-share-project-type-item-first y-active" data-typeid = ''>全部</span>
                        <span class="y-share-project-type-item" data-typeid = '12'>图片</span>
                        <span class="y-share-project-type-item" data-typeid = '13'>视频</span>
                        <span class="y-share-project-type-item" data-typeid = '14'>其他</span>
                    </dd>
                </dl>
            </div>
            <div class="y-content__opt__bar">
                <div class="y-share-bar">
                    <button class="y-btn y-btn__blue" id="filePicker" type="button">分享</button>
                    <ul class="js-share-list">
                        <li class="js-share-local">从本地分享</li>
                        <li class="js-share-y">从云库分享</li>
                    </ul>
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
<#--分享至公共库-->
<script type="text/template" id="shareToPublic">
    <input name="shareLibraryId" type="hidden">
    <div class="pe-select-tree-wrap pe-input-tree-wrap-drop">
        <ul id="editOrgTree" class="ztree pe-tree-container"></ul>
    </div>
</script>
<script src="${resourcePath!}/web-static/proExam/index/js/share.js"></script>
