<div class="y-major-project" id="yunLContentBody">
    <div class="y-major-project-header"></div>
    <div class="y-major-project-content">
        <div class="y-project-contribution-list y-project-contribution-list">
            <div class="y-contribution-info">贡献榜单</div>
            <div class="y-contribution">
                <ul id="contributionList"></ul>
            </div>
        </div>
        <div class="y-project-content-up">
            <div class="y-project-desc">
                <div class="y-project-info">项目介绍</div>
                <div class="y-project-introduction" id="projectDeatil"></div>
            </div>

        </div>
        <div class="y-project-content-down">
            <div class="y-project-activity">
                <div class="y-project-file-inline">
                    <div class="y-project-activity-info">云库动态</div>
                    <div class="y-project-activity-more">
                        <a href="#" onclick="fileSelectMore('activity')">
                            查看更多
                        </a>
                    </div>
                </div>
                <div class="y-project-activity-list">
                    <ul id="activityList"></ul>
                </div>
            </div>
            <div class="y-project-file">
                <div class="y-project-file-inline">
                    <div class="y-project-file-info">项目文件</div>
                    <div class="y-project-file-more">
                        <a href="javascript:void(0);" class="project-upload" style="padding-right: 20px;">
                            上传文件
                        </a> <a href="#" onclick="fileSelectMore('project')">
                            查看更多
                        </a>
                    </div>
                    <div class="y-project-file-add">
                        <a href="#" onclick="fileAdd()">
                            上传文件
                        </a>
                    </div>
                </div>
                <div class="y-project-file-list">
                    <ul id="fileList"></ul>
                </div>
            </div>
        </div>
    </div>
</div>

<#--排行榜-->
<script type="text/template" id="tplsContributionTable">
    <%if(list.length !== 0){%>
    <%_.each(list,function(item,i){%>
    <li>
        <%if(item.rank == 1){%>
        <div class="y-contribution-icon_first"></div>
        <%}else if(item.rank == 2){%>
        <div class="y-contribution-icon_second"></div>
        <%}else if(item.rank == 3){%>
        <div class="y-contribution-icon_third"></div>
        <%}else if(item.rank == 4){%>
        <div class="y-contribution-icon_forth"></div>
        <%}else if(item.rank == 5){%>
        <div class="y-contribution-icon_fifth"></div>
        <%}%>
        <div class="y-contribution-img">
            <img class="y-contribution-person-img" src="<%=item.facePath%>"
                 onerror="javascript:this.src='${resourcePath!}/web-static/proExam/index/img/default_user.png'" alt="">
        </div>
        <div class="y-contribution-name"><%=item.userName%></div>
        <div class="y-contribution-position"><%=item.orgName%></div>
        <div class="y-contribution-person-number"><%=item.count%>份</div>
    </li>
    <%})}else{%>
    <div class="table__none">--暂无数据--</div>
    <%}%>
</script>

<#--项目详情初始化-->
<script type="text/template" id="projectDetailDetail">
    <img class="y-project-img"
         src="${resourcePath!}/web-static/proExam/index/img/ico_rar.png" alt="">
    <div class="y-project-introduction-content">
        <div class="y-project-content-title"><%= data.libraryName %></div>
        <div class="y-project-content-author">项目负责人：<%=data.libraryDetail.chargeName%></div>
        <div class="y-introduction-content"><%=data.libraryDetail.summary%></div>
        <div class="y-project-select-all">
            <a href="#" onclick="selectProjectIntroduction()">
                查看全文
            </a>
        </div>
    </div>
</script>

<#--项目文件初始化-->
<script type="text/template" id="tplsFileTable">
    <table class="y-table">
        <tbody>
        <%if(list.length !== 0){%>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr js-opt-dbclick">
            <td class="y-table__td name">
                <div class="y-table__opt__bar">
                    <button type="button" title="点击下载" onclick="downloadKnowledge('<%=item.id%>')"
                            class="yfont-icon opt-item js-opt-download">&#xe64f;
                    </button>
                </div>
                <div class="y-table__filed_name type-<%=item.knowledgeType%>" title="<%=item.knowledgeName%>">
                    <%=item.knowledgeName%>
                </div>
            </td>
            <td class="y-table__td size">
                <%=item.userName%>
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

<#--云库动态初始化-->
<script type="text/template" id="tplsActivityTable">
    <table class="y-table">
        <tbody>
        <%if(list.length !== 0){%>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr js-opt-dbclick">
            <td class="y-table__td size" title="<%=item.userName%><%=item.typeStr%><%=item.knowledgeName%>">
                <span class="y-dynamic-file-author-name"><%=item.userName%><%=item.typeStr%><%=item.knowledgeName%></span>
            </td>
            <td class="y-table__td size" title="<%=item.createTimeStr%>" style="text-align: right;">
                <span class="y-dynamic-file-time"><%=item.createTimeStr%></span>
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
    //查看更多
    function fileSelectMore(type) {
        var libraryId = '${libraryId!}';
        var $yContainer = $('.y-content');
        $yContainer.load('${ctx!}/km/front/fileList?libraryId='+libraryId+"&type="+type);
    }
    //查看全文
    function selectProjectIntroduction() {
        var libraryId = '${libraryId!}';
        var $yContainer = $('.y-content');
        $yContainer.load('${ctx!}/km/front/projectIntroduction?libraryId='+libraryId);
    }
    //下载
    function downloadKnowledge(id) {
        PEBASE.ajaxRequest({
            url: pageContext.rootPath + '/km/knowledge/downloadKnowledge2',
            async: false,
            data: {'knowledgeIds': id, libraryId: "${libraryId!}"},
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
    var libraryId= '${libraryId!}';
</script>
<script src="${resourcePath!}/web-static/proExam/index/js/projectDetail.js"></script>