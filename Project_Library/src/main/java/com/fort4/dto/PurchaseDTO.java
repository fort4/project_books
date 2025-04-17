package com.fort4.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class PurchaseDTO {
    private int purchaseId;
    private int bookId;
    private String username;
    private LocalDateTime purchaseDate;
}
