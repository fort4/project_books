package com.fort4.service.impl;

import com.fort4.dto.RentalDTO;
import com.fort4.dto.RentalRequestDTO;
import com.fort4.mapper.BookMapper;
import com.fort4.mapper.RentalMapper;
import com.fort4.mapper.RentalRequestMapper;
import com.fort4.service.AdminRentalService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminRentalServiceImpl implements AdminRentalService {

    private final RentalRequestMapper rentalRequestMapper;
    private final RentalMapper rentalMapper;
    private final BookMapper bookMapper;

    @Override
    public List<RentalRequestDTO> getAllRequests() {
        return rentalRequestMapper.getAllRequestsWithBookTitle();
    }

    @Override
    public boolean approveRequest(int requestId) {
        RentalRequestDTO request = rentalRequestMapper.getRequestById(requestId);
        if (request == null || !"pending".equals(request.getStatus())) return false;

        // 승인 처리
        rentalRequestMapper.approveRequest(requestId, LocalDateTime.now());

        // 대여 등록
        RentalDTO rental = new RentalDTO();
        rental.setBookId(request.getBookId());
        rental.setUsername(request.getUsername());
        rental.setRentalDate(LocalDateTime.now());
        rental.setIsReturned("rented");

        rentalMapper.insertRental(rental);
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
