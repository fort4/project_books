package com.fort4.service;

import java.util.List;
import java.util.Map;

import com.fort4.dto.BookDTO;

public interface HomeService {
    Map<String, List<BookDTO>> getHomePageData();
}

