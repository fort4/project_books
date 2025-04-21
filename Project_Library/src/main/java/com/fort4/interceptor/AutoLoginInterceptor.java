package com.fort4.interceptor;

import com.fort4.dto.MemberDTO;
import com.fort4.dto.RememberTokenDTO;
import com.fort4.mapper.MemberMapper;
import com.fort4.mapper.RememberTokenMapper;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class AutoLoginInterceptor implements HandlerInterceptor {

    private final MemberMapper memberMapper;
    private final RememberTokenMapper rememberTokenMapper;

    public AutoLoginInterceptor(MemberMapper memberMapper, RememberTokenMapper rememberTokenMapper) {
        this.memberMapper = memberMapper;
        this.rememberTokenMapper = rememberTokenMapper;
    }
    
    
    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        HttpSession session = request.getSession(false);
        Object loginUser = (session != null) ? session.getAttribute("loginUser") : null;

        if (loginUser != null) return true;

        Cookie[] cookies = request.getCookies();
        if (cookies == null) return true;

        for (Cookie cookie : cookies) {
            if ("remember-me".equals(cookie.getName())) {
                String token = cookie.getValue();

                RememberTokenDTO tokenDto = rememberTokenMapper.findByToken(token);
                System.out.println("DB에서 찾은 토큰: " + tokenDto);

                if (tokenDto != null && tokenDto.getExpiredAt().isAfter(java.time.LocalDateTime.now())) {
                    MemberDTO member = memberMapper.findByUsername(tokenDto.getUsername());
                    if (member != null && !member.isDeleted()) {
                        // 로그인 세션 생성
                        request.getSession(true).setAttribute("loginUser", member);
                    }
                }
                break;
            }
        }

        return true;
    }

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}
}
