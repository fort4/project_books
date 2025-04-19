package com.fort4.service;

import java.util.List;
import java.util.Map;

import com.fort4.dto.RentalDTO;

public interface RentalService {

    Map<String, Object> requestRental(int bookId, String username);
    Map<String, Object> cancelRequest(int bookId, String username);
    Map<String, Object> returnBook(int bookId, String username);
    Map<String, Object> extendBook(int bookId, String username);
	List<RentalDTO> getMyRentals(String username);
}
