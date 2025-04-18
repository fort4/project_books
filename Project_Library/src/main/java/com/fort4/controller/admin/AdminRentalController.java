package com.fort4.controller.admin;

import com.fort4.dto.RentalRequestDTO;
import com.fort4.dto.RentalDTO;
import com.fort4.mapper.RentalRequestMapper;
import com.fort4.mapper.BookMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/rental-requests")
public class AdminRentalController extends BaseAdminController {

    private final RentalRequestMapper rentalRequestMapper;
    //private final RentalMapper rentalMapper;
    private final BookMapper bookMapper;

    // 1. 요청 목록 조회
    @GetMapping
    public String requestList(Model model) {
        List<RentalRequestDTO> requests = rentalRequestMapper.getAllRequestsWithBookTitle();
        model.addAttribute("requests", requests);
        return render("admin/rentalRequestList", model);
    }

    // 2. 요청 승인
    @PostMapping("/approve/{requestId}")
    public String approveRequest(@PathVariable int requestId) {
        RentalRequestDTO request = rentalRequestMapper.getRequestById(requestId);
        if (request == null || !"pending".equals(request.getStatus())) {
            return "redirect:/admin/rental-requests";
        }

        // 승인 처리
        rentalRequestMapper.approveRequest(requestId, LocalDateTime.now());

        // rental 테이블에 insert
        RentalDTO rental = new RentalDTO();
        rental.setBookId(request.getBookId());
        rental.setUsername(request.getUsername());
        rental.setRentalDate(LocalDateTime.now());
        rental.setIsReturned("rented");

        // 도서 수량 차감 (수량 컬럼 있어야 함)
        bookMapper.decreaseQuantity(request.getBookId());

        return "redirect:/admin/rental-requests";
    }

    // 3. 요청 거절
    @PostMapping("/reject/{requestId}")
    public String rejectRequest(@PathVariable int requestId) {
        RentalRequestDTO request = rentalRequestMapper.getRequestById(requestId);
        if (request == null || !"pending".equals(request.getStatus())) {
            return "redirect:/admin/rental-requests";
        }

        rentalRequestMapper.rejectRequest(requestId, LocalDateTime.now());
        return "redirect:/admin/rental-requests";
    }
}
