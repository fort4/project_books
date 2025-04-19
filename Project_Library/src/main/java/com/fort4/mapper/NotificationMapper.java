package com.fort4.mapper;

import java.util.List;

import com.fort4.dto.NotificationDTO;

public interface NotificationMapper {
    List<NotificationDTO> getNotificationsByUser(String username);

    int insertNotification(NotificationDTO notification);

    int markAsRead(int notificationId);
    
    int countUnreadNotifications(String username);
}

