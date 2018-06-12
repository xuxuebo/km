package com.qgutech.pe.module.mobile.uc;

import com.qgutech.pe.base.ExecutionContext;
import com.qgutech.pe.base.controller.BaseController;
import com.qgutech.pe.base.vo.JsonResult;
import com.qgutech.pe.module.uc.model.User;
import com.qgutech.pe.module.uc.service.UserService;
import com.qgutech.pe.utils.PeException;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller("mobileUserController")
@RequestMapping("mobile/user")
public class UserController extends BaseController {

    @Resource
    private UserService userService;

    @ResponseBody
    @RequestMapping("getUserInfo")
    public User getUserInfo() {
        return userService.get(ExecutionContext.getUserId());
    }

    @ResponseBody
    @RequestMapping("updatePwd")
    public JsonResult<User> updatePwd(String newPwd, String oldPwd) {
        try {
            userService.updatePwd(newPwd, oldPwd, ExecutionContext.getUserId());
            return new JsonResult<>(true, JsonResult.SUCCESS);
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping("checkMyMobile")
    public JsonResult<User> checkMyMobile(String mobile,String passWord) {
        if(StringUtils.isNotBlank(passWord)){
            Boolean hasExist = userService.checkUserPassWord(passWord);
            if(!hasExist){
                return new JsonResult<>(false,"输入密码不正确！");
            }
        }
        return super.checkMyMobile(mobile);
    }

    @ResponseBody
    @RequestMapping("getBindMobileCode")
    public JsonResult<User> getBindMobileCode(String mobile) {
        return super.bindLoginMobile(mobile);
    }

    @ResponseBody
    @RequestMapping("bindMobile")
    public JsonResult<User> bindMobile(String mobile, String verifyCode) {
        return super.bindMobile(mobile, verifyCode);
    }

    @ResponseBody
    @RequestMapping("updateMobile")
    public JsonResult<User> updateMobile(String password, String mobile, String verifyCode) {
        if (StringUtils.isBlank(mobile) || StringUtils.isBlank(verifyCode)) {
            throw new IllegalArgumentException("Checking info is illegal!");
        }

        JsonResult<User> jsonResult = checkPwd(password);
        if (!jsonResult.isSuccess()) {
            return jsonResult;
        }

        return super.bindMobile(mobile, verifyCode);
    }
}
