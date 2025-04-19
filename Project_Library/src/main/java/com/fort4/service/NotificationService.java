package com.fort4.service;

import java.util.List;

import com.fort4.dto.NotificationDTO;

public interface NotificationService {

    // 사용자 알림 전체 조회
    List<NotificationDTO> getUserNotifications(String username);

    // 알림 전송
    boolean sendNotification(NotificationDTO notification);

    // 알림 읽음 처리
    boolean markAsRead(int notificationId);
    
    // 안읽은 알림
    int countUnread(String username);
}

