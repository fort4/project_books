package com.fort4.controller;

import com.fort4.dto.MemberDTO;
import com.fort4.dto.RememberTokenDTO;
import com.fort4.mapper.MemberMapper;
import com.fort4.mapper.RememberTokenMapper;

import java.time.LocalDateTime;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginController extends BaseController {

	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private RememberTokenMapper rememberTokenMapper;
	
	@GetMapping("/login")
	public String loginForm(HttpSession session, Model model) {
	    return render("member/login", model);
	}
	
	@PostMapping("/login")
	public String login(@RequestParam String username,
	                    @RequestParam String password,
	                    @RequestParam(required = false) String rememberMe,
	                    HttpSession session,
	                    HttpServletResponse response,
	                    RedirectAttributes redirectAttrs,
	                    Model model) {

	    MemberDTO member = memberMapper.findByUsernameAndPassword(username, password);
	    
	    if (member == null || member.isDeleted()) {
	        redirectAttrs.addFlashAttribute("errorMsg", "아이디 또는 비밀번호가 틀렸습니다.");
	        return "redirect:/login";
	    }

	    loginUser(session, member);  // 세션 저장 (기존 로직 유지)

	    // ✅ 자동 로그인 체크되었을 경우 쿠키 발급
	    if ("on".equals(rememberMe)) {
	        System.out.println("🔥 자동 로그인 조건문 진입");

	        String uuid = UUID.randomUUID().toString();
	        String token = uuid + ":" + username;
	        System.out.println("✅ 생성된 토큰: " + token);

	        Cookie cookie = new Cookie("remember-me", token);
	        cookie.setPath("/");
	        cookie.setMaxAge(60 * 60 * 24 * 7);
	        response.addCookie(cookie);

	        RememberTokenDTO tokenDto = new RememberTokenDTO();
	        tokenDto.setUsername(username);
	        tokenDto.setToken(token);
	        tokenDto.setCreatedAt(LocalDateTime.now());
	        tokenDto.setExpiredAt(LocalDateTime.now().plusDays(7));

	        System.out.println("📝 tokenDto 준비 완료: " + tokenDto);

	        rememberTokenMapper.insertToken(tokenDto);
	        // 자동 로그인 이전에 만료된 토큰 먼저 삭제
	        rememberTokenMapper.deleteExpiredTokens();

	        System.out.println("📦 DB 저장 완료!");
	    }

	    return "redirect:/index";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request,
	                     HttpServletResponse response, RedirectAttributes redirectAttrs) {

	    // 자동 로그인 쿠키 제거
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("remember-me".equals(cookie.getName())) {
	                // DB에서 토큰 삭제
	                rememberTokenMapper.deleteByToken(cookie.getValue());

	                // 쿠키 삭제
	                cookie.setValue(null);
	                cookie.setMaxAge(0);
	                cookie.setPath("/");
	                response.addCookie(cookie);
	                break;
	            }
	        }
	    }

	    // 세션 무효화
	    session.invalidate();

	    // 플래시 메시지
	    redirectAttrs.addFlashAttribute("successMsg", "정상적으로 로그아웃 되었습니다.");
	    return "redirect:/index";
	}




}

