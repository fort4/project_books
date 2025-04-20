package com.fort4.controller.api;

import com.fort4.dto.MemberDTO;
import com.fort4.service.WishlistService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/wishlist")
@RequiredArgsConstructor
public class WishlistApiController {

    private final WishlistService wishlistService;

    // 찜 추가
    @PostMapping("/add")
    public Map<String, Object> addWishlist(@RequestParam int bookId, HttpSession session) {
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        Map<String, Object> result = new HashMap<>();

        if (user == null) {
            result.put("status", "error");
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        boolean success = wishlistService.addWishlist(user.getUsername(), bookId);
        result.put("status", success ? "success" : "error");
        result.put("message", success ? "찜 목록에 추가되었습니다." : "이미 찜한 도서입니다.");
        return result;
    }

    // 찜 취소
    @PostMapping("/remove")
    public Map<String, Object> removeWishlist(@RequestParam int bookId, HttpSession session) {
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        Map<String, Object> result = new HashMap<>();

        if (user == null) {
            result.put("status", "error");
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        boolean success = wishlistService.removeWishlist(user.getUsername(), bookId);
        result.put("status", success ? "success" : "error");
        result.put("message", success ? "찜이 취소되었습니다." : "찜 취소 실패");
        return result;
    }

    // 찜 여부 확인(비동기 하트 상태 갱신용)
    @GetMapping("/check")
    public boolean isWished(@RequestParam int bookId, HttpSession session) {
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        if (user == null) return false;
        return wishlistService.isWished(user.getUsername(), bookId);
    }
}
