package com.demisco.fod.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login-page")
public class LoginController {

    @GetMapping
    public String login() {
        return "login";
    }
}
