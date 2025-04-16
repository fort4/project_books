package com.fort4.controller;

import com.fort4.dto.MemberDTO;
import com.fort4.mapper.MemberMapper;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginController extends BaseController {
	
    @Autowired
    private MemberMapper memberMapper;
    
    // 처음 화면(로그인)
    @GetMapping("/index")
    public String index(Model model) {
        return render("index", model);
    }

    @PostMapping("/login")
    public String login(@ModelAttribute MemberDTO input,
                        HttpSession session,
                        Model model) {
        MemberDTO member = memberMapper.login(input.getUsername(), input.getPassword());

        if (member != null) {
            loginUser(session, member);

            if (isAdmin(member)) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/books";  // 일반 사용자용 리다이렉트
            }
        } else {
            model.addAttribute("errorMsg", "아이디 또는 비밀번호가 틀렸습니다.");
            return render("index", model);
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        
        return "redirect:/index";
    }
}
