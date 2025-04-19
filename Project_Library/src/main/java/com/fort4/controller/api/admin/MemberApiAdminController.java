package com.fort4.controller.api.admin;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fort4.dto.MemberDTO;
import com.fort4.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/admin/members")
@RequiredArgsConstructor
public class MemberApiAdminController {

	private final MemberMapper memberMapper;
	
    // 모달(회원 상세보기)에 뿌릴 정보 반환하는 API
    @GetMapping("/{username}")
    public MemberDTO getMemberDetail(@PathVariable String username) {
        return memberMapper.findByUsername(username);
    }
}
