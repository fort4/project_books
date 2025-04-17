package com.fort4.mapper;

import com.fort4.dto.BookDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RentalMapper {
    List<BookDTO> getTopRentedBooks(); // 대여수 기준 Top 5
}
