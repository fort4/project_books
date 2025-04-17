package com.fort4.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.fort4.dto.BookDTO;
import com.fort4.dto.SearchCondition;
import com.fort4.mapper.BookMapper;
import com.fort4.mapper.CategoryMapper;
import com.fort4.mapper.RentalMapper;

@Controller
public class MainController extends BaseController {
	
	@Autowired
	private RentalMapper rentalMapper;	
	@Autowired
	private BookMapper bookMapper;	
	@Autowired
	private CategoryMapper categoryMapper;
	
	// 루트경로도 매핑, 메인페이지
	@GetMapping({"/", "/index"})
	public String index(@ModelAttribute SearchCondition condition, Model model) {
	    List<BookDTO> topBooks = rentalMapper.getTopRentedBooks();
	    List<BookDTO> latestBooks = bookMapper.getLatestBooks(); // 조건 적용 안 한 단순 리스트
	    //System.out.println("📊 추천 도서 수: " + topBooks.size());
	    
	    model.addAttribute("topBooks", topBooks);
	    model.addAttribute("latestBooks", latestBooks);
	    model.addAttribute("categories", categoryMapper.getAllCategories());
	    model.addAttribute("condition", condition); // JSP에서 필터 상태 유지용

	    return render("main/index", model);
	}



}
