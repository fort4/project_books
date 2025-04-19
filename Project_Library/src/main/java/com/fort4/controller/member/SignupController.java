package com.fort4.controller.member;

import com.fort4.dto.MemberDTO;
import com.fort4.service.MemberService;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.fort4.controller.BaseController;

@Controller
@RequiredArgsConstructor
@RequestMapping("/signup")
public class SignupController extends BaseController {

    private final MemberService memberService;

    @GetMapping
    public String signupForm(Model model) {
        return render("member/signup", model);
    }

    @PostMapping
    public String signup(@ModelAttribute MemberDTO member,
                         RedirectAttributes redirectAttrs) {

        if (memberService.isUsernameDuplicated(member.getUsername())) {
            redirectAttrs.addFlashAttribute("errorMsg", "이미 사용 중인 아이디입니다.");
            return "redirect:/signup";
        }

        boolean success = memberService.signup(member);
        if (success) {
            redirectAttrs.addFlashAttribute("successMsg", "회원가입이 완료되었습니다!");
            return "redirect:/login";
        } else {
            redirectAttrs.addFlashAttribute("errorMsg", "회원가입 중 오류가 발생했습니다.");
            return "redirect:/signup";
        }
    }
}

