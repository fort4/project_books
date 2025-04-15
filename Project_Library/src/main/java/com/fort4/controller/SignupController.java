package com.fort4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fort4.dto.MemberDTO;
import com.fort4.mapper.MemberMapper;

@Controller
public class SignupController {
	
	private MemberMapper memberMapper;
	
	@GetMapping("/join")
	public String joinForm() {
	    return "join";
	}

	@PostMapping("/join")
	public String join(@ModelAttribute MemberDTO member, RedirectAttributes redirectAttrs) {
	    member.setRole("user");
	    member.setDeleted(false);
	    memberMapper.insertMember(member);
	    
	    redirectAttrs.addFlashAttribute("successMsg", "회원가입이 완료되었습니다. 로그인해주세요!");
	    return "redirect:/index";
	}

	
}
