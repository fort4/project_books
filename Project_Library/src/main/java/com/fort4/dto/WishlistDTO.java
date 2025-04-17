package com.fort4.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class WishlistDTO {
    private int wishlistId;
    private String username;
    private int bookId;
    private LocalDateTime createdAt;
    private int isDeleted;
    private LocalDateTime deletedAt;
}
