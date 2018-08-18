<div class="discover__block">
    <div class="discover--left pull-left">
        <div class="discover__hot__tag discover__sec">
            <div class="discover__sec__header">热门标签</div>
            <div class="d-hot__tag__container" id="hotTagContainer"></div>
        </div>
        <div class="discover__hot__resource">
            <div class="discover__sec__header">热门资源</div>
            <ul class="d-hot__resource" id="hotResource"></ul>
        </div>
    </div>
    <div class="discover--right pull-right">
        <div class="discover_ctr__person discover__sec">
            <div class="discover__sec__header">
                <span>贡献达人</span>
                <ul class="pull-right discover__ctr__nav" id="ctrPersonNav">
                    <li class="d-ctr__nav pull-left active" data-type="WEEK">周排行</li>
                    <li class="d-ctr__nav pull-left" data-type="MONTH">月排行</li>
                    <li class="d-ctr__nav pull-left last" data-type="TOTAL">总排行</li>
                </ul>
            </div>
            <ul class="d-ctr__list" id="ctrPerson"></ul>
        </div>
        <div class="discover__department__rank">
            <div class="discover__sec__header">部门排行</div>
            <ul class="d-department__list" id="departmentRank"></ul>
        </div>
    </div>
    <div class="discover--center">
        <div class="discover__search discover__sec">
            <div class="d-search__title">云搜索</div>
            <div class="d-search__line">
                <input id="dSearchNpt" type="text" class="d-search__npt" placeholder="请输入关键字"/>
                <#--<span class="d-search__num">5</span>-->
            </div>
            <div class="d-search__btns">
                <button id="dSearchGlobal" class="d-search__global d-search__btn">全局搜索</button>
                <button id="dSearchPersonal" class="d-search__personal d-search__btn">个人云库搜索</button>
            </div>
            <div class="d-search__types">
                <div class="d-search__type files">
                    <img class="d-search__type__files" src="${resourcePath!}/web-static/proExam/index/img/ico_upload.png" alt="文件数量">
                    <div class="d-search__type__container">
                        <div class="d-search__type__title">文件数量</div>
                        <div id="dSearchFileNum" class="d-search__type__num"></div>
                    </div>
                </div>
                <div class="d-search__type upload">
                    <img class="d-search__type__upload" src="${resourcePath!}/web-static/proExam/index/img/ico_download.png" alt="文件数量">
                    <div class="d-search__type__container">
                        <div class="d-search__type__title">已上传数量</div>
                        <div id="dSearchUploadNum" class="d-search__type__num"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="discover__cloud">
            <div class="discover__sec__header">
                <span>云库动态</span>
                <#--<a target="_self" href="javascript:" class="d-cloud__more pull-right">查看更多</a>-->
            </div>
            <ul class="d-cloud__list" id="dCloudList"></ul>
        </div>
    </div>
</div>

<script type="text/template" id="tplHotTagContainer">
    <div class="d-hot__tag__list">
        <div class="d-hot__tag__list__title">热点项目</div>
        <ul class="d-hot__tag__list__line">
            <%if(d.hotProject.length !== 0){%>
            <%_.each(d.hotProject, function(item,i){%>
                <li class="d-hot__tag__list__item"><span title="<%= item.libraryName %>" onclick="projectAndSpecial('<%= item.id %>', 'majorProject')"><%= item.libraryName %></span></li>
            <%})}%>
        </ul>
    </div>
    <div class="d-hot__tag__list">
        <div class="d-hot__tag__list__title">热点专业</div>
        <ul class="d-hot__tag__list__line">
            <%if(d.hotMajor.length !== 0){%>
            <%_.each(d.hotMajor, function(item,i){%>
            <li class="d-hot__tag__list__item"><span title="<%= item.libraryName %>" onclick="projectAndSpecial('<%= item.id %>', 'specialty')"><%= item.libraryName %></span></li>
            <%})}%>
        </ul>
    </div>
    <#--<div class="d-hot__tag__list">
        <div class="d-hot__tag__list__title">热点标签</div>
        <ul class="d-hot__tag__list__line">
            <%if(d.hotTag.length !== 0){%>
            <%_.each(d.hotTag, function(item,i){%>
            <li class="d-hot__tag__list__item"><a target="_self" href="<%= item.link %>"><%= item.name %></a></li>
            <%})}%>
        </ul>
    </div>-->
</script>

<script type="text/template" id="tplHotResourceContainer">
    <table class="y-table">
        <tbody>
        <%if(list.length !== 0){%>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr js-opt-dbclick">
            <td class="y-table__td name" style="border: none;height: 30px;">
                <div class="y-table__opt__bar">
                    <button type="button" title="点击下载" onclick="downloadKnowledge('<%=item.id%>')"
                            class="yfont-icon opt-item js-opt-download">&#xe64f;
                    </button>
                </div>
                <div title="《<%=item.knowledgeName%>》" class="d-name-item">
                    《<%=item.knowledgeName%>》
                </div>
            </td>
        </tr>
        <%})}%>
        </tbody>
    </table>
    <%if(list.length === 0){%>
    <div class="table__none">--暂无数据--</div>
    <%}%>
</script>

<script type="text/template" id="tplCtrPerson">
    <%if(list.length !== 0){%>
    <%_.each(list, function(item,i){%>
    <li class="d-ctr__item">
        <div class="d-ctr__rank pull-left"></div>
        <img class="d-ctr__icon pull-left"  src="<%= item.facePath %>"
             onerror="javascript:this.src='${resourcePath!}/web-static/proExam/index/img/default_user.png'" alt="头像"/>
        <div class="d-ctr__score pull-right"><%= item.count %>份</div>
        <div class="d-ctr__name"><%= item.userName %></div>
    </li>
    <%})}%>
</script>

<script type="text/template" id="tplDepartmentRank">
    <%if(list.length !== 0){%>
    <%_.each(list, function(item,i){%>
    <li class="d-department__item">
        <div class="pull-left d-department__rank"><%= i + 1 %></div>
        <div class="pull-right d-department__score"><%= item.count %></div>
        <div class="d-department__name"><%= item.orgName %></div>
    </li>
    <%})}%>
</script>

<script type="text/template" id="tplCloudList">
    <%if(list.length !== 0){%>
    <%_.each(list, function(item,i){%>
    <li class="d-cloud__item">
        <div class="pull-right d-cloud__time"><%=item.createTimeStr%></div>
        <div class="d-cloud__name"><%=item.userName%><%=item.typeStr%><%=item.knowledgeName%></div>
    </li>
    <%})}%>
</script>
<script>
    //下载
    function downloadKnowledge(id) {
        PEBASE.ajaxRequest({
            url: pageContext.rootPath + '/km/knowledge/downloadKnowledge2',
            async: false,
            data: {'knowledgeIds': id},
            success: function (data) {
                if (data.success) {
                    downloadFile(data.data.fileUrl, data.data.name);
                } else {
                    PEMO.DIALOG.alert({
                        content: data.message,
                        btn: ['我知道了'],
                        yes: function (index) {
                            layer.close(index);
                        }
                    });
                }

            }
        });

    }

    function projectAndSpecial(id, type) {
        var $type = $("li[data-type='" + type + "']");
        $type.attr("data-id", id);
        $type.click();
    }
</script>
<script src="${resourcePath!}/web-static/proExam/index/js/discover.js"></script>