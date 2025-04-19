package com.fort4.service;

import com.fort4.dto.BookDTO;
import com.fort4.dto.BookSearchCondition;

import java.util.List;

public interface BookService {
	
    List<BookDTO> getBooks(BookSearchCondition condition);
    
    int countBooks(BookSearchCondition condition);
    
    BookDTO getBookById(int bookId);
    
    // 도서 상세보기
    BookDTO getBookDetail(int bookId, String username);

}
