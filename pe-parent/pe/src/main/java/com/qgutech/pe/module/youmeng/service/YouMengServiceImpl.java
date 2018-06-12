package com.qgutech.pe.module.youmeng.service;

import com.alibaba.fastjson.JSON;
import com.qgutech.pe.constant.MessageConstant;
import com.qgutech.pe.constant.PeConstant;
import com.qgutech.pe.module.ems.model.Exam;
import com.qgutech.pe.module.ems.model.ExamArrange;
import com.qgutech.pe.module.ems.model.ExamMonitor;
import com.qgutech.pe.module.ems.service.ExamMonitorService;
import com.qgutech.pe.module.ems.service.ExamService;
import com.qgutech.pe.module.youmeng.AndroidNotification;
import com.qgutech.pe.module.youmeng.Notification;
import com.qgutech.pe.module.youmeng.PushClient;
import com.qgutech.pe.module.youmeng.YouMengService;
import com.qgutech.pe.module.youmeng.android.AndroidCustomizedcast;
import com.qgutech.pe.module.youmeng.ios.IOSCustomizedcast;
import com.qgutech.pe.utils.LogUtil;
import com.qgutech.pe.utils.PeDateUtils;
import com.qgutech.pe.utils.PropertiesUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.logging.Log;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author: xiaolong@hf
 * @since: 2018/5/9 9:27
 */
@Service("youMengService")
public class YouMengServiceImpl implements YouMengService {
    private static final Log LOG = LogUtil.getLog();
    private PushClient client = new PushClient();
    public static String appKey = PropertiesUtils.getEnvProp().getProperty("youmeng.android.appKey");
    public static String appMaster = PropertiesUtils.getEnvProp().getProperty("youmeng.android.app.master.secret");
    public static String iosAppKey = PropertiesUtils.getEnvProp().getProperty("youmeng.ios.appKey");
    public static String iosAppMaster = PropertiesUtils.getEnvProp().getProperty("youmeng.ios.app.master.secret");

    @Override
    public boolean sendAndroidBroadcast(Notification notification) throws Exception {
        AndroidCustomizedcast androidCustomizedcast = new AndroidCustomizedcast(appKey, appMaster);
        androidCustomizedcast.setAlias(notification.getAlias(), notification.getAlias_type());
        androidCustomizedcast.setDescription(notification.getDescription());
        androidCustomizedcast.setTicker(notification.getTicker());
        androidCustomizedcast.setText(notification.getText());
        androidCustomizedcast.setTitle(notification.getTitle());
        androidCustomizedcast.setAfterOpenAction(AndroidNotification.AfterOpenAction.go_custom);
        androidCustomizedcast.goCustomAfterOpen(JSON.toJSONString(notification));
        androidCustomizedcast.setDisplayType(notification.getDisplayType());
        String environmentModel = PropertiesUtils.getEnvProp().getProperty("youmeng.environmentModel");
        if(BooleanUtils.toBoolean(environmentModel)){
            androidCustomizedcast.setProductionMode();
        }else{
            androidCustomizedcast.setTestMode();
        }

        androidCustomizedcast.setExpireTime(PeDateUtils.format(DateUtils.addDays(new Date(), 3), PeDateUtils.FORMAT_YYYY_MM_DD_HH_MM_SS));
        LOG.info("Push message to Umeng"+notification.getTicker());
        return client.send(androidCustomizedcast);
    }

    @Override
    public boolean sendAndroidBroadcastByFile(Notification notification) throws Exception {
        AndroidCustomizedcast androidCustomizedcast = new AndroidCustomizedcast(appKey, appMaster);
        androidCustomizedcast.setExpireTime(PeDateUtils.format(DateUtils.addDays(new Date(), 3), PeDateUtils.FORMAT_YYYY_MM_DD_HH_MM_SS));
        androidCustomizedcast.setDescription(notification.getDescription());
        androidCustomizedcast.setTicker(notification.getTicker());
        androidCustomizedcast.setText(notification.getText());
        androidCustomizedcast.setTitle(notification.getTitle());
        androidCustomizedcast.goAppAfterOpen();
        androidCustomizedcast.setDisplayType(notification.getDisplayType());
        androidCustomizedcast.goCustomAfterOpen(JSON.toJSONString(notification));
        String environmentModel = PropertiesUtils.getEnvProp().getProperty("youmeng.environmentModel");
        if(BooleanUtils.toBoolean(environmentModel)){
            androidCustomizedcast.setProductionMode();
        }else{
            androidCustomizedcast.setTestMode();
        }
        String[] userIds = notification.getAlias().split(PeConstant.COMMA);
        StringBuffer contentBuffer = new StringBuffer();
        for (String alias : userIds) {
            contentBuffer.append(alias);
            contentBuffer.append("\n");    // don't forget the return character
        }

        String fileId = client.uploadContents(appKey, appMaster, contentBuffer.toString());
        if (StringUtils.isBlank(fileId)) {
            LOG.error("Exception was accured when upload content to Umeng");
            return false;
        }

        androidCustomizedcast.setFileId(fileId, MessageConstant.EMS_YOUMENG_ANDROID_ALIAS_TYPE);
        androidCustomizedcast.setStartTime(notification.getStartTime());
        return client.send(androidCustomizedcast);

    }

    @Override
    public boolean sendIOSCustomizedcast(Notification notification) throws Exception {
        IOSCustomizedcast customizedcast = new IOSCustomizedcast(iosAppKey, iosAppMaster);
        customizedcast.setAlias(notification.getAlias(), notification.getAlias_type());
        customizedcast.setAlert(notification.getTicker());
        customizedcast.setBadge(0);
        customizedcast.setSound("default");
        String environmentModel = PropertiesUtils.getEnvProp().getProperty("youmeng.environmentModel");
        if(BooleanUtils.toBoolean(environmentModel)){
            customizedcast.setProductionMode();
        }else{
            customizedcast.setTestMode();
        }
        customizedcast.setDescription(JSON.toJSONString(notification));
        customizedcast.setCustomizedField("examData",JSON.toJSONString(notification));
        customizedcast.setExpireTime(PeDateUtils.format(DateUtils.addDays(new Date(), 3), PeDateUtils.FORMAT_YYYY_MM_DD_HH_MM_SS));
        return client.send(customizedcast);
    }

    @Override
    public boolean sendIOSCustomizedcastByFile(Notification notification) throws Exception {
        IOSCustomizedcast customizedcast = new IOSCustomizedcast(iosAppKey, iosAppMaster);
        customizedcast.setAlert(notification.getTicker());
        customizedcast.setBadge(0);
        customizedcast.setSound("default");
        String environmentModel = PropertiesUtils.getEnvProp().getProperty("youmeng.environmentModel");
        if(BooleanUtils.toBoolean(environmentModel)){
            customizedcast.setProductionMode();
        }else{
            customizedcast.setTestMode();
        }
        customizedcast.setExpireTime(PeDateUtils.format(DateUtils.addDays(new Date(), 3), PeDateUtils.FORMAT_YYYY_MM_DD_HH_MM_SS));
        String[] userIds = notification.getAlias().split(PeConstant.COMMA);
        customizedcast.setDescription("EMS_MESSAGE_NOTICE!");
        StringBuffer contentBuffer = new StringBuffer();
        for (String alias : userIds) {
            contentBuffer.append(alias);
            contentBuffer.append("\n");    // don't forget the return character
        }

        String fileId = client.uploadContents(appKey, appMaster, contentBuffer.toString());
        if (StringUtils.isBlank(fileId)) {
            LOG.error("Exception was accured when upload content to Umeng");
        }
        customizedcast.setStartTime(notification.getStartTime());
        customizedcast.setFileId(fileId, MessageConstant.EMS_YOUMENG_ANDROID_ALIAS_TYPE);
        return client.send(customizedcast);
    }

    @Override
    @Transactional(readOnly = true,rollbackFor = Exception.class)
    public boolean sendExamMessage(String examId) throws Exception {

        return false;
    }

}
