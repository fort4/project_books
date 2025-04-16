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
    private boolean isReturned;
    private int extendCount;

}
