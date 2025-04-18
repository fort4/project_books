package com.fort4.dto;

import lombok.Data;

@Data
public class MemberSearchCondition {
	private String keyword;
	private String role; // user, admin
	private String status; // active, deleted

}
