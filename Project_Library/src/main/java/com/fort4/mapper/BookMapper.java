package com.fort4.mapper;

import com.fort4.dto.BookDTO;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BookMapper {
    List<BookDTO> getAllBooks();
    
    void updateIsRentedTrue(int bookId);
    void updateIsRentedFalse(int bookId);
    // 도서 상세조회
    BookDTO getBookById(int bookId); 
    
    // 도서 목록
    List<BookDTO> searchBooks(String keyword);
    
    // 도서 등록
    void insertBook(BookDTO book);


}
