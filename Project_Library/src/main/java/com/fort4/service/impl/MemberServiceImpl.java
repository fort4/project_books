package com.fort4.service.impl;

import com.fort4.dto.MemberDTO;
import com.fort4.dto.RememberTokenDTO;
import com.fort4.mapper.MemberMapper;
import com.fort4.mapper.RememberTokenMapper;
import com.fort4.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.*;
import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;
    private final RememberTokenMapper rememberTokenMapper;

    @Override
    public MemberDTO authenticate(String username, String password) {
        return memberMapper.findByUsernameAndPassword(username, password);
    }

    @Override
    @Transactional
    public void rememberLogin(MemberDTO member, HttpServletResponse response) {
        String uuid = UUID.randomUUID().toString();
        String token = uuid + ":" + member.getUsername();

        Cookie cookie = new Cookie("remember-me", token);
        cookie.setPath("/");
        cookie.setMaxAge(60 * 60 * 24 * 7);
        response.addCookie(cookie);

        RememberTokenDTO tokenDto = new RememberTokenDTO();
        tokenDto.setUsername(member.getUsername());
        tokenDto.setToken(token);
        tokenDto.setCreatedAt(LocalDateTime.now());
        tokenDto.setExpiredAt(LocalDateTime.now().plusDays(7));
        
        rememberTokenMapper.deleteTokensByUsername(member.getUsername());
        rememberTokenMapper.insertToken(tokenDto);
        rememberTokenMapper.deleteExpiredTokens();
    }
    
    // 트랜잭션 굳이 필요한가 싶은데 일단 붙여놔야지
    @Override
    @Transactional
    public void logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        // 자동 로그인시 토큰이 있으면 db에서 토큰 제거
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("remember-me".equals(cookie.getName())) {
                    rememberTokenMapper.deleteByToken(cookie.getValue());

                    cookie.setValue(null);
                    // 쿠키 무효화
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    break;
                }
            }
        }
        // 세션 무효화
        session.invalidate();
    }
    
	/* SingupController 부분 */
    @Override
    public boolean isUsernameDuplicated(String username) {
        return memberMapper.checkId(username) > 0;
    }

    @Override
    @Transactional
    public boolean signup(MemberDTO member) {
        try {
            memberMapper.insertMember(member);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
	/* MemberController 부분 */
    @Override
    public MemberDTO getMemberInfo(String username) {
        return memberMapper.findByUsername(username);
    }
    
    @Override
    @Transactional
    public boolean changePassword(String username, String currentPw, String newPw) {
        MemberDTO member = memberMapper.findByUsernameAndPassword(username, currentPw);
        if (member == null) return false;

        memberMapper.updatePassword(username, newPw);
        return true;
    }
    
    @Override
    public boolean softDeleteMember(String username) {
        return memberMapper.softDeleteMember(username, LocalDateTime.now()) > 0;
    }

    @Override
    public String findUsername(String name, String birthDate) {
        return memberMapper.findUsername(name, birthDate);
    }





}
