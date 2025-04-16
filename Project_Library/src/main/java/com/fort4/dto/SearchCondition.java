package com.fort4.dto;

import lombok.Data;

@Data
public class SearchCondition {
    private String keyword;
    private Integer categoryId;
    private int start;
    private int size;
    private String sort;
    private String order;
    //페이지 번호
    private int page; 
}
