package com.fort4.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fort4.dto.MemberDTO;
import com.fort4.mapper.MemberMapper;

@Controller
public class SignupController extends BaseController {

    @Autowired
    private MemberMapper memberMapper;

    @GetMapping("/join")
    public String joinForm(Model model) {
        return render("member/join", model); // layout 적용
    }

    @GetMapping("/check-id")
    @ResponseBody
    public int checkId(@RequestParam String username) {
        return memberMapper.checkId(username); // 0이면 사용 가능임
    }

    @PostMapping("/join")
    public String join(@ModelAttribute MemberDTO member, RedirectAttributes redirectAttrs) {
        member.setRole("user");
        member.setDeleted(false);

        memberMapper.insertMember(member);

        redirectAttrs.addFlashAttribute("successMsg", "회원가입이 완료되었습니다!");
        return "redirect:/index";
    }
}
