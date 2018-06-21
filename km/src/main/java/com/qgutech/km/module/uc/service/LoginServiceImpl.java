package com.qgutech.km.module.uc.service;

import com.qgutech.km.utils.MD5Generator;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.redis.PeJedisCommands;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.base.service.I18nService;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.constant.RedisKey;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.utils.PeException;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.annotation.Resource;

/**
 * @author Created by zhangyang on 2016/11/4.
 */
@Service("loginService")
public class LoginServiceImpl extends BaseServiceImpl<User> implements LoginService {
    @Resource
    private UserService userService;
    @Resource
    private I18nService i18nService;
    @Resource
    private UserRedisService userRedisService;

    @Override
    public User getUserByLoginName(String loginName) {
        Assert.hasText(loginName, "loginName is empty when getUserByLoginName");

        if (!existLoginName(loginName)) {//controller层捕获处理
            throw new PeException("login.user.not.exist");
        }

        return getByCriterion(Restrictions.conjunction()
                .add(Restrictions.eq(User._corpCode, ExecutionContext.getCorpCode()))
                .add(Restrictions.disjunction()
                        .add(Restrictions.eq(User._loginName, loginName.trim()))
                        .add(Restrictions.eq(User._userName, loginName.trim()))
                        .add(Restrictions.eq(User._mobile, loginName.trim()))));
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public boolean existLoginName(String loginName) {
        Assert.hasText(loginName, "loginName is empty when existLoginName");

        return userService.exist(Restrictions.conjunction()
                .add(Restrictions.eq(User._corpCode, ExecutionContext.getCorpCode()))
                .add(Restrictions.disjunction()
                        .add(Restrictions.eq(User._loginName, loginName.trim()))
                        .add(Restrictions.eq(User._userName, loginName.trim()))
                        .add(Restrictions.eq(User._mobile, loginName.trim()))));
    }

    @Override
    @Transactional(readOnly = true)
    public JsonResult<User> login(User loginUser) {
        JsonResult<User> jsonResult = new JsonResult<>();
        jsonResult.setSuccess(false);
        //用户名或密码为空
        if (loginUser == null
                || StringUtils.isBlank(loginUser.getLoginName())
                || StringUtils.isBlank(loginUser.getPassword())) {
            jsonResult.setMessage(i18nService.getI18nValue("login.name.password.not.empty"));
            return jsonResult;
        }

        String loginPwd = MD5Generator.getHexMD5(loginUser.getPassword());
        String loginRedisKey = loginUser.getLoginName() + PeConstant.REDIS_DIVISION + loginPwd;
        String userId = PeRedisClient.getSessionJedis().hget(ExecutionContext.getCorpCode(), loginRedisKey);
        if (StringUtils.isBlank(userId)) {
            User user = userService.getByAccount(loginUser.getLoginName());
            if (user == null) {
                jsonResult.setMessage(i18nService.getI18nValue("login.user.not.exist"));
                return jsonResult;
            }

            if (!User.UserStatus.ENABLE.equals(user.getStatus())) {
                jsonResult.setMessage(i18nService.getI18nValue("login.user.forbidden"));
                return jsonResult;
            }

            if (!user.getPassword().equalsIgnoreCase(loginPwd)) {
                jsonResult.setMessage(i18nService.getI18nValue("login.user.not.match"));
                return jsonResult;
            }

            userRedisService.save(user);
            userId = user.getId();
        }

        User user = userRedisService.get(userId, User._userName, User._mobile, User._email,
                User._emailVerify, User._mobileVerify, User._roleType, User._loginName);
        if (user == null) {
            PeRedisClient.getSessionJedis().del(loginRedisKey);
            jsonResult.setMessage(i18nService.getI18nValue("login.user.not.match"));
            return jsonResult;
        }

//        if (!loginUser.getLoginName().equals(user.getLoginName())) {
//            //用户的邮箱未验证
//            if (StringUtils.isNotBlank(user.getEmail()) && user.getEmail().equals(loginUser.getLoginName())
//                    && !BooleanUtils.isTrue(user.getEmailVerify())) {
//                jsonResult.setMessage(i18nService.getI18nValue("login.email.not.verify"));
//                return jsonResult;
//            }
//
//            //用户的手机未验证
//            if (StringUtils.isNotBlank(user.getMobile()) && user.getMobile().equals(loginUser.getMobile())
//                    && !BooleanUtils.isTrue(user.getMobileVerify())) {
//                jsonResult.setMessage(i18nService.getI18nValue("login.mobile.not.verify"));
//                return jsonResult;
//            }
//        }

        //防止重复登录
        String lockKey = RedisKey.LOGIN_LOCK + PeConstant.REDIS_DIVISION
                + user.getCorpCode() + PeConstant.REDIS_DIVISION
                + userId;
        if (!getLock(lockKey, 2)) {
            jsonResult.setMessage(i18nService.getI18nValue("login.repeat.login"));
            return jsonResult;
        }

        PeRedisClient.getSessionJedis().expire(lockKey, 0);
        jsonResult.setSuccess(true);
        jsonResult.setData(user);
        return jsonResult;
    }

    //重复登录锁
    private boolean getLock(String key, int lockExpireSecond) {
        PeJedisCommands jedis = PeRedisClient.getSessionJedis();
        Long lockFlag = jedis.setnx(key, System.currentTimeMillis() + "");
        if (lockFlag != null && lockFlag == 1L) {
            jedis.expire(key, lockExpireSecond);
            //logger.info("==========成功1：第一次进入，没有锁==========");
            return true;
        }

        String millSeconds = jedis.get(key);
        if (millSeconds == null) {
            lockFlag = jedis.setnx(key, System.currentTimeMillis() + "");
            boolean preempted = lockFlag != null && lockFlag == 1L;
            if (preempted) {
                jedis.expire(key, lockExpireSecond);
                //logger.info("==========成功2：检查锁的时间时发现锁刚刚好过期可以抢占==========");
            }
            return preempted;
        }

        long currentMillSeconds = System.currentTimeMillis();
        if (currentMillSeconds - Long.valueOf(millSeconds) >= lockExpireSecond * 1000) {
            String redisLockTime = jedis.getSet(key, currentMillSeconds + "");
            boolean preempted = redisLockTime == null || redisLockTime.equals(millSeconds);
            if (preempted) {
                jedis.expire(key, lockExpireSecond);
                //logger.info("==========成功3：检查锁发现时间已经过期可以抢占==========");
            }
            return preempted;
        }

        return false;
    }
}
