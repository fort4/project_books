package com.fort4.controller;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fort4.dto.MemberDTO;

/**
 * 전역 공통 헬퍼
 */
public abstract class BaseController {
	
	// 로그인 여부 검사
    protected boolean isLoggedIn(HttpSession session) {
        return getLoginUser(session) != null;
    }
	
	// 세션 유지(1시간 유지)
    protected void loginUser(HttpSession session, MemberDTO member) {
        session.setAttribute("loginUser", member);
        session.setMaxInactiveInterval(60 * 60);
    }
    
    // 로그인된 사용자 가져옴
    protected MemberDTO getLoginUser(HttpSession session) {
        return (MemberDTO) session.getAttribute("loginUser");
    }
    
    // 관리자 여부 검사 
    protected boolean isAdmin(MemberDTO user) {
        return user != null && "admin".equals(user.getRole());
    }
	
    // 로그인 필요 시 리다이렉트
    protected boolean checkLoginOrRedirect(HttpSession session, RedirectAttributes redirectAttrs) {
        if (!isLoggedIn(session)) {
            redirectAttrs.addFlashAttribute("errorMsg", "로그인이 필요합니다.");
            return false;
        }
        return true;
    }
    
    /**
     * 일반 사용자용 레이아웃 렌더링
     * @param viewPath 실제 뷰 경로 (contentPage로 include됨)
     * @param model 모델 객체
     * @return layout.jsp
     */
    protected String render(String viewPath, Model model) {
        model.addAttribute("contentPage", viewPath);
        return "layout";
    }
    
    /**
     * 관리자용 레이아웃 렌더링
     * @param viewPath 실제 뷰 경로 (contentPage로 include됨)
     * @param model 모델 객체
     * @return adminLayout.jsp
     */
    protected String renderAdmin(String viewPath, Model model) {
        model.addAttribute("contentPage", viewPath);
        return "adminLayout";
    }
    
    
}

