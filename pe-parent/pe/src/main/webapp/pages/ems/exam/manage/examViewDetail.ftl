<#assign ctx=request.contextPath/>
<#--todo开发开始做这个页面的跳转时记得把下面的import和p.pageFrame删除-->
<#import "../../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header">
    <h3 class="paper-add-accredit-title" style="width:1200px;">这里是考试名称哦</h3>
</div>
<section class="pe-all-panel-default exam-view-detail-all-wrap">
    <div class="pe-manage-content-right view-exam-detail-step-wrap">
        <div class="pe-manage-panel pe-manage-default">
            <div class="add-exam-top-head">
                <ul class="over-flow-hide view-exam-detail-head" style="display:inline-block;">
                    <li class="add-paper-step-item floatL overStep" style="text-align:left;">
                        <div class="add-step-icon-wrap">
                   <span class="iconfont icon-step-circle floatL">
                    <span class="add-step-number">1</span>
                   </span>
                            <div class="add-step-line"></div>
                        </div>
                        <span class="add-step-text">基本信息</span>
                    </li>
                    <li class="add-paper-step-item add-paper-step-two floatL">
                        <div class="add-step-icon-wrap">
                            <div class="add-step-line add-step-two-line"></div>
                            <span class="iconfont icon-step-circle floatL">
                           <span class="add-step-number">2</span>
                        </span>
                            <div class="add-step-line"></div>
                        </div>
                        <span class="add-step-text">试卷设置</span>
                    </li>
                    <li class="add-paper-step-item add-paper-step-two floatL">
                        <div class="add-step-icon-wrap">
                            <div class="add-step-line add-step-two-line"></div>
                            <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">3</span>
                     </span>
                            <div class="add-step-line"></div>
                        </div>
                        <span class="add-step-text">考试安排</span>
                    </li>
                    <li class="add-paper-step-item add-paper-step-three floatL"
                        style="width:150px;">
                        <div class="add-step-icon-wrap">
                            <div class="add-step-line"></div>
                            <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">4</span>
                     </span>
                        </div>
                        <span class="add-step-text" style="margin-left:70px;">考试设置</span>
                    </li>
                </ul>
            </div>
            <#--第二个步骤试卷设置显示-->
            <div class="view-exam-detail-step-one" style="display:none;">
                <div class="detail-step-one-content">
                    <dl class="over-flow-hide user-detail-msg-wrap">
                        <dt class="floatL user-detail-title">考试名称:</dt>
                        <dd class="user-detail-value">合肥青谷信息科技有限公司考试</dd>
                        <dt class="floatL user-detail-title">考试编号:</dt>
                        <dd class="user-detail-value">124324234234234234</dd>
                        <dt class="floatL user-detail-title" style="line-height: 24px;">考试说明:</dt>
                        <dd class="user-detail-value" style="line-height: 24px;">这里是专业的考试说明这里是专业的考试说明这里是专业的考试说明这里是专业的考试说明这里是专业的考试说明这里是专业的考试说明这里是专业的考试说明这里是专业的考试说明这里是专业的考试说明这里是专业的考试说明这里是专业的考试说明这里是专业的考试说明这里是专业的考试说明</dd>
                    </dl>
                </div>
            </div>
            <#--第二个步骤试卷设置显示-->
            <div class="view-exam-detail-step-two" style="display:none;">
                <div class="pe-stand-table-panel">
                    <div class="pe-stand-table-top-panel">
                       <span>已生成的试卷：</span>
                    </div>
                <#--表格包裹的div-->
                    <div class="pe-stand-table-main-panel">
                        <div class="pe-stand-table-wrap"></div>
                        <div class="pe-stand-table-pagination"></div>
                    </div>
                </div>
            </div>
            <#--第三步考试安排-->
            <div class="view-exam-detail-step-three">
                <#list [1,2,3] as p>
                    <div class="exam-batch-item-wrap">
                        <div class="batch-item-left floatL">
                           <span class="iconfont icon-batch"></span> 批次1
                        </div>
                        <div class="batch-item-right">
                            <dl class="over-flow-hide user-detail-msg-wrap">
                                <dt class="floatL user-detail-title">考试开始时间:</dt>
                                <dd class="user-detail-value">2016-11-04 14:00</dd>
                                <dt class="floatL user-detail-title">考试结束时间:</dt>
                                <dd class="user-detail-value">2016-11-04 16:00</dd>
                                <dt class="floatL user-detail-title">考生说明:</dt>
                                <dd class="user-detail-value"><a href="javascript:;">查看考生信息</a></dd>
                            </dl>
                        </div>
                    </div>
                </#list>
            </div>
            <#--第四步考试设置-->
            <div class="view-exam-detail-step-four" style="display:none;">
                <div class="add-exam-item-wrap">
                    <dl class="over-flow-hide user-detail-msg-wrap">
                        <dt class="floatL user-detail-title">考试管理员:</dt>
                        <dd class="user-detail-value"><a href="javascript:;" class="exam-view-user">查看人员</a></dd>
                        <dt class="floatL user-detail-title">考试时长:</dt>
                        <dd class="user-detail-value"><input type="text" placeholder="0" class="exam-create-num-input">&nbsp;分钟
                            <span class="add-paper-tip-text" style="margin-left:10px;">*当输入为0时，表示不限制时长</span>
                        </dd>
                        <dt class="floatL user-detail-title">答题模式:</dt>
                        <dd class="user-detail-value">整卷模式</dd>
                        <dt class="floatL user-detail-title">答题模式:</dt>
                        <dd class="user-detail-value">整卷模式</dd>
                        <dt class="floatL user-detail-title">补考设置:</dt>
                        <dd class="user-detail-value">不允许补考</dd>
                        <dt class="floatL user-detail-title">评卷策略:</dt>
                        <dd class="user-detail-value" style="margin-bottom:20px;">自动评卷
                            <span class="add-paper-tip-text" style="margin-left:10px;">*适合全部为客观题的试卷，系统对客观题自动评卷，若有主观题，则记为0分</span>
                        </dd>
                        <dt class="floatL user-detail-title">成绩设置:</dt>
                        <dd class="user-detail-value">原试卷题目分数按比例折算成满分
                            <input type="text" placeholder="100" class="exam-create-num-input">&nbsp; 分
                        </dd>
                        <dt class="floatL user-detail-title">及格条件:</dt>
                        <dd class="user-detail-value">得分率不低于
                            <input type="text" placeholder="60" class="exam-create-num-input">&nbsp;%
                        </dd>
                        <dt class="floatL user-detail-title">成绩发布设置:</dt>
                        <dd class="user-detail-value">评卷后自动发布成绩</dd>
                        <dt class="floatL user-detail-title">排行榜设置:</dt>
                        <dd class="user-detail-value">不显示考试排名</dd>
                        <dt class="floatL user-detail-title">考试权限设置:</dt>
                        <dd class="user-detail-value">评卷后允许考生查看答卷和正确答案</dd>
                        <dt class="floatL user-detail-title">防舞弊设置:</dt>
                        <dd class="user-detail-value" style="height:80px;">
                            <#--<div>全屏模式</div>-->
                            <div>切屏次数超过
                                <input type="text" placeholder="60" class="exam-create-num-input">&nbsp;次,强制交卷；
                                <input type="text" placeholder="60" class="exam-create-num-input">&nbsp;分钟内,考试页面不操作算为舞弊并强制交卷</div>
                        </dd>
                    </dl>
                </div>
            </div>
            <div class="btns-group-wrap">
                <button type="button" class="pe-btn pe-btn-blue pe-large-btn close-btn">关闭</button>
                <button type="button" class="pe-btn pe-btn-purple pe-large-btn step-two-eidt">编辑考试信息</button>
            </div>
        </div>
    <#--部门节点Id-->
        <input type="hidden" name="organize.id" value="${(organize.id)!}"/>
    <#--岗位Id-->
        <input type="hidden" name="positionId"/>
    </div>
</section>
<#--渲染表格模板-->
<script type="text/template" id="peQuestionTableTep">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%_.each(peData.tableTitles,function(tableTitle){%>
            <th style="width:<%=tableTitle.width%>%">
                <%=tableTitle.title%>
            </th>
            <%});%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%_.each(peData.rows,function(paper,index){%>
        <tr data-id="<%=paper.id%>">
        <#--试卷序号-->
            <td>
                <div class="pe-ellipsis" title="<%=paper.comments%>"><%=(paper.start + index)%></div>
            </td>
        <#--试卷来源-->
            <td>
                <div class="pe-ellipsis" title="<%=paper.examName%>"><%=paper.examName%></div>
            </td>
        <#--试卷总数-->
            <td>
                <div class="pe-ellipsis" title="<%=paper.itemCount%>"><%=paper.itemCount%></div>
            </td>
        <#--试题分值-->
            <td>
                <div class="pe-ellipsis" title="<%=paper.mark%>"><%=paper.mark%></div>
            </td>
        <#--综合难度-->
            <td>
                <div class="pe-ellipsis">
                    <div class="pe-star-wrap">
                        <%if(paper.level == 'SIMPLE'){%>
                        <span class="pe-star-container floatL">
                                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                      </span>
                        <%}else if(paper.level == 'RELATIVELY_SIMPLE'){%>
                        <span class="pe-star-container floatL">
                                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                        <span class="pe-star iconfont icon-start-difficulty"></span>
                                      </span>
                        <%}else if(paper.level == 'MORE_DIFFICULT'){%>
                        <span class="pe-star-container floatL">
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty"></span>
                                      </span>
                        <%}else if(paper.level == 'DIFFICULT'){%>
                        <span class="pe-star-container floatL">
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                      </span>
                        <%}else{%>
                        <span class="pe-star-container floatL">
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                                         <span class="pe-star iconfont icon-start-difficulty"></span>
                                         <span class="pe-star iconfont icon-start-difficulty"></span>
                                      </span>
                        <%}%>
                    </div>
                </div>
            </td>
        <#--操作-->
            <td>
                <div class="pe-stand-table-btn-group">
                    <button type="button" class="pe-icon-btn iconfont icon-show-analysis preview-paper" title="预览"
                            data-id="<%=paper.id%>">
                    </button>
                    <button type="button" class="pe-icon-btn iconfont icon-edit edit-paper" title="编辑"
                            data-id="<%=paper.id%>">
                    </button>
                    <button type="button" class="pe-icon-btn iconfont icon-delete delete-paper" title="删除"
                            data-id="<%=paper.id%>">
                    </button>
                </div>
            </td>
        </tr>
        <%});%>
        <%}else{%>
        <tr class="pe-stand-tr">
            <td class="pe-stand-td pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
                <div class="pe-result-no-date"></div>
                <p class="pe-result-date-warn">暂无数据</p>
            </td>
        </tr>
        <%}%>
        </tbody>
    </table>
</script>

<script>
    $(function () {

        /*自定义表格头部数量及宽度*/
        //宽度单位为百分比！
        var peTableTitle = [
            {'title': '试卷序号', 'width': 10},
            {'title': '试卷来源', 'width': 30},
            {'title': '试题总量', 'width': 10},
            {'title': '试题分值', 'width': 10},
            {'title': '综合难度', 'width': 20},
            {'title': '操作', 'width': 14}
        ];

        /*表格生成*/
        $('.pe-stand-table-wrap').peGrid({
            url: pageContext.rootPath + '/uc/role/manage/search',
            formParam: $('#peFormSub').serializeArray(),//表格上方表单的提交参数
            tempId: 'peQuestionTableTep',//表格模板的id
            showTotalDomId: 'showTotal',
            title: peTableTitle, //表格头部的数量及名称数组;
            onLoad: function () {

            }
        });

        //部门渲染
        var organizeTreeData = {
            dataUrl: pageContext.rootPath + '/uc/user/manage/listTree',
            clickNode: function (treeNode) {
                if (!treeNode.pId) {
                    return false;
                }

                $('.pe-organize-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                $('input[name="organize.id"]').val(treeNode.id);
            }
        };
        PEBASE.inputTree({dom: '.pe-organize-tree-wrap', treeId: 'organizeTree', treeParam: organizeTreeData});

        //岗位
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
            }
        };
        PEBASE.inputTree({
            dom: '.pe-position-tree-wrap',
            treeId: 'positionTree',
            treeParam: settingInputPositionTree
        });

        /*关闭按钮事件*/
        $('.pe-view-question-close-btn').on('click',function(){
            window.close();
        });
    })
</script>
</@p.pageFrame>