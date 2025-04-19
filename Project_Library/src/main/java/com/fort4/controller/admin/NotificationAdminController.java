package com.fort4.controller.admin;

import com.fort4.dto.MemberDTO;
import com.fort4.dto.NotificationDTO;
import com.fort4.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/notification")
public class NotificationAdminController extends BaseAdminController {

    private final NotificationService notificationService;

    @GetMapping("/send")
    public String sendForm(Model model) {
        return render("admin/notificationSend", model);
    }
    
    // 알림 전송처리 ajax
    @PostMapping(value = "/send", produces = "application/json")
    @ResponseBody
    public Map<String, Object> sendNotificationAjax(
            @RequestParam String targetType,
            @RequestParam(required = false) String targetId,
            @RequestParam String content,
            HttpSession session) {

        MemberDTO admin = (MemberDTO) session.getAttribute("loginUser");
        Map<String, Object> result = new HashMap<>();

        if (admin == null || !"admin".equals(admin.getRole())) {
            result.put("status", "error");
            result.put("message", "권한이 없습니다.");
            return result;
        }

        NotificationDTO notification = new NotificationDTO();
        notification.setTargetType(targetType);
        notification.setTargetId(targetId);
        notification.setContent(content);
        notification.setSender(admin.getUsername());

        boolean success = notificationService.sendNotification(notification);
        result.put("status", success ? "success" : "error");
        result.put("message", success ? "알림이 전송되었습니다." : "알림 전송에 실패했습니다.");
        return result;
    }

    
    
}
