<div class="y-content-body" id="yunContentBody">
    <h4 class="y-content__title">${libraryName!}</h4>
    <div class="y-content-professional" style="background: none;">
        <div class="y-content-professional-file-box">
            <div class="y-project-activity" style="width: 475px;">
                <div class="y-project-file-inline">
                    <div class="y-project-activity-info">贡献榜单</div>
                </div>
                <div class="y-project-activity-list">
                    <ul class="y-content-professional-rank-list"></ul>
                </div>
            </div>
            <div class="y-project-file">
                <div class="y-project-file-inline">
                    <div class="y-project-file-info">项目文件</div>
                    <div class="y-project-file-more">
                        <a href="javascript:void(0);" class="project-upload" style="padding-right: 20px;">
                            上传文件
                        </a>
                        <a href="#" onclick="fileSelectMore('project')">查看更多</a>
                    </div>
                </div>
                <div class="y-project-file-list">
                    <ul class="y-content-professional-file-list"></ul>
                </div>
            </div>
        </div>
        <div class="y-content-professional-dynamic y-project-activity" style="margin-top: 15px;">
            <div class="y-content-professional-wrap">
                <span class="y-content-professional-title">动态</span>
                    <span class="y-content-professional-more">
                        <a href="#" onclick="fileSelectMore('activity')">查看更多</a>
                    </span>
            </div>
            <ul class="y-content-professional-dynamic-list"></ul>
        </div>
    </div>
</div>
<footer class="y-footer footer-bar">
    国家电网江苏省电力公司 ©苏ICP备15007035号-1
</footer>
<script type="text/template" id="tplYunFileList">
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
                    <%if(item.canDelete){%>
                    <button type="button" title="删除" onclick="deleteKnowledge('<%=item.id%>')"
                            class="yfont-icon opt-item js-opt-delete">&#xe65c;</button>
                    <%}%>
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
<script type="text/template" id="tplYunDynamicList">
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
<#--排行榜-->
<script type="text/template" id="tplYunRankList">
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
<script>
    var libraryId = '${libraryId!}';
    $(function () {
        //上传文件
        $('.project-upload').on('click', function (e) {
            e.preventDefault();
            var deptId, fileIds = "";
            PEMO.DIALOG.selectorDialog({
                content: pageContext.rootPath + '/km/knowledge/openUpload',
                area: ['650px', '400px'],
                title: '上传文件',
                skin: 'js-file-upload',
                btn: ['确定', '取消'],
                btn1: function () {
                    var fileList = window.frames[0] && window.frames[0].document.getElementById('theList');
                    var length = $(fileList).find('li').length;
                    if (window.frames[0] && length == 0) {
                        PEMO.DIALOG.tips({
                            content: '您还未上传文件!',
                            time: 2000
                        });
                        return;
                    }

                    for (var i = 0; i < length; i++) {
                        fileIds += $($(fileList).find('li')[i]).attr("data-id");
                        if (i < length - 1) {
                            fileIds += ",";
                        }
                    }

                    if (libraryId) {
                        PEBASE.ajaxRequest({
                            url: '/km/library/addToLibrary',
                            data: {
                                "fileIds": fileIds,
                                "libraryIds": "${libraryId!}"
                            },
                            success: function (data) {
                                initTable();
                                if (data.success) {
                                    layer.closeAll();
                                    PEMO.DIALOG.tips({
                                        content: '操作成功',
                                        time: 1000,
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
                    }
                }
            });
        });

        initTable();
    })

    function initTable() {
        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/knowledge/searchKnowledge?page=1&pageSize=6&libraryId=${libraryId!}',
            dataType: 'json',
            success: function (data) {
                $(".y-content-professional-file-list").html(_.template($("#tplYunFileList").html())({list: data.rows}));
            }
        });

        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/library/dynamic?page=1&pageSize=10&libraryId=${libraryId!}',
            dataType: 'json',
            success: function (data) {
                $(".y-content-professional-dynamic-list").html(_.template($("#tplYunDynamicList").html())({list: data.rows}));
            }
        });

        $.ajax({
            type: "POST",
            url: pageContext.resourcePath + '/library/rank?libraryId=${libraryId!}',
            dataType: 'json',
            success: function (result) {
                $(".y-content-professional-rank-list").html(_.template($("#tplYunRankList").html())({list: result}));
            }
        });
    }

    //查看更多
    function fileSelectMore(type) {
        var $yContainer = $('.y-content');
        $yContainer.load('${ctx!}/km/front/fileList?libraryId=${libraryId!}&type=' + type);
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
    //删除
    function deleteKnowledge(id) {
        PEMO.DIALOG.confirmL({
            content: '<div><h3 class="pe-dialog-content-head">确定删除上传的知识吗？</h3><p class="pe-dialog-content-tip">删除后，可在我的云库中查看。 </p></div>',
            btn1: function () {
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/km/library/delete',
                    data: {
                        "knowledgeIds": id,
                        "shareLibraryId": libraryId
                    },
                    success: function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '操作成功',
                                time: 1000,
                            });
                            layer.closeAll();
                            //刷新列表
                           initTable();
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
            },
            btn2: function () {
                layer.closeAll();
            }
        });
    }
</script>