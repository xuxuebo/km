<section>
    <div class="y-content-body">
        <h4 class="y-content__title">
            <#if type?? && type == 'project'>
                项目列表
                <#else>
                 动态云库
            </#if>
        </h4>
        <div class="y-content__opt__bar">
            <button class="y-btn y-btn__blue js-copy" type="button">复制到我的云库</button>
            <button class="y-btn y-btn__green js-download" type="button">下载</button>
            <button class="y-btn y-btn__blue js-upload" id="filePicker" type="button">上传</button>
            <div id="theList"></div>
        </div>
        <ul class="y-bread-crumbs" id="breadCrumbs">
            <li>全部</li>
        </ul>
        <div class="pe-stand-table-main-panel">
            <div class="y-content__table" id="yunTable">
                <div class="pe-stand-table-pagination"></div>
            </div>
        </div>
    </div>
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
                <span class="">文件名称</span>
            </th>
            <th class="y-table__td name">
                <span class="">上传人</span>
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
        <tr class="y-table__tr js-opt-dbclick">
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div class="y-table__opt__bar">
                    <button type="button" title="点击下载"
                            class="yfont-icon opt-item js-opt-download">&#xe64f;
                    </button>
                    <button type="button" title="分享"  class="yfont-icon opt-item js-opt-share">
                        &#xe652;
                    </button>
                    <button type="button" title="删除" class="yfont-icon opt-item js-opt-delete">
                        &#xe65c;
                    </button>
                </div>
                <div class="y-table__filed_name">
                    <%=item.knowledgeName%>
                </div>
            </td>
            <td class="y-table__td userName">
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
<script>
    var libraryId = '${libraryId!}';
    var type = '${type!}';
</script>
<script src="${resourcePath!}/web-static/proExam/index/js/fileList.js"></script>

