package com.fort4.mapper;

import com.fort4.dto.BookDTO;
import com.fort4.dto.SearchCondition;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BookMapper {
    
	// 도서 페이징
	List<BookDTO> getBooksPaged(SearchCondition cond);
	int countBooks(SearchCondition cond);
	
	// 대여
    void updateIsRentedTrue(int bookId);
    void updateIsRentedFalse(int bookId);
    
    // 도서 상세조회
    BookDTO getBookById(int bookId); 
    
    // 도서 목록
    List<BookDTO> searchBooks(String keyword);
    
    // 도서 등록
    void insertBook(BookDTO book);
    
    // 도서 수정 / 삭제
    void updateBook(BookDTO book);
    void deleteBook(int bookId);
    
    // 최근도서
    List<BookDTO> getLatestBooks();
    
    // 통계용
    int countBooks();


}
