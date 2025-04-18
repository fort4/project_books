package com.fort4.dto;

import lombok.Data;

@Data
public class BookSearchCondition {
    private String keyword;
    private Integer categoryId;
    private int start;
    private int size;
    //페이지 번호
    private int page;
    
    private String sort = "book_id";   // 기본값 설정
    private String order = "desc";

}
