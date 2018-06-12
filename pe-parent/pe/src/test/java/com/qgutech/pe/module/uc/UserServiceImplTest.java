package com.qgutech.pe.module.uc;

import com.qgutech.pe.base.BaseTests;
import com.qgutech.pe.module.uc.model.User;
import com.qgutech.pe.module.uc.service.UserService;
import org.junit.Test;
import org.springframework.test.annotation.Rollback;

import javax.annotation.Resource;
import java.util.Collections;

/**
 * Created by Administrator on 2016/10/31.
 */
public class UserServiceImplTest extends BaseTests {

    @Resource
    private UserService userService;

    @Test
    @Rollback(false)
    public void testSave() {
        User user = new User();
        user.setUserName("李延成");
        user.setPassword("123456");
        user.setLoginName("liyancheng");
        userService.save(user);
    }

    @Test
    @Rollback(false)
    public void testDelete() {
        userService.updateStatus(Collections.singletonList("4028819d581a235501581a235c680000"), User.UserStatus.ENABLE);
    }

    @Test
    @Rollback(false)
    public void testUpdateOrg() {
        userService.updateOrganize(Collections.singletonList("4028819d581a235501581a235c680000"), "40288119580a584f01580a5857560000");
    }

}
