package com.fort4.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class RememberTokenDTO {
    private int id;
    private String username;
    private String token;
    private LocalDateTime createdAt;
    private LocalDateTime expiredAt;
}

