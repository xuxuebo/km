<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">试题</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">试题管理</li>
    <#if item?? && item.id??>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">编辑试题</li>
    <#else >
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">新增试题</li>
    </#if>
    </ul>
</div>
<section class="pe-add-question-wrap">
    <form id="editItemForm">
        <input type="hidden" value="${(item.id)!}" name="id"/>
        <input type="hidden" value="${(item.itemDetail.id)!}" name="itemDetail.id"/>
        <div class="pe-question-top-head">
            <h2 class="pe-question-head-text">基本信息</h2>
        </div>
        <div class="pe-question-item-container">
            <div class="pe-main-input-tree clearF" style="relative;margin-bottom:18px;">
                <span class="pe-input-tree-text floatL">
                    <span style="color:red;">*</span>所属题库:
                </span>
                <div class="pe-stand-filter-form-input  pe-question-input-tree">
                    <label class="input-tree-choosen-label">
                    <#if item?? && item.itemBank?? && item.itemBank.bankName?? >
                        <span class="itemBank-span search-tree-text" title="${(item.itemBank.bankName)!}"
                              data-id="${(item.itemBank.id)!}">${(item.itemBank.bankName)!}</span>
                    </#if>
                    </label>
                    <input type="hidden" name="itemBank.id" class="required" value="${(item.itemBank.id)!}"/>
                    <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"
                          style="height:40px;line-height:40px;"></span>
                    <span class="iconfont icon-inputDele km-input-tree-dele input-icon"
                          style="display:none;top:4px;"></span>
                    <div class="pe-select-tree-wrap pe-input-tree-drop-two pe-input-tree-wrap-drop "
                         style="display:none;">
                        <ul id="bankInputTree" class="ztree pe-tree-container floatL"></ul>
                        <ul id="bankTreeChildren" class="pe-input-tree-children-container" style="overflow: auto;">暂无，请点击左边进行筛选</ul>
                    </div>
                </div>
            </div>
            <label class="pe-question-label">
                 <span class="pe-input-tree-text floatL">
                    <span style="color:red;">*</span>试题分值:
                </span>
                <input class="pe-stand-filter-form-input pe-question-score-num required " type="text" value="${(item.mark)!'1'}"
                       name="mark">
            </label>
            <div class="pe-main-input-tree over-flow-hide" style="height:40px;">
                <span class="pe-input-tree-text floatL">
                    <span style="color:red;">*</span>试题难度:
                </span>
                <div class="pe-star-wrap">
                <#--freemarkke初始难度，给下面的span加上pe-checked-star-->
                <#if item?? && item.level?? && item.level == 'SIMPLE'>
                    <span class="pe-star-container floatL">
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        </span>
                    <span class="pe-difficulty-num">简单</span>
                <#elseif item?? && item.level?? && item.level == 'RELATIVELY_SIMPLE'>
                    <span class="pe-star-container floatL">
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                       </span>
                    <span class="pe-difficulty-num">较简单</span>
                <#elseif item?? && item.level?? && item.level == 'MORE_DIFFICULT'>
                    <span class="pe-star-container floatL">
                           <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                       </span>
                    <span class="pe-difficulty-num">较难</span>
                <#elseif item?? && item.level?? && item.level == 'DIFFICULT'>
                    <span class="pe-star-container floatL">
                           <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                       </span>
                    <span class="pe-difficulty-num">困难</span>
                <#else>
                    <span class="pe-star-container floatL">
                           <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                       </span>
                    <span class="pe-difficulty-num">中等</span>
                </#if>
                    <input type="hidden" class="required" name="level" value="${(item.level)!'MEDIUM'}">
                </div>
            </div>
        </div>
        <div class="pe-question-top-head">
            <h2 class="pe-question-head-text">试题内容</h2>
        </div>
        <div class="pe-question-item-container pe-add-qutestion-type-container">
            <div class="pe-question-content-wrap over-flow-hide">
                <span class="pe-input-tree-text floatL">
                    <span style="color:red;">*</span>选择题型:
                </span>
                <div class="pe-add-question-type-btn">
                    <input type="hidden" value="SINGLE_SELECTION" class="question-item-curType"/>
                <#if (!(item?? && item.type??))>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-single curType "
                            data-type="SINGLE_SELECTION">单选题
                    </button>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-multiple"
                            data-type="MULTI_SELECTION">多选题
                    </button>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-indefinite"
                            data-type="INDEFINITE_SELECTION">不定项选择题
                    </button>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-judgment"
                            data-type="JUDGMENT">判断题
                    </button>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-fill"
                            data-type="FILL">填空题
                    </button>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-question"
                            data-type="QUESTIONS">问答题
                    </button>
                <#elseif item?? &&item.status =='DRAFT'>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-single <#if item.type=='SINGLE_SELECTION'>curType</#if> "
                            data-type="SINGLE_SELECTION" style="cursor: auto;">单选题
                    </button>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-multiple  <#if item.type=='MULTI_SELECTION'>curType</#if>"
                            data-type="MULTI_SELECTION" style="cursor: auto;">多选题
                    </button>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-indefinite <#if item.type=='INDEFINITE_SELECTION'>curType</#if> "
                            data-type="INDEFINITE_SELECTION" style="cursor: auto;">不定项选择题
                    </button>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-judgment <#if item.type=='JUDGMENT'>curType</#if>"
                            data-type="JUDGMENT" style="cursor: auto;">判断题
                    </button>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-fill <#if item.type=='FILL'>curType</#if>"
                            data-type="FILL" style="cursor: auto;">填空题
                    </button>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-question <#if item.type=='QUESTIONS'>curType</#if>"
                            data-type="QUESTIONS" style="cursor: auto;">问答题
                    </button>
                <#elseif item.type == 'SINGLE_SELECTION'>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-single curType"
                            data-type="SINGLE_SELECTION" style="cursor: auto;">单选题
                    </button>
                <#elseif item.type == 'MULTI_SELECTION'>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-multiple curType"
                            data-type="MULTI_SELECTION" style="cursor: auto;">多选题
                    </button>
                <#elseif item.type == 'INDEFINITE_SELECTION'>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-indefinite curType"
                            data-type="INDEFINITE_SELECTION" style="cursor: auto;">不定项选择题
                    </button>
                <#elseif item.type == 'JUDGMENT'>
                    <button type="button"
                            class="pe-btn floatL pe-add-judgment curType"
                            data-type="JUDGMENT" style="cursor: auto;">判断题
                    </button>
                <#elseif item.type == 'FILL'>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-fill curType"
                            data-type="FILL" style="cursor: auto;">填空题
                    </button>
                <#elseif item.type == 'QUESTIONS'>
                    <button type="button"
                            class="pe-btn pe-btn-white floatL pe-add-question curType"
                            data-type="QUESTIONS" style="cursor: auto;">问答题
                    </button>
                </#if>
                    <input type="hidden" name="type" value="${(item.type)!'SINGLE_SELECTION'}"/>
                </div>
            </div>
            <div class="pe-question-add-item-type">
                <div class="pe-add-question-all-panel pe-add-type-wrap">
                    <div class="pe-add-question-tip">
                    <#if item?? && item.type?? && item.type=='MULTI_SELECTION'>
                        （至少有两个选项是正确答案）
                    <#elseif item?? && item.type?? && item.type=='INDEFINITE_SELECTION'>
                        （至少有一个选项是正确答案）
                    <#elseif item?? && item.type?? && item.type=='JUDGMENT'>
                        (判断题干中描述内容是正确或者错误)
                    <#elseif !(item?? && item.type??) >
                        （只有一个选项是正确答案）
                    </#if>
                    </div>
                    <div class="pe-question-item-rich-wrap">
                        <div class="pe-rich-text-wrap">
                            <div class="pe-rich-text-item-area">
                                <div id="containerContent" class="option pe-simple-editor">

                                </div>
                            </div>
                        </div>
                        <div class="pe-question-single-rich-wrap pe-editors-wrap" data-type="SINGLE_SELECTION"
                             style="display:none;"></div>
                        <div class="pe-question-multiple-rich-wrap pe-editors-wrap" data-type="MULTI_SELECTION"
                             style="display:none;"></div>
                        <div class="pe-question-indefinite-rich-wrap pe-editors-wrap" data-type="INDEFINITE_SELECTION"
                             style="display:none;"></div>
                        <div class="pe-question-judgment-rich-wrap pe-editors-wrap" data-type="JUDGMENT" style="display:none;"></div>
                        <div class="pe-question-fill-rich-wrap pe-editors-wrap" data-type="FILL" style="display:none;"></div>
                        <div class="pe-question-question-rich-wrap pe-editors-wrap" data-type="QUESTIONS" style="display:none;"></div>
                        <button type="button" class="pe-add-rich-area-btn">增加选项</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="pe-question-top-head pe-question-more-wrap">
            <h2 class="pe-question-head-text"> 更多信息</h2>
                <span class="pe-add-question-more-msg">
                        <span class="iconfont icon-pack"></span>
                 </span>
        </div>
        <div class="pe-add-question-more-choosen-wrap" style="display:none;">
            <div class="pe-question-item-container" style="position:relative;">
                <@authVerify authCode="VERSION_OF_SECRET_ITEM">
                    <div class="pe-top-secret">
                        <div class="floatL pe-left-text"><span style="color:red;">*</span>是否绝密:</div>
                        <label class="pe-radio">
                            <span class="iconfont <#if (!(item?? && item.security??) || (item?? && item.security?? && !item.security))>icon-checked-radio peChecked<#else>icon-unchecked-radio peChecked</#if>"></span>
                            <input class="pe-form-ele" type="radio"
                               <#if (!(item?? && item.security??) || (item?? && item.security?? && !item.security))>checked="checked"</#if>
                                   value="false" name="security"/>否
                        </label>
                        <span class="pe-secret-tip-text">非绝密试题允许创建人和其他被授权管理员查看并使用试题</span>
                    </div>
                    <div class="pe-top-secret">
                        <label class="pe-radio">
                            <span class="iconfont <#if item?? && item.security?? && item.security>icon-checked-radio peChecked<#else>icon-unchecked-radio peChecked</#if>"></span>
                            <input class="pe-form-ele" type="radio"
                                   <#if item?? && item.security?? && item.security>checked="checked"</#if>
                                   value="true" name="security"/>是
                        </label>
                        <span class="pe-secret-tip-text">绝密试题只允许创建人查看并使用试题</span>
                    </div>
                </@authVerify>
                <div class="pe-more-item-wrap">
                    <label class="pe-table-form-label floatL">
                        <span class="pe-input-tree-text"><span style="color:red;">*</span>试题编号:</span>
                    <#if item?? && item.id??&&item.status=='ENABLE'>
                    ${(item.itemCode)!}
                    <#elseif item?? && item.id??&&item.status=="DRAFT">
                        <input class="pe-stand-filter-form-input iconfont  item-code-input" type="text" maxlength="50"
                               name="itemCode" style="margin-left: -2px;"
                               value="${(item.itemCode)!}"/>
                    <#else>
                        <input class="pe-stand-filter-form-input iconfont required item-code-input" type="text" maxlength="50"
                               name="itemCode" style="margin-left: -2px;"
                               value="${(item.itemCode)!}"/>
                    </#if>
                    </label>
                </div>
                <div class="pe-more-item-wrap" style="overflow: visible;">
                    <div class="pe-form-select pe-attribute-select-wrap">
                    <#--select模式，取值见下面的hidden的input及peSelect方法-->
                        <span class="pe-input-tree-text floatL"><span style="color:red;">*</span>试题属性:</span>
                        <input type="hidden" name="choosenAttribute" class="required"  value="EXAM" >
                        <select class="pe-attribute-select dropdown " name="attributeType">
                            <option value="EXAM"
                                    <#if ((item?? && item.attributeType?? && item.attributeType=='EXAM'))>selected="selected"</#if>>
                                考试专用
                            </option>
                            <option value="EXAMEXERCISE"
                                    <#if !(item?? && item.attributeType??) ||(item?? && item.attributeType?? && item.attributeType=='EXAMEXERCISE')>selected="selected"</#if>>
                                考试练习可用
                            </option>
                            <option value="EXERCISE"
                                    <#if ( item?? && item.attributeType?? && item.attributeType == 'EXERCISE')>selected="selected"</#if>>
                                练习专用
                            </option>

                        </select>
                    </div>
                </div>
                <div class="pe-more-item-wrap" style="overflow: visible;">
                    <div class="pe-form-select pe-language-select-wrap">
                    <#--select模式，取值见下面的hidden的input及peSelect方法-->
                        <span class="pe-input-tree-text floatL"><span style="color:red;">*</span>语言属性:</span>
                        <input type="hidden" name="choosenLanguage" class="required" value="CHINESE">
                        <select class="pe-language-select dropdown" name="languageType">
                            <option value="CHINESE"
                                    <#if (!(item?? && item.languageType??) || (item?? && item.languageType?? && item.languageType == 'CHINESE'))>selected="selected"</#if>>
                                中文
                            </option>
                            <option value="ENGLISH"
                                    <#if (item?? && item.languageType?? && item.languageType == 'ENGLISH')>selected="selected"</#if>>
                                英文
                            </option>
                            <option value="TRADITIONAL_CHINESE"
                                    <#if (item?? && item.languageType?? && item.languageType == 'TRADITIONAL_CHINESE')>selected="selected"</#if>>
                                繁体中文
                            </option>
                            <option value="JAPANESE"
                                    <#if (item?? && item.languageType?? && item.languageType == 'JAPANESE')>selected="selected"</#if>>
                                日文
                            </option>
                            <option value="KOREAN"
                                    <#if (item?? && item.languageType?? && item.languageType == 'KOREAN')>selected="selected"</#if>>
                                韩语
                            </option>
                        </select>
                    </div>
                </div>

            <#--下面更多的知识点树状渲染;-->
                <@authVerify authCode="VERSION_OF_KNOWLEDGE_POINT">
                    <div class="pe-more-item-wrap" style="position:relative;overflow: visible;">
                        <div id="peMainKmText" class="pe-main-km-text-wrap" style="clear:both;">
                            <span class="pe-km-text floatL pe-left-text">知&nbsp;识&nbsp;点:</span>
                            <div class="pe-km-input-tree pe-stand-filter-form-input">
                            <#--<input class="pe-km-save-input-tree pe-tree-show-name" value="" style="position: absolute;"/>-->
                                <label class="input-tree-choosen-label">
                                <#if item?? && item.knowledges?? && (item.knowledges?size>0) >
                                    <#list item.knowledges as knowledge>
                                        <span class="search-tree-text" style="vertical-align:middle;"
                                              title="${(knowledge.knowledgeName)!}"
                                              data-id="${(knowledge.id)!}">${(knowledge.knowledgeName)!}</span>
                                    </#list>
                                </#if>
                                    <input class="pe-tree-show-name" value="" name="knowledgeName" maxlength="6"
                                           style="width:2px;"/>
                                </label>
                                <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"
                                      style="height:40px;line-height:40px;"></span>
                                <span class="iconfont icon-inputDele km-input-tree-dele input-icon"
                                      style="display:none;top:4px;"></span>
                                <div class="pe-select-tree-wrap pe-input-tree-drop-two pe-input-tree-wrap-drop"
                                     style="display:none;top:38px;">
                                    <ul id="peSelelctKmInputTree" class="ztree pe-tree-container floatL"></ul>
                                    <ul id="peSelectKmChildren" class="pe-input-tree-children-container"
                                        style="overflow: auto;">暂无，请点击左边进行筛选
                                    </ul>
                                </div>
                            </div>
                            <input type="hidden" name="knowledge" value="${(knowledge)!}"/>
                        </div>
                    </div>
                </@authVerify>
                <div class="pe-more-item-wrap pe-add-ques-score"
                <#if item?? && item.type?? && (item.type =='MULTI_SELECTION'|| item.type =='INDEFINITE_SELECTION')>
                     style="display: block;"
                <#else>
                     style="display: none;"
                </#if>>
                </div>
                <div class="pe-rich-text-more-item-area">
                    <div id="containerMoreMsg" class="option pe-simple-editor">
                    </div>
                </div>
            </div>
        </div>
        <div class="pe-btns-group-wrap">
        <#if item?? && item.id??>
            <button type="button" class="pe-btn pe-btn-blue pe-large-btn pe-item-save-draft">保存</button>
        <#else>
            <button type="button" class="pe-btn pe-btn-blue pe-large-btn pe-item-save-draft">保存为草稿</button>
            <button type="button" class="pe-btn pe-btn-blue pe-large-btn pe-item-save-enable-btn">保存并启用</button>
        </#if>
            <button type="button" class="pe-btn pe-btn-purple pe-large-btn pe-add-ques-cancel-btn">取消</button>
        </div>
    </form>
</section>
<#--判断题的模板-->
<script type="text/template" id="judgeTemp">
    <div class="pe-add-question-true-answer-wrap option-text-wrap">
        <h3 class="pe-add-true-answer-head">正确答案</h3>
        <div class="pe-add-true-answer-item">
            <label class="pe-radio judgeAnswer">
                <span class="iconfont icon-checked-radio"></span>
                <span class="pe-select-true-answer"><input class="pe-form-ele" checked="checked" type="radio"
                                                           value="true" name="judgeAnswer"/>正确</span>
            </label>
            <label class="pe-radio judgeAnswer">
                <span class="iconfont icon-unchecked-radio"></span>
                <span class="pe-select-true-answer"><input class="pe-form-ele" type="radio" value="false"
                                                           name="judgeAnswer"/>错误</span>
            </label>
        </div>
    </div>
</script>
<#--问答题模板-->
<script type="text/template" id="questionTemp">
    <div class="pe-add-question-true-answer-wrap option-text-wrap" style="height:161px;">
        <h3 class="pe-add-true-answer-head">参考答案</h3>
        <div class="pe-add-true-answer-item">
            <textarea class="pe-add-question-text-answer" style="height: 100px;"></textarea>
        </div>
    </div>
</script>
<#--填空题模板-->
<script type="text/template" id="fillTemp">
    <div class="pe-add-question-true-answer-wrap option-text-wrap" style="border:none;height:auto;min-height:108px;">
        <h3 class="pe-add-true-answer-head">参考答案</h3>
        <div class="pe-add-true-answer-item fill-item-true-answer-wrap">
            <#--<textarea class="pe-add-fill-text-answer"></textarea>-->
        </div>
    </div>
</script>
<#--填空题的选项插入模板-->
<script type="text/template" id="fillAnswerTemplate">
    <label class="pe-question-label" data-index="ill<%=data.index%>">
                 <span class="pe-input-tree-text floatL">
                    填空<%=data.index%>:
                </span>
        <input class="pe-stand-filter-form-input" type="text" value="<%=data.a%>" maxlength="50"
               name="fillItemAnswer" placeholder="请输入第<%=data.index%>个填空的答案">
        <em id="fillItemAnswer<%=data.index%>-error error-em" style="display:none;" class="error">答案不能为空</em>
    </label>
</script>
<#--单选题的选择项模板-->
<script type="text/template" id="radioTemp">
    <div class="pe-rich-text-wrap option-text-wrap">
        <div class="pe-rich-text-item-area">
            <div id="<%=containerDom%>" class="option pe-simple-editor">
            </div>
        </div>
        <div class="pe-uedit-opt floatL">
            <label class="pe-radio isRadioOpt">
                <span class="iconfont <%if (answer) {%>icon-checked-radio peChecked<%} else {%>icon-unchecked-radio<%}%>"></span>
                <span class="pe-select-true-answer">
                    <input class="pe-form-ele" <%if (answer) {%>checked="checked"<%}%> type="radio" name="answer"/>设置为正确答案</span>
            </label>
            <ul class="pe-uedit-opt-move over-flow-hide">
                <%if (first){%>
                <li class="uedit-move-up iconfont disabled icon-up floatL"></li>
                <%}else{%>
                <li class="uedit-move-up iconfont icon-up floatL option-hover" title="上移选项"></li>
                <%}%>
                <%if (last){%>　
                <li class="uedit-move-down iconfont disabled icon-down floatL"></li>
                <%}else{%>
                <li class="uedit-move-down iconfont icon-down floatL option-hover" title="下移选项"></li>
                <%}%>
                <li class="uedit-dele iconfont icon-delete <%if(!canDele){%>disabled<%}%> floatL"></li>
            </ul>
        </div>
    </div>
</script>
<#--多选和不定项选题的选择项模板-->
<script type="text/template" id="checkboxTemp">
    <div class="pe-rich-text-wrap option-text-wrap">
        <div class="pe-rich-text-item-area">
            <div id="<%=containerDom%>" class="option pe-simple-editor">
            </div>
        </div>
        <div class="pe-uedit-opt floatL">
            <label class="pe-checkbox">
                <span class="iconfont <%if (answer) {%>icon-checked-checkbox peChecked<%} else {%>icon-unchecked-checkbox<%}%>"></span>
                <span class="pe-select-true-answer"><input class="pe-form-ele" type="checkbox" <%if (answer) {%>checked="checked"<%}%>
                                                           name="answer"/>设置为正确答案</span>
            </label>
            <ul class="pe-uedit-opt-move over-flow-hide">
                <%if (first){%>
                <#--<li class="uedit-move-up iconfont disabled 433|<|li| |class|=|"|uedit-move-up iconfont disabled icon-up floatL|"|>|</|li|> floatL"></li>-->
                <li class="uedit-move-up iconfont disabled icon-up floatL"></li>
                <%}else{%>
                <li class="uedit-move-up iconfont icon-up floatL option-hover" title="上移选项"></li>
                <%}%>
                <%if (last){%>
                <li class="uedit-move-down iconfont disabled icon-down floatL"></li>
                <%}else{%>
                <li class="uedit-move-down iconfont icon-down floatL option-hover" title="下移选项"></li>
                <%}%>
                <li class="uedit-dele iconfont icon-delete <%if(!canDele){%>disabled<%}%> floatL" ></li>
            </ul>
        </div>
    </div>
</script>

<#--题库的input点击下拉框生成的模板-->
<script type="text/template" id="bankTemplate">
    <%if(data.length !== 0){%>
    <%_.each(data, function(itemBank) {%>
    <li class="pe-search-children-nodes" title="<%=itemBank.bankName%>">
        <label class="pe-radio">
            <%if(itemBankId === itemBank.id){%>
            <span class="iconfont icon-checked-radio"></span>
            <input class="pe-form-ele" type="radio" name="bankName" data-id="<%=itemBank.id%>" checked="checked"
                   title="<%=itemBank.bankName%>" value=""/><%=itemBank.bankName%>
            <%}else{%>
            <span class="iconfont icon-unchecked-radio"></span>
            <input class="pe-form-ele" type="radio" name="bankName" data-id="<%=itemBank.id%>"
                   title="<%=itemBank.bankName%>" value=""/><%=itemBank.bankName%>
            <%}%>
        </label>
    </li>
    <%});%>
    <%}else{%>
    <div class="input-tree-no-data-tip">此类别下暂无数据</div>
    <%}%>
</script>
<#--知识点的input点击下拉框生成的模板-->
<script type="text/template" id="knowledgeTemplate">
    <%if(data.length !== 0){%>
    <%_.each(data, function(knowledge) {%>
    <li class="pe-search-children-nodes" title="<%=knowledge.name%>">
        <label class="pe-checkbox">
            <%if(_.contains(knowledgeId,knowledge.id)){%>
            <span class="iconfont icon-checked-checkbox"></span>
            <input class="pe-form-ele" type="checkbox" data-id="<%=knowledge.id%>" checked="checked"
                   title="<%=knowledge.name%>" value=""/><%=knowledge.name%>
            <%}else{%>
            <span class="iconfont icon-unchecked-checkbox"></span>
            <input class="pe-form-ele" type="checkbox" data-id="<%=knowledge.id%>" title="<%=knowledge.name%>"
                   value=""/><%=knowledge.name%>
            <%}%>
        </label>
    </li>
    <%});%>
    <%}else{%>
    <div class="input-tree-no-data-tip">此类别下暂无数据</div>
    <%}%>
</script>
<script type="text/javascript">
    subscriptMap = {
        '0': 'A', '1': 'B', '2': 'C', '3': 'D', '4': 'E', '5': 'F', '6': 'G', '7': 'H', '8': 'I', '9': 'J'
        , '10': 'K', '11': 'L', '12': 'M', '13': 'N', '14': 'O', '15': 'P', '16': 'Q', '17': 'R', '18': 'S', '19': 'T'
        , '20': 'U', '21': 'V', '22': 'W', '23': 'X', '24': 'Y', '25': 'Z'
    };
</script>
<script type="text/javascript">
    var matchOldArray = '';
    var itemPage = {
        initUeScript: function (template, flag, wrapDom) {
            var canDele = true;
            for (var i = 0; i < 4; i++) {
                var first = i === 0;
                var last = i === 3;
                var containerDom = 'container' + i + flag;
                wrapDom.append(_.template($('#' + template).html())({
                    containerDom: containerDom,
                    first: first,
                    last: last,
                    canDele: canDele,
                    answer:first
                }));
                itemPage.renderUedit(containerDom,'选项'+ subscriptMap[i],'');
            }
        },

        //题型切换的函数
        typeTabChange: function (chooseType) {
            var thisContainer = $('.pe-add-question-all-panel'),
                 singleWrap   = $('.pe-question-single-rich-wrap'),
                 multipleWrap  = $('.pe-question-multiple-rich-wrap'),
                 indefiniteWrap  = $('.pe-question-indefinite-rich-wrap'),
                 judgmentWrap  = $('.pe-question-judgment-rich-wrap'),
                 fillWrap  = $('.pe-question-fill-rich-wrap'),
                 questionWrap  = $('.pe-question-question-rich-wrap');
            if (!chooseType || chooseType === 'SINGLE_SELECTION') {
                singleWrap.show();
                multipleWrap.hide();
                indefiniteWrap.hide();
                judgmentWrap.hide();
                fillWrap.hide();
                questionWrap.hide();
                thisContainer.find('.pe-add-question-tip').html('(只有一个选项是正确答案)');
                $('input[name="type"]').val('SINGLE_SELECTION');
                $('.pe-add-rich-area-btn').css({'display': ''});
                $('.pe-add-ques-score').hide();
                PEBASE.peFormEvent('radio');
            } else if (chooseType === 'MULTI_SELECTION') {
                singleWrap.hide();
                multipleWrap.show();
                indefiniteWrap.hide();
                judgmentWrap.hide();
                fillWrap.hide();
                questionWrap.hide();
                thisContainer.find('.pe-add-question-tip').html('(至少有两个选项是正确答案)');
                $('input[name="type"]').val('MULTI_SELECTION');
                $('.pe-add-rich-area-btn').css({'display': ''});
                $('.pe-add-ques-score').show();
                PEBASE.peFormEvent('checkbox');
            } else if (chooseType === 'INDEFINITE_SELECTION') {
                singleWrap.hide();
                multipleWrap.hide();
                indefiniteWrap.show();
                judgmentWrap.hide();
                fillWrap.hide();
                questionWrap.hide();
                thisContainer.find('.pe-add-question-tip').html('(至少有一个选项是正确答案)');
                $('input[name="type"]').val('INDEFINITE_SELECTION');
                $('.pe-add-rich-area-btn').css({'display': ''});
                $('.pe-add-ques-score').show();
                PEBASE.peFormEvent('checkbox');
            } else if (chooseType === 'JUDGMENT') {
                singleWrap.hide();
                multipleWrap.hide();
                indefiniteWrap.hide();
                judgmentWrap.show();
                fillWrap.hide();
                questionWrap.hide();
                judgmentWrap.html(_.template($('#judgeTemp').html())({}));
                thisContainer.find('.pe-add-question-tip').html('(判断题干中描述内容是正确或者错误)');
                $('input[name="type"]').val('JUDGMENT');
                $('.pe-add-rich-area-btn').css({'display': 'none'});
                $('.pe-add-ques-score').hide();
                PEBASE.peFormEvent('radio');
            } else if (chooseType === 'FILL') {
                singleWrap.hide();
                multipleWrap.hide();
                indefiniteWrap.hide();
                judgmentWrap.hide();
                fillWrap.show();
                questionWrap.hide();
                fillWrap.html(_.template($('#fillTemp').html())({}));
                thisContainer.find('.pe-add-question-tip').html('');
                $('input[name="type"]').val('FILL');
                $('.pe-add-rich-area-btn').css({'display': 'none'});
                $('.pe-add-ques-score').hide();
            } else if (chooseType === 'QUESTIONS') {
                singleWrap.hide();
                multipleWrap.hide();
                indefiniteWrap.hide();
                judgmentWrap.hide();
                fillWrap.hide();
                questionWrap.show();
                questionWrap.html(_.template($('#questionTemp').html())({}));
                thisContainer.find('.pe-add-question-tip').html('');
                $('input[name="type"]').val('QUESTIONS');
                $('.pe-add-rich-area-btn').css({'display': 'none'});
                $('.pe-add-ques-score').hide();
            }

            if(chooseType === 'FILL'){
                $('#containerContent .insert-fill-blank').show();
            }else{
                $('#containerContent  .insert-fill-blank').hide();
            }
        },

        //渲染富文本编辑器
        renderUedit: function (name, selfLeftContent,frameContent) {
        //渲染简单富文本编辑器;
        $('#'+name).peEditor({
            name:name,
            initFrameWidth:788,
            initFrameHeight:122,
            toolLeftContent:selfLeftContent,
            baseUrl:pageContext.rootPath,
            imageUrl:'',
            videoUrl:'',
            audioUrl:'',
            initContent:frameContent,
            toolBar:[['image','video','music','magnify']],
            onLoad:function(d,t){
                //富文本编辑器渲染好后，进行内容变化函数的定义
                var afterRenderEditorDom = $(d.peEditor);
                var ua = navigator.userAgent.toLowerCase();
                var s = ua.match(/msie ([\d.]+)/);
                if(s && parseInt(s[1]) == 9){
                    $.fn.ieChangeListen = function () {
                        return this.each(function () {
                            var $this = $(this);
                            var htmlold = $this.html();
                            $this.bind('blur keyup paste copy cut mouseup', function () {
                                var htmlnew = $this.html();
                                if (htmlold !== htmlnew) {
                                    eidtorContetnChange($(this));
                                }
                            })
                        })
                    };
                    $(afterRenderEditorDom).ieChangeListen();
                }else{
                    $(afterRenderEditorDom)[0].oninput = $(afterRenderEditorDom)[0].onpropertychange = function(e){
                        var e = e || window.event;
                        eidtorContetnChange($(this));
                    };
                }

            }
        });
        },
        saveDeleUIdNum:[]
    };

    //富文本编辑器内容动态变化调用方法
    function eidtorContetnChange(eidtorDom){
        if($(eidtorDom).attr('id') === 'containerMoreMsg'){
            return false;
        }

        if ($('.pe-add-fill').hasClass('curType')) {
            var eidtorContent = eidtorDom.peEditor('getContent');
            var blanReg = /name="insertPeSimpleBlankValueByTomFill\d+"/ig;
            var matchArray = eidtorContent.match(blanReg);
            if (matchOldArray && matchArray && matchArray.length !== 0) {
                if (matchArray.length !== matchOldArray.length) {
                    var fillAnswerDom = $('.fill-item-true-answer-wrap').find('.pe-question-label');
                    var isHasMatch = 0;
                    for (var i = 0, iLen = fillAnswerDom.length; i < iLen; i++) {
                        for (var j = 0, jLen = matchArray.length; j < jLen; j++) {
                            if (matchArray[j].indexOf($(fillAnswerDom[i]).attr('data-index')) > 0) {
                                isHasMatch++;
                            }
                        }
                        if(isHasMatch){
                            isHasMatch = 0;
                        }else{
                            $(fillAnswerDom[i]).remove();
                            var newFillAnswer = $('.fill-item-true-answer-wrap').find('.pe-question-label');
                        }
                    }
                    for(var k =0,kLen = newFillAnswer.length;k<kLen;k++){
                        $(newFillAnswer[k]).find('.pe-input-tree-text').html('填空'+(k+1) + ':');
                        $(newFillAnswer[k]).find('.pe-stand-filter-form-input').attr('name','fillItemAnswer'+(k+1));
                    }
                    iLen--;
                }
            }else if(!matchArray){
                $('.fill-item-true-answer-wrap').find('.pe-question-label').remove();
            }
            matchOldArray = matchArray;
        }
    }

    function findFillInputAddName(){
        var fillContent = $('#containerContent').peEditor('getContent');
        var matchFill = fillContent.split('<input type="text" class="insert-blank-item" readonly="true">');
        var newFillStr = '';
        for(var j=0,jLen = matchFill.length -1;j < jLen; j++){
            var newInputName = '<input type="text" data-index="fill'+ (j +1)+'" class="insert-blank-item" readonly="true"  name="insertPeSimpleBlankValueByTomFill'+ (j+1) +'" />';
                newFillStr += matchFill[j] + newInputName;
        }
        if(newFillStr){
            $('#containerContent').peEditor('setContent',newFillStr);
        }
    }
    /*填空题添加空格函数*/
    function fillAddBlank(){
        var hasFillAnswerNum = $('.fill-item-true-answer-wrap').find('.pe-question-label').length + 1;
        if(hasFillAnswerNum > 20){
            PEMO.DIALOG.tips({
                content:'最多添加20个空格'
            });
            return false;
        }else{
            /*此处的inputDom包括其属性等都要在ueditor的config.js中添加到过滤的白名单中(whitList)，否则无效;*/
            var inputDom = '<input type="text" data-index="fill'+ hasFillAnswerNum+'" class="insert-blank-item" readonly="true"  name="insertPeSimpleBlankValueByTomFill'+ hasFillAnswerNum +'" />';
//            UE.getEditor('containerContent').execCommand('inserthtml',inputDom);
            $('#containerContent').peEditor('insertHtml',inputDom);
            $('.fill-item-true-answer-wrap').append(_.template($('#fillAnswerTemplate').html())({data:{index:hasFillAnswerNum}}));
            var eidtorContent =  $('#containerContent').peEditor('getContent');
            var blanReg = /name="insertPeSimpleBlankValueByTomFill\d+"/ig;
            matchOldArray = eidtorContent.match(blanReg);
        }
    }


    $(function () {
        //自定义简单编辑器结束
        //题型选择按钮点击事件
        $('.pe-add-question-type-btn').delegate('.pe-btn', 'click', function () {
            if ($(this).hasClass('curType')) {
                return false;
            }

            var chooseType = $(this).attr('data-type'),_thisBtn = $(this),
                    thisEditorDoms = $('.pe-editors-wrap:visible').find('.pe-simple-editor'),
                    nowItemContent = false;
            var preType = $('.pe-btn.curType').data('type');
            var isHasSelectedContent = false;
            for(var n=0,nLen = thisEditorDoms.length;n < nLen ;n++){
                if($(thisEditorDoms[n]).peEditor('getContent')){
                    isHasSelectedContent =true;
                    break;
                }
            }
            if(preType === 'SINGLE_SELECTION' || preType === 'MULTI_SELECTION' || preType === 'INDEFINITE_SELECTION'){
                nowItemContent = true;
            }

            if (nowItemContent &&isHasSelectedContent) {
                PEMO.DIALOG.confirmR({
                    content: '切换题型会导致已经设置好的试题选项被清空，确定切换?',
                    btn2: function () {
                        changeTypeFunc();
                        layer.closeAll();
                    },
                    btn1: function () {
                        layer.closeAll();
                    }
                })
            } else {
                changeTypeFunc();
            }
            function changeTypeFunc() {
                $('.pe-add-question-type-btn').find('.pe-btn').removeClass('curType');
                _thisBtn.addClass('curType');
                var beforeWrap = $('.pe-editors-wrap:visible').find('.pe-simple-editor');
                for(var k =0,kLen = beforeWrap.length;k<kLen;k++){
                    $(beforeWrap[k]).peEditor('setContent','');
                }

                var thisContainerContent = $('#containerContent').peEditor('getContent');
                var blanRegRe = /<input type="text" data-index="fill\d" class="insert-blank-item" readonly="true" name="insertPeSimpleBlankValueByTomFill\d">/ig;
                thisContainerContent = thisContainerContent.replace(blanRegRe,'');
                $('#containerContent').peEditor('setContent',thisContainerContent);
                $('#containerMoreMsg').peEditor('setContent','');
                $('.question-item-curType').val(chooseType);
                itemPage.typeTabChange(chooseType);
            }

        });

        //如果是编辑试题，则走这里，根据题目的类型，进行渲染已经有的题目和选项
    <#if item?? && item.id??>
        $.post(pageContext.rootPath + "/ems/item/manage/getIc", {'itemId': '${(item.id)!}'}, function (data) {
            if (!data) {
                return false;
            }
            var thisWrapDom = '';
            if ('${(item.type)!}' === 'SINGLE_SELECTION') {
                thisWrapDom = $('.pe-question-single-rich-wrap');
                itemPage.initUeScript('checkboxTemp', 'MULTI_SELECTION', $('.pe-question-multiple-rich-wrap'));
                itemPage.initUeScript('checkboxTemp', 'INDEFINITE_SELECTION', $('.pe-question-indefinite-rich-wrap'));

            } else if ('${(item.type)!}' === 'MULTI_SELECTION') {
                thisWrapDom = $('.pe-question-multiple-rich-wrap');
                itemPage.initUeScript('radioTemp', 'SINGLE_SELECTION', $('.pe-question-single-rich-wrap'));
                itemPage.initUeScript('checkboxTemp', 'INDEFINITE_SELECTION', $('.pe-question-indefinite-rich-wrap'));

            } else if ('${(item.type)!}' === 'INDEFINITE_SELECTION') {
                thisWrapDom = $('.pe-question-indefinite-rich-wrap');
                itemPage.initUeScript('radioTemp', 'SINGLE_SELECTION', $('.pe-question-single-rich-wrap'));
                itemPage.initUeScript('checkboxTemp', 'MULTI_SELECTION', $('.pe-question-multiple-rich-wrap'));
            } else if ('${(item.type)!}' === 'JUDGMENT') {
                thisWrapDom = $('.pe-question-judgment-rich-wrap');
                itemPage.initUeScript('radioTemp', 'SINGLE_SELECTION', $('.pe-question-single-rich-wrap'));
                itemPage.initUeScript('checkboxTemp', 'MULTI_SELECTION', $('.pe-question-multiple-rich-wrap'));
                itemPage.initUeScript('checkboxTemp', 'INDEFINITE_SELECTION', $('.pe-question-indefinite-rich-wrap'));
            } else if ('${(item.type)!}' === 'FILL') {
                thisWrapDom = $('.pe-question-fill-rich-wrap');
                itemPage.initUeScript('radioTemp', 'SINGLE_SELECTION', $('.pe-question-single-rich-wrap'));
                itemPage.initUeScript('checkboxTemp', 'MULTI_SELECTION', $('.pe-question-multiple-rich-wrap'));
                itemPage.initUeScript('checkboxTemp', 'INDEFINITE_SELECTION', $('.pe-question-indefinite-rich-wrap'));
            } else {
                thisWrapDom = $('.pe-question-question-rich-wrap');
                itemPage.initUeScript('radioTemp', 'SINGLE_SELECTION', $('.pe-question-single-rich-wrap'));
                itemPage.initUeScript('checkboxTemp', 'MULTI_SELECTION', $('.pe-question-multiple-rich-wrap'));
                itemPage.initUeScript('checkboxTemp', 'INDEFINITE_SELECTION', $('.pe-question-indefinite-rich-wrap'));
            }
            if (thisWrapDom) {
                thisWrapDom.show();
            }

            itemPage.renderUedit('containerMoreMsg','试题解析', data.ep);
            itemPage.renderUedit('containerContent','题干内容', data.ct);
            $('.insert-fill-blank').click(function(){
                fillAddBlank();
            });


            if ('${(item.type)!}' === 'JUDGMENT') {
                thisWrapDom.append(_.template($('#judgeTemp').html())({}));
                var judgeAnswerDom = $('.judgeAnswer');
                judgeAnswerDom.each(function (index, ele) {
                    $(this).find('input[name="judgeAnswer"]').removeProp('checked');
                    var hasClass = $(this).find('.iconfont').hasClass('icon-checked-radio');
                    if (hasClass) {
                        $(this).find('.iconfont').addClass('icon-unchecked-radio');
                        $(this).find('.iconfont').removeClass('icon-checked-radio');
                    }
                });

                if (data.t) {
                    $(judgeAnswerDom[0]).find('input[name="judgeAnswer"]').prop('checked', 'checked');
                    $(judgeAnswerDom[0]).find('.iconfont').addClass('icon-checked-radio');
                } else {
                    $(judgeAnswerDom[1]).find('input[name="judgeAnswer"]').prop('checked', 'checked');
                    $(judgeAnswerDom[1]).find('.iconfont').addClass('icon-checked-radio');
                }
                $('.pe-add-rich-area-btn').hide();
            <#--itemPage.typeTabChange('${(item.type)!}');-->
                return false;
            } else if ('${(item.type)!}' === 'FILL') {

                thisWrapDom.append(_.template($('#fillTemp').html())({}));
                $.each(data.a.split('|'),function(i,v){
                    $('.fill-item-true-answer-wrap').append(_.template($('#fillAnswerTemplate').html())({data:{index:(i+1),a:v}}));
                });
                /*找到填空题题干里面的 input并添加指定的name名称*/
                findFillInputAddName();
                var editStateEidtorContent = $('#containerContent').peEditor('getContent'),
                     blanReg = /name="insertPeSimpleBlankValueByTomFill\d+"/ig,
                     editStateMatchArray = editStateEidtorContent.match(blanReg);
                matchOldArray = editStateMatchArray;
                $('#containerContent .insert-fill-blank').show();
                $('.pe-add-rich-area-btn').hide();
                return false;
            } else if ('${(item.type)!}' === 'QUESTIONS') {
                thisWrapDom.append(_.template($('#questionTemp').html())({}));
                thisWrapDom.find('.pe-add-question-text-answer').val(data.a);
                $('.pe-add-rich-area-btn').hide();
                return false;
            }

            if (data.ios && data.ios.length > 0) {
                var canDele = false;
                if (data.ios.length > 2) {
                    canDele = true;
                }

                if(data.ios.length >=10){
                    $('.pe-add-rich-area-btn').hide();
                }

                $.each(data.ios, function (index, ele) {
//                    var beforeLast = $('.pe-question-item-rich-wrap').find('.pe-rich-text-wrap').last();
                    var first = index === 0;
                    var last = index === data.ios.length - 1;
                    var containerDom = 'container' + index + '${(item.type)!}';
                    var template = 'radioTemp';
                    if ('${(item.type)!}' != 'SINGLE_SELECTION') {
                        template = 'checkboxTemp';
                    }

                    thisWrapDom.append(_.template($('#' + template).html())({
                        containerDom: containerDom,
                        first: first,
                        last: last,
                        canDele: canDele,
                        answer: ele.t
                    }));
                    itemPage.renderUedit(containerDom,'选项'+ subscriptMap[index], ele.ct);
                });
            }
            PEBASE.peFormEvent('checkbox');
            PEBASE.peFormEvent('radio');
        }, 'json');
    <#else>
        //新增试题的时候初始化
        $('.pe-question-single-rich-wrap').show();
        itemPage.initUeScript('radioTemp', 'SINGLE_SELECTION', $('.pe-question-single-rich-wrap'));
        itemPage.initUeScript('checkboxTemp', 'MULTI_SELECTION', $('.pe-question-multiple-rich-wrap'));
        itemPage.initUeScript('checkboxTemp', 'INDEFINITE_SELECTION', $('.pe-question-indefinite-rich-wrap'));
//        itemPage.typeTabChange('SINGLE_SELECTION');
        itemPage.renderUedit('containerMoreMsg','试题解析');
        itemPage.renderUedit('containerContent','题干内容');
        $('.insert-fill-blank').click(function(){
            fillAddBlank();
        });
    </#if>
        PEBASE.peSelect($('.pe-question-select'), null, $('input[name="peQuestionType"]'));//临时用于渲染，后期删除
        PEBASE.peSelect($('.pe-language-select'), null, $('input[name="choosenLanguage"]'));
        PEBASE.peSelect($('.pe-attribute-select'), null, $('input[name="choosenAttribute"]'));
        PEBASE.peFormEvent('checkbox');
        PEBASE.peFormEvent('radio');

        /*保存为草稿*/
        $('.pe-item-save-draft').on('click', function () {
            var ic = processItem();
            if (!ic) {
                return false;
            }
            checkScoreIsZero();
            $.post(pageContext.rootPath + "/ems/item/manage/saveItem?" + $('#editItemForm').serialize(), {'content': JSON.stringify(ic)}, function (data) {
                var msg = '试题新增成功！';
                var id = $('input[name="id"]').val();
                if (id != '') {
                    msg = '试题编辑成功！';
                }
                if (data.success) {
                    PEMO.DIALOG.tips({
                        content: msg,
                        end: function () {
                            location.href = '#url=${ctx!}/ems/item/manage/initPage&nav=question';
                        }
                    });

                    return false;
                }

                PEMO.DIALOG.tips({
                    content: data.message
                });
            }, 'json');
        });

        //检查试题分值的函数
        function checkScoreIsZero() {
            var $score = $('.pe-question-score-num').val();
            if (parseFloat($score) === 0) {
                $score = 1;
                PEMO.DIALOG.alert({
                    content: '试题分值不能为0分',
                    btn: ['我知道了'],
                    yes: function () {
                        layer.closeAll();
                    }
                });
            }

        }

        /*保存并启用*/
        $('.pe-item-save-enable-btn').on('click', function () {
            var ic = processItem();
            if (!ic) {
                return false;
            }
            checkScoreIsZero();
            $.post(pageContext.rootPath + "/ems/item/manage/saveEnableItem?" + $('#editItemForm').serialize(), {'content': JSON.stringify(ic)}, function (data) {
                var msg = '试题新增成功！';
                var id = $('input[name="id"]').val();
                if (id != '') {
                    msg = '试题编辑成功！';
                }


              if (data.success) {
                    history.back(-1);
                    PEMO.DIALOG.tips({
                        content: msg
                    });

                    return false;
                }

                PEMO.DIALOG.tips({
                    content: data.message
                });
            }, 'json');
        });

        //取消按钮的点击事件;
        $('.pe-add-ques-cancel-btn').on('click', function () {
            history.back(-1);
        });

        //提交保存前内容校验;
        function processItem() {
            var idValidTrue = $("#editItemForm").valid();
            if (!idValidTrue) {
                return false;
            }
            var bankId = $('input[name="itemBank.id"]').val();
            if (!bankId) {
                PEMO.DIALOG.tips({
                    content: "请选择题库！"
                });
                return false;
            }

            var ic = {};
            //题干检查;
              var hasContent = $('#containerContent').peEditor('getContent');
            if (!hasContent || !$.trim(hasContent)) {
                PEMO.DIALOG.alert({
                    content: "题干内容不能为空！",
                    btn: ['我知道了'],
                    yes: function () {
                        layer.closeAll();
                    }
                });
                return false;
            }else{
                if($('.pe-add-fill').hasClass('curType')){
                    var eidtorContent = $('#containerContent').peEditor('getContent'),
//                        blanReg = /<input type="text" data-index="fill\d/ig,
                        blanReg = /name="insertPeSimpleBlankValueByTomFill\d+"/ig,
                        matchArray;
                        matchArray = eidtorContent.match(blanReg);
                    if(!matchArray){
                        PEMO.DIALOG.alert({
                            content: "这是填空题，请至少插入一个空格！",
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });
                        return false;
                    }
                }
            }
            ic.ct = $('#containerContent').peEditor('getContent');
            var type = $('input[name="type"]').val();
            if (type === 'SINGLE_SELECTION' || type === 'MULTI_SELECTION' || type === 'INDEFINITE_SELECTION') {
                var errMsg = getIos(ic, type);
                if (errMsg) {
                    PEMO.DIALOG.alert({
                        content: errMsg,
                        btn: ['我知道了'],
                        yes: function () {
                            layer.closeAll();
                        }
                    });
                    return false;
                }

            } else if (type === 'JUDGMENT') {
                ic.t = $('input[name="judgeAnswer"]:checked').val();
                if (!ic.t || !$.trim(ic.t)) {
                    PEMO.DIALOG.alert({
                        content: '选项不可为空！',
                        btn: ['我知道了'],
                        yes: function () {
                            layer.closeAll();
                        }
                    });
                    return false;
                }

            } else if (type === 'FILL') {
                 var fillAnswerInput = $('.fill-item-true-answer-wrap').find('input');
                var isVal = true;
                 for(var i=0,iLen=fillAnswerInput.length;i<iLen;i++){
                     if(!$.trim($(fillAnswerInput[i]).val())){
                         $(fillAnswerInput[i]).addClass('error');
                         $(fillAnswerInput[i]).next('em').text('请填写答案');
                         $(fillAnswerInput[i]).next('em').eq(0).show();
                         isVal = false;
                     }
                 }

                if(!isVal){
                    return false;
                }

                var answer = [],val = true;
                $('input[name="fillItemAnswer"]').each(function(i,v){
                    if(!$(v).val()){
                        val = false;
                    }

                    answer.push($(v).val());
                });

                if (!val) {
                    PEMO.DIALOG.alert({
                        content: '参考答案不可为空！',
                        btn: ['我知道了'],
                        yes: function () {
                            layer.closeAll();
                        }
                    });
                    return false;
                }

                ic.a = answer.join('|');
            } else if (type === 'QUESTIONS') {
                ic.a = $('.pe-add-question-text-answer').val();
                if (!ic.a || !$.trim(ic.a)) {
                    PEMO.DIALOG.alert({
                        content: '参考答案不可为空！',
                        btn: ['我知道了'],
                        yes: function () {
                            layer.closeAll();
                        }
                    });
                    return false;
                }

            } else {
                return false;
            }
            var knowledgeId = '';
            $('.pe-km-input-tree .input-tree-choosen-label span').each(function (index, ele) {
                if (knowledgeId) {
                    knowledgeId = knowledgeId + ',';
                }

                knowledgeId = knowledgeId + $(ele).data('id');
            });

            if (knowledgeId) {
                $('input[name="knowledge"]').val(knowledgeId);
            }

            ic.ep = $('#containerMoreMsg').peEditor('getContent');
//            ic.ep = '';
            ic.m = $('input[name="mark"]').val();
            return ic;
        }

        //循环获取富文本编辑器里面的内容
        function getIos(ic, type) {
            var ios = [];
            var currentNum = 0;
            //      var nowChooseType= $('.question-item-curType').val();
            var nowChooseType = type;
            var message = '';
            $('div[data-type="' + nowChooseType + '"]').find('.option').each(function (index, optionDom) {
                var idDom = $(optionDom).attr('id');
                var hasContent = $('#'+ idDom).peEditor('hasContent');
                if (!hasContent || !$.trim(hasContent)) {
                    message = '选项内容不可为空！';
                    return;
                }
                var io = {};
                io.ct = $('#'+ idDom).peEditor('getContent');
                var answer;
                if (type === 'SINGLE_SELECTION') {
                    answer = $('#' + idDom).parents('.pe-rich-text-wrap').find('.icon-checked-radio').hasClass('peChecked');
                } else {
                    answer = $('#' + idDom).parents('.pe-rich-text-wrap').find('.icon-checked-checkbox').hasClass('peChecked');
                }
                if (answer) {
                    io.t = true;
                    currentNum = currentNum + 1;
                }

                ios.push(io);
            });

            if(message){
                return message;
            }

            if ((type==='SINGLE_SELECTION' || type==='MULTI_SELECTION'
                    ||type ==='INDEFINITE_SELECTION') && ios.length < 2) {
                return "至少2个选项！";
            }

            if (type === 'SINGLE_SELECTION' && currentNum != 1) {
                return "请选择一个正确答案！";
            }

            if (type === 'MULTI_SELECTION' && currentNum < 2) {
                return "请至少选择两个正确答案！";
            }

            if (type === 'INDEFINITE_SELECTION' && currentNum < 1) {
                return "请至少选择一个正确答案！";
            }

            ic.ios = ios;
        }

        var thisRichAllWrap = $('.pe-question-item-rich-wrap');
        //题型选项向下移动函数;
        thisRichAllWrap.delegate('.uedit-move-down', 'click', function () {
            var type = $('.pe-add-question-type-btn').find('.curType.pe-btn').data('type');
            if ($(this).hasClass('disabled')) {
                return false;
            } else {
                var $thisRichWrap = $(this).parents('.pe-rich-text-wrap'),
                        $thisOpt = $thisRichWrap.find('.pe-uedit-opt'),
                        thisUeId = $thisRichWrap.find('.pe-simple-editor').attr('id'),
                        thisOptHtml = $thisOpt.html(),
                        $nextRichWrap = $(this).parents('.pe-rich-text-wrap').next('.pe-rich-text-wrap').eq(0),
                        $nextOpt = $nextRichWrap.find('.pe-uedit-opt'),
                        nextUeId = $nextRichWrap.find('.pe-simple-editor').attr('id'),
                        nextOptHtml = $nextOpt.html();
                var thisUEContent = $('#' + thisUeId).peEditor('getContent');
                var nextUEContent = $('#' + nextUeId).peEditor('getContent');
                $thisOpt.html(nextOptHtml);
                $nextOpt.html(thisOptHtml);
                if ($thisRichWrap.index() === 0) {
                    $thisRichWrap.find('.uedit-move-up').addClass('disabled');
                }
                $thisRichWrap.find('.uedit-move-down').removeClass('disabled');
                if ($nextRichWrap.index() === (thisRichAllWrap.find('div[data-type="'+ type +'"]').find('.pe-rich-text-wrap').length -1)) {
                    $nextRichWrap.find('.uedit-move-down').addClass('disabled');
                }
                $nextRichWrap.find('.uedit-move-up').removeClass('disabled');
                $('#' + thisUeId).peEditor('setContent',nextUEContent);
                $('#' + nextUeId).peEditor('setContent',thisUEContent);
                PEBASE.peFormEvent('radio');
                PEBASE.peFormEvent('checkbox');
            }
        });
        //题型选项删除函数;
        thisRichAllWrap.delegate('.uedit-dele', 'click', function () {
            if ($(this).hasClass('disabled')) {
                return false;
            }
            var type = $('.pe-add-question-type-btn').find('.curType.pe-btn').data('type');
            var nowChooseType = $('.question-item-curType').val();
            var optionDoms =  $('div[data-type="'+ nowChooseType +'"]').find('.option-text-wrap');
            if(optionDoms.length === 3){
                $('div[data-type="'+ nowChooseType +'"]').find('.uedit-dele').addClass('disabled');
            }
            var thisUeId = $(this).parents('.pe-rich-text-wrap').find('.option.pe-simple-editor').attr('id');
            $(this).parents('.pe-rich-text-wrap').remove();

            $('div[data-type="' + nowChooseType + '"]').find('.option-text-wrap').each(function (index) {
                $(this).find('.self-toolbar-left').html('选项' + subscriptMap[index]);
            });
            $('div[data-type="' + nowChooseType + '"]').find('.option-text-wrap').last().find('.uedit-move-down').addClass('disabled');
            $('.pe-add-rich-area-btn').show();
        });
        //题型向上移动函数;
        /*此处的上移，富文本编辑器并没有真的上移动，只是内容进行了交互，旁边的操作区域进行了交互,其实操作区也可不进行交互，算了，没时间改了*/
        thisRichAllWrap.delegate('.uedit-move-up', 'click', function () {
            var type = $('.pe-add-question-type-btn').find('.curType.pe-btn').data('type');
            if ($(this).hasClass('disabled')) {
                return false;
            } else {
                var $thisRichWrap = $(this).parents('.pe-rich-text-wrap'),
                        $thisOpt = $thisRichWrap.find('.pe-uedit-opt'),
                        thisUeId = $thisRichWrap.find('.pe-simple-editor').attr('id'),
                        thisOptHtml = $thisOpt.html(),
                        $prevRichWrap = $(this).parents('.pe-rich-text-wrap').prev('.pe-rich-text-wrap').eq(0),
                        $nextOpt = $prevRichWrap.find('.pe-uedit-opt'),
                        nextUeId = $prevRichWrap.find('.pe-simple-editor').attr('id'),
                        nextOptHtml = $nextOpt.html();
                var thisUEContent = $('#' + thisUeId).peEditor('getContent');
                var nextUEContent = $('#' + nextUeId).peEditor('getContent');
                $thisOpt.html(nextOptHtml);
                $nextOpt.html(thisOptHtml);
                if ($thisRichWrap.index() === (thisRichAllWrap.find('div[data-type="' + type + '"]').find('.pe-rich-text-wrap').length - 1)) {
                    $thisRichWrap.find('.uedit-move-down').addClass('disabled');
                }
                $thisRichWrap.find('.uedit-move-up').removeClass('disabled');

                if ($prevRichWrap.index() === 0) {
                    $prevRichWrap.find('.uedit-move-up').addClass('disabled');
                }
                $prevRichWrap.find('.uedit-move-down').removeClass('disabled');
                $('#' + thisUeId).peEditor('setContent',nextUEContent);
                $('#' + nextUeId).peEditor('setContent',thisUEContent);
                PEBASE.peFormEvent('radio');
                PEBASE.peFormEvent('checkbox');
            }
        });


        //增加选项按钮点击事件
        $('.pe-add-rich-area-btn').click(function () {
            var type = $('.pe-add-question-type-btn').find('.curType.pe-btn').data('type');
            //克隆还是模板，待定,一下注释误删！
            var thisWrapRichDoms = thisRichAllWrap.find('div[data-type="' + type + '"]').find('.pe-rich-text-wrap');
            var beforeLast = thisWrapRichDoms.last();
            if(itemPage.saveDeleUIdNum.length !== 0){
                var hasRichNum = itemPage.saveDeleUIdNum[0];
                    itemPage.saveDeleUIdNum.shift();
            }else{
                var hasRichNum = thisWrapRichDoms.length + 1;
            }

//            var hasRichNum = $('.pe-question-item-rich-wrap  .pe-rich-text-wrap').length + 1;
            var containerDom = 'container' + hasRichNum + type;
            var canDele = false;
            if (thisWrapRichDoms.length > 1) {
                canDele = true;
                thisWrapRichDoms.find('.uedit-dele').removeClass('disabled');
            }
            if (type === 'SINGLE_SELECTION') {
                beforeLast.after(_.template($('#radioTemp').html())({
                    containerDom: containerDom,
                    first: false,
                    last: true,
//                    subscript: '选项' + subscriptMap[thisWrapRichDoms.length],
                    canDele: canDele,
                    answer:false
                }));
                itemPage.renderUedit(containerDom,'选项' + subscriptMap[thisWrapRichDoms.length]);
                PEBASE.peFormEvent('radio');
            } else {
                beforeLast.after(_.template($('#checkboxTemp').html())({
                    containerDom: containerDom,
                    first: false,
                    last: true,
//                    subscript: '选项' + subscriptMap[thisWrapRichDoms.length - 1],
                    canDele: canDele,
                    answer:false
                }));
                itemPage.renderUedit(containerDom,'选项' + subscriptMap[thisWrapRichDoms.length]);
                PEBASE.peFormEvent('checkbox');
            }

            if (thisWrapRichDoms.length >= 9) {
                $('.pe-add-rich-area-btn').hide();
            }

            beforeLast.find('.uedit-move-down').removeClass('disabled');
        });

        //点击更多信息按钮点击事件
        $('.pe-add-question-more-msg').click(function () {
            if ($(this).find('.iconfont').hasClass('icon-pack')) {
                $('.pe-add-question-more-choosen-wrap').slideDown();
                $(this).find('.iconfont').removeClass('icon-pack').addClass('icon-show');
            } else if ($(this).find('.iconfont').hasClass('icon-show')) {
                $('.pe-add-question-more-choosen-wrap').slideUp();
                $(this).find('.iconfont').removeClass('icon-show').addClass('icon-pack');
            }

        });
        //星星难度选择交互
        $('.pe-star-container .pe-star').click(function () {
            var thisStarDoms = $('.pe-star-container .pe-star');
            var thisIndex = $(this).index();
            var thisNum = $('.pe-star-wrap .pe-difficulty-num');
            var thisInput = $('input[name="level"]');
            if (thisIndex === 0) {
                thisStarDoms.removeClass('pe-checked-star');
                $(this).addClass('pe-checked-star');
                thisNum.html('简单');
                thisInput.val('SIMPLE');
            } else if (thisIndex === 1) {
                thisStarDoms.removeClass('pe-checked-star');
                thisStarDoms.eq(0).addClass('pe-checked-star');
                thisStarDoms.eq(1).addClass('pe-checked-star');
                thisNum.html('较简单');
                thisInput.val('RELATIVELY_SIMPLE');
            } else if (thisIndex === 2) {
                thisStarDoms.addClass('pe-checked-star');
                thisStarDoms.eq(3).removeClass('pe-checked-star');
                thisStarDoms.eq(4).removeClass('pe-checked-star');
                thisNum.html('中等');
                thisInput.val('MEDIUM');
            } else if (thisIndex === 3) {
                thisStarDoms.addClass('pe-checked-star');
                thisStarDoms.eq(4).removeClass('pe-checked-star');
                thisNum.html('较难');
                thisInput.val('MORE_DIFFICULT');
            } else if (thisIndex === 4) {
                thisStarDoms.addClass('pe-checked-star');
                thisNum.html('困难');
                thisInput.val('DIFFICULT');
            }
        });

        //input里面的树类型渲染的选项清除函数
        $('.km-input-tree-dele').click(function (e) {
            var e = e || window.event;
            e.stopPropagation();
            e.preventDefault();
            $(this).siblings('.input-tree-choosen-label').html('');
            var thisCheckedBox = $(this).parent('div').find('.pe-input-tree-wrap-drop').find('.pe-input-tree-children-container').find('li .icon-checked-checkbox');
            thisCheckedBox.removeClass('icon-checked-checkbox peChecked').addClass('icon-unchecked-checkbox').siblings('input').removeProp('checked');
            $(this).hide().siblings('.icon-class-tree').show();
            $('input[name="knowledge"]').val('');

        });

        //检查新增知识点的选择是否达到最大值;
        function checkIsSaveFull(type, thisRealCheck) {
            var thisId = thisRealCheck.attr('data-id'),
                thisLimitNum = '';
            if (type === 'checkbox') {
                var thisLabel = $('.pe-km-input-tree .input-tree-choosen-label');
                var thisLabelspan = thisLabel.find('span');
                thisLimitNum = 3;
                for (var i = 0, len = thisLabelspan.length; i < len; i++) {
                    if ($(thisLabelspan[i]).attr('data-id') === thisId) {
                        return true;
                    }
                }
            } else {
                var thisLabel = $('.pe-question-input-tree .input-tree-choosen-label');
                thisLimitNum = 1;
            }

            var inputTreeChoosen = thisLabel.find('span').length;
            if ((type === 'checkbox') && inputTreeChoosen >= thisLimitNum) {
                PEMO.DIALOG.tips({
                    content: '亲，最多选择' + thisLimitNum + '个哦'
                });
                return false;
            } else {
                return true;
            }

        }

        //检查input里面树状渲染已选择和取消选择的点击事件
        function checkInputTreeChoose(inputDom) {
            var id = inputDom.data('id');
            if (!id) {
                return false;
            }

            var idDom;
            var name = inputDom.attr('name');
            var itemSpan;
            if (name === 'bankName') {
                itemSpan = 'itemBank-span';
            }

            if (inputDom.attr('type') === 'checkbox') {
                var thisLabel = $('.pe-km-input-tree .input-tree-choosen-label');
                thisLabel.find('span').each(function (index, ele) {
                    if ($(ele).data('id') === id) {
                        idDom = ele;
                        return false;
                    }
                });
                if (inputDom.prop('checked') && !idDom) {
                    var checkedText = $('.pe-km-input-tree .search-tree-text');
                    var beforeScrollLeft = checkedText.outerWidth() * checkedText.length;
                    thisLabel.append('<span class="search-tree-text" title="' + inputDom.attr('title') + '" data-id="' + id + '">' + inputDom.attr('title') + '</span>');
                    thisLabel.siblings('.icon-class-tree').hide().siblings('.icon-inputDele').show();
                    $('.pe-km-input-tree .input-tree-choosen-label').scrollLeft(beforeScrollLeft + $('.pe-km-input-tree .search-tree-text').outerWidth());
                    thisLabel.find('.pe-tree-show-name').insertAfter(thisLabel.find('.search-tree-text').last()).focus();
                } else if (!inputDom.prop('checked') && idDom) {
                    $(idDom).remove();
                    if (!thisLabel.find('span').get(0)) {
                        thisLabel.siblings('.icon-class-tree').show().siblings('.icon-inputDele').hide();
                    }
                }
            } else {
                var thisLabel = $('.pe-question-input-tree .input-tree-choosen-label');
                $('input[name="itemBank.id"]').val(id);
                if (!thisLabel.find('span').get(0)) {
                    thisLabel.append('<span class="search-tree-text ' + itemSpan + '" title="' + inputDom.attr('title') + '" data-id="' + id + '">' + inputDom.attr('title') + '</span>');
                } else {
                    thisLabel.find('span').attr('data-id', id).attr('title', inputDom.attr('title')).html(inputDom.attr('title'));
                }

            }

        }

        //初始化题库input框点击生成树状渲染dom函数
        var questionsInputTree = {
            dataUrl: pageContext.rootPath + '/ems/itemBank/manage/listTree',
            clickNode: function (treeNode) {
                $.post(pageContext.rootPath + '/ems/itemBank/manage/listItemBank', {'categoryId': treeNode.id}, function (data) {
                    $('#bankTreeChildren').html('');
                    var $itemBankSpan = $('.itemBank-span');
                    var itemBankId = '';
                    if ($itemBankSpan) {
                        itemBankId = $itemBankSpan.attr('data-id');
                    }

                    $('#bankTreeChildren').append(_.template($('#bankTemplate').html())({
                        data: data,
                        itemBankId: itemBankId
                    }));
                    var obj = {'func1': checkIsSaveFull, 'func2': checkInputTreeChoose};
                    //PEBASE.peFormEvent('checkbox');
                    PEBASE.peFormEvent('radio', obj);
                }, 'json');
            },
            width: 305
        };
        //题库类型输入框类型树状弹框 dom为需要下拉框的那一行div元素
        PEBASE.inputTree({dom: '.pe-question-input-tree', treeId: 'bankInputTree', treeParam: questionsInputTree});


        ////初始化知识点input框点击生成树状渲染dom函数
        var kmInputTree = {
            dataUrl: pageContext.rootPath + '/ems/knowledge/manage/listCategoryKnowledge',
            clickNode: function (treeNode) {
                kmSearchAndShow(treeNode);
            },
            width: 305
        };
        //题库类型输入框类型树状弹框 dom为需要下拉框的那一行div元素
        PEBASE.inputTree({dom: '.pe-km-input-tree', treeId: 'peSelelctKmInputTree', treeParam: kmInputTree});
        inputTreeKeyup($('.pe-km-input-tree'), 'peSelelctKmInputTree');

        function setKnowledge() {
            var knowledgeId = '';
            $('.pe-stand-filter-form-input .input-tree-choosen-label span').each(function (index, ele) {
                if (knowledgeId) {
                    knowledgeId = knowledgeId + ',';
                }

                knowledgeId = knowledgeId + $(ele).data('id');
            });

            if (knowledgeId) {
                $('input[name="knowledge"]').val(knowledgeId);
            }
        }

        /* nput树类型的输入框在div里面左右移动删除功能;*/
        function inputTreeKeyup(wrapDom, treeId) {
            wrapDom.find('.pe-tree-show-name').on('keyup', function (e) {
                var treeObj;
                if (!treeObj) {
                    treeObj = $.fn.zTree.getZTreeObj(treeId);
                }
                var keyCode = (e || event).keyCode,
                        thisInput = $(this),
                        thisVal = $.trim(thisInput.val()),
                        thisSpan,
                        labelSpans = wrapDom.find('.search-tree-text'),
                        positionId,
                        checkedInput;
                if (keyCode === 8) {//Backspace
                    thisSpan = $(this).prev(".search-tree-text");
                    if (!thisVal && thisSpan && labelSpans) {
                        positionId = thisSpan.data('id');
                        checkedInput = $("input[data-id=" + positionId + "]");
                        checkedInput.removeProp('checked');
                        checkedInput.prev().removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisSpan.remove();
                    }
                    if (wrapDom.find('.icon-inputDele').get(0) && !wrapDom.find('.search-tree-text').get(0)) {
                        wrapDom.find('.icon-inputDele').hide().siblings('.icon-class-tree').show();
                    }
//                    return false;
                }
                if (keyCode === 37) {//left
                    thisSpan = $(this).prev(".search-tree-text");
                    if (!thisVal && thisSpan && labelSpans && labelSpans.index(thisSpan) >= 0) {
                        thisSpan.before($(this));
                        setTimeout(function () {
                            thisInput.focus();
                        }, 500);

                    }
//                    return false;
                }
                if (keyCode === 39) {//right
                    thisSpan = $(this).next(".search-tree-text");
                    if (!thisVal && thisSpan && labelSpans && (labelSpans.index(thisSpan) <= labelSpans.length - 1)) {
                        thisSpan.after($(this));
                        setTimeout(function () {
                            thisInput.focus();
                        }, 500);
                    }
                    return false;
                }
                if (keyCode === 46) {//delete
                    thisSpan = $(this).next(".search-tree-text");
                    if (!thisVal && thisSpan.get(0)) {
                        positionId = thisSpan.data('id');
                        checkedInput = $("input[data-id=" + positionId + "]");
                        checkedInput.removeProp('checked');
                        checkedInput.prev().removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisSpan.remove();
                    }
                    if (wrapDom.find('.icon-inputDele').get(0) && !wrapDom.find('.search-tree-text').get(0)) {
                        wrapDom.find('.icon-inputDele').hide().siblings('.icon-class-tree').show();
                    }
                }
                /*TODO这里进行搜索知识点*/
                if(treeObj){
                    var rootNode = treeObj.getNodes()[0];
                }
                kmSearchAndShow(rootNode,thisVal);
                $(this).width($(this).val().length > 0 ? $(this).val().length * 16 : 2);
            });
        }

        //知识点的点击或输入框搜索执行函数
        function kmSearchAndShow(treeNode, val) {
            var showFilter = false,
                    searchData = [];
            if (val) {
                showFilter = true;
            }

            (function searchNode(treeNode) {
                var nodeData = treeNode.nodeData,
                        newNodeData = [];
                if(nodeData){
                    if(showFilter){
                        for(var j=0,lenJ=nodeData.length;j<lenJ;j++){
                            try{
                                if(nodeData[j].name.indexOf(val) !== -1){
                                    newNodeData.push(nodeData[j])
                                }
                            }catch(e){
                            }

                        }
                        nodeData = newNodeData;
                    }
                    searchData = searchData.concat(nodeData);
                }
                if (!$.isEmptyObject(treeNode) && treeNode.children) {
                    for (var i = 0, len = treeNode.children.length; i < len; i++) {
                        searchNode(treeNode.children[i])
                    }
                }
            })(treeNode);
            showSearchList(searchData, showFilter, val);
        }

        //知识点搜索结果进行展示的函数
        function showSearchList(data,showFilter,val) {
            $('#peSelectKmChildren .mCSB_container').html('');
            var knowledgeId = [];
            $('.pe-km-input-tree .input-tree-choosen-label').find('span').each(function (index, ele) {
                knowledgeId.push($(ele).data('id'));
            });

            $('#peSelectKmChildren .mCSB_container').append(_.template($('#knowledgeTemplate').html())({
                data: data,
                knowledgeId: knowledgeId
            }));

            var obj = {'func1': checkIsSaveFull, 'func2': checkInputTreeChoose};
            PEBASE.peFormEvent('checkbox', obj);
            PEBASE.peFormEvent('radio');
        }
        //输入框搜索函数;
        function searchInputTree(val, treeId) {
            var zTree = $.fn.zTree.getZTreeObj(treeId);
            var resultArr = [];
            var keyType = "name";
            if (val) {
                $("#" + treeId).addClass('zTree-filter-state');
            } else {
                $('#' + treeId).removeClass('zTree-filter-state');
            }
            resultArr = zTree.getNodesByParamFuzzy(keyType, val);

            updateNodes(true, zTree, resultArr, val);
        }

        //更新搜索节点函数
        function updateNodes(highlight, zTree, resultArr, val) {
            for (var i = 0, l = resultArr.length; i < l; i++) {
                resultArr[i].highlight = highlight;
                zTree.updateNode(resultArr[i], null, val);
            }
        }

        $('.pe-km-save-input-tree').keyup(function () {
            if ($.trim(this.value)) {
                $('.pe-tree-search-btn').removeClass('icon-class-tree').addClass('icon-clear-contents');
            } else {
                $('.pe-tree-search-btn').removeClass('icon-clear-contents').addClass('icon-class-tree');
            }
            var thisSearchVal = $.trim($(this).val());
            searchInputTree(thisSearchVal, 'peSelelctKmInputTree')
        })


        //试题分值输入检测函数
        var score = 1;
        $('.pe-question-score-num').keyup(function (e) {
            var e = e || window.event;
            var eKeyCode = e.keyCode;
            var thisVal = this.value;
            if ((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || eKeyCode === 110 || eKeyCode === 190 || eKeyCode === 8 || eKeyCode === 108 || eKeyCode === 46) {
                if (!(thisVal.indexOf('.') === 0)) {
                    if (parseFloat(thisVal) > 99.9) {
                        this.value = 99.9;
                    } else {
                        if ((thisVal.indexOf('.') !== -1) && (thisVal.indexOf('.') !== thisVal.lastIndexOf('.'))) {
                            this.value = thisVal.substring(0, thisVal.lastIndexOf('.'));
                        }
                        if (thisVal.length >= 4 && (thisVal.indexOf('.') !== -1)) {
                            this.value = thisVal.substring(0, thisVal.indexOf('.') + 2);
                        }
                    }
                } else {
                    this.value = 1;
                }

            } else {
                if (!Number(thisVal)) {
                    this.value = score;
                } else {
                    this.value = thisVal;
                    score = thisVal;
                }
                return false;
            }
        }).keydown(function (e) {
            var e = e || window.event;
            var eKeyCode = e.keyCode;
            var thisVal = this.value;
            if (!((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || eKeyCode === 110 || eKeyCode === 190 || eKeyCode === 8 || eKeyCode === 108 || eKeyCode === 46)) {
                if (!Number(thisVal)) {
                    this.value = score;
                } else {
                    this.value = thisVal;
                    score = thisVal;
                }

                return false;
            }
         }).blur(function (e) {
                var e = e || window.event;
                var eKeyCode = e.keyCode;
                var thisVal = this.value;
                if ((thisVal.indexOf('0') === 0 && thisVal.indexOf('.') !== 1)) {
                    this.value = thisVal.substring(1);
                }
                if ((thisVal.indexOf('.') === 1 && thisVal.length === 2)) {
                    this.value = 1;
                }
                if (!Number(thisVal) || thisVal === 0) {
                    this.value = 1;
                }
            });

//        试题编号输入检测函数
        var itemcode = ${(item.itemCode)!};
        $('.item-code-input').keyup(function (e) {
            var e = e || window.event;
            var eKeyCode = e.keyCode;
            var thisVal = this.value;
            if ((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || (eKeyCode >= 65 && eKeyCode <= 90)
                    || eKeyCode === 8 || eKeyCode === 37 || eKeyCode === 39 || eKeyCode === 46) {
                if (thisVal.length >= 16) {
                    this.value = thisVal.substring(0, 18);
                }
            } else {
                if (!Number(thisVal)) {
                    this.value = itemcode;
                } else {
                    this.value = thisVal;
                    itemcode = thisVal;
                }
                return false;
            }
        }).keydown(function (e) {
            var e = e || window.event;
            var eKeyCode = e.keyCode;
            var thisVal = this.value;
            if (!((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || (eKeyCode >= 65 && eKeyCode <= 90)
                    || eKeyCode === 8 || eKeyCode === 37 || eKeyCode === 39 || eKeyCode === 46)) {
                if (!Number(thisVal)) {
                    this.value = itemcode;
                } else {
                    this.value = thisVal;
                    itemcode = thisVal;
                }
                return false;
            }
        });

        //得分设置输入检测函数
        var scoreRate = ${(item.scoreRate)!'50'};
        $('.pe-some-correct-number').keyup(function (e) {
            var e = e || window.event;
            var eKeyCode = e.keyCode;
            var thisVal = this.value;
            if ((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105)
                    || eKeyCode === 8 || eKeyCode === 37 || eKeyCode === 39 || eKeyCode === 46) {
                if (parseInt(thisVal) > 100) {
                    this.value = 99;
                }
            } else {
                if (!Number(thisVal)) {
                    this.value = scoreRate;
                } else {
                    this.value = thisVal;
                    scoreRate = thisVal;
                }
                return false;
            }
        }).keydown(function () {
            var e = e || window.event;
            var eKeyCode = e.keyCode;
            var thisVal = this.value;
            if (!((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105)
                    || eKeyCode === 8 || eKeyCode === 37 || eKeyCode === 39 || eKeyCode === 46)) {
                if (!Number(thisVal)) {
                    this.value = scoreRate;
                } else {
                    this.value = thisVal;
                    scoreRate = thisVal;
                }
                return false;
            }
        });

        //表单校验
        $("#editItemForm").validate({
            errorElement: 'em',
            onfocusout:false,
            rules: {
                mark: "required",
                itemCode: {
                    required: true,
                    remote: {
                        url: pageContext.rootPath + '/ems/item/manage/checkItemCode',     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        data: {
                            /*username: function () {
                                return $("input[name='id']").val();
                            },
                            userId: function () {
                                return $("input[name='itemCode']").val();
                            }*/
                            id: function () {
                                return $("input[name='id']").val();
                            },
                            itemCode: function () {
                                return $("input[name='itemCode']").val();
                            }
                        }
                    }
                }
            },
            messages: {
                mark: "分值不能为空",
                itemCode: {
                    required: "试题编号不能为空",
                    remote: "试题编号不能重复"
                }
            }
        });
    })
</script>