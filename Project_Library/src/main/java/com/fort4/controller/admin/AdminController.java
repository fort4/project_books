package com.fort4.controller.admin;

import org.springframework.stereotype.Controller;

@Controller
public class AdminController extends BaseAdminController {
	
	/*
	 * @Autowired private MemberMapper memberMapper;
	 * 
	 * @Autowired private BookMapper bookMapper;
	 * 
	 * @Autowired private RentalMapper rentalMapper;
	 * 
	 * // 관리자용 회원 목록
	 * 
	 * @GetMapping("/admin/dashboard") public String dashboard(Model model) { int
	 * memberCount = memberMapper.countMembers(); int bookCount =
	 * bookMapper.countBooks(); int rentalCount = rentalMapper.countTotalRentals();
	 * 
	 * List<BookDTO> topBooks = rentalMapper.getTopRentedBooks();
	 * 
	 * model.addAttribute("memberCount", memberCount);
	 * model.addAttribute("bookCount", bookCount); model.addAttribute("rentalCount",
	 * rentalCount); model.addAttribute("topBooks", topBooks);
	 * 
	 * return renderAdmin("admin/dashboard", model); }
	 */

}
