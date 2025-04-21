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
    
    /**
     * 도서와 연관된 모든 자식 레코드를 함께 물리 삭제.
     * @param bookId 삭제할 도서의 PK
     */
    void deleteBook(int bookId);

}
