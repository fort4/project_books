package com.fort4.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class LoginCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loginUser") == null) {
        	boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
            // AJAX 요청이라면 JSON 에러 응답
            if (isAjax) {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"status\":\"error\",\"message\":\"로그인이 필요합니다.\"}");
                response.getWriter().flush();
                return false;
            } 
            // 일반 요청시 에러msg 전달
            else {
            	request.setAttribute("errorMsg", "로그인이 필요합니다.");
            	return false;  // 더 이상 핸들러 호출 안 함
            }
        }
        // 로그인 되어 있으면 평소대로 진행
        return true;
    }
    
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) throws Exception {
        // (사용 안 함)
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
                                Object handler, Exception ex) throws Exception {
        // (사용 안 함)
    }


}
