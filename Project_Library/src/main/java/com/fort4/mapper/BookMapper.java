package com.fort4.mapper;

import com.fort4.dto.BookDTO;
import com.fort4.dto.BookSearchCondition;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BookMapper {
	
	// 논리삭제 제외 모든 도서
    List<BookDTO> getAllBooks();
    // 도서 id 
    BookDTO getBookById(int bookId);
    // 최신 도서
    List<BookDTO> getLatestBooks(); 
    // 도서 등록
    int insertBook(BookDTO book);
    // 도서 수정
    int updateBook(BookDTO book);
    // 도서 삭제(논리)
    int softDeleteBook(int bookId);
    // 도서 영구 삭제(물리)
    int deleteBook(int bookId);
    // 도서 삭제 복구
    int restoreBook(int bookId);
    // 논리 삭제된 도서 조회
    List<BookDTO> getDeletedBooks();
    // 논리삭제 포함 전체 도서 가져옴
    List<BookDTO> getAllBooksIncludingDeleted();
    
    List<BookDTO> getBooksByCondition(BookSearchCondition condition);
    int countBooksByCondition(BookSearchCondition condition);
    
    // 도서 수량 조절
    void decreaseQuantity(@Param("bookId") int bookId);
    void increaseQuantity(@Param("bookId") int bookId);
    
    List<BookDTO> getBooksByUser(String username);
    // 전체 도서 수(관리자 통계용)
    int countTotalBooks();
    
    // 도서 이미지 변경
    void updateImageUrl(@Param("bookId") int bookId,
            @Param("imageUrl") String imageUrl);

    
}
