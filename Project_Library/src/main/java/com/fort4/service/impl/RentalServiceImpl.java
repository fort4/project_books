package com.fort4.service.impl;

import com.fort4.dto.RentalDTO;
import com.fort4.dto.RentalRequestDTO;
import com.fort4.mapper.BookMapper;
import com.fort4.mapper.RentalMapper;
import com.fort4.mapper.RentalRequestMapper;
import com.fort4.service.RentalService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class RentalServiceImpl implements RentalService {

    private final RentalRequestMapper rentalRequestMapper;
    private final RentalMapper rentalMapper;
    private final BookMapper bookMapper;

    @Override
    public Map<String, Object> requestRental(int bookId, String username) {
        Map<String, Object> result = new HashMap<>();

        int count = rentalRequestMapper.countPendingRequest(bookId, username);
        if (count > 0) {
            result.put("status", "error");
            result.put("message", "이미 요청이 접수되어 있습니다.");
            return result;
        }

        RentalRequestDTO request = new RentalRequestDTO();
        request.setBookId(bookId);
        request.setUsername(username);
        rentalRequestMapper.insertRequest(request);      

        result.put("status", "success");
        result.put("message", "대여 요청이 접수되었습니다.");
        return result;
    }

    @Override
    public Map<String, Object> cancelRequest(int bookId, String username) {
        Map<String, Object> result = new HashMap<>();
        int updated = rentalRequestMapper.cancelRequest(bookId, username, LocalDateTime.now());

        if (updated > 0) {
            result.put("status", "success");
            result.put("message", "대여 요청이 취소되었습니다.");
        } else {
            result.put("status", "error");
            result.put("message", "취소할 요청이 없습니다.");
        }
        return result;
    }

    @Override
    public Map<String, Object> returnBook(int bookId, String username) {
        Map<String, Object> result = new HashMap<>();

        RentalDTO rental = rentalMapper.findRentalByBookAndUser(bookId, username);
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

    @Override
    public Map<String, Object> extendBook(int bookId, String username) {
        Map<String, Object> result = new HashMap<>();

        RentalDTO rental = rentalMapper.findRentalByBookAndUser(bookId, username);
        if (rental == null || "returned".equals(rental.getIsReturned())) {
            result.put("status", "error");
            result.put("message", "연장 가능한 대여가 없습니다.");
            return result;
        }

        rentalMapper.extendReturnDateByRentalId(rental.getRentalId());

        result.put("status", "success");
        result.put("message", "대여 기간이 연장되었습니다.");
        return result;
    }
    
    // 대여 도서 보기
    @Override
    public List<RentalDTO> getMyRentals(String username) {
        return rentalMapper.getMyRentals(username);
    }

    
    
    
}
