package com.fort4.controller;

import org.springframework.ui.Model;

public abstract class BaseController {
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

    protected String renderAdmin(String viewPath, Model model) {
        model.addAttribute("contentPage", viewPath);
        return "adminLayout";
    }
}

