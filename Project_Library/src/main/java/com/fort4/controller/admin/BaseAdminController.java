package com.fort4.controller.admin;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.fort4.controller.BaseController;
import com.fort4.dto.MemberDTO;

/*
 * 관리자 전용 헬퍼(BaseController 상속)
 */
public abstract class BaseAdminController extends BaseController {
	
    
    protected boolean checkAdmin(HttpSession session) {
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        return isAdmin(user);
    }
    
    // adminLayout.jsp
    protected String renderAdmin(String view, Model model) {
        return super.renderAdmin(view, model);
    }
}

