package com.fort4.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fort4.dto.NotificationDTO;
import com.fort4.mapper.NotificationMapper;
import com.fort4.service.NotificationService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService {

    private final NotificationMapper notificationMapper;

    @Override
    public List<NotificationDTO> getUserNotifications(String username) {
        return notificationMapper.getNotificationsByUser(username);
    }

    @Override
    public boolean sendNotification(NotificationDTO notification) {
        return notificationMapper.insertNotification(notification) > 0;
    }

    @Override
    public boolean markAsRead(int notificationId) {
        return notificationMapper.markAsRead(notificationId) > 0;
    }
    
    @Override
    public int countUnread(String username) {
        return notificationMapper.countUnreadNotifications(username);
    }
}


