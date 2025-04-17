package com.fort4.mapper;

import com.fort4.dto.BookDTO;
import com.fort4.dto.SearchCondition;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
    
    // 도서 수량 조절
    void decreaseQuantity(@Param("bookId") int bookId);
    void increaseQuantity(@Param("bookId") int bookId);
    
    List<BookDTO> getBooksByUser(String username);
    
}
