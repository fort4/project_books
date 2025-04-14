package com.fort4.mapper;

import org.apache.ibatis.annotations.Param;
import com.fort4.dto.MemberDTO;

public interface MemberMapper {
    MemberDTO login(@Param("username") String username, @Param("password") String password);
}


