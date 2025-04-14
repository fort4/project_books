package com.fort4.dto;

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
}
