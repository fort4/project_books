package com.fort4.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.fort4.dto.RememberTokenDTO;

@Mapper
public interface RememberTokenMapper {
	
	void insertToken(RememberTokenDTO dto);

	RememberTokenDTO findByToken(String token);

	void deleteByToken(@Param("token") String token);
	
	// 로그인시 만료된 토큰 제거
	int deleteExpiredTokens();

}
