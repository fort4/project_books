package com.fort4.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.fort4.dto.MemberDTO;

public interface MemberMapper {
	
	// 회원 가입
	void insertMember(MemberDTO member);
	
	// 아이디 중복 검사
	int checkId(String username);

	// 비번 확인용
    MemberDTO login(@Param("username") String username, @Param("password") String password);
    
    // 비밀번호 변경
    void updatePassword(@Param("username") String username, @Param("password") String password);

    // 회원 탈퇴
    void deleteMember(String username);
    
    // 관리자용 회원목록 조회
    List<MemberDTO> getAllMembers();

}


