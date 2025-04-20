package com.fort4.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.fort4.dto.NotificationDTO;

public interface NotificationMapper {
    List<NotificationDTO> getNotificationsByUser(String username);

    int insertNotification(NotificationDTO notification);
    
    int countUnreadNotifications(String username);
    
    // MyBatis가 호출할 실제 쿼리용 메서드(읽음 기능 많아서 안적어 놓으면 또 까먹을듯)
    int insertReadRecord(@Param("notificationId") int notificationId,
            @Param("username") String username);
    // 읽음 여부 확인용
    boolean hasUserRead(@Param("notificationId") int notificationId,
           @Param("username") String username);
}

