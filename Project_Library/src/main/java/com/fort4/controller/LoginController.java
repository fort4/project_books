package com.fort4.controller;

import com.fort4.dto.MemberDTO;
import com.fort4.mapper.MemberMapper;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginController {
	
    @Autowired
    private MemberMapper memberMapper;

    @GetMapping("/index")
    public String index() {
        return "index";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute MemberDTO input, HttpSession session, Model model) {
        MemberDTO member = memberMapper.login(input.getUsername(), input.getPassword());

        if (member != null) {
            session.setAttribute("loginUser", member);
            session.setMaxInactiveInterval(60 * 60); // 세션 1시간 유지로 설정
            return "redirect:/books";
        } else {
            model.addAttribute("errorMsg", "아이디 또는 비밀번호가 틀렸습니다.");
            return "index";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        
        return "redirect:/index";
    }
}
