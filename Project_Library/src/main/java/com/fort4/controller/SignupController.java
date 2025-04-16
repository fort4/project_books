package com.fort4.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fort4.dto.MemberDTO;
import com.fort4.mapper.MemberMapper;

@Controller
public class SignupController {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@GetMapping("/join")
	public String joinForm() {
	    return "join";
	}
	
	@GetMapping("/check-id")
	@ResponseBody
	public int checkId(@RequestParam String username) {
	    return memberMapper.checkId(username); // 0이면 사용 가능, 1 이상이면 중복뜨게
	}

	@PostMapping("/join")
	public String join(@ModelAttribute MemberDTO member, RedirectAttributes redirectAttrs) {
	    member.setRole("user");
	    member.setDeleted(false);
	    memberMapper.insertMember(member);
	    
	    redirectAttrs.addFlashAttribute("successMsg", "회원가입이 완료되었습니다!");
	    return "redirect:/index";
	}

	
}
