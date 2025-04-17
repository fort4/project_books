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
    
    // setter 호출시 start 계산
//	public void setPage(int page) { 
//		this.page = page; 
//		this.start = (page - 1) * size; 
//		}
	 

}
