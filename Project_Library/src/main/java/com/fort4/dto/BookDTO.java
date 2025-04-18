package com.fort4.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookDTO {
    private int bookId;
    private String title;
    private String author;
    private String publisher;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate pubDate;
    // 이미지 필드
    private String imageUrl;
    // 프리미티브 타입에서 래퍼로 바꿈(널세이프)
    private Integer quantity;
    private Integer price;
    private Integer categoryId;
    
    private String categoryName; // JOIN용
    private int isDeleted;
    private LocalDateTime deletedAt;
    
    // 파일 업로드 필드. DB에는 저장X
    private MultipartFile uploadFile; 
}

