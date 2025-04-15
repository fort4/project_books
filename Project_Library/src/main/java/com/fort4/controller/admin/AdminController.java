package com.fort4.controller.admin;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fort4.dto.MemberDTO;
import com.fort4.mapper.MemberMapper;

@Controller
public class AdminController {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@GetMapping("/admin/members")
	public String memberList(HttpSession session, Model model) {
	    MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
	    if (user == null || !"admin".equals(user.getRole())) {
	        return "redirect:/index";
	    }

	    List<MemberDTO> members = memberMapper.getAllMembers();
	    model.addAttribute("members", members);
	    return "adminMemberList";
	}

}
