package com.fort4.controller.admin;

import com.fort4.service.AdminRentalService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;


// 1. 요청 목록 조회
// 2. 요청 승인
// 3. 요청 거절

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/rental-requests")
public class RentalAdminController extends BaseAdminController {

    private final AdminRentalService adminRentalService;

    @GetMapping
    public String requestList(Model model) {
        model.addAttribute("requests", adminRentalService.getAllRequests());
        return render("admin/rentalRequestList", model);
    }

    @PostMapping("/approve/{requestId}")
    public String approveRequest(@PathVariable int requestId) {
        adminRentalService.approveRequest(requestId);
        return "redirect:/admin/rental-requests";
    }

    @PostMapping("/reject/{requestId}")
    public String rejectRequest(@PathVariable int requestId) {
        adminRentalService.rejectRequest(requestId);
        return "redirect:/admin/rental-requests";
    }
}

