package com.fort4.dto;

import lombok.Data;

@Data
public class MemberDTO {
    private String username;
    private String name;
    private String role;
    private String password;
    private String birthDate;
}