package com.fp.cloud.module.ems.service;

import com.alibaba.fastjson.JSON;
import com.fp.cloud.base.ExecutionContext;
import com.fp.cloud.base.service.BaseServiceImpl;
import com.fp.cloud.module.ems.model.SystemSetting;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

@Service("systemSettingService")
public class SystemSettingServiceImpl extends BaseServiceImpl<SystemSetting>
        implements SystemSettingService {

    @Override
    @Transactional(readOnly = true)
    public SystemSetting getByCorp(SystemSetting.SystemType systemType) {
        if (systemType == null) {
            throw new IllegalArgumentException("The parameter is not valid!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.eq(SystemSetting._corpCode, ExecutionContext.getCorpCode()));
        conjunction.add(Restrictions.eq(SystemSetting._systemType, systemType));
        return getByCriterion(conjunction, SystemSetting._message, SystemSetting._openAppMsg, SystemSetting._id, SystemSetting._systemType, SystemSetting._corpCode);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean checkAppMsg() {
        SystemSetting systemSetting = getByCorp(SystemSetting.SystemType.APPMSG);
        if(systemSetting==null){
            return false;
        }

        return systemSetting.isOpenAppMsg();
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int updateMessage(SystemSetting systemSetting) {
        if (StringUtils.isBlank(systemSetting.getId()) || systemSetting.getSystemType() == null) {
            throw new IllegalArgumentException("The parameter is not valid!");
        }

        SystemSetting dbSystemSetting = get(systemSetting.getId(), SystemSetting._message);
        switch (systemSetting.getSystemType()) {
            case USER:
                if (systemSetting.getUserSetting() != null) {
                    String message = JSON.toJSONString(systemSetting.getUserSetting());
                    dbSystemSetting.setMessage(message);
                } else {
                    dbSystemSetting.setMessage(null);
                }
                break;
            case EXAM:
                if (systemSetting.getExamSetting() != null) {
                    String examSetting = JSON.toJSONString(systemSetting.getExamSetting());
                    dbSystemSetting.setMessage(examSetting);
                } else {
                    dbSystemSetting.setMessage(null);
                }
                break;
            default:
                break;
        }

        dbSystemSetting.setOpenAppMsg(systemSetting.isOpenAppMsg());
        update(dbSystemSetting, SystemSetting._message,SystemSetting._openAppMsg);
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public void saveMessageSetting(SystemSetting systemSetting) {
        if (systemSetting.getSystemType() == null || systemSetting.getSystemType() == null) {
            throw new IllegalArgumentException("Parameters are not valid");
        }

        switch (systemSetting.getSystemType()) {
            case EXAM:
                if (systemSetting.getExamSetting() != null) {
                    String examMessage = JSON.toJSONString(systemSetting.getExamSetting());
                    systemSetting.setMessage(examMessage);
                } else {
                    systemSetting.setMessage(null);
                }

                break;
            case USER:
                if (systemSetting.getUserSetting() != null) {
                    String userMessage = JSON.toJSONString(systemSetting.getUserSetting());
                    systemSetting.setMessage(userMessage);
                } else {
                    systemSetting.setMessage(null);
                }
                break;
            default:
                break;
        }

        save(systemSetting);
    }

    @Override
    @Transactional(readOnly = true)
    public String getMessage(SystemSetting.SystemType systemType) {
        if (systemType == null) {
            throw new IllegalArgumentException("systemType can't be null;");
        }

        SystemSetting systemSetting = getByCorp(systemType);
        if (systemSetting == null || StringUtils.isBlank(systemSetting.getMessage())) {
            return null;
        }

        return systemSetting.getMessage();
    }
}
