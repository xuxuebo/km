
<aside class="y-aside" id="YAside">
        <div class="y-aside__title">
            <span class="yfont-icon">&#xe650;</span><span class="txt">菜单</span>
        </div>
        <ul class="y-aside__menu">
            <li class="y-menu__item my-yun">
                <a href="#yun" class="y-menu__item__title y-aside__menu__item__title">
                    <span class="yfont-icon">&#xe643;</span><span class="txt">我的云库</span>
                </a>
            </li>
            <#--<li class="y-menu__item public-yun">
                <a href="javascript:void(0);" class="y-menu__item__title y-aside__menu__item__title has-arrow">
                    <span class="yfont-icon">&#xe656;</span><span class="txt">公共库</span>
                </a>
                <ul class="y-menu__sub">
                    <#list firstLevelLibrary as fl>
                        <li class="y-menu__item">
                            <a href="#public/${fl.id}/${fl.libraryName}" data-id="${fl.id}" class="y-menu__item__title">
                                <span class="txt" data-name="${fl.libraryName}">${fl.libraryName}</span>
                            </a>
                        </li>
                    </#list>
                </ul>
            </li>

            <li class="y-menu__item share-yun">
                <a href="#share" class="y-menu__item__title y-aside__menu__item__title">
                    <span class="yfont-icon">&#xe643;</span><span class="txt">我的分享</span>
                </a>
            </li>-->

            <li class="y-menu__item recycle-yun">
                <a href="#recycle" class="y-menu__item__title y-aside__menu__item__title">
                    <span class="yfont-icon">&#xe65c;</span><span class="txt">回收站</span>
                </a>
            </li>
        </ul>
    </aside>
<section class="y-content">
        <div class="y-content-body" id="yunLContentBody">

        </div>
    <#--<footer class="y-footer">-->
    <#--国家电网江苏省电力公司 ©苏ICP备15007035号-1-->
    <#--</footer>-->
    </section>
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
            <th class="y-table__td create-time">
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
                <div class="y-table__opt__bar">
                    <button type="button" title="点击下载" data-id="<%=item.id%>" class="yfont-icon opt-item js-opt-download">&#xe64f;</button>
                    <#--<button type="button" title="分享" data-id="<%=item.id%>" class="yfont-icon opt-item js-opt-share">&#xe652;</button>-->
                    <button type="button" title="删除" data-id="<%=item.id%>" class="yfont-icon opt-item js-opt-delete">&#xe65c;</button>
                </div>
                <div class="y-table__filed_name type-<%=item.knowledgeType%>">
                    <%=item.knowledgeName%>
                </div>
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

<script type="text/template" id="tplPublicTable">
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
            <th class="y-table__td create-time">
                <span class="">上传时间</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <%if(list.length !== 0){%>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr js-opt-dbclick" data-shareid="<%=item.shareId%>" data-id="<%=item.id%>" data-fileid="<%=item.fileId%>">
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div class="y-table__opt__bar">
                    <button type="button" title="点击下载" data-shareid="<%=item.shareId%>" data-id="<%=item.id%>" class="yfont-icon opt-item js-opt-download">&#xe64f;</button>
                </div>
                <div class="y-table__filed_name type-<%=item.knowledgeType%>">
                    <%=item.knowledgeName%>
                </div>
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

<script type="text/template" id="tplRecycleTable">
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
            <th class="y-table__td create-time">
                <span class="">删除时间</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <%if(list.length !== 0){%>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr" data-id="<%=item.id%>">
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div class="y-table__opt__bar">
                    <#--<button type="button" class="yfont-icon opt-item js-opt-download">&#xe64f;</button>
                    <button type="button" class="yfont-icon opt-item js-opt-more">&#xe652;</button>-->
                </div>
                <div class="y-table__filed_name type-<%=item.knowledgeType%>">
                    <%=item.knowledgeName%>
                </div>
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


<script type="text/template" id="tplShareTable">
    <div>
        <table class="y-table">
            <thead class="y-table__header">
            <tr>
                <th class="y-table__td checkbox" style="width: 2%">
                    <label class="y-checkbox">
                        <input type="checkbox">
                        <span class="y-checkbox__span"></span>
                    </label>
                </th>
                <th class="y-table__td name" style="width: 25%">
                    <span class=" ">文件名</span>
                </th>
                <th class="y-table__td create-time" style="width: 8%">
                    <span class="  ">分享时间</span>
                </th>
                <th class="y-table__td size" style="width: 8%">
                    <span class="  ">大小</span>
                </th>
                <th class="y-table__td download-count" style="width: 8%">
                    <span class=" ">下载次数</span>
                </th>
                <th class="y-table__td copy-count" style="width: 8%">
                    <span class="  ">复制次数</span>
                </th>
            </tr>
            </thead>
            <tbody>
            <%if(list.length !== 0){%>
            <%_.each(list,function(item,i){%>
            <tr class="y-table__tr" data-id="<%=item.id%>" data-shareid="<%=item.shareId%>">
                <td class="y-table__td checkbox">
                    <label class="y-checkbox">
                        <input type="checkbox">
                        <span class="y-checkbox__span"></span>
                    </label>
                </td>
                <td class="y-table__td name">
                    <div class="y-table__filed_name type-<%=item.knowledgeType%>">
                        <span title="<%=item.knowledgeName%>"><%=item.knowledgeName%></span>
                    </div>
                </td>
                <td class="y-table__td create-time">
                    <%=item.createTimeStr%>
                </td>
                <td class="y-table__td size">
                    <%=item.knowledgeSize%>
                </td>
                <td class="y-table__td download-count">
                    <%=item.downloadCount%>
                </td>
                <td  class="y-table__td copy-count">
                    <%=item.copyCount%>
                </td>
            </tr>
            <%})}%>
            </tbody>
        </table>
        <%if(list.length === 0){%>
        <div class="table__none">--暂无数据--</div>
        <%}%>
    </div>

</script>


<#--模板引擎-->

<#--我的云库-->
<script type="text/template" id="tplYun">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-upload" id="filePicker" type="button">上传</button>
        <button class="y-btn y-btn__green js-download" type="button">下载</button>
        <#--<button class="y-btn y-btn__green js-share" type="button">分享至公共库</button>-->
        <button class="y-btn y-btn__orange js-newFolder" type="button">新建文件夹</button>
        <div id="theList"></div>
    </div>
    <#--表格包裹的div-->
    <ul class="y-bread-crumbs" id="breadCrumbs">
        <li>全部</li>
    </ul>

    <div class="pe-stand-table-main-panel">
        <div class="y-content__table" id="yunTable">
            <div class="pe-stand-table-pagination"></div>
        </div>
    </div>
</script>

<#--分享至公共库-->
<script type="text/template" id="shareToPublic">
       <input name="shareLibraryId" type="hidden">
       <div class="pe-select-tree-wrap pe-input-tree-wrap-drop">
           <ul id="editOrgTree" class="ztree pe-tree-container"></ul>
       </div>
</script>


<script type="text/template" id="addNewFolder" >
    <div class="clearF">
            <div class="validate-form-cell" style="margin-left:80px;">
            <em class="error" style="display: none;"></em>
            </div>
            <label class="floatL">
            <span class="pe-label-name floatL">文件夹名称:</span>
    <input class="pe-table-form-text pe-stand-filter-form-input pe-km-tree-name" type="text" placeholder="请输入文件夹名称"
    name="libraryName" >
            </label>
            </div>

</script >


<#--公共库-->
<script type="text/template" id="tplPublic">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-opt-copy" type="button">复制到我的云库</button>
        <button class="y-btn y-btn__green js-download" type="button">下载</button>
    </div>
    <div class="pe-stand-table-main-panel">
        <div class="y-content__table" id="publicTable">
            <div class="pe-stand-table-pagination"></div>
        </div>
    </div>
    </div>
</script>

<#--我的分享-->
<script type="text/template" id="tplShare">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-cancelShare" type="button">取消分享</button>
    </div>
    <div class="y-content__table" id="shareTable">
    </div>
</script>

<script type="text/template" id="cancelShare" >
    <div class="clearF">
        <div class="validate-form-cell" style="">
            <em class="error" style="display: none;"></em>
        </div>
        <label class="floatL">
            <span style="margin-left:60px;" class="pe-label-name floatL">确定将选中的文件取消分享?</span>
        </label>
    </div>

</script>




<#--回收站-->
<script type="text/template" id="tplRecycle">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-reduction" type="button" >还原文件</button>
        <button class="y-btn y-btn__green js-emptyRecycle" type="button">清空回收站</button>
    </div>
    <div class="y-content__table" id="recycleTable">
    </div>
</script>

<script type="text/template" id="reduction" >
    <div class="clearF">
        <div class="validate-form-cell" style="margin-left:80px;">
            <em class="error" style="display: none;"></em>
        </div>
        <label class="floatL">
            <span class="pe-label-name floatL">确定还原选中的文件?</span>
        </label>
    </div>

</script>

<script type="text/template" id="emptyRecycle" >
    <div class="clearF">
        <div class="validate-form-cell" style="margin-left:80px;">
            <em class="error" style="display: none;"></em>
        </div>
        <label class="floatL">
            <span class="pe-label-name floatL">确定清空回收站?</span>
        </label>
    </div>

</script >

<#--面包屑-->
<script  type="text/template" id="breadCrumbsTpl">
    <%_.each(list,function(item,i){%>
        <%if(list.length ==1){%>
        <li><span><%=item.title%></span></li>
        <%}else if(i==0){%>
        <li><a href="javascript:void(0);" data-id="<%=item.id%>"><%=item.title%></a></li>
        <%}else if(i===list.length-1){%>
        <li><span class="split">&gt;</span><span><%=item.title%></span></li>
        <%}else{%>
        <li><span class="split">&gt;</span><a href="javascript:void(0);" data-id="<%=item.id%>"><%=item.title%></a></li>
        <%}%>
    <%})%>
</script>


<script src="${resourcePath!}/web-static/proExam/index/js/index.js"></script>
<script src="${resourcePath!}/web-static/proExam/index/js/md5.js"></script>
