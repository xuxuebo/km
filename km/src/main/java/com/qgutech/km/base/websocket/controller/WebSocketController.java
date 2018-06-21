package com.qgutech.km.base.websocket.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/websocket")//测试
public class WebSocketController {

    @RequestMapping("toClient")
    public String toClient() {
        return "client";
    }

    @RequestMapping("toPage")
    public String toPage() {
        return "page";
    }

    @ResponseBody
    @RequestMapping("send")
    public String send(String msg) {
        return "page";
    }
}