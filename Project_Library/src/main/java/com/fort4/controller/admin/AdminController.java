package com.fort4.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fort4.dto.BookDTO;
import com.fort4.mapper.BookMapper;
import com.fort4.mapper.MemberMapper;
import com.fort4.mapper.RentalMapper;

@Controller
public class AdminController extends BaseAdminController {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private BookMapper bookMapper;

	@Autowired
	private RentalMapper rentalMapper;
	
	// 관리자용 회원 목록
	@GetMapping("/admin/dashboard")
	public String dashboard(Model model) {
	    int memberCount = memberMapper.countMembers();
	    int bookCount = bookMapper.countBooks();
	    int rentalCount = rentalMapper.countTotalRentals();

	    List<BookDTO> topBooks = rentalMapper.getTopRentedBooks();

	    model.addAttribute("memberCount", memberCount);
	    model.addAttribute("bookCount", bookCount);
	    model.addAttribute("rentalCount", rentalCount);
	    model.addAttribute("topBooks", topBooks);

	    return renderAdmin("admin/dashboard", model);
	}

}
