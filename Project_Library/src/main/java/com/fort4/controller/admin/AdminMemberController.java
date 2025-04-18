package com.fort4.controller.admin;

import com.fort4.dto.MemberDTO;
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
public class AdminMemberController {

    private final MemberMapper memberMapper;

    // 회원 목록
    @GetMapping
    public String memberList(Model model) {
        List<MemberDTO> members = memberMapper.getAllMembersWithDeleted();
        model.addAttribute("members", members);
        return "admin/memberManage";
    }

    // 탈퇴 처리 (논리 삭제)
    @PostMapping("/delete")
    public String deleteMember(@RequestParam String username,
                               RedirectAttributes redirectAttrs) {
        memberMapper.softDeleteMember(username, LocalDateTime.now());
        redirectAttrs.addFlashAttribute("successMsg", "회원이 탈퇴 처리되었습니다.");
        return "redirect:/admin/members";
    }
}
