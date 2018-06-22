package com.qgutech.km.module.uc.service;

import com.alibaba.fastjson.JSON;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.sfm.service.FileServerService;
import com.qgutech.km.module.uc.model.Organize;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.ReflectUtil;
import com.qgutech.km.base.redis.PeJedisCommands;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * redis 存储用户信息 service impl
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月27日11:28:23
 */
@Service("userRedisService")
public class UserRedisServiceImpl implements UserRedisService {

    @Resource
    private UserService userService;
    @Resource
    private FileServerService fileServerService;

    @Override
    public int remove(String userId) {
        if (StringUtils.isBlank(userId)) {
            return NumberUtils.INTEGER_ZERO;
        }

        User user = get(userId, User._loginName, User._mobile, User._email, User._password);
        if (user == null) {
            return NumberUtils.INTEGER_ZERO;
        }

        removeLoginInfo(user);
        PeRedisClient.getSessionJedis().del(userId);
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    public int remove(List<String> userIds) {
        if (CollectionUtils.isEmpty(userIds)) {
            throw new PeException("UserId list is empty!");
        }

        userIds.forEach(this::remove);
        return userIds.size();
    }

    @Override
    public String save(User user) {
        if (user == null || StringUtils.isBlank(user.getId())) {
            throw new PeException("save user to redis error!");
        }

        remove(user.getId());
        Map<String, String> userMap = new HashMap<>();
        userMap.put(User._userName, user.getUserName());
        userMap.put(User._loginName, user.getLoginName());
        if (StringUtils.isNotBlank(user.getEmail())) {
            userMap.put(User._email, user.getEmail());
            userMap.put(User._emailVerify, BooleanUtils.isTrue(user.getEmailVerify()) ? PeConstant.TRUE : PeConstant.FALSE);
        }

        if (StringUtils.isNotBlank(user.getMobile())) {
            userMap.put(User._mobile, user.getMobile());
            userMap.put(User._mobileVerify, BooleanUtils.isTrue(user.getMobileVerify()) ? PeConstant.TRUE : PeConstant.FALSE);
        }

        userMap.put(User._password, user.getPassword());
        if (StringUtils.isNotBlank(user.getIdCard())) {
            userMap.put(User._idCard, user.getIdCard());
        }

        if (StringUtils.isNotBlank(user.getFacePath())) {
            userMap.put(User._facePath, user.getFacePath());
        }

        if (StringUtils.isNotBlank(user.getEmployeeCode())) {
            userMap.put(User._employeeCode, user.getEmployeeCode());
        }

        if (user.getSexType() != null) {
            userMap.put(User._sexType, user.getSexType().toString());
        }

        if (user.getOrganize() != null) {
            userMap.put(User._organizeAlias, JSON.toJSONString(user.getOrganize()));
        }

        if (user.getRoleType() != null) {
            userMap.put(User._roleType, user.getRoleType().toString());
        }

        userMap.put(User._roleType, user.getRoleType().toString());
        PeRedisClient.getSessionJedis().hmset(user.getId(), userMap);
        saveLoginInfo(user);
        return user.getId();
    }

    @Override
    public List<String> save(List<User> users) {
        if (CollectionUtils.isEmpty(users)) {
            throw new PeException("User list is empty!");
        }

        List<String> userIds = new ArrayList<>(users.size());
        for (User user : users) {
            userIds.add(user.getId());
            save(user);
        }

        return userIds;
    }

    @Override
    public String saveAdmin(String userId) {
        if (StringUtils.isBlank(userId)) {
            throw new PeException("Save admin to redis error!");
        }

        PeRedisClient.getSessionJedis().hset(userId, User._roleType, User.RoleType.ADMIN.toString());
        return userId;
    }

    @Override
    public int removeAdmin(String userId) {
        if (StringUtils.isBlank(userId)) {
            throw new PeException("Remove admin to redis error!");
        }

        PeRedisClient.getSessionJedis().hset(userId, User._roleType, User.RoleType.USER.toString());
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    public int updateLogin(User user) {
        if (user == null || StringUtils.isBlank(user.getId())) {
            throw new PeException("Update user login to redis error!");
        }

        User redisUser = get(user.getId(), User._loginName, User._mobile, User._email, User._password);
        if (redisUser == null) {
            return NumberUtils.INTEGER_ZERO;
        }

        removeLoginInfo(redisUser);
        saveLoginInfo(user);
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    public int updatePwd(String userId, String newPwd) {
        if (StringUtils.isBlank(userId) || StringUtils.isBlank(newPwd)) {
            throw new PeException("UserId or newPwd is blank!");
        }

        User redisUser = get(userId, User._loginName, User._mobile, User._email, User._password);
        if (redisUser == null) {
            return NumberUtils.INTEGER_ZERO;
        }

        removeLoginInfo(redisUser);
        redisUser.setPassword(newPwd);
        saveLoginInfo(redisUser);
        PeRedisClient.getSessionJedis().hset(userId, User._password, newPwd);
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    public int updatePwd(List<String> userIds, String newPwd) {
        if (CollectionUtils.isEmpty(userIds) || StringUtils.isBlank(newPwd)) {
            throw new PeException("UserId list is empty or newPwd is blank!");
        }

        for (String userId : userIds) {
            updatePwd(userId, newPwd);
        }

        return userIds.size();
    }

    @Override
    public int updateOrganize(String userId, Organize organize) {
        if (StringUtils.isBlank(userId) || organize == null) {
            throw new PeException("UserId or organize is blank!");
        }

        PeRedisClient.getSessionJedis().hset(userId, User._organizeAlias, JSON.toJSONString(organize));
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    public int updateOrganize(List<String> userIds, Organize organize) {
        if (CollectionUtils.isEmpty(userIds) || organize == null) {
            return NumberUtils.INTEGER_ZERO;
        }

        for (String userId : userIds) {
            updateOrganize(userId, organize);
        }

        return userIds.size();
    }

    @Override
    public User get(String userId, String... fields) {
        if (StringUtils.isBlank(userId)) {
            return null;
        }

        if (ArrayUtils.isEmpty(fields)) {
            Map<String, String> userMap = PeRedisClient.getSessionJedis().hgetAll(userId);
            if (MapUtils.isEmpty(userMap)) {
                Conjunction conjunction = Restrictions.conjunction();
                conjunction.add(Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()));
                conjunction.add(Restrictions.eq(User.ID, userId));
                conjunction.add(Restrictions.eq(User._status, User.UserStatus.ENABLE));
                User user = userService.getByCriterion(conjunction, User.ID, User._mobile, User._email, User._employeeCode,
                        User._loginName, User._faceFileName, User._faceFileId, User._idCard, User._userName, User._organize,
                        User._organizeName, User._status, User._password, User._roleType);
                if (user == null) {
                    return null;
                }

                if (StringUtils.isNotBlank(user.getFaceFileId())) {
                    String facePath = userService.getFacePath(user.getFaceFileId(), user.getFaceFileName());
                    user.setFacePath(facePath);
                }

                save(user);
                userMap = PeRedisClient.getSessionJedis().hgetAll(userId);
            }

            User user = new User();
            user.setId(userId);
            for (String key : userMap.keySet()) {
                if (User._roleType.equals(key) && StringUtils.isNotBlank(userMap.get(key))) {
                    user.setRoleType(Enum.valueOf(User.RoleType.class, userMap.get(key)));
                    continue;
                }

                if (User._organizeAlias.equals(key)) {
                    user.setOrganize(JSON.parseObject(userMap.get(key), Organize.class));
                    continue;
                }

                if (User._emailVerify.equals(key) || User._mobileVerify.equals(key)) {
                    ReflectUtil.setFieldValue(key, user, PeConstant.TRUE.equals(userMap.get(key)));
                    continue;
                }

                ReflectUtil.setFieldValue(key, user, userMap.get(key));
            }

            return user;
        }

        List<String> values = PeRedisClient.getSessionJedis().hmget(userId, fields);
        if (CollectionUtils.isEmpty(values)) {
            return null;
        }

        User user = new User();
        user.setId(userId);
        for (int index = 0; index < fields.length; index++) {
            if (User._roleType.equals(fields[index]) && StringUtils.isNotBlank(values.get(index))) {
                user.setRoleType(Enum.valueOf(User.RoleType.class, values.get(index)));
                continue;
            }

            if (User._organizeAlias.equals(fields[index])) {
                user.setOrganize(JSON.parseObject(values.get(index), Organize.class));
                continue;
            }

            if (User._emailVerify.equals(fields[index]) || User._mobileVerify.equals(fields[index])) {
                ReflectUtil.setFieldValue(fields[index], user, PeConstant.TRUE.equals(values.get(index)));
                continue;
            }

            ReflectUtil.setFieldValue(fields[index], user, values.get(index));
        }

        return user;
    }

    @Override
    public int updateMobile(String userId, String mobile) {
        if (StringUtils.isBlank(userId) || StringUtils.isBlank(mobile)) {
            throw new PeException("userId or mobile id blank");
        }

        PeJedisCommands redis = PeRedisClient.getSessionJedis();
        String oldMobile = redis.hget(userId, User._mobile);
        String password = redis.hget(userId, User._password);
        redis.hdel(ExecutionContext.getCorpCode(), oldMobile + PeConstant.REDIS_DIVISION + password);
        redis.hset(userId, User._mobile, mobile);
        redis.hset(ExecutionContext.getCorpCode(), mobile + PeConstant.REDIS_DIVISION + password, userId);
        redis.hset(userId, User._mobileVerify, PeConstant.TRUE);
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    public int updateEmail(String userId, String email) {
        if (StringUtils.isBlank(userId) || StringUtils.isBlank(email)) {
            throw new PeException("userId or email id blank");
        }

        PeJedisCommands redis = PeRedisClient.getSessionJedis();
        String oldEmail = redis.hget(userId, User._email);
        String password = redis.hget(userId, User._password);
        redis.hdel(ExecutionContext.getCorpCode(), oldEmail + PeConstant.REDIS_DIVISION + password);
        redis.hset(userId, User._email, email);
        redis.hset(ExecutionContext.getCorpCode(), email + PeConstant.REDIS_DIVISION + password, userId);
        redis.hset(userId, User._emailVerify, PeConstant.TRUE);
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    public int updateUserFace(String userId, String faceFileId, String faceFileName) {
        if (StringUtils.isBlank(userId) || StringUtils.isBlank(faceFileId) || StringUtils.isBlank(faceFileName)) {
            throw new PeException("userId or faceFileId or faceFileName is blank");
        }

        String url = userService.getFacePath(faceFileId, faceFileName);
        if (StringUtils.isBlank(url)) {
            return NumberUtils.INTEGER_ZERO;
        }

        PeRedisClient.getSessionJedis().hset(userId, User._facePath, url);
        return NumberUtils.INTEGER_ONE;
    }

    private void removeLoginInfo(User user) {
        String pwdSuffix = PeConstant.REDIS_DIVISION + user.getPassword();
        if (StringUtils.isNotBlank(user.getLoginName())) {
            PeRedisClient.getSessionJedis().hdel(ExecutionContext.getCorpCode(), user.getLoginName() + pwdSuffix);
        }

        if (StringUtils.isNotBlank(user.getMobile())) {
            PeRedisClient.getSessionJedis().hdel(ExecutionContext.getCorpCode(), user.getMobile() + pwdSuffix);
        }

        if (StringUtils.isNotBlank(user.getEmail())) {
            PeRedisClient.getSessionJedis().hdel(ExecutionContext.getCorpCode(), user.getEmail() + pwdSuffix);
        }
    }

    private void saveLoginInfo(User user) {
        String pwdSuffix = PeConstant.REDIS_DIVISION + user.getPassword();
        if (StringUtils.isNotBlank(user.getLoginName())) {
            PeRedisClient.getSessionJedis().hset(ExecutionContext.getCorpCode(), user.getLoginName() + pwdSuffix, user.getId());
        }

        if (StringUtils.isNotBlank(user.getMobile())) {
            PeRedisClient.getSessionJedis().hset(ExecutionContext.getCorpCode(), user.getMobile() + pwdSuffix, user.getId());
        }

        if (StringUtils.isNotBlank(user.getEmail())) {
            PeRedisClient.getSessionJedis().hset(ExecutionContext.getCorpCode(), user.getEmail() + pwdSuffix, user.getId());
        }
    }
}
