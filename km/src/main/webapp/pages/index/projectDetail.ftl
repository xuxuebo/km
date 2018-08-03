<div class="y-major-project" id="yunLContentBody">
    <div class="y-major-project-header"></div>
    <div class="y-major-project-content">
        <div class="y-project-contribution-list">
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
                        <a href="javascript:void(0);" class="project-upload">
                            上传文件
                        </a> <a href="#" onclick="fileSelectMore('project')">
                            查看更多
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
                 onerror="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
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
    <%if(list.length !== 0){%>
    <%_.each(list,function(item,i){%>
    <li>
        <span class="y-project-file-name"> <%=item.knowledgeName%></span>
        <span class="y-project-file-author-name"><%=item.userName%></span>
        <span class="y-project-file-time"><%=item.createTimeStr%></span>
    </li>
    <%})}%>
    <%if(list.length === 0){%>
    <div class="table__none">--暂无数据--</div>
    <%}%>
</script>

<#--云库动态初始化-->
<script type="text/template" id="tplsActivityTable">
    <%if(list.length !== 0){%>
    <%_.each(list,function(item,i){%>
    <li>
        <div class="y-project-activity-time"><%=item.userName%><%=item.typeStr%><%=item.knowledgeName%></div>
        <div class="y-project-activity-name"><%=item.createTimeStr%></div>
    </li>
    <%})}%>
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
    var libraryId= '${libraryId!}';
</script>
<script src="${resourcePath!}/web-static/proExam/index/js/projectDetail.js"></script>