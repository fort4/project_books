package com.fort4.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class MemberDTO {
    private String username;
    private String name;
    private String role;
    private String password;
    // 기본 직렬화 변경. JSON으로 내려올때 하이픈으로 나오도록
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthDate;
    private boolean isDeleted;
    private LocalDateTime deletedAt;
    private int points; // 기본값 0
}