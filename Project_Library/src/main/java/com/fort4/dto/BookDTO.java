package com.fort4.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BookDTO {
    private int bookId;
    private String title;
    private String author;
    private String publisher;
    private String pubDate;
    private String imageUrl;
    private boolean isRented;
    //카테고리
    private Integer categoryId;
    // 표시용(좌조인 결과 매핑용)
    private String categoryName;
    // 파일 업로드 필드. DB에는 저장X
    private MultipartFile uploadFile; 
}
