package com.fort4.controller.admin;

import com.fort4.mapper.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/dashboard")
@RequiredArgsConstructor
public class AdminDashboardController extends BaseAdminController {

    private final MemberMapper memberMapper;
    private final BookMapper bookMapper;
    private final RentalMapper rentalMapper;
    private final RentalRequestMapper rentalRequestMapper;

    @GetMapping
    public String dashboard(Model model) {
        // 회원 통계
        model.addAttribute("totalMembers", memberMapper.countTotalMembers());
        model.addAttribute("userMembers", memberMapper.countUserMembers());
        model.addAttribute("adminMembers", memberMapper.countAdminMembers());
        model.addAttribute("deletedMembers", memberMapper.countDeletedMembers());

        // 도서 통계
        model.addAttribute("totalBooks", bookMapper.countTotalBooks());

        // 대여/요청 통계
        model.addAttribute("rentedBooks", rentalMapper.countRentedBooks());
        model.addAttribute("pendingRequests", rentalRequestMapper.countPendingRequests());

        return render("admin/dashboard", model);
    }
}

