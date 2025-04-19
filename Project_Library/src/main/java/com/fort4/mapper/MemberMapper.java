package com.fort4.mapper;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.fort4.dto.MemberDTO;
import com.fort4.dto.MemberSearchCondition;

public interface MemberMapper {
	
	// 회원 가입
	void insertMember(MemberDTO member);
	
	// 아이디 중복 검사
	int checkId(String username);
	
	// 아이디 확인
	MemberDTO findByUsername(@Param("username") String username);
	
	// 로그인 확인
	MemberDTO findByUsernameAndPassword(@Param("username") String username, @Param("password") String password);

	// 비번 확인용
    MemberDTO login(@Param("username") String username, @Param("password") String password);
    
    // 비밀번호 변경
    void updatePassword(@Param("username") String username, @Param("password") String password);
    
    // 관리자 통계용
    int countTotalMembers();
    int countUserMembers();   // role = 'user'
    int countAdminMembers();  // role = 'admin'
    int countDeletedMembers(); // is_deleted = 1

    // 관리자용 회원목록 조회
    List<MemberDTO> getAllMembers();
    
    // 회원 찾기
    List<MemberDTO> searchMembers(@Param("cond") MemberSearchCondition cond);
    
    // 계정 찾기
    String findUsername(@Param("name") String name, @Param("birthDate") String birthDate);
    
    // 관리자용 전체 회원 보기(탈퇴포함)
    List<MemberDTO> getAllMembersWithDeleted();
    // 탈퇴(논리) 기능. 일반사용자 탈퇴시에도 사용
    int softDeleteMember(@Param("username") String username,
                          @Param("deletedAt") LocalDateTime deletedAt);
    // 관리자용 포인트(돈) 조정
    void adjustPoints(@Param("username") String username, @Param("points") int points);
    

}


