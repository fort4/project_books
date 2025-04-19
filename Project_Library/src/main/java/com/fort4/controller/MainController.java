package com.fort4.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.fort4.dto.BookDTO;
import com.fort4.dto.BookSearchCondition;
import com.fort4.mapper.CategoryMapper;
import com.fort4.service.HomeService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class MainController extends BaseController {
	
	private final HomeService homeService;
	private final CategoryMapper categoryMapper;
	
	// 루트경로도 매핑, 메인페이지
	@GetMapping({"/", "/index"})
	public String index(@ModelAttribute BookSearchCondition condition, Model model) {
        Map<String, List<BookDTO>> data = homeService.getHomePageData();
        
        model.addAttribute("topBooks", data.get("topBooks"));
        model.addAttribute("latestBooks", data.get("latestBooks"));
        model.addAttribute("categories", categoryMapper.getAllCategories());
        model.addAttribute("condition", condition);

        return render("main/index", model);
	}



}
