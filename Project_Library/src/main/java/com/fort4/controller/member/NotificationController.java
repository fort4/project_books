package com.fort4.controller.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fort4.controller.BaseController;
import com.fort4.dto.MemberDTO;
import com.fort4.dto.NotificationDTO;
import com.fort4.service.NotificationService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/member")
public class NotificationController extends BaseController {

    private final NotificationService notificationService;

    @GetMapping("/notifications")
    public String notificationPage(HttpSession session, Model model) {
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/member/login";

        List<NotificationDTO> notifications = notificationService.getUserNotifications(user.getUsername());
        model.addAttribute("notifications", notifications);

        return render("member/notifications", model);
    }
}

