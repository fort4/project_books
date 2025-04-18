package com.fort4.controller.admin;

import com.fort4.dto.MemberDTO;
import com.fort4.dto.MemberSearchCondition;
import com.fort4.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/admin/members")
@RequiredArgsConstructor
public class AdminMemberController extends BaseAdminController {

    private final MemberMapper memberMapper;

    // 회원 목록
    @GetMapping
    public String memberList(@ModelAttribute MemberSearchCondition cond, Model model) {
    	List<MemberDTO> members = memberMapper.searchMembers(cond);
    	model.addAttribute("members", members);
    	model.addAttribute("condition", cond); // 선택값 유지용
    	return render("admin/memberManage", model);
    }

    // 탈퇴 처리 (논리 삭제)
    @PostMapping("/delete")
    public String deleteMember(@RequestParam String username,
                               RedirectAttributes redirectAttrs) {
    	
        // 관리자 탈퇴 차단
        MemberDTO member = memberMapper.findByUsername(username);
        if (member.getRole().equals("admin")) {
            redirectAttrs.addFlashAttribute("errorMsg", "관리자는 탈퇴할 수 없습니다.");
            return "redirect:/admin/members";
        }
    	
        memberMapper.softDeleteMember(username, LocalDateTime.now());
        redirectAttrs.addFlashAttribute("successMsg", "회원이 탈퇴 처리되었습니다.");
        return "redirect:/admin/members";
    }
    
    // 포인트 조정
    @PostMapping("/points")
    public String adjustPoints(@RequestParam String username,
                               @RequestParam int points,
                               RedirectAttributes redirectAttrs) {

        // 유효성 검사
        if (points == 0) {
            redirectAttrs.addFlashAttribute("errorMsg", "0 포인트는 적용되지 않습니다.");
            return "redirect:/admin/members";
        }
        
        // 10만포 이하만 충정되게
        if (Math.abs(points) > 100000) {
            redirectAttrs.addFlashAttribute("errorMsg", "±100,000 포인트 이내만 조정 가능합니다.");
            return "redirect:/admin/members";
        }

        memberMapper.adjustPoints(username, points);
        redirectAttrs.addFlashAttribute("successMsg",
            String.format("'%s' 회원의 포인트를 %s%d 적용했습니다.", username, points > 0 ? "+" : "", points));

        return "redirect:/admin/members";
    }
    

    
    
}
