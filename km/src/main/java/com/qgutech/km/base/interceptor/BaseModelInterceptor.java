package com.qgutech.km.base.interceptor;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.BaseModel;
import org.hibernate.CallbackException;
import org.hibernate.EmptyInterceptor;
import org.hibernate.type.Type;

import java.io.Serializable;
import java.util.Date;

public class BaseModelInterceptor extends EmptyInterceptor {

    @Override
    public boolean onSave(Object entity, Serializable id, Object[] state, String[] propertyNames, Type[] types) {
        return audit(entity, state, propertyNames);
    }

    @Override
    public boolean onFlushDirty(Object entity, Serializable id, Object[] currentState, Object[] previousState,
                                String[] propertyNames, Type[] types) throws CallbackException {
        for (int i = 0; i < propertyNames.length; i++) {
            if (BaseModel.UPDATE_TIME.equals(propertyNames[i])) {
                currentState[i] = new Date();
            } else if (BaseModel.UPDATE_BY.equals(propertyNames[i])) {
                currentState[i] = ExecutionContext.getUserId();
            }
        }

        return true;
    }

    private boolean audit(Object entity, Object[] state, String[] propertyNames) {
        if (!(entity instanceof BaseModel)) {
            return false;
        }

        boolean changed = false;
        for (int i = 0; i < propertyNames.length; i++) {
            String propertyName = propertyNames[i];
            if (BaseModel.CREATE_TIME.equals(propertyName)) {
                Object currState = state[i];
                if (currState == null) {
                    state[i] = new Date();
                    changed = true;
                }
            } else if (BaseModel.UPDATE_TIME.equals(propertyName)) {
                Object currState = state[i];
                if (currState == null) {
                    state[i] = new Date();
                    changed = true;
                }
            } else if (BaseModel.CREATE_BY.equals(propertyName)) {
                Object currState = state[i];
                if (currState == null) {
                    state[i] = ExecutionContext.getUserId();
                    changed = true;
                }
            } else if (BaseModel.UPDATE_BY.equals(propertyName)) {
                Object currState = state[i];
                if (currState == null) {
                    state[i] = ExecutionContext.getUserId();
                    changed = true;
                }
            } else if (BaseModel.CORP_CODE.equals(propertyName)) {
                Object currState = state[i];
                if (currState == null) {
                    state[i] = ExecutionContext.getCorpCode();
                    changed = true;
                }
            }
        }

        return changed;
    }
}
