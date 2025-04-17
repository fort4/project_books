package com.fort4.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class RentalRequestDTO {
    private int requestId;
    private int bookId;
    private String username;
    private LocalDateTime requestDate;
    private String status; // ENUM: pending, approved, rejected
    private LocalDateTime processedAt;
}
