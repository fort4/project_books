package com.fort4.mapper;

import com.fort4.dto.BookDTO;
import com.fort4.dto.RentalDTO;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface RentalMapper {
	// 대여수 기준 Top 5
    List<BookDTO> getTopRentedBooks(); 
    // 대여 삽입
    void insertRental(RentalDTO rental);
    // 일반회원용 대여도서 보기
    List<RentalDTO> getMyRentals(@Param("username") String username);
    // 반납 처리
    void updateIsReturnedToReturned(@Param("rentalId") int rentalId);
    // 연장 처리
    void extendReturnDateByRentalId(@Param("rentalId") int rentalId);
    // 대여상태 확인
    int countRentedBooksByBookId(@Param("bookId") int bookId);
    // 특정 사용자의 대여 기록 조회
    RentalDTO findRentalByBookAndUser(@Param("bookId") int bookId, @Param("username") String username);
    // 현재 대여 중 개수
    int countRentedByBookId(@Param("bookId") int bookId);
    // 대여 요청 취소
    int cancelRequest(@Param("bookId") int bookId, @Param("username") String username, @Param("cancelTime") LocalDateTime cancelTime);
    // 대여 도서 수(관리자 통계용)
    int countRentedBooks(); // is_returned = 'rented'

}
