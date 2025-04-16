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
public class AdminController extends BaseAdminController {
	
	@Autowired
	private MemberMapper memberMapper;
	
	// 관리자용 회원 목록
    @GetMapping("/admin/members")
    public String memberList(HttpSession session, Model model) {
        if (!checkAdmin(session)) {
            return "redirect:/index";
        }

	    List<MemberDTO> members = memberMapper.getAllMembers();
	    model.addAttribute("members", members);
	    
	    return renderAdmin("admin/adminMemberList", model);
	}

}
