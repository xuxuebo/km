/*!
 * gulp
 * $ npm install gulp gulp-sass gulp-autoprefixer gulp-jshint gulp-uglify gulp-imagemin  gulp-rename gulp-concat gulp-notify gulp-cache gulp-header gulp-livereload  gulp-clean-css gulp-connect --save-dev
 */
// Load plugins
var gulp = require('gulp'),
    sass = require('gulp-sass'),
    autoPreFixer = require('gulp-autoprefixer'),
    jshint = require('gulp-jshint'),
    uglify = require('gulp-uglify'),
    imageMin = require('gulp-imagemin'),
    rename = require('gulp-rename'),
    concat = require('gulp-concat'),
    notify = require('gulp-notify'),
    cache = require('gulp-cache'),
    rev = require('gulp-rev'),
    revCollector = require('gulp-rev-collector'),
    header = require('gulp-header'),
    liveReload = require('gulp-livereload'),
    cleanCss = require('gulp-clean-css'),
    connect = require('gulp-connect'),
    shell = require('gulp-shell'),
    gulpSSH = require('gulp-ssh'),
    sftp = require('gulp-sftp');


var cfg = {
    srcPath:'../',
    ajaxPath:'',
    assetsPath:'web-static/proExam/',
    afterCssFile:'gulpStatic/css/',
    afterJsFile:'gulpStatic/js/'
//    assetsAdminPath:'../../release/assets/admin/'
};
var JSFILES = {
        jQuery : [
            //jQuery
            'web-static/proExam/js/plugins/jquery-1.9.1.min.js'
        ],

        jQueryPlugins : [
            // jQuery Plugins  , 不包含hightcharts
              'web-static/proExam/js/plugins/html5.js'
            , 'web-static/proExam/js/plugins/media/video_dev.js'
            , 'web-static/proExam/js/plugins/jquery.ztree.core.js'
            , 'web-static/proExam/js/plugins/jquery.ztree.exedit.js'
            , 'web-static/proExam/js/plugins/jquery.ztree.excheck.js'
            , 'web-static/proExam/js/plugins/jquery.underscore-min.js'
            , 'web-static/proExam/js/plugins/jquery.pagination.js'
            , 'web-static/proExam/js/plugins/jquery.webuploader.js'
            , 'web-static/proExam/js/plugins/jquery-peGrid.js'
            , 'web-static/proExam/js/plugins/layer/layer.js'
            , 'web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js'
            , 'web-static/proExam/js/plugins/viewer.js'
            , 'web-static/proExam/js/plugins/jquery.easydropdown.js'
            , 'web-static/proExam/js/plugins/jquery.moment.js'
            , 'web-static/proExam/js/plugins/jquery.validate.js'
            , 'web-static/proExam/js/plugins/zclip/jquery.zclip.js'
            , 'web-static/proExam/js/plugins/idangerous.swiper2.7.6.js'
            , 'web-static/proExam/js/peEditor/pe_simple_editor.js'

        ],
        /*学员端考试页面专用插件js*/
        examIngPlugins : [
              'web-static/proExam/js/plugins/html5.js'
            , 'web-static/proExam/js/plugins/viewer.js'
            , 'web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js'
            , 'web-static/proExam/carmera/jquery.webcam.js'
            , 'web-static/proExam/js/plugins/media/video_dev.js'
            , 'web-static/proExam/js/plugins/idangerous.swiper2.7.6.js'
            , 'web-static/proExam/js/lz-string-1.4.4.js'
        ],
        /*学员端考试自定义的js*/
        examIngCompleteSelfJs:[
             'web-static/proExam/js/baseExam.js'
            ,'web-static/proExam/js/exam.js'
        ],
        examIngMarkingSelfJs:[
             'web-static/proExam/js/baseExam.js'
            ,'web-static/proExam/js/markingExam.js'
        ],

        base : [
            'web-static/proExam/js/pro_exam_base.js'
        ]
    },
    CSSFILES = {
        /*总体的css*/
        style : [
              'web-static/proExam/css/plugins/jquery.mCustomScrollbar.css'
            , 'web-static/proExam/css/plugins/jquery.zTreeStyle.css'
            , 'web-static/proExam/css/plugins/pagination.css'
            , 'web-static/proExam/css/plugins/video-js.css'
            , 'web-static/proExam/css/plugins/viewer.min.css'
            , 'web-static/proExam/css/plugins/webuploader.css'
            , 'web-static/proExam/css/plugins/easydropdown.css'
            , 'web-static/proExam/css/plugins/sui-append.css'
            , 'web-static/proExam/js/peEditor/pe_editor.css'
            , 'web-static/proExam/css/iconfont.css'
            , 'web-static/proExam/css/pe-common.css'
        ],
        /*学员端考试页面专用插件css*/
        examIngPluginsStyle:[
              'web-static/proExam/css/plugins/jquery.mCustomScrollbar.css'
            , 'web-static/proExam/css/plugins/swiper3.min.css'
            , 'web-static/proExam/css/plugins/video-js.css'
            , 'web-static/proExam/css/plugins/viewer.min.css'
            , 'web-static/proExam/css/iconfont.css'
        ],
        base : [
            'web-static/proExam/css/pro_exam_base.css'
        ]
    };
var css_base = CSSFILES.style.concat(CSSFILES.base),
    css_plugin_exam = CSSFILES.examIngPluginsStyle,
    js_base  = JSFILES.base,
    js_plugin = JSFILES.jQueryPlugins,
    js_examIngPlugins = JSFILES.examIngPlugins,
    js_all = js_plugin.concat(js_base);

//云环境配置
var config = {
    /*host: '120.26.130.77',*/
    host: '192.168.0.53',
    port: 22,
    username: 'web',
    /*password: 'web.21tb',*/
    password: 'web.123',
    remotePath:'/web/eln4share/pe/web-static/proExam/css'
};

var SSHObj = new gulpSSH({
    ignoreErrors: false,
    sshConfig: config
});
// gulp.task('sftp-write', ['zip'],function () {
//     return gulp.src('default/edition/dist/wx.zip')
//         .pipe(SSHObj.sftp('write', '/web/eln4share/web-static/proExam/css/pe.zip'));
// });
gulp.task('shell-css', function () {
    return SSHObj
        .shell(['cd /web/eln4share/web-static/proExam/css','unzip -uo wx.zip','rm -fv wx.zip'], {filePath: 'wx.zip'})
        .pipe(gulp.dest('logs'));
});
// gulp.task('upload', function () {
//     var workDirectory = 'xxx';
//     return gulp.src( workDirectory + '/**' )
//         .pipe(sftp({
//             host: config.host,
//             user: config.user,
//             port: config.port,
//             pass: config.pass,
//             remotePath: config.remotePath+objectDirectoryName
//         }));
// });
/*JS 压缩*/
// 压缩基础的peBaseJs js
gulp.task('peBaseJs', ['jsCheck'],function() {
    return gulp.src(js_base)
        .pipe(uglify(
            {
                mangle: {except: ['for' ,'class' ,'module' ,'$']},//排除混淆关键字
                compress: true//类型：Boolean 默认：true 是否完全压缩

            }
        ))
        .pipe(concat('pro_exam_base.js'))
        .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
        .pipe(gulp.dest('gulpStatic/js/'))
        .pipe(notify({ message: 'preBaseScripts task complete' }));
});
// 压缩基础的userControl js
gulp.task('userControlMin', ['jsCheck'],function() {
    return gulp.src('web-static/proExam/js/user_control.js')
        .pipe(uglify(
            {
                mangle: {except: ['for' ,'class' ,'module' ,'$']},//排除混淆关键字
                compress: true//类型：Boolean 默认：true 是否完全压缩

            }
        ))
        .pipe(concat('user_control.js'))
        .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
        .pipe(gulp.dest('gulpStatic/js/'))
        .pipe(notify({ message: 'userControlMin task complete' }));
});
// 临时用的，压缩基础的考试用 js
gulp.task('examIngBaseJs', ['jsCheck'],function() {
    return gulp.src('web-static/proExam/js/baseExam.js')
        .pipe(uglify(
            {
                mangle: {except: ['for' ,'class' ,'module' ,'$']},//排除混淆关键字
                compress: true//类型：Boolean 默认：true 是否完全压缩
            }
        ))
        .pipe(concat('baseExam.js'))
        .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
        .pipe(gulp.dest('gulpStatic/js/'))
        .pipe(notify({ message: 'examIngBaseJs task complete' }));
});

//JS-总体的压缩插件pePluginJs压缩，并没有包括全部
gulp.task('pePluginJs', ['jsCheck'],function() {
    return gulp.src(js_plugin)
        .pipe(uglify(
            {
                mangle: true,//排除混淆关键字
                compress: true
            }
        ))
        .pipe(concat('pro_exam_plugin_min.js'))
        .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
        .pipe(gulp.dest('gulpStatic/js/'))
        .pipe(notify({ message: 'prePluginScripts task complete' }));
});
//JS-学员端考试过程中的js,压缩插件userPluginJs压缩
gulp.task('examIngJsPlugins',function() {
    return gulp.src(js_examIngPlugins)
        .pipe(uglify(
            {
                mangle: true,//排除混淆关键字
                compress: true
            }
        ))
        .pipe(concat('examIng_plugin_min.js'))
        .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
        .pipe(gulp.dest('gulpStatic/js/'))
        .pipe(notify({ message: 'examIngPluginsScripts task complete' }));
});

//js layerjs 压缩
gulp.task('jsLayerMin',function() {
    return gulp.src('web-static/proExam/js/plugins/layer/layer.js')
        .pipe(uglify(
            {
                mangle: true,//排除混淆关键字
                compress: true
            }
        ))
        .pipe(concat('layer.js'))
        .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
        .pipe(gulp.dest('gulpStatic/js/'))
        .pipe(notify({ message: 'jsLayerMin task complete' }));
});
//js检测
gulp.task('jsCheck', function() {
    return gulp.src([cfg.assetsPath +'js/*.js'])
        .pipe(jshint())
        .pipe(jshint.reporter('default'))
        .pipe(notify({ message: 'Scripts task complete' }));
});


/*CSS  压缩*/
// CSS-压缩插件的css
gulp.task('pePluginCss',function() {
    return gulp.src(CSSFILES.style)
        .pipe(cleanCss({
            "compatibility": "ie7"
        }))
        .pipe(concat('pro_exam_plugin_min.css'))
        .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
        .pipe(gulp.dest('gulpStatic/css/'))
        .pipe(notify({ message: 'proPluginsCss task complete' }));
});

/*CSS-压缩 学员端 考试 过程的插件 css*/
gulp.task('examIngCssPlugins',function() {
    return gulp.src(css_plugin_exam)
        .pipe(cleanCss({
            "compatibility": "ie7"
        }))
        .pipe(concat('examIng_plugin_min.css'))
        .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
        .pipe(gulp.dest('gulpStatic/css/'))
        .pipe(notify({ message: 'examIngPlugins task complete' }));
});
/*CSS-压缩 学员端 考试 过程的exam.css的压缩*/
gulp.task('examIngSelfCss',function() {
    return gulp.src(cfg.assetsPath + 'css/exam.css')
        .pipe(cleanCss({
            "compatibility": "ie7"
        }))
        .pipe(concat('exam.css'))
        .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
        .pipe(gulp.dest('gulpStatic/css/'))
        .pipe(notify({ message: 'exam_minCSS task complete' }));
});

//CSS- 压缩基本的 css
gulp.task('peBaseCss',function() {
    return gulp.src(CSSFILES.base)
        .pipe(cleanCss({
            "compatibility": "ie7"
        }))
        .pipe(concat('pro_exam_base.css'))
        .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
        .pipe(gulp.dest('gulpStatic/css/'))
        .pipe(notify({ message: 'proBaseCss task complete' }));
});

gulp.task('cssVersion', function() {                                //- 创建一个名为 concat 的 task
    gulp.src(cfg.afterCssFile + '*.css')    //- 需要处理的css文件，放到一个字符串数组里
        .pipe(rev())                                            //- 文件名加MD5后缀
        .pipe(gulp.dest('gulpStatic/cssVer/'))                               //- 输出文件本地
        .pipe(rev.manifest())                                   //- 生成一个rev-manifest.json
        .pipe(gulp.dest('gulpStatic/rev/'));                              //- 将 rev-manifest.json 保存到 rev 目录内
});


//CSS- 压缩基本的 user.css
gulp.task('peUserCss',function() {
    return gulp.src(cfg.assetsPath + 'css/user.css')
        .pipe(cleanCss({
            "compatibility": "ie7"
        }))
        .pipe(concat('user.css'))
        .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
        .pipe(gulp.dest('gulpStatic/css/'))
        .pipe(notify({ message: 'peUserCss task complete' }));
});

gulp.task('cssVersion', function() {                                //- 创建一个名为 concat 的 task
    gulp.src(cfg.afterCssFile + '*.css')    //- 需要处理的css文件，放到一个字符串数组里
        .pipe(rev())                                            //- 文件名加MD5后缀
        .pipe(gulp.dest('gulpStatic/cssVer/'))                               //- 输出文件本地
        .pipe(rev.manifest())                                   //- 生成一个rev-manifest.json
        .pipe(gulp.dest('gulpStatic/rev/'));                              //- 将 rev-manifest.json 保存到 rev 目录内
});


gulp.task('default', function () {
    gulp.start('examIngSelfCss', 'peBaseCss', 'peUserCss', 'peBaseJs', 'examIngBaseJs');
});



// // 压缩lecture images
// gulp.task('preImages',function() {
//     return gulp.src([ 'images/*'])
//         .pipe(cache(imageMin({ optimizationLevel: 3, progressive: true, interlaced: true })))
//         .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
//         .pipe(gulp.dest(cfg.assetsPath+'img/'))
//         .pipe(notify({ message: 'lecturerImages task complete' }));
// });
//
// gulp.task('parseSass', function() {
//     return gulp.src(['front/css/tbc_lecturer_main.scss'])
//         .pipe(sass())
//         .pipe(autoPreFixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'))
//         .pipe(gulp.dest('front/css'))
//         .pipe(notify({ message: 'sass parse task complete' }));
// });
// gulp.task('parseAdminSass', function() {
//     return gulp.src(['admin/css/tbc_lecturer_main.scss'])
//         .pipe(sass())
//         .pipe(autoPreFixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'))
//         .pipe(gulp.dest('admin/css'))
//         .pipe(notify({ message: 'sass parse task complete' }));
// });

// // Images 压缩
// gulp.task('images', function() {
//     return gulp.src('front/img/*')
//         .pipe(cache(imageMin({ optimizationLevel: 3, progressive: true, interlaced: true })))
//         .pipe(gulp.dest(cfg.assetsPath+'img'))
//         .pipe(gulp.dest('front/img/'))
//         .pipe(notify({ message: 'Images task complete' }));
// });
//
// gulp.task('styles', function() {
//     return  gulp.src([
//         cfg.ajaxPath+'jt.timepicker/1.7.0/jquery.timepicker.css',
//         'front/css/datepicker.css',
//         'front/css/perfect-scrollbar.css',
//         cfg.srcPath+'common-v4/css/i18n.css',
//         cfg.srcPath+'common-v4/css/normalize.css',
//         cfg.srcPath+'common-v4/css/ui-dialog.css',
//         'front/css/dialog.css',
//         'front/css/main.css'])
//         .pipe(minifyCss({"compatibility": "ie8"}))
//         .pipe(concat('tbc-tms.min.css'))
//         .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
//         .pipe(gulp.dest(cfg.assetsPath+'css/'))
//         .pipe(notify({ message: 'Styles task complete' }));
// });

// gulp.task('clean-styles', function() {
//     return gulp.src([
//         cfg.ajaxPath+'jt.timepicker/1.7.0/jquery.timepicker.css',
//         'front/css/datepicker.css',
//         'front/css/perfect-scrollbar.css',
//         cfg.srcPath+'common-v4/css/i18n.css',
//         cfg.srcPath+'common-v4/css/normalize.css',
//         cfg.srcPath+'common-v4/css/ui-dialog.css',
//         'front/css/dialog.css',
//         'front/css/main.css'])
//         .pipe(cleanCss({compatibility: 'ie8'}))
//         .pipe(concat('tbc-tms.min.css'))
//         .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
//         .pipe(gulp.dest(cfg.assetsPath+'css/'))
//         .pipe(notify({ message: 'Styles task complete' }));
// })


//
// // 压缩base js
// gulp.task('scriptsBase',function() {
//     return gulp.src([
//         cfg.ajaxPath+'jquery/1.7.2/jquery.min.js',
//         cfg.ajaxPath+'jquery-cookie/1.4.1/jquery.cookie.min.js',
//         cfg.srcPath+'common-v4/js/initAppId.js',
//         cfg.srcPath+'common-v4/js/i18n.js'])
//         .pipe(concat('tbc-cal-base.min.js'))
//         .pipe(uglify())
//         .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
//         .pipe(gulp.dest(cfg.assetsPath+'js/'))
//         .pipe(notify({ message: 'Scripts task complete' }));
// });

//
//
// //解析sass
// gulp.task('w-front', function() {
//     // Watch .scss files
//     gulp.watch('front/css/*.scss', ['parseSass']);
//     // Watch any files in assets/, reload on change
//     liveReload.listen();
//     gulp.watch(['front/css/*']).on('change', liveReload.changed);
// });
// gulp.task('w-admin', function() {
//     // Watch .scss files
//     gulp.watch('admin/css/*.scss', ['parseAdminSass']);
//     // Watch any files in assets/, reload on change
//     liveReload.listen();
//     gulp.watch(['admin/css/*']).on('change', liveReload.changed);
// });
//
// // Default task
// gulp.task('front-release', function() {
//     gulp.start('styles', 'scripts', 'images');
// });
//
// gulp.task('front-js',function() {
//     gulp.start('scripts');
// });
//
// gulp.task('front-css',function() {
//     gulp.start('styles');
// });
//
//
// gulp.task('c-styles', function() {
//     return  gulp.src([
//         cfg.srcPath+'common-v4/css/i18n.css',
//         'admin/css/main.css'])
//         .pipe(minifyCss())
//         .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
//         .pipe(gulp.dest(cfg.assetsAdminPath+'css/'))
//         .pipe(notify({ message: 'Styles task complete' }));
// });
// gulp.task('c-scripts',function() {
//     return gulp.src([
//         cfg.srcPath+'common-v4/js/initAppId.js',
//         cfg.srcPath+'common-v4/js/i18n.js'])
//         .pipe(uglify())
//         .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
//         .pipe(gulp.dest(cfg.assetsAdminPath+'js/'))
//         .pipe(notify({ message: 'Scripts task complete' }));
// });
// gulp.task('c-images', function() {
//     return gulp.src('admin/img/*')
//         .pipe(cache(imageMin({ optimizationLevel: 3, progressive: true, interlaced: true })))
//         .pipe(gulp.dest(cfg.assetsAdminPath+'img'))
//         .pipe(gulp.dest('admin/img/'))
//         .pipe(notify({ message: 'Images task complete' }));
// });
// gulp.task('admin-release', function() {
//     gulp.start('c-styles', 'c-scripts', 'c-images');
// });
//
// gulp.task('admin-css', function() {
//     gulp.start('c-styles');
// });
//
// gulp.task('webserver',function(){
//     connect.server({
//         livereload:true
//     });
// });
//
// gulp.task('default',['webserver']);
//
// gulp.task('webtask',function(){
//     connect.server({
//         livereload:true
//     });
// });
