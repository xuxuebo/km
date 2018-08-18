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
            tree.delegate(".y-menu-item-title","click",function(){
                $(this).addClass("y-menu-item-title-active").siblings().removeClass("y-menu-item-title-active");
            });
            var id = result[0].id;
            if (libraryId) {
                id = libraryId;
                $("div[data-id='" + id + "']").addClass("y-menu-item-title-active");
            } else {
                $(".y-menu-item-title").eq(0).addClass("y-menu-item-title-active");
            }

            var $yContainer = $('.y-content');
            $yContainer.load('/km/front/projectDetail?libraryId=' + id);
        }
    });
})
function selectProjectDetail(id) {
    var $yContainer = $('.y-content');
    $yContainer.load('/km/front/projectDetail?libraryId=' + id);
}
