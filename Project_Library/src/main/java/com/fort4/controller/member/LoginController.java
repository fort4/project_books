package com.fort4.controller.member;

import com.fort4.controller.BaseController;
import com.fort4.dto.MemberDTO;
import com.fort4.service.MemberService;

import lombok.RequiredArgsConstructor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class LoginController extends BaseController {

    private final MemberService memberService;

    @GetMapping("/login")
    public String loginForm(HttpSession session, Model model) {
        return render("member/login", model);
    }
    
    // 아직 그럴일 없겠지만 폼 입력값 늘어나면 LoginFormDTO로 묶어서 처리해야지
    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        @RequestParam(required = false) String rememberMe,
                        @RequestParam(required = false) String saveId,
                        HttpSession session,
                        HttpServletResponse response,
                        RedirectAttributes redirectAttrs) {

        MemberDTO member = memberService.authenticate(username, password);

        if (member == null || member.isDeleted()) {
            redirectAttrs.addFlashAttribute("errorMsg", "아이디 또는 비밀번호가 틀렸습니다.");
            return "redirect:/member/login";
        }
        
        // 로그인 성공 - 세션 생성
        session.setAttribute("loginUser", member);
        
        // 아이디 저장 쿠키 처리
        Cookie cookie = new Cookie("saveId", username);
        cookie.setPath("/");
        if (saveId != null) {
            cookie.setMaxAge(60 * 60 * 24 * 7); // 7일
        } else {
            cookie.setMaxAge(0); // 쿠키 삭제
        }
        response.addCookie(cookie);
        
        loginUser(session, member);

        if ("on".equals(rememberMe)) {
            memberService.rememberLogin(member, response);
        }

        return "redirect:/index";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session,
                         HttpServletRequest request,
                         HttpServletResponse response,
                         RedirectAttributes redirectAttrs) {
        memberService.logout(session, request, response);
        redirectAttrs.addFlashAttribute("successMsg", "정상적으로 로그아웃 되었습니다.");
        return "redirect:/member/login";
    }
}

