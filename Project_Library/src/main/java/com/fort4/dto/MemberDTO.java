package com.fort4.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class MemberDTO {
    private String username;
    private String name;
    private String role;
    private String password;
    private LocalDate birthDate;
    private boolean isDeleted;
    private LocalDateTime deletedAt;
    private int points; // 기본값 0
}