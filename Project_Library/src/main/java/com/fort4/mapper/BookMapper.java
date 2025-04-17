package com.fort4.mapper;

import com.fort4.dto.BookDTO;
import com.fort4.dto.SearchCondition;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BookMapper {
	
    List<BookDTO> getAllBooks();
    BookDTO getBookById(int bookId);
    List<BookDTO> getLatestBooks(); // 최신 도서 10권
    int insertBook(BookDTO book);
    int updateBook(BookDTO book);
    int deleteBook(int bookId); // 논리 삭제로 바꿀 수도 있음
    
    List<BookDTO> getBooksByCondition(SearchCondition condition);
    int countBooksByCondition(SearchCondition condition);
    
    
    List<BookDTO> getBooksByUser(String username);
    
}
