<section class="s-data-statistics">
    <div class="s-data-statistics-content">
        <div class="s-data-statistics-header">
            <div class="s-data-file-total">
                <div class="s-data-show">
                    <div class="s-data-file-info">文件数量</div>
                    <div class="s-data-account">568345</div>
                </div>
            </div>
            <div class="s-data-upload-file-total">
                <div class="s-file-upload">
                    <div class="s-file-upload-info">日上传数量</div>
                    <div class="s-file-upload-account">568345</div>
                </div>
            </div>
        </div>
        <div class="s-echarts">
            <div class="s-echarts-central-info">中心排行</div>
            <div class="s-echarts-up">
                <div class="s-echarts-central">
                    <div class="s-central-bar" id="s-echarts-bar" style="height: 403px;width: 492px;"></div>
                </div>
                <div class="s-echarts-special">
                    <div class="s-echarts-special-info">专业排行</div>
                    <ul id="s-progress">

                    </ul>
                </div>
            </div>
        </div>
        <div class="s-echarts-down">
            <div class="s-echarts-person">
                <div class="s-echarts-person-info">个人排行</div>
                <div class="s-person-picture">
                    <ul>
                        <li>
                            <div class="s-person-icon_first"></div>
                            <img class="s-person-img"
                                 src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            <div class="s-person-name">张恒恒</div>
                            <div class="s-person-number">50000份</div>
                        </li>
                        <li>
                            <div class="s-person-icon_second"></div>
                            <img class="s-person-img"
                                 src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            <div class="s-person-name">张恒恒</div>
                            <div class="s-person-number">50000份</div>
                        </li>
                        <li>
                            <div class="s-person-icon_third"></div>
                            <img class="s-person-img"
                                 src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            <div class="s-person-name">张恒恒</div>
                            <div class="s-person-number">50000份</div>
                        </li>
                        <li>
                            <span class="s-person-order-number">4</span>
                            <img class="s-person-img"
                                 src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            <div class="s-person-name">张恒恒</div>
                            <div class="s-person-number">50000份</div>
                        </li>
                        <li>
                            <span class="s-person-order-number">5</span>
                            <img class="s-person-img"
                                 src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            <div class="s-person-name">张恒恒</div>
                            <div class="s-person-number">50000份</div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="s-echarts-point">
                <div class="s-echarts-point-info">重点项目排行</div>
                <div class="s-echarts-point-pie" id="s-echarts-pie"></div>
            </div>
        </div>
    </div>
    <div class="s-data-statistics-background_icon"></div>
</section>
<script src="${resourcePath!}/web-static/proExam/index/js/dataStatistics.js"></script>