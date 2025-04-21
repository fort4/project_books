package com.fort4.service;

import com.fort4.dto.MemberDTO;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;

public interface MemberService {
	
	// LoginController
    MemberDTO authenticate(String username, String password);
    void rememberLogin(MemberDTO member, HttpServletResponse response);
    void logout(HttpSession session, HttpServletRequest request, HttpServletResponse response);
    
    // SignupController
    boolean isUsernameDuplicated(String username);
    boolean signup(MemberDTO member);
    
    // MemberController
    MemberDTO getMemberInfo(String username);
    boolean changePassword(String username, String currentPw, String newPw);
	boolean softDeleteMember(String username);
	String findUsername(String name, String birthDate);

}
