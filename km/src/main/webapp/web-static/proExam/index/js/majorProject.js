$(function () {
    $.ajax({
        url: pageContext.resourcePath + '/library/listLibrary?type=PROJECT_LIBRARY',
        dataType: 'json',
        success: function (result) {
            var tree=$('.y-user-tree');
            tree.append(_.template($("#tplYunManageList").html())({data: result}));
            var user=$(".y-user");
            var h=user.height()+23;
            user.height(h);
            $(".y-menu-item-title").eq(0).addClass("y-menu-item-title-active");
            tree.delegate(".y-menu-item-title","click",function(){
                $(this).addClass("y-menu-item-title-active").siblings().removeClass("y-menu-item-title-active");
            });
            var $yContainer = $('.y-content');
            $yContainer.load('/km/front/projectDetail?libraryId='+result[0].id);
        }
    });
})
function selectProjectDetail(id) {
    var $yContainer = $('.y-content');
    $yContainer.load('/km/front/projectDetail?libraryId='+id);
}
