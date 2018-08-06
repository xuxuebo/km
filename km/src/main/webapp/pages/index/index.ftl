<#include "header.ftl"/>
<script type="text/javascript">
    function goLoadPage(type) {
        var $yContainer = $('.y-container');
        if (type === 'dataShare') {
            $yContainer.load('${ctx!}/km/front/dataShare');
        } else if (type === "majorProject") {
            $yContainer.load('${ctx!}/km/front/majorProject');
        }else if (type === "specialty") {
            $yContainer.load('${ctx!}/km/front/specialty');
        }else if (type === "dataStatistics") {
            $yContainer.load('${ctx!}/km/front/dataStatistics');
        }else if (type === "adminSetting") {
            $yContainer.load('${ctx!}/km/front/adminSetting',function () {
                location.hash = 'user';
            });
        } else if(type === "publicLibrary"){
            $yContainer.load('${ctx!}/km/front/publicLibrary');
        } else{
                // 首页
                $yContainer.load('${ctx!}/km/front/loadIndex',function () {
                location.hash = 'yun';
            });
        }
    }

    $(function () {
        $(".y-nav__link").find("li").bind("click", function () {
            var $this = $(this);
            if($this.hasClass('active')){
                return;
            }
            $(".y-nav__link").find("li").removeClass("active");
            $this.addClass("active");
            goLoadPage($this.attr("data-type"))
        });
        goLoadPage();
    })
</script>
<#include "footer.ftl"/>