package com.fort4.controller.api;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fort4.dto.MemberDTO;
import com.fort4.dto.NotificationDTO;
import com.fort4.service.NotificationService;

import lombok.RequiredArgsConstructor;


/**
 * 사용자용 알림 API 
 * 지순이 응답용
 * @author core
 *
 */
@RestController
@RequestMapping("/api/notification")
@RequiredArgsConstructor
public class NotificationApiController {

    private final NotificationService notificationService;
    
    // 알림 목록 조회
    @GetMapping("/list")
    public List<NotificationDTO> getMyNotifications(HttpSession session) {
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        if (user == null) return null;
        return notificationService.getUserNotifications(user.getUsername());
    }
    
    // 안 읽은 알림 수 조회(뱃지용)
    @GetMapping("/unread-count")
    public int getUnreadCount(HttpSession session) {
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        if (user == null) return 0;
        return notificationService.countUnread(user.getUsername());
    }

    // 알림 읽음 처리(단일 건)
    @PostMapping("/read")
    public boolean markAsRead(@RequestParam int notificationId) {
        return notificationService.markAsRead(notificationId);
    }
}
