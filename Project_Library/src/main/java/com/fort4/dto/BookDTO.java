package com.fort4.dto;

import java.time.LocalDate;

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
    private LocalDate pubDate;
    private String imageUrl;
    private int quantity;
    private int price;
    private int categoryId;
    private String categoryName; // JOIN용
    private int isDeleted;
    
    // 파일 업로드 필드. DB에는 저장X
    private MultipartFile uploadFile; 
}

