package com.fort4.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class RentalDTO {
    private int rentalId;
    private int bookId;
    private String username;
    private LocalDateTime rentalDate;
    private LocalDateTime returnDate;
    private String isReturned; // ENUM: rented, returned
    private String bookTitle; // JOIN용 도서 제목
    
    // JSP조건처리용
    private boolean rented;
}
