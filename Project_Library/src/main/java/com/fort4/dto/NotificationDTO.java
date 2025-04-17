package com.fort4.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class NotificationDTO {
    private int notificationId;
    private String targetType; // ENUM : user, group, all
    private String targetId;
    private String sender;
    private String content;
    private int isRead;
    private LocalDateTime createdAt;
}
