package com.fort4.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fort4.dto.MemberDTO;
import com.fort4.mapper.MemberMapper;

@Controller
public class MemberController {

	@Autowired
	private MemberMapper memberMapper;
	
	// 마이 페이지
	@GetMapping("/mypage")
	public String myPage(HttpSession session, Model model) {
	    MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
	    if (user == null) {
	        return "redirect:/index";
	    }
	    model.addAttribute("user", user);
	    return "mypage";
	}
	
	// 비밀번호 변경
	@GetMapping("/mypage/password")
	public String changePasswordForm() {
	    return "changePassword";
	}

	@PostMapping("/mypage/password")
	public String changePassword(@RequestParam String currentPw,
	                             @RequestParam String newPw,
	                             HttpSession session,
	                             RedirectAttributes redirectAttrs) {

	    MemberDTO user = (MemberDTO) session.getAttribute("loginUser");

	    MemberDTO check = memberMapper.login(user.getUsername(), currentPw);
	    if (check == null) {
	        redirectAttrs.addFlashAttribute("errorMsg", "현재 비밀번호가 일치하지 않습니다.");
	        return "redirect:/mypage/password";
	    }

	    memberMapper.updatePassword(user.getUsername(), newPw);
	    redirectAttrs.addFlashAttribute("successMsg", "비밀번호가 변경되었습니다.");
	    return "redirect:/mypage";
	}

	// 회원정보 삭제
	@GetMapping("/mypage/delete")
	public String deleteAccountForm() {
	    return "deleteAccount";
	}

	@PostMapping("/mypage/delete")
	public String deleteAccount(@RequestParam String password,
	                            HttpSession session,
	                            RedirectAttributes redirectAttrs) {

	    MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
	    MemberDTO check = memberMapper.login(user.getUsername(), password);
	    if (check == null) {
	        redirectAttrs.addFlashAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
	        return "redirect:/mypage/delete";
	    }

	    memberMapper.deleteMember(user.getUsername());
	    session.invalidate();
	    return "redirect:/index";
	}


}
