package com.fort4.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class MemberDTO {
    private String username;
    private String name;
    private String role;
    private String password;
    private String birthDate;
    
    // 회원 탈퇴용
    private boolean isDeleted;
    private LocalDateTime deletedAt;
}