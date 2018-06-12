#运行环境
jdk8+   
#项目的获取地址：git clone ssh://git@gitlab.qgutech.com/root/pe-parent.git  
方法命名
----
1.  查询方法名 : 查询page-->使用search，并且page参数放在最后;  
查询单个对象-->使用get、getByXxx、getXxxByXxx;  
查询集合例如set、list-->使用list  
查询集合为Map--->使用find  
2.  修改对象方法名 : update、updateByXxx、updateXxx、updateXxxByXxx  
3.  新增对象方法名 : save  
4.  删除对象方法名 : delete  

action 请求路径命名  
-------------
1.学员端请求为：/模块/应用名称/client/方法名  
2.管理员端请求为：/模块/应用名称/manage/方法名  
3.未登录请求统一放在LoginController里面  

id path 规范
----------
id path：父id path.id；如果是根ID时，idPath为id  
redis命名规则  
1. 通用的redis的key直接以项目名作为标示  
2. 特定的功能模块的key以，模块名 + 功能模块名 + 特定标示符 UC_LOGIN_...  

redis 考试中
--------    
1.存放考试对应的试卷模板序号前缀 EXAM_PAPER_examId：map key：paperId value paper  
2.存放考试中学员提交答题记录 EXAM_USER_SUBMIT_examId：map key userId  value Ur  
3.存放待评卷学员提交答题记录 EXAM_USER_MARKING_examId：map key userId  value Ur  
4.存放考试待评卷前缀 EXAM_MARKING_examId：list userIds  
5.考试基本信息前缀 EXAM_INFO_examId：value Ei  
6.考试关联人员 EXAM_USER_examId：map key userId/orgId value 批次ID  
7.强制提交考试队列 FORCE_USER_SUBMIT_examId list userIds  

前后台提交格式
------- 
1.三分钟保存学生答题记录格式如下：  
{key:'ANSWER',status:状态/DOING/SUBMIT/FORCE/INVALID,value:{id:考试ID,cut:更新时间,am:{1:答案,mark:false/true,2:答案,mark:false/true,3:答案...}}}  
使用技术：webSocket ajax轮询（防止webSocket不支持自动切换ajax轮询） 数据传输加密LZString+Base64

文件服务器存储地址说明
----
1.个人头像：  
源图片：公司/模板名称/(图片)/common/年月/(关联ID)/主键ID/o.png
头像：公司/模板名称/(图片)/common/年月/(关联ID)/主键ID/x_y_w_h.png  
2.试题：公司/模板名称/(文件)/common/年月/(关联ID)/主键ID
3.导入、导出、错误模板：  
导入：公司/模板名称/(文件)/template/年月/文件名  
导出：公司/模板名称/(文件)/template/年月/文件名  
错误模板：公司/模板名称/(文件)/template/error/userId/文件名
4.考试  
监控：  
(1)录像：公司/模板名称/(文件)/videotape/年月/examId/批次ID/监考员ID/录像.mp4  
(2)录像截图：公司/模板名称/(文件)/videotape/年月/examId/批次ID/监考员ID/images/UUID.png  
(3)截屏图片：公司/模板名称/(文件)/videotape/年月/examId/批次ID/监考员ID/printImage/主键ID.png
考试随机拍照：  
公司/模板名称/(图片)/photograph/年月/examId/userId/主键ID.png  

类名说明
----
1.用户模块  
model：  
(1)com.qgutech.pe.module.uc.model.Authority 权限路径MODEL  
(2)com.qgutech.pe.module.uc.model.Organize 部门MODEL  
(3)com.qgutech.pe.module.uc.model.Position 岗位MODEL  
(4)com.qgutech.pe.module.uc.model.Role 角色MODEL  
(5)com.qgutech.pe.module.uc.model.RoleAuthority 角色权限MODEL  
(6)com.qgutech.pe.module.uc.model.User 用户管理MODEL  
(7)com.qgutech.pe.module.uc.model.UserPosition 用户岗位MODEL  
(8)com.qgutech.pe.module.uc.model.UserRole 用户角色MODEL  

Service:  
(1)com.qgutech.pe.module.uc.service.AuthorityService 权限Service  
(2)com.qgutech.pe.module.uc.service.LoginService 登录Service  
(3)com.qgutech.pe.module.uc.service.OrganizeService 部门Service  
(4)com.qgutech.pe.module.uc.service.PositionService 岗位Service  
(5)com.qgutech.pe.module.uc.service.RoleAuthorityService 角色权限Service  
(6)com.qgutech.pe.module.uc.service.RoleService 角色Service  
(7)com.qgutech.pe.module.uc.service.UserPositionService 用户岗位Service  
(8)com.qgutech.pe.module.uc.service.UserRedisService 用户redis Service  
(8)com.qgutech.pe.module.uc.service.UserRoleService 用户角色Service  
(8)com.qgutech.pe.module.uc.service.UserService 用户Service  

Controller  
(1)com.qgutech.pe.module.uc.controller.LoginController 登录控制层  
(2)com.qgutech.pe.module.uc.controller.OrganizeController 部门控制层  
(3)com.qgutech.pe.module.uc.controller.PositionController 岗位控制层  
(4)com.qgutech.pe.module.uc.controller.RoleController 角色控制层  
(5)com.qgutech.pe.module.uc.controller.UserController 用户控制层  
(6)com.qgutech.pe.module.uc.controller.UserImportController 导入用户控制层  

2.考试模块  
model：  
(1)com.qgutech.pe.module.ems.model.Exam 考试MODEL  
(2)com.qgutech.pe.module.ems.model.ExamArrange 考试安排MODEL  
(3)com.qgutech.pe.module.ems.model.ExamAuth 考试管理员MODEL  
(4)com.qgutech.pe.module.ems.model.ExamMonitor 考试监控MODEL  
(5)com.qgutech.pe.module.ems.model.ExamResult 考试结果MODEL  
(6)com.qgutech.pe.module.ems.model.ExamResultDetail 考试结果详情MODEL  
(7)com.qgutech.pe.module.ems.model.ExamSetting 考试设置MODEL  
(8)com.qgutech.pe.module.ems.model.ExamUser 考试人员MODEL  
(9)com.qgutech.pe.module.ems.model.IllegalRecord 考试违规MODEL  
(10)com.qgutech.pe.module.ems.model.Item 试题MODEL  
(11)com.qgutech.pe.module.ems.model.ItemBank 题库MODEL  
(12)com.qgutech.pe.module.ems.model.ItemBankAuth 题库授权MODEL  
(13)com.qgutech.pe.module.ems.model.ItemDetail 试题详情(题干等内容)MODEL  
(14)com.qgutech.pe.module.ems.model.JudgeUser 评卷人MODEL  
(15)com.qgutech.pe.module.ems.model.JudgeUserRecord 评卷记录MODEL  
(16)com.qgutech.pe.module.ems.model.Knowledge 知识点MODEL  
(17)com.qgutech.pe.module.ems.model.KnowledgeItem 试题知识点关联MODEL  
(18)com.qgutech.pe.module.ems.model.Paper 试卷MODEL  
(19)com.qgutech.pe.module.ems.model.PaperTemplate 试卷模板MODEL  
(20)com.qgutech.pe.module.ems.model.PaperTemplateAuth 试卷模板授权MODEL  
(21)com.qgutech.pe.module.ems.model.PaperTemplateItem 试卷模板必考题关联MODEL  
(22)com.qgutech.pe.module.ems.model.TemplateStrategy 组卷策略关联题库知识点MODEL  
(23)com.qgutech.pe.module.ems.model.UserExamRecord 学员答题记录MODEL  

Service  
(1)com.qgutech.pe.module.ems.service.ExamArrangeService 考试安排Service  
(2)com.qgutech.pe.module.ems.service.ExamAuthService 考试管理员Service  
(3)com.qgutech.pe.module.ems.service.ExamMonitorService 考试监控Service  
(4)com.qgutech.pe.module.ems.service.ExamRedisService 考试Redis Service  
(5)com.qgutech.pe.module.ems.service.ExamResultDetailService 考试结果详情Service  
(6)com.qgutech.pe.module.ems.service.ExamResultService 考试结果Service  
(7)com.qgutech.pe.module.ems.service.ExamService 考试Service  
(8)com.qgutech.pe.module.ems.service.ExamSettingService 考试设置Service  
(9)com.qgutech.pe.module.ems.service.ExamUserService 考试人员Service  
(10)com.qgutech.pe.module.ems.service.IllegalRecordService 考试违规Service  
(11)com.qgutech.pe.module.ems.service.ItemBankAuthService 题库授权Service  
(12)com.qgutech.pe.module.ems.service.ItemBankService 题库Service  
(13)com.qgutech.pe.module.ems.service.ItemDetailService 试题详情Service  
(14)com.qgutech.pe.module.ems.service.ItemService 试题Service  
(15)com.qgutech.pe.module.ems.service.JudgeUserRecordService 评卷记录Service  
(16)com.qgutech.pe.module.ems.service.JudgeUserService 评卷人Service  
(17)com.qgutech.pe.module.ems.service.KnowledgeItemService 知识点试题关联Service  
(18)com.qgutech.pe.module.ems.service.KnowledgeService 知识点Service  
(19)com.qgutech.pe.module.ems.service.PaperService 试卷Service  
(20)com.qgutech.pe.module.ems.service.ResultReportService 统计报表Service  
(21)com.qgutech.pe.module.ems.service.TemplateAuthService 试卷模板授权Service  
(22)com.qgutech.pe.module.ems.service.TemplateItemService 试卷模板必考题Service  
(23)com.qgutech.pe.module.ems.service.TemplateService 试卷模板Service  
(24)com.qgutech.pe.module.ems.service.TemplateStrategyService 试卷模板组卷策略Service  
(25)com.qgutech.pe.module.ems.service.UserExamRecordService 学员答题记录Service  

Model  
(1)com.qgutech.pe.module.ems.controller.ExamController  考试控制层  
(2)com.qgutech.pe.module.ems.controller.ExamMonitorController  考试监控控制层  
(3)com.qgutech.pe.module.ems.controller.ExamResultController  考试结果控制层  
(4)com.qgutech.pe.module.ems.controller.FrontController 初始化学员端和管理员首页控制层  
(5)com.qgutech.pe.module.ems.controller.ItemBankController  题库控制层  
(6)com.qgutech.pe.module.ems.controller.ItemController 试题控制层  
(7)com.qgutech.pe.module.ems.controller.ItemFileController 试题导入控制层  
(8)com.qgutech.pe.module.ems.controller.JudgeController  评卷控制层  
(9)com.qgutech.pe.module.ems.controller.KnowledgeController  知识点控制层  
(10)com.qgutech.pe.module.ems.controller.ResultReportController  统计报表控制层  
(11)com.qgutech.pe.module.ems.controller.TemplateController  考试模板控制层  

核心类：  
com.qgutech.pe.module.ems.scheduler.EmsScheduler 当key为：  
(1)com.qgutech.pe.constant.RedisKey.EXAM_MARKING  评卷  
(2)com.qgutech.pe.constant.RedisKey.IN_EXAMINATION 更新监控表的考试进行时间以及状态更新  


远程监控:WebRTC 协议 https   
1.穿透服务器 stun服务器搭建  
2.中转服务器 turn服务器搭建  
3.recordRTC.js以及服务搭建 peerjs 
 
peerjs server安装  
PeerJS是一个开源的JavaScript库，目的是允许运行在不同系统上的Web应用程序相互联系。PeerJS开发者称，PeerJS完善了WebRTC，因为作为视频连接协议，WebRTC并没有说明基于WebRTC的客户端应该如何定位连接的用户。   

PeerJS有一个简单的API，允许通过三行代码来实现对等连接。PeerServer作为PeerJS的后端，这是一个基于Node.js的web服务器，这也是开源的。   
依赖nodejs 环境
1.npm install peer  
2.bin/peerjs --port 9000 --key peerjs  
 


定时任务:quartz实现  
1.com.qgutech.pe.base.job.QuartzJobTrigger 实时监听数据库中需要执行的定时任务  
2.com.qgutech.pe.base.job.QuartzExecute 时间到时，中间过度类  
3.com.qgutech.pe.base.scheduler.PeScheduler 当key为：  
  (1)com.qgutech.pe.constant.RedisKey.WAIT_CONSUME_FUNCTION_CODE 处理定时任务真正执行   
