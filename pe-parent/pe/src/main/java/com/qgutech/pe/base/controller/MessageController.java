package com.qgutech.pe.base.controller;

import com.alibaba.fastjson.JSON;
import com.qgutech.pe.base.model.Message;
import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.base.service.I18nService;
import com.qgutech.pe.base.service.MessageService;
import com.qgutech.pe.base.vo.JsonResult;
import com.qgutech.pe.utils.PeException;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("message/client")
public class MessageController {
    @Resource
    private MessageService messageService;
    @Resource
    private I18nService i18nService;

    @ResponseBody
    @RequestMapping("searchMyMessage")
    public Page<Message> searchMyMessage(PageParam pageParam) {
        return messageService.search(pageParam);
    }

    @ResponseBody
    @RequestMapping("deleteMessage")
    public JsonResult deleteMessage(String messageId) {
        if (StringUtils.isBlank(messageId)) {
            return new JsonResult(false, "delete.fail");
        }

        messageService.delete(messageId);
        return new JsonResult(true, i18nService.getI18nValue("delete.success"));
    }

    @ResponseBody
    @RequestMapping("batchDeleteMessage")
    public JsonResult batchDeleteMessage(String messageId) {
        try {
            List<String> messageIds = JSON.parseArray(messageId, String.class);
            messageService.delete(messageIds);
            return new JsonResult(true, i18nService.getI18nValue("delete.success"));
        } catch (PeException e) {
            return new JsonResult(false, e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping("markReadMessage")
    public JsonResult markReadMessage(String messageId) {
        List<String> messageIds = Collections.singletonList(messageId);
        messageService.markReadMessage(messageIds);
        return new JsonResult(true, i18nService.getI18nValue("success.mark.read"));
    }

    @ResponseBody
    @RequestMapping("batchMarkReadMessage")
    public JsonResult batchMarkReadMessage(String messageId) {
        List<String> messageIds = JSON.parseArray(messageId, String.class);
        messageService.markReadMessage(messageIds);
        return new JsonResult(true, i18nService.getI18nValue("success.mark.read"));
    }
}
