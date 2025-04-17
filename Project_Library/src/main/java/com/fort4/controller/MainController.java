package com.fort4.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
    // 루트경로까지 매핑
	@GetMapping({"/", "/index"})
	public String index(@RequestParam(required = false) String keyword,
	                    @RequestParam(required = false) Integer categoryId,
	                    @RequestParam(defaultValue = "latest") String sort,
	                    Model model) {
	    model.addAttribute("topBooks", rentalMapper.getTopRentedBooks());
	    model.addAttribute("latestBooks", bookMapper.getLatestBooks());
	    model.addAttribute("categories", categoryMapper.getAllCategories());
	    return render("main/index", model);
	}

}
