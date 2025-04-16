package com.fort4.mapper;

import com.fort4.dto.BookDTO;
import com.fort4.dto.RentalDTO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface RentalMapper {
	
	// 대여중인지 확인
	int countNotReturned(int bookId); 
	
	// 대여 등록
	void insertRental(RentalDTO rental); 
	
	// 반납용
	RentalDTO getRentalByBookIdAndUsername(@Param("bookId") int bookId, @Param("username") String username); 
	
	// rental 테이블 반납 처리
	void returnBook(int rentalId); 
	
	// 대여 목록 보기
	List<RentalDTO> getMyRentals(String username);
	
	// TOP 대여횟수
	List<BookDTO> getTopRentedBooks();

	// 대여 통계
	int countTotalRentals();
	
	// 대여 연장
	void extendRental(int rentalId);


}
