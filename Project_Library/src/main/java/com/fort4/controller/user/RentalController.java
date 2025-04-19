package com.fort4.controller.user;

import com.fort4.controller.BaseController;
import com.fort4.dto.MemberDTO;
import com.fort4.service.RentalService;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/books")
public class RentalController extends BaseController {
	
	private final RentalService rentalService;
	
	// 대여요청 ajax 처리
    @PostMapping("/{bookId}/rent-ajax")
    @ResponseBody
    public Map<String, Object> requestRental(@PathVariable int bookId, HttpSession session) {
    	MemberDTO user = getLoginUser(session);
    	
        return rentalService.requestRental(bookId, user.getUsername());
    }
    
    // 대여요청 취소
    @PostMapping("/{bookId}/cancel-request")
    @ResponseBody
    public Map<String, Object> cancelRequest(@PathVariable int bookId, HttpSession session) {
    	MemberDTO user = getLoginUser(session);
        return rentalService.cancelRequest(bookId, user.getUsername());
    }
    
    // 도서 반납
    @PostMapping("/{bookId}/return-ajax")
    @ResponseBody
    public Map<String, Object> returnBook(@PathVariable int bookId, HttpSession session) {
        MemberDTO user = getLoginUser(session);
        return rentalService.returnBook(bookId, user.getUsername());
    }
    
    // 대여 연장
    @PostMapping("/{bookId}/extend-ajax")
    @ResponseBody
    public Map<String, Object> extendBook(@PathVariable int bookId, HttpSession session) {
        MemberDTO user = getLoginUser(session);
        return rentalService.extendBook(bookId, user.getUsername());
    }

}
