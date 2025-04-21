package com.fort4.service.impl;

import com.fort4.dto.RentalDTO;
import com.fort4.dto.RentalRequestDTO;
import com.fort4.mapper.BookMapper;
import com.fort4.mapper.RentalMapper;
import com.fort4.mapper.RentalRequestMapper;
import com.fort4.service.AdminRentalService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminRentalServiceImpl implements AdminRentalService {

    private final RentalRequestMapper rentalRequestMapper;
    private final BookMapper bookMapper;
    private final RentalMapper rentalMapper;

    @Override
    public List<RentalRequestDTO> getAllRequests() {
        return rentalRequestMapper.getAllRequestsWithBookTitle();
    }

    @Override
    @Transactional
    public boolean approveRequest(int requestId) {
        RentalRequestDTO request = rentalRequestMapper.getRequestById(requestId);
        if (request == null || !"pending".equals(request.getStatus())) return false;

        // 1. 승인 처리
        rentalRequestMapper.approveRequest(requestId, LocalDateTime.now());

        // 2. 대여 등록 (rental 테이블)
        RentalDTO rental = new RentalDTO();
        rental.setBookId(request.getBookId());
        rental.setUsername(request.getUsername());
        rental.setRentalDate(LocalDateTime.now());
        rental.setIsReturned("rented");

        rentalMapper.insertRental(rental);

        // 3. 도서 수량 감소
        bookMapper.decreaseQuantity(request.getBookId());

        return true;
    }


    @Override
    public boolean rejectRequest(int requestId) {
        RentalRequestDTO request = rentalRequestMapper.getRequestById(requestId);
        if (request == null || !"pending".equals(request.getStatus())) return false;

        rentalRequestMapper.rejectRequest(requestId, LocalDateTime.now());
        return true;
    }
}
