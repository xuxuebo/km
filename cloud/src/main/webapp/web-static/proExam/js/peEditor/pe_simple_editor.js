var seDialog = {
    close: function () {
        $('.pe-box-wrap').remove();
        $('.pe-exam-mask').remove();
    },
    comfire: function (settings) {
        var defaults = {
            title: '',
            content: '',
            btn: ['取消', '确定'],
            btnBlueR: true,
            okBtn: function () {
                //examDialog.close();
            },
            cancelBtn: function () {
                //examDialog.close();
            },
            onLoad: function () {
            }
        };
        $.extend(defaults, settings);
        var dialogDom1 = '<div class="pe-exam-mask"></div><div class="pe-box-wrap pe-simple-editor-wrap">'
            + '<i class="iconfont pe-box-close">&#xe643;</i>'
            + '<h3 class="pe-box-title">' + defaults.title + '</h3>'
            + '<div class="pe-box-contain pe-editor-box-contain">'
            + '</div>';
        var dialogDom2 = '</div>';
        if (defaults.btnBlueR) {
            var btnDom = '<div class="btns-wrap"><button class="pe-btn pe-btn-purple pe-box-known se-upload-cancel">' + defaults.btn[0] + '</button>'
                + '<button class="pe-btn pe-btn-blue pe-box-known se-upload-ok">' + defaults.btn[1] + '</button></div>'
        } else {
            var btnDom = '<div class="btns-wrap"><button class="pe-btn  pe-btn-blue  pe-box-known se-upload-cancel">' + defaults.btn[0] + '</button>'
                + '<button class="pe-btn pe-btn-purple pe-box-known se-upload-ok">' + defaults.btn[1] + '</button></div>'
        }
        var allDialogDom = dialogDom1 + btnDom + dialogDom2;
        $('body').append(allDialogDom);
        $('.pe-box-wrap .pe-editor-box-contain').load(defaults.content);
        $('.se-upload-ok').click(function (e) {
            var e = e || window.event;
            e.stopPropagation();
            defaults.okBtn();
            seDialog.close();
        });
        $('.se-upload-cancel').click(function (e) {
            var e = e || window.event;
            defaults.cancelBtn();
            seDialog.close();
        });
        $('.pe-box-close').click(function () {
            seDialog.close();
        });
        defaults.onLoad();
    }
};
(function ($) {
    function _$(t) {
        return $(t);
    }

    var editorRenderDom = '';//包裹编辑器的外部容器，一般都已经在页面实先写好了
    var peId = 0;

    //开始渲染编辑器的结构
    function render(t) {
        //渲染工具栏
        renderTitle(t);
        //渲染iframe的主体
        renderFrame(t);
        //设置编辑器工具栏里的图标点击事件;
        bindEvent(t);
    }

    //渲染图片展示的提示框
    renderImgWrap();

    //设置编辑器工具栏里的图标点击事件;
    function bindEvent(t) {
        var data = $.data(t, 'peEditor');
        //图片上传
        $('#' + data.options.name).delegate('.image-upload', 'click', function () {
            var editorDom = $(this);
            var _thisEditorId = editorDom.parents('.pe-simple-editor').find('.editor-content-wrap').attr('id');
            seDialog.comfire({
                title: '上传图片',
                content: pageContext.rootPath + '/ems/item/initUploadImage',
                okBtn: function () {
                    var uploadStateVal = $('input[name="uploadState"]').val();
                    var uploadImageUrl = $('input[name="uploadImageUrl"]').val();
                    var uploadImageAlt = $('input[name="uploadImageAlt"]').val();
                    var imageId = $('input[name="imageId"]').val();
                    seDialog.close();
                    if ((uploadStateVal.toLowerCase()) === 'success' && uploadImageUrl) {
                        insertHTML(_thisEditorId, '<img class="upload-img" title="点击定位图片" data-id="' + imageId + '" height="20" alt="' + uploadImageAlt + '" src="' + pageContext.resourcePath
                            + '/web-static/proExam/images/default-image.png" data-src="' + uploadImageUrl + '" />');
                    }
                }
            })
        });
        //音频上传
        $('#' + data.options.name).delegate('.audio-upload', 'click', function () {
            var editorDom = $(this);
            var _thisEditorId = editorDom.parents('.pe-simple-editor').find('.editor-content-wrap').attr('id');
            seDialog.comfire({
                title: '上传音频',
                content: pageContext.rootPath + '/ems/item/initUploadAudio',
                okBtn: function () {
                    var uploadStateVal = $('input[name="uploadState"]').val();
                    var audioId = $('input[name="audioId"]').val();
                    if ((uploadStateVal.toLowerCase()) === 'success') {
                        var musicSrc = '<img style="margin-right:6px;" data-id="' + audioId + '" class="image-audio" height="20" width="20" alt="音频图标" src="' + pageContext.resourcePath + '/web-static/proExam/images/default-music.png"/>';
                        insertHTML(_thisEditorId, musicSrc);
                    }
                },
                cancelBtn: function () {
                    // alert('cancel');
                },
                onLoad: function () {
                    // alert('onLoad');
                }
            })
        });
        //视频上传
        $('#' + data.options.name).delegate('.video-upload', 'click', function () {
            var editorDom = $(this);
            var _thisEditorId = editorDom.parents('.pe-simple-editor').find('.editor-content-wrap').attr('id');
            seDialog.comfire({
                title: '上传视频',
                content: pageContext.rootPath + '/ems/item/initUploadVideo',
                okBtn: function () {
                    var uploadStateVal = $('input[name="uploadState"]').val();
                    var videoId = $('input[name="videoId"]').val();
                    if ((uploadStateVal.toLowerCase()) === 'success') {
                        var videoSrc = '<img style="margin-right:6px;" data-id="' + videoId + '" class="image-video" height="20" width="20" alt="视频图标" src="' + pageContext.resourcePath + '/web-static/proExam/images/default-video.png"/>';
                        insertHTML(_thisEditorId, videoSrc);
                    }
                },
                cancelBtn: function () {
                    // alert('cancel');
                },
                onLoad: function () {
                    // alert('onLoad');
                }
            })
        });
        //窗口放大
        $('#' + data.options.name).delegate('.view-big-window', 'click', function () {
            var _thisEditorWrap = $(this).parents('.pe-simple-editor');
            if (!_thisEditorWrap.hasClass('big-view-states')) {
                $(this).removeClass('icon-start-fullscreen').addClass('icon-cancel-fullscreen');
                _thisEditorWrap.addClass('big-view-states');
                _thisEditorWrap.find('.editor-content-wrap').width(_thisEditorWrap.width() - 30);
                _thisEditorWrap.find('.editor-content-wrap').height(_thisEditorWrap.height() - 40);
            } else {
                $(this).removeClass('icon-cancel-fullscreen').addClass('icon-start-fullscreen');
                _thisEditorWrap.removeClass('big-view-states');
                _thisEditorWrap.find('.editor-content-wrap').height((data.options.initFrameHeight - 20));
                _thisEditorWrap.find('.editor-content-wrap').width((data.options.initFrameWidth - 30));
            }

        });
        //编辑器里面的上次图片之后小图标的hover事件；
        $('#' + data.options.name).delegate('.upload-img', 'mouseover', function (e) {
            var e = e || window.event;
            e.stopPropagation();
            var _this = $(this),
                $realImgWrap = $('.editor-real-img-wrap'),
                thisRealSrc = _this.attr('data-src'),
                thisImgIconLeft = _this.offset().left - 30,
                thisImgIconTop = _this.offset().top - 120;
            $realImgWrap.css({"top": thisImgIconTop, "left": thisImgIconLeft});
            showRealImg($realImgWrap);
            $realImgWrap.find('.real-img').attr('src', thisRealSrc);
        });
        $('#' + data.options.name).delegate('.upload-img', 'mouseout', function (e) {
            var e = e || window.event;
            e.stopPropagation();
            clearInterval(loadingInterval);
            $('.editor-real-img-wrap').hide();
        });
    }

    //渲染工具栏.目前不会超过10个
    function renderTitle(t) {
        var data = $.data(t, 'peEditor');
        var titleDom_One = '<div class="container-content-title">'
            + '<div class="self-toolbar-left">' + data.options.toolLeftContent + '</div>'
            + '<div class="self-toolbar-left insert-fill-blank">'
            + '<span class="iconfont icon-insert-blank"></span>插入空格</div>';
        +'<ul class="tool-btns-wrap">';
        var titleDom_Two = '</ul>';
        var titleSubDom = '';//每个分类里面的小的分类

        var toolBarArr = data.options.toolBar;
        for (var i = 0, tLen = toolBarArr.length; i < tLen; i++) {
            var subOne = '<ul class="over-flow-hide single-item-wrap">';
            var subTwo = '</ul>';
            for (var j = 0, jLen = toolBarArr[i].length; j < jLen; j++) {
                switch (toolBarArr[i][j]) {
                    case 'image':
                        subOne += '<li class="floatL">'
                            + '<a href="javascript:;" title="上传图片" class="tool-btn image-upload iconfont icon-picture-icon"></a>'
                            + '</li>';
                        break;
                    case 'video':
                        subOne += '<li class="floatL">'
                            + '<a href="javascript:;" title="上传视频" class="tool-btn video-upload iconfont  icon-pe-video"></a>'
                            + '</li>';
                        break;
                    case 'music':
                        subOne += '<li class="floatL">'
                            + '<a href="javascript:;" title="上传音频" class="tool-btn audio-upload iconfont  icon-pe-audio"></a>'
                            + '</li>';
                        break;
                    case 'magnify':
                        subOne += '<li class="floatL">'
                            + '<a href="javascript:;" title="放大查看" class="tool-btn view-big-window iconfont  icon-start-fullscreen"></a>'
                            + '</li>';
                        break;
                }
            }
            var subTitleDom = '<li class="tool-cate-item floatL">' + subOne + subTwo + '</li>';//形成工具栏子分类内部的ul
            titleSubDom += subTitleDom;
        }
        var allToolBarDom = titleDom_One + titleSubDom + titleDom_Two;

        editorRenderDom.append(allToolBarDom);
    }

    //初始化富文本编辑器的可编辑的属性 //留用，误删！！
    // function InitEditable (peId) {
    //     var editorDoc;
    //     var editor = document.getElementById ("peEditor_" + peId);
    //     if (editor.contentDocument){
    //         editorDoc = editor.contentDocument;
    //     }else{
    //         editorDoc = editor.contentWindow.document;
    //     }
    //     var editorBody = editorDoc.body;
    //
    //     // turn off spellcheck
    //     if ('spellcheck' in editorBody) {   // Firefox
    //         editorBody.spellcheck = false;
    //     }
    //
    //     if ('contentEditable' in editorBody) {
    //         // allow contentEditable
    //         editorBody.contentEditable = true;
    //     }
    //     else {  // Firefox earlier than version 3
    //         if ('designMode' in editorDoc) {
    //             // turn on designMode
    //             editorDoc.designMode = "on";
    //         }
    //     }
    // }

    //渲染富文本编辑器里面小图片hover的提示框
    function renderImgWrap() {
        var imgWrap = '<div class="editor-real-img-wrap"><img alt="" src="" class="real-img" height="100%"/><span class="img-loading one-point">loading<span>...</span></span></div>';
        $('body').append(imgWrap);
    }

    var loadingInterval;
    //富文本编辑器的图片上传hover效果
    function showRealImg($realImgWrap) {
        var $loadDom = $realImgWrap.find('.img-loading');
        var $loadDomSpan = $realImgWrap.find('.img-loading').find('span');
        $realImgWrap.show();
        $realImgWrap.find('.real-img')[0].onload = function () {
            clearInterval(loadingInterval);
            $loadDom.hide();
            $realImgWrap.width('auto');
            $realImgWrap.find('.real-img').show();
        };
        loadingInterval = setInterval(function () {
            if ($loadDom.hasClass('one-point')) {
                $loadDom.removeClass('one-point');
                twoPointLoad();
            } else if ($loadDom.hasClass('two-point')) {
                $loadDom.removeClass('two-point');
                threePointLoad();
            } else if ($loadDom.hasClass('three-point')) {
                $loadDom.removeClass('one-point');
                onePointLoad();
            }
        }, 500);
        function onePointLoad() {
            $loadDomSpan.html('.');
            $loadDom.addClass('one-point');
        }

        function twoPointLoad() {
            $loadDomSpan.html('..');
            $loadDom.addClass('two-point');
        }

        function threePointLoad() {
            $loadDomSpan.html('...');
            $loadDom.addClass('three-point');
        }
    }

    //判断各个浏览器的contenteditabled写入方式的支持方式;
    function pasteHtmlAtCaret(html, selectPastedContent) {
        var sel, range;
        if (window.getSelection) {
            sel = window.getSelection();
            if (sel.getRangeAt && sel.rangeCount) {
                range = sel.getRangeAt(0);
                range.deleteContents();
                var el = document.createElement("div");
                el.innerHTML = html;
                var frag = document.createDocumentFragment(), node, lastNode;
                while ((node = el.firstChild)) {
                    lastNode = frag.appendChild(node);
                }
                var firstNode = frag.firstChild;
                range.insertNode(frag);

                // Preserve the selection
                if (lastNode) {
                    range = range.cloneRange();
                    range.setStartAfter(lastNode);
                    if (selectPastedContent) {
                        range.setStartBefore(firstNode);
                    } else {
                        range.collapse(true);
                    }
                    sel.removeAllRanges();
                    sel.addRange(range);
                }
            }
        } else if ((sel = document.selection) && sel.type != "Control") {
            // IE < 9
            var originalRange = sel.createRange();
            originalRange.collapse(true);
            sel.createRange().pasteHTML(html);
            if (selectPastedContent) {
                range = sel.createRange();
                range.setEndPoint("StartToStart", originalRange);
                range.select();
            }
        } else {
            document.execCommand('InsertHtml', '', html);
        }
    }

    function set_focus(el) {
        el.focus();
        if (!window.getSelection) {
            var rng, result;
            el.focus();
            rng = document.selection.createRange();
            rng.moveStart('character', -el.innerText.length);
            var text = rng.text;
            for (var i = 0; i < el.innerText.length; i++) {
                if (el.innerText.substring(0, i + 1) == text.substring(text.length - i - 1, text.length)) {
                    result = i + 1;
                }
            }
        } else {
            var range = document.createRange();
            range.selectNodeContents(el);
            range.collapse(false);
            var sel = window.getSelection(); 
            sel.removeAllRanges();
            sel.addRange(range);
        }
    }

    //锁定编辑器中鼠标光标位置。。 //误删，留用;
    // function insertimg(str,editorDomId){
    //     var selection= window.getSelection ? window.getSelection() : document.selection;
    //     var range= selection.createRange ? selection.createRange() : selection.getRangeAt(0);
    //     if (!window.getSelection){
    //         document.getElementById(editorDomId).focus();
    //         var selection= window.getSelection ? window.getSelection() : document.selection;
    //         var range= selection.createRange ? selection.createRange() : selection.getRangeAt(0);
    //         range.pasteHTML(str);
    //         range.collapse(false);
    //         range.select();
    //     }else{
    //         document.getElementById(editorDomId).focus();
    //         range.collapse(false);
    //         var hasR = range.createContextualFragment(str);
    //         var hasR_lastChild = hasR.lastChild;
    //         while (hasR_lastChild && hasR_lastChild.nodeName.toLowerCase() == "br" && hasR_lastChild.previousSibling && hasR_lastChild.previousSibling.nodeName.toLowerCase() == "br") {
    //             var e = hasR_lastChild;
    //             hasR_lastChild = hasR_lastChild.previousSibling;
    //             hasR.removeChild(e)
    //         }
    //         range.insertNode(hasR);
    //         if (hasR_lastChild) {
    //             range.setEndAfter(hasR_lastChild);
    //             range.setStartAfter(hasR_lastChild)
    //         }
    //         selection.removeAllRanges();
    //         selection.addRange(range)
    //     }
    // }
    //往editor里面插入html标签的功能
    function insertHTML(thisEditorDom, sHtml) {
        var isIe = navigator.userAgent.toLowerCase();
        // document.getElementById(thisEditorDom).focus();
        // _insertimg(sHtml,thisEditorDom)
        set_focus(document.getElementById(thisEditorDom));
        pasteHtmlAtCaret(sHtml, false);
    }

    //渲染编辑器editor主体
    function renderFrame(t) {
        var data = $.data(t, 'peEditor');
        peId++;
        var frameDom_one = '<div id="peEditor_' + peId + '" class="editor-content-wrap"  contenteditable="true" style="height:'
            + (data.options.initFrameHeight - 20) + 'px;width:'
            + (data.options.initFrameWidth - 30 ) + 'px;">'
            + (data.options.initContent)
            + '</div>';

        // var frameDom_two = frameDom_one + '</div>';
        var frameDom_two = frameDom_one;
        editorRenderDom.append(frameDom_two);
        // InitEditable(peId);

        //onLoad事件触发
        data.options.onLoad.call({dom: data.peEditor}, data);
        // 定义最后光标对象
        var lastEditRange, userSelection;

        //自定义简介编辑器的paste事件,去除粘贴带的一些标签
        editorRenderDom.find('[contenteditable]').on('paste', function (e) {
            var e = e || window.event;
            e.stopPropagation();
            pasteHandler($(this));
        });
        function pasteHandler(thisDom) {
            try {
                document.execCommand("AutoUrlDetect", false, false);
            } catch (e) {
            }
            setTimeout(function () {
                var content = thisDom.html();
                var valiHTML = ["br"];
                // content = content.replace(/_moz_dirty=""/gi, "").replace(/\[/g, "[[-").replace(/\]/g, "-]]")
                //     .replace(/<\/ ?tr[^>]*>/gi, "[br]").replace(/<\/ ?td[^>]*>/gi, "&nbsp;&nbsp;")
                //     .replace(/<(ul|dl|ol)[^>]*>/gi, "[br]").replace(/<(li|dd)[^>]*>/gi, "[br]").replace(/<p [^>]*>/gi, "[br]")
                //     .replace(new RegExp("<(/?(?:" + valiHTML.join("|") + ")[^>]*)>", "gi"), "[$1]")
                //     .replace(new RegExp('<span([^>]*class="?at"?[^>]*)>', "gi"), "[span$1]")
                //     .replace(/<[^>]*>/g, "").replace(/\[\[\-/g, "[").replace(/\-\]\]/g, "]")
                //     .replace(new RegExp("\\[(/?(?:" + valiHTML.join("|") + "|img|span)[^\\]]*)\\]", "gi"), "<$1>");
                // if (!/firefox/.test(navigator.userAgent.toLowerCase())) {
                //     content = content.replace(/\r?\n/gi, "<br>");
                // }
                content = content.replace(/_moz_dirty=""/gi, "").replace(/\[/g, "[[-").replace(/\]/g, "-]]")
                    .replace(/<\/ ?tr[^>]*>/gi, "").replace(/<\/ ?td[^>]*>/gi, "&nbsp;&nbsp;")
                    .replace(/<(ul|dl|ol)[^>]*>/gi, "").replace(/<(li|dd)[^>]*>/gi, "").replace(/<p [^>]*>/gi, "")
                    .replace(new RegExp("<(/?(?:" + valiHTML.join("|") + ")[^>]*)>", "gi"), "[$1]")
                    .replace(new RegExp('<span([^>]*class="?at"?[^>]*)>', "gi"), "[span$1]")
                    .replace(/<[^>]*>/g, "").replace(/\[\[\-/g, "[").replace(/\-\]\]/g, "]")
                    .replace(new RegExp("\\[(/?(?:" + valiHTML.join("|") + "|img|span)[^\\]]*)\\]", "gi"), "<$1>");
                if (!/firefox/.test(navigator.userAgent.toLowerCase())) {
                    content = content.replace(/\r?\n/gi, "");
                }
                thisDom.html(content);
            }, 1)

        }

        // editorRenderDom.find('[contenteditable]').on('paste',function(e){
        //     // 干掉IE http之类地址自动加链接
        //     try {
        //         document.execCommand("AutoUrlDetect", false, false);
        //     } catch (e) {
        //     }
        //
        //     e.preventDefault();
        //     var text = null;
        //     if (window.clipboardData && clipboardData.setData) {
        //         // IE
        //         text = window.clipboardData.getData('text');
        //         console.log('jin clipData la',text);
        //     } else {
        //         text = (e.originalEvent || e).clipboardData.getData('text/plain');
        //     }
        //     if (document.body.createTextRange) {
        //         if (document.selection) {
        //             console.log('ie selection');
        //             textRange = document.selection.createRange();
        //         } else if (window.getSelection) {
        //             sel = window.getSelection();
        //             var range = sel.getRangeAt(0);
        //
        //             // 创建临时元素，使得TextRange可以移动到正确的位置
        //             var tempEl = document.createElement("span");
        //             tempEl.innerHTML = "&#FEFF;";
        //             range.deleteContents();
        //             range.insertNode(tempEl);
        //             textRange = document.body.createTextRange();
        //             textRange.moveToElementText(tempEl);
        //             tempEl.parentNode.removeChild(tempEl);
        //         }
        //         textRange.text = text;
        //         textRange.collapse(false);
        //         textRange.select();
        //         return false;
        //     } else {
        //         // Chrome之类浏览器
        //         document.execCommand("insertText", false, text);
        //     }
        // });
        //  editorRenderDom.find('[contenteditable]').on('keyup',function(e){
        //      var e = e || window.event;
        //      if (e.keyCode == 13) {
        //          var htmlString = $(this).html();
        //          htmlString  = htmlString.replace(/<\/(div|p)>/gi,"<br/>");///<(div|p)>|<\/(div|p)>/g
        //          htmlString  = htmlString.replace(/<(div|p)>/gi,"");
        //          $(this).html(htmlString);
        //      }
        //
        //  })
    }

    $.fn.peEditor = function (o, p, func) {
        if (typeof o == "string") {
            return $.fn.peEditor.methods[o](this, p, func);
        }
        o = o || {};
        return this.each(function () {
            var data = $.data(this, "peEditor");
            var option;
            if (data) {
                option = $.extend(data.options, o);
            } else {
                option = option = $.extend({}, $.fn.peEditor.defaults, o);
                data = $.data(this, "peEditor", {
                    options: option,
                    peEditor: _$(this),
                    isLoaded: false
                });
            }
            editorRenderDom = $('#' + option.name);
            render(this);
        })
    };

    $.fn.peEditor.methods = {
        //获取编辑器里面带格式的内容
        getContent: function (t) {
            var editorContent = $.trim($(t).find('.editor-content-wrap').html());
            editorContent = editorContent.replace(/<(div|p)>/gi, "");
            editorContent = editorContent.replace(/<\/(div|p)>/gi, "<br/>");
            return editorContent;
        },
        //判断里面是否有内容
        hasContent: function (t) {
            var isEmpty = $.trim($(t).find('.editor-content-wrap').html()).replace(/<br>/, '');
            return isEmpty;
        },
        //设置编辑器里面的内容
        setContent: function (t, content) {
            $(t).find('.editor-content-wrap').html(content);
        },

        insertHtml: function (t, content) {
            var thisEditorID = $(t).find('.editor-content-wrap').attr('id');
            insertHTML(thisEditorID, content);
        }
    };
    $.fn.peEditor.defaults = {
        name: 'peEditor',//同时此区块元素的class类名为'option pe-simple-editor'
        initFrameWidth: 788,
        initFrameHeight: 122,//此高为编辑区域的高度,不包含工具栏的高度
        toolLeftContent: '',//暂时只支持文字
        cls: '',
        baseUrl: pageContext.rootPath,
        imageUrl: '',
        videoUrl: '',
        audioUrl: '',
        initContent: '',
        toolBar: [['image', 'video', 'music', 'magnify']],
        autoHeightEnabled: false,//如果此处开启，则设置的高度仅作为初始高度
        onLoad: function () {
            //每一个渲染之后执行的事件
        }
    }
})(jQuery);
