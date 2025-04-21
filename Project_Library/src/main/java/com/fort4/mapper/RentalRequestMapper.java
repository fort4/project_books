package com.fort4.mapper;

import com.fort4.dto.RentalRequestDTO;

import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface RentalRequestMapper {

    // 사용자의 대여 요청
    void insertRequest(RentalRequestDTO request);
    // 대여 요청 취소(사용자용)
    int cancelRequest(@Param("bookId") int bookId, @Param("username") String username, @Param("cancelTime") LocalDateTime cancelTime);
    
    // 도서 대여 요청 승인/거절
    void approveRequest(@Param("requestId") int requestId, @Param("processedAt") LocalDateTime processedAt);
    void rejectRequest(@Param("requestId") int requestId, @Param("processedAt") LocalDateTime processedAt);
    
    int countPendingRequest(@Param("bookId") int bookId, @Param("username") String username);

    List<RentalRequestDTO> getAllRequests(); // 관리자용 전체 목록

    RentalRequestDTO getRequestById(int requestId); // 승인용
    
    // 도서제목까지 join
    List<RentalRequestDTO> getAllRequestsWithBookTitle();
    
    RentalRequestDTO findLatestRequestByBookAndUser(@Param("bookId") int bookId, @Param("username") String username);
    
    // 대여 요청 수(관리자 통계용)
    int countPendingRequests(); // status = 'pending'
    
    int deleteByBookId(@Param("bookId") int bookId);

}
