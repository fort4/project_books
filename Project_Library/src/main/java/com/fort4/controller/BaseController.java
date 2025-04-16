package com.fort4.controller;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.fort4.dto.MemberDTO;

/**
 * 전역 공통 헬퍼
 */
public abstract class BaseController {
	
	// 세션 유지
    protected void loginUser(HttpSession session, MemberDTO member) {
        session.setAttribute("loginUser", member);
        session.setMaxInactiveInterval(60 * 60); // 1시간 유지
    }
    
    // 로그인 검사 공통 메서드
    protected MemberDTO getLoginUser(HttpSession session) {
        return (MemberDTO) session.getAttribute("loginUser");
    }
    
    // 관리자인지 
    protected boolean isAdmin(MemberDTO user) {
        return user != null && "admin".equals(user.getRole());
    }
	
    /**
     * 레이아웃을 사용할 뷰를 반환하는 헬퍼 함수임.
     * @param viewName contentPage에 해당하는 JSP 파일명(확장자 없이)
     * @param model JSP로 넘길 Model 객체
     * @return layout.jsp 로 이동
     */
    protected String render(String viewPath, Model model) {
        model.addAttribute("contentPage", viewPath);
        return "layout";
    }
    
    /**
     * 레이아웃을 사용할 뷰를 반환하는 헬퍼 함수임.
     * @param viewName contentPage에 해당하는 JSP 파일명(확장자 없이)
     * @param model JSP로 넘길 Model 객체
     * @return adminLayout.jsp 로 이동
     */
    protected String renderAdmin(String viewPath, Model model) {
        model.addAttribute("contentPage", viewPath);
        return "adminLayout";
    }
    
    
}

