package com.fort4.mapper;

import com.fort4.dto.BookDTO;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface BookMapper {
    
	// 도서 페이징 처리
	List<BookDTO> getBooksPaged(@Param("keyword") String keyword,
								@Param("start") int start,
								@Param("size") int size,
								@Param("sort") String sort,
								@Param("order") String order);
	
	int countBooks(@Param("keyword") String keyword);
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
    


}
