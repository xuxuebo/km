<!doctype html>
<html lang="zh-cmn-Hans">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>监控</title>
    <style>
        .pay-monitor-panel{
            width:1080px;
            margin:40px auto;
            font-family:'PingFangSC-Regular','Hiragino Sans GB', 'Microsoft Yahei', Arial, sans-serif;
        }
        .pay-monitor-panel .title{
            width:100%;
            border-bottom:2px solid #ddd;
        }
        .pay-monitor-panel .title h3{
            display:inline-block;
            font-size:24px;
            color:#444;
            line-height:1.4;
            border-bottom:2px solid #199AE2;
            margin-bottom:-2px;
        }
        .pay-monitor-panel .title > h3 > i{
            float:left;
            width: 8px;
            height: 8px;
            margin: 6px;
            font-style: normal;
        }
        .pay-monitor-panel .pay-monitor-msg{
            font-size:18px;
            color:#666;
            line-height:1.4;
            margin-top:26px;
            margin-bottom:58px;
        }
        .pay-monitor-panel .pay-monitor-msg > i{
            color:#FC984E;
            font-style:normal;
        }
        .monitor-intro > i{
            color:#444;
            font-style:normal;
            font-size:20px;
            margin-bottom:20px;
        }
        .monitor-intro .monitor-intro-img{
            width:1080px;
            /*height:803px;*/
            margin-top:20px;
            margin-bottom:60px;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.50);
        }
        .monitor-intro-img > img{
            display:block;
        }

    </style>
</head>
<body>
    <div class="pay-monitor-panel">
        <div class="title">
            <h3><i>*</i>开通说明</h3>
        </div>
        <div class="pay-monitor-msg">
            远程监控为付款功能，如需开通，请联系 吴经理：<i>13855167015</i>。
        </div>
        <div class="title">
            <h3><i>*</i>功能介绍</h3>
        </div>
        <div class="pay-monitor-msg">
            每场考试可设置现场监考人员和总监控人员，现场监考人员开启监控摄像后，总监控人员可远程查看各个考试现场监控画面，如有异常，可发送消息提醒现场监考人员。监控画面支持截屏保存，监控录像自动保存。
        </div>
        <div class="monitor-intro">
            <i>现场监考人员界面:</i>
            <div class="monitor-intro-img">
                <img src="${resourcePath!}/web-static/proExam/images/monitor-inside-img.jpg?v=1" width="100%"  alt="">
            </div>
            <i>总监控人员界面:</i>
            <div class="monitor-intro-img">
                <img src="${resourcePath!}/web-static/proExam/images/monitor-total-img.jpg?v=1" width="100%" alt="">
            </div>
        </div>
    </div>
</body>
</html>