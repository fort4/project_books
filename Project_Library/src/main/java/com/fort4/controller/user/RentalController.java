package com.fort4.controller.user;

import com.fort4.controller.BaseController;
import com.fort4.dto.MemberDTO;
import com.fort4.dto.RentalDTO;
import com.fort4.dto.RentalRequestDTO;
import com.fort4.mapper.BookMapper;
import com.fort4.mapper.RentalMapper;
import com.fort4.mapper.RentalRequestMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/books")
public class RentalController extends BaseController {

    private final RentalRequestMapper rentalRequestMapper;
    private final RentalMapper rentalMapper;
    private final BookMapper bookMapper;

    // 대여 요청 AJAX 처리
    @PostMapping("/{bookId}/rent-ajax")
    @ResponseBody
    public Map<String, Object> requestRental(@PathVariable int bookId, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        MemberDTO user = getLoginUser(session);

        int count = rentalRequestMapper.countPendingRequest(bookId, user.getUsername());
        if (count > 0) {
            result.put("status", "error");
            result.put("message", "이미 해당 도서에 대한 대여 요청이 접수되어 있습니다.");
            return result;
        }

        RentalRequestDTO request = new RentalRequestDTO();
        request.setBookId(bookId);
        request.setUsername(user.getUsername());

        rentalRequestMapper.insertRequest(request);

        result.put("status", "success");
        result.put("message", "대여 요청이 접수되었습니다.");
        return result;
    }
    
    // 대여요청 취소
    @PostMapping("/{bookId}/cancel-request")
    @ResponseBody
    public Map<String, Object> cancelRequest(@PathVariable int bookId, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        MemberDTO user = getLoginUser(session);

        int updated = rentalRequestMapper.cancelRequest(bookId, user.getUsername(), LocalDateTime.now());

        if (updated > 0) {
            result.put("status", "success");
            result.put("message", "대여 요청이 취소되었습니다.");
        } else {
            result.put("status", "error");
            result.put("message", "취소 가능한 요청이 없거나 이미 처리되었습니다.");
        }

        return result;
    }
    
    // 반납
	@PostMapping("/{bookId}/return-ajax")
	@ResponseBody
	public Map<String, Object> returnBook(@PathVariable int bookId, HttpSession session) {
	    Map<String, Object> result = new HashMap<>();
	    MemberDTO user = getLoginUser(session);

	    RentalDTO rental = rentalMapper.findRentalByBookAndUser(bookId, user.getUsername());
	    if (rental == null || "returned".equals(rental.getIsReturned())) {
	        result.put("status", "error");
	        result.put("message", "반납 가능한 도서가 없습니다.");
	        return result;
	    }

	    rentalMapper.updateIsReturnedToReturned(rental.getRentalId());
	    bookMapper.increaseQuantity(bookId);
	    result.put("status", "success");
	    result.put("message", "도서를 반납했습니다.");
	    return result;
	}
	
	// 연장
	@PostMapping("/{bookId}/extend-ajax")
	@ResponseBody
	public Map<String, Object> extendBook(@PathVariable int bookId, HttpSession session) {
	    Map<String, Object> result = new HashMap<>();
	    MemberDTO user = getLoginUser(session);
	    RentalDTO rental = rentalMapper.findRentalByBookAndUser(bookId, user.getUsername());
	    if (rental == null || "returned".equals(rental.getIsReturned())) {
	        result.put("status", "error");
	        result.put("message", "연장 가능한 대여가 없습니다.");
	        return result;
	    }

	    rentalMapper.extendReturnDateByRentalId(rental.getRentalId()); // 날짜 +7일
	    result.put("status", "success");
	    result.put("message", "대여 기간이 연장되었습니다.");
	    return result;
	}
}
