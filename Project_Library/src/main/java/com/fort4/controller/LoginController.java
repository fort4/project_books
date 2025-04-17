package com.fort4.controller;

import com.fort4.dto.MemberDTO;
import com.fort4.mapper.MemberMapper;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginController extends BaseController {

	@Autowired
	private MemberMapper memberMapper;
	
	@GetMapping("/login")
	public String loginForm(HttpSession session, Model model) {
	    return render("member/login", model);
	}
	
	@PostMapping("/login")
	public String login(@RequestParam String username,
	                    @RequestParam String password,
	                    HttpSession session,
	                    RedirectAttributes redirectAttrs,
	                    Model model) {
	    MemberDTO member = memberMapper.findByUsernameAndPassword(username, password);

	    if (member == null || member.isDeleted()) {
	        redirectAttrs.addFlashAttribute("errorMsg", "아이디 또는 비밀번호가 틀렸습니다.");
	        return "redirect:/login";
	    }
	    System.out.println("로그인 정보: " +member);
	    loginUser(session, member); // BaseController의 헬퍼 메서드
	    return render("main/index", model);
	}

}

