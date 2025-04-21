package com.fort4.controller.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fort4.controller.BaseController;
import com.fort4.dto.MemberDTO;
import com.fort4.service.MemberService;
import com.fort4.service.RentalService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController extends BaseController {

    private final MemberService memberService;
    private final RentalService rentalService;
    
    // 마이페이지로
    @GetMapping("/mypage")
    public String myPage(HttpSession session, Model model) {
        MemberDTO loginUser = getLoginUser(session);
        MemberDTO fullInfo = memberService.getMemberInfo(loginUser.getUsername());
        model.addAttribute("member", fullInfo);
        return render("member/mypage", model);
    }
    
    @GetMapping("/mybooks")
    public String myBooks(HttpSession session, Model model) {
    	MemberDTO loginUser = getLoginUser(session);
    	model.addAttribute("rentals", rentalService.getMyRentals(loginUser.getUsername()));
        return render("member/mybooks", model);
    }
    
    // 비번 변경
    @PostMapping("/change-password")
    public String changePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 HttpSession session,
                                 RedirectAttributes redirectAttrs) {
        MemberDTO user = getLoginUser(session);

        boolean success = memberService.changePassword(user.getUsername(), currentPassword, newPassword);
        if (success) {
            redirectAttrs.addFlashAttribute("successMsg", "비밀번호가 변경되었습니다.");
        } else {
            redirectAttrs.addFlashAttribute("errorMsg", "현재 비밀번호가 일치하지 않습니다.");
        }
        return "redirect:/member/mypage";
    }
    
    // 회원 탈퇴(논리)
    @PostMapping("/delete")
    public String deleteMember(HttpSession session,
                               HttpServletRequest request,
                               HttpServletResponse response,
                               RedirectAttributes redirectAttrs) {
        MemberDTO user = getLoginUser(session);

        boolean success = memberService.softDeleteMember(user.getUsername());
        if (success) {
            memberService.logout(session, request, response);
            redirectAttrs.addFlashAttribute("successMsg", "회원 탈퇴가 완료되었습니다.");
        } else {
            redirectAttrs.addFlashAttribute("errorMsg", "회원 탈퇴에 실패했습니다.");
        }

        return "redirect:/index";
    }
    
    @GetMapping("/find-id")
    public String findIdForm(Model model) {
		return render("member/findId", model);
    }
    
    @PostMapping("/find-id")
    public String findIdSubmit(@RequestParam String name,
    						   @RequestParam String birthDate,
                               RedirectAttributes redirectAttrs,
                               Model model) {
    	String username = memberService.findUsername(name, birthDate);

        if (username != null) {
        	redirectAttrs.addFlashAttribute("successMsg", "회원님의 아이디는 " + username + "입니다.");
        	return "redirect:/member/find-id";

        } else {
            redirectAttrs.addFlashAttribute("errorMsg", "일치하는 회원 정보가 없습니다.");
            return "redirect:/member/find-id";
        }
    }
    
    
}
