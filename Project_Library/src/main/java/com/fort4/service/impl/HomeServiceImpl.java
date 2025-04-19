package com.fort4.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fort4.dto.BookDTO;
import com.fort4.mapper.BookMapper;
import com.fort4.mapper.RentalMapper;
import com.fort4.service.HomeService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class HomeServiceImpl implements HomeService {
	
	private final RentalMapper rentalMapper;
	private final BookMapper bookMapper;
	
	@Override
	public Map<String, List<BookDTO>> getHomePageData() {
	    Map<String, List<BookDTO>> data = new HashMap<>();

	    // 추천 도서 5권
	    List<BookDTO> topBooks = rentalMapper.getTopRentedBooks();

	    // 최신 도서들
	    List<BookDTO> latestBooks = bookMapper.getLatestBooks();

	    data.put("topBooks", topBooks);
	    data.put("latestBooks", latestBooks);

	    return data;
	}
}
