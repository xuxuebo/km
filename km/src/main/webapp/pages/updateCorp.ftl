<#assign ctx=request.contextPath/>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>智慧云-升级页面</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <link rel="author" type="text/html" href="https://plus.google.com/+MuazKhan">
    <meta name="author" content="Muaz Khan">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <style>
        *{
            padding: 0;
            margin: 0;
        }
        body{
            background-color: #f4f6f9;
        }
        .updataCrop-header{
            width: 100%;
            background: #6d9ed9;
            min-width: 1200px;
        }
        .byk_w{
            width: 1200px;
            margin: 0 auto;
        }
        .updataCrop-header-container{
            height: 64px;
            line-height: 64px;
            color: #fff;
            font-size: 20px;
            text-align: center;
        }
        .updataCrop-header-logo{
            float: left;
            margin-top: 14px;
        }
        .updataCrop-header-back{
            float: right;
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
        }
        .updataCrop-header-back:before{
            display: inline-block;
            content: '';
            width: 26px;
            height: 26px;
            background: url(../../web-static/proExam/images/back@2x.png) center center no-repeat;
            background-image: none\9;
            filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../../web-static/proExam/images/back@2x.png', sizingMethod='scale')\9;
            background-size: contain;
            vertical-align: middle;
            margin-top: -1px;
            margin-right: 5px;
        }
        .updataCrop-main{
            min-height: 800px;
        }
        .updataCrop-main-table{
            display: table;
            width: 100%;
        }
        .updataCrop-main-left,.updataCrop-main-right{
            display: table-cell;
            width: 50%;
            box-sizing: border-box;
            text-align: center;
            padding-top: 30px;
            vertical-align: top;
        }
        .updataCrop-main-item{
            display: inline-block;
            width: 508px;
            height: 634px;
            background-repeat: no-repeat;
            background-position: center 0;
            background-size: contain;
            padding: 42px 94px;
            box-sizing: border-box;
        }
        .updataCrop-main-left .updataCrop-main-item{
            background-image: url(../../web-static/proExam/images/enterprise@2x.png);
            background-image: none\9;
            filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../../web-static/proExam/images/enterprise@2x.png', sizingMethod='scale')\9;
        }
        .updataCrop-main-right .updataCrop-main-item{
            background-image: url(../../web-static/proExam/images/deploy@2x.png);
            background-image: none\9;
            filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../../web-static/proExam/images/deploy@2x.png', sizingMethod='scale')\9;
        }
        .updataCrop-main-item-title{
            width: 100%;
            font-size: 16px;
            color: #fff;
            text-align: left;
            margin-top: 20px;
        }
        .updataCrop-main-item-title span{
            display: inline-block;
            font-size: 28px;
            padding: 6px 0 10px;
            border-bottom: 2px solid #fff;
        }
        .updataCrop-table-td span{
            font-size: 16px;
            border: 1px solid #ccc;
            padding: 5px 20px;
        }
        ul.updataCrop-main-item-content{
            list-style: none;
            margin-top: 85px;
        }
        ul.updataCrop-main-item-content li{
            width: 148px;
            height: 40px;
            line-height: 40px;
            box-sizing: border-box;
            border-radius: 4px;
            font-size: 14px;
        }
        ul.updataCrop-main-item-content li.even{
            float: left;
            margin-bottom: 20px;
            border: 1px solid #2a9cfe;
            color: #2a9cfe;
            cursor: pointer;
        }
        ul.updataCrop-main-item-content li.odd{
            float: right;
            margin-bottom: 20px;
            border: 1px solid #2a9cfe;
            color: #2a9cfe;
            cursor: pointer;
        }
        ul.updataCrop-main-item-content li.center{
            margin:0 auto  40px;
            border: 1px solid #4BA78C;
            color: #4BA78C;
        }
        ul.updataCrop-main-item-content li.even:hover,ul.updataCrop-main-item-content li.odd:hover{
            background-color: #2a9cfe;
            color: #fff;
        }
        ul.updataCrop-main-item-content li.lastLi{
            margin-bottom: 30px;
        }
        .updataCrop-main-item-footer{
            clear: both;
            font-size: 14px;
            color: #666666;
        }
        .updataCrop-footer{
            background-color: #3E3E3E;
            color: #fff;
            text-align: center;
            font-size: 14px;
            height: 60px;
            line-height: 60px;
        }
        .updataCrop-dialog-mask{
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: #444;
            opacity: 0.5;
            filter: alpha(opacity=50);
        }
        .updataCrop-dialog{
            position: fixed;
            width: 600px;
            height: auto;
            top: 50%;
            left: 50%;
            /*  margin: -180px 0 0 -300px;*/
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 2px 2px 10px 2px #f1f1f1;
        }
        .updataCrop-dialog-title{
            height: 60px;
            line-height: 60px;
            border-bottom: 1px solid #e0e0e0;
            position: relative;
        }
        .updataCrop-dialog-title,.updataCrop-dialog-content{
            padding: 0 40px;
            box-sizing: border-box;
        }
        .updataCrop-dialog-content{
            padding: 20px 40px;
            font-size: 14px;
            color: #444444;
            line-height: 1.8;
        }
        .updataCrop-dialog-close{
            cursor: pointer;
            width: 16px;
            height: 16px;
            float: right;
            margin-top: 21px;
            margin-right: -16px;
            background: url(../../web-static/proExam/images/close@2x.png) center center no-repeat;
            background-size: contain;
            background-image: none\9;
            filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../../web-static/proExam/images/close@2x.png', sizingMethod='scale')\9;
        }
        .updataCrop-dialog-arrow{
            position: absolute;
            bottom: -13px;
            left: -28px;
            border: 14px solid #fff;
            border-left-color: transparent;
            border-top-color: transparent;
            border-bottom-color: transparent;
        }
        .main-item-dialog,.updataCrop-dialog-mask,.updataCrop-dialog{
            display: none;
        }
    </style>

</head>

<body>
<div class="updataCrop-header">
    <div class="updataCrop-header-container byk_w">
        <img src="${(resourcePath+logoUrl)!'${resourcePath!}/web-static/proExam/images/long_logo_pure.png'}" class="updataCrop-header-logo" width="118" alt="LOGO">
        升级页面
    <#--<div class="updataCrop-header-back">如需升级请联系0551-65990121</div>-->
        <div class="updataCrop-header-back" onclick="window.history.back(-1);"></div>
    </div>
</div>
<div class="updataCrop-main byk_w">
    <div class="updataCrop-main-table">
        <div class="updataCrop-main-left">
            <div class="updataCrop-main-item">
                <div class="updataCrop-main-item-title">升级至</br><span>企业版</span></div>
                <UL class="updataCrop-main-item-content" id="enterprice">
                    <li class="even">远程监控
                        <div class="main-item-dialog">
                            <div class="main-item-dialog-title">企业版·远程监控功能简介</div>
                            <div class="main-item-dialog-content">
                                每场考试可设置现场监考人员和总监控人员，总监控人员可远程查看各个考试现场监控画面，
                                包括视频监控、考生数据监控和截图抓拍，数据监控支持提醒考生参加考试、添加考生操作，
                                并监控所有参加考生考试操作详情，记录切屏、退出、违纪等操作，支持违纪处理和强制交卷功能。
                            </div>
                        </div>
                    </li>
                    <li class="odd">手动评卷
                        <div class="main-item-dialog">
                            <div class="main-item-dialog-title">企业版·手动评卷功能简介</div>
                            <div class="main-item-dialog-content">
                                <p>手动评卷更加人性化，对于开放性题型比较自动评卷更加科学化、公正化。</p>
                                <p>并且评卷人可看到考生考试监控详情，如有违纪操作可合理扣分或者取消成绩。</p>
                                <p>本次考试所有考卷手动评卷后，考试信息和评卷细则转到已评卷中，可查看。</p>
                            </div>
                        </div>
                    </li>
                    <li class="even">多重防舞弊
                        <div class="main-item-dialog">
                            <div class="main-item-dialog-title">企业版·多重防舞弊功能简介</div>
                            <div class="main-item-dialog-content">
                                独特的防舞弊设置，包括进入考试时短信验证身份、开启实时摄像抓拍功能、开启远程监控功能、切屏次数限制（超过限制强制交卷）、
                                限制时间内考试页面不操作记为舞弊并强制交卷、限制迟到时间，超过取消考试资格、答卷时间限制，没超过不得提前交卷、
                                生成试卷时打乱相同题型下的试题的顺序以及试题选项的顺序；（均为可选择项，时间次数项可设置，有默认值）
                            </div>
                        </div>
                    </li>
                    <li class="odd">手动发布
                        <div class="main-item-dialog">
                            <div class="main-item-dialog-title">企业版·手动发布成绩功能简介</div>
                            <div class="main-item-dialog-content">
                                <p>考试设置可设置自动或者手动发布成绩，手动发布中可选择是否定时发布，选择定时发布需要设定时间。</p>
                                <p>如设置手动发布，可选择设置为以评卷分数发布还是自行导入成绩发布。</p>
                                <p>在发布成绩栏可查看已发布的考试，对设置成手动发布的考试进行管理。</p>
                            </div>
                        </div>
                    </li>
                    <li class="even">证书关联
                        <div class="main-item-dialog">
                            <div class="main-item-dialog-title">企业版·证书功能简介</div>
                            <div class="main-item-dialog-content">
                                <p>考生通过考试可获得相关证书。</p>
                                <p>支持增删改查基本操作；分为启用和停用两种形式；启用后的证书不可编辑，停用后可删除和再次启用；</p>
                                <p>编辑证书可添加各种变量（姓名、性别、单位、头像、身份证号、考试名称、考试成绩、证书编号、证书序列号、证书有效期、证书二维码），保证证书的完整性和严谨性；</p>
                                <p>可设置背景、添加图片；</p>
                            </div>
                        </div>
                    </li>
                    <li class="odd">角色分配
                        <div class="main-item-dialog">
                            <div class="main-item-dialog-title">企业版·角色分配功能简介</div>
                            <div class="main-item-dialog-content">
                                <p>拥有角色分配的管理员可以给其他角色分配角色权限，被分配权限的用户具有管理系统某一模块的功能。</p>
                                <p>比如试题管理员、试卷管理员、考试监控专员、评卷专员、人事管理员......</p>
                            </div>
                        </div>
                    </li>
                    <li class="even">知识点关联
                        <div class="main-item-dialog">
                            <div class="main-item-dialog-title">企业版·知识点功能简介</div>
                            <div class="main-item-dialog-content">
                                每道试题都具有相关知识点，能更好的帮助考生理解试题内容，是使用相关分析报表中知识点弱项分析的前提。
                            </div>
                        </div>
                    </li>
                    <li class="odd">批量导出
                        <div class="main-item-dialog">
                            <div class="main-item-dialog-title">企业版·批量导出功能简介</div>
                            <div class="main-item-dialog-content">
                                用户数据、试卷内容、考试人员数据和成绩数据可以进行批量导出。利于考试信息传递和发布。
                            </div>
                        </div>
                    </li>
                    <li class="even lastLi">高级考试设置
                        <div class="main-item-dialog">
                            <div class="main-item-dialog-title">企业版·高级考试设置功能简介</div>
                            <div class="main-item-dialog-content">
                                <p>答题模式分为整卷模式和逐题模式；（可选择允许返回修改答案）</p>
                                <p>补考设置分为自动安排补考、手动安排补考和不允许补考。手动安排补考可以设置新的试卷和考试时间；</p>
                                <p>评卷策略分为系统自动评卷和人工评卷；（可选择允许评卷人查看考生信息）</p>
                                <p>成绩设置包括原试卷分数按比例折算成任一分数和使用原试卷分数；</p>
                                <p>成绩发布分为自动发布和手动发布，手动发布支持定时发布；</p>
                                <p>考试权限支持学生查看答卷、错题、正确答案和解析；</p>
                            </div>
                        </div>
                    </li>
                    <li class="odd lastLi">随机组卷精确设置
                        <div class="main-item-dialog">
                            <div class="main-item-dialog-title">企业版·随机组卷精确设置功能简介</div>
                            <div class="main-item-dialog-content">
                                随机组卷时可以自定义选择所选题库中题型、题量、难度的数目，智能化随机组卷，合理调整试卷水平。
                            </div>
                        </div>
                    </li>
                </UL>
                <div class="updataCrop-main-item-footer">
                    咨询企业级升级请联系：0551-65990121 (转8016)
                </div>
            </div>
        </div>
        <div class="updataCrop-main-right">
            <div class="updataCrop-main-item">
                <div class="updataCrop-main-item-title">升级至</br><span>部署版</span></div>
                <UL class="updataCrop-main-item-content">
                    <li class="center">支持现有功能</li>
                    <li class="center">接受部署定制</li>
                    <li class="center">自定义化服务</li>
                    <li class="center lastLi">多种需求满足</li>
                </UL>
                <div class="updataCrop-main-item-footer">
                    咨询部署版升级请联系：0551-65990121 (转8016)
                </div>
            </div>
        </div>
    </div>
</div>
<div class="updataCrop-footer">
    <p>Copyright ©2018 青谷科技专业考试系统 All Rights Reserved 皖ICP备16015686号-2</p>
</div>

<#--<div class="updataCrop-dialog-mask"></div>-->
<div class="updataCrop-dialog" style="display: none;">
    <div class="updataCrop-dialog-title"><span class="title">企业版·远程监控功能简介</span><#--<span class="updataCrop-dialog-close"></span>--><span class="updataCrop-dialog-arrow"></span></div>
    <div class="updataCrop-dialog-content">
        <p>独特的防舞弊设置，包括：</p>
        <p>（1）进入考试时短信验证身份；</p>
        <p>（2）开启实时摄像抓拍功能；</p>
        <p>（3）开启远程监控功能；</p>
        <p>（4）切屏次数限制（超过限制强制交卷）；</p>
        <p>（5）限制时间内考试页面不操作记为舞弊并强制交卷；</p>
        <p>（6）限制迟到时间，超过取消考试资格；</p>
        <p>（7）答卷时间限制，没超过不得提前交卷；</p>
        <p>（8）生成试卷时打乱相同题型下的试题的顺序以及试题选项的顺序；</p>
        <p>（均为可选择项，时间次数项可设置，有默认值）</p>
    </div>
</div>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript">
    $(function () {
        /* $(".updataCrop-dialog-close").on('click',function (e) {
             $(this).parents('.updataCrop-dialog').hide();
             $('.updataCrop-dialog-mask').hide();
         });*/
        (function($){
            var flag = false;
            var hideDialogTag = $('.updataCrop-dialog');
            $('#enterprice').on('mouseenter','li',function (event) {
                flag = true;
                var e = event || window.event;
                var liDialogTag = $(this).find('.main-item-dialog');
                hideDialogTag.find('.updataCrop-dialog-title .title').text(liDialogTag.find('.main-item-dialog-title').text());
                hideDialogTag.find('.updataCrop-dialog-content').html(liDialogTag.find('.main-item-dialog-content').html());
                hideDialogTag.show();
                setPosition(e.clientX,e.clientY);
            }).on('mouseleave','li',function(e){
                flag = false
                hideDialogTag.hide();
            }).on('mousemove','li',function(event){
                var e = event || window.event;
                setPosition(e.clientX,e.clientY);
            });
            hideDialogTag.on('mouseenter',function (e) {
                if(flag){
                    hideDialogTag.show();
                }else{
                    hideDialogTag.hide();
                }
            }).on('mousemove',function (event) {
                var e = event || window.event;
                setPosition(e.clientX,e.clientY);
            });
            /*设置dialog的xtopleft值*/
            function setPosition(x,y){
                hideDialogTag.css({"left":x+35,"top":y-50});
            }
        })(jQuery);
    });
</script>

</body>

</html>
