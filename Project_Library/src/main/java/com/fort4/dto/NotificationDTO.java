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
    // isRead인데 boolean쓸때 자동 get이 isIsRead로 만들어버리는듯? 암튼 read로 해놔야지
    private boolean readed;
    private LocalDateTime createdAt;
}
