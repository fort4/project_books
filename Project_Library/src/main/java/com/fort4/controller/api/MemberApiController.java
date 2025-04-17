package com.fort4.controller.api;

import com.fort4.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class MemberApiController {

    private final MemberMapper memberMapper;
    
    /**
     * AJAX 용 API임
     * @param username
     * @return
     */
    @GetMapping("/api/check-id")
    public int checkId(@RequestParam String username) {
        return memberMapper.checkId(username); // 0이면 사용 가능
    }
}
