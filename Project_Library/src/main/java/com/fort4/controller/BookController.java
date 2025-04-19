package com.fort4.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import com.fort4.dto.BookDTO;
import com.fort4.dto.MemberDTO;
import com.fort4.dto.BookSearchCondition;
import com.fort4.mapper.BookMapper;
import com.fort4.service.BookService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class BookController extends BaseController {

	
	private final BookMapper bookMapper;
	private final BookService bookService;
	
	// books url이 들어올지도 모르니 일단 만들어둠
	@GetMapping("/books")
	public String redirectToIndex() {
	    return "redirect:/index";
	}
	
	// 비동기 도서 목록 전용
	@GetMapping("/books/ajax")
	public String ajaxBookList(@ModelAttribute BookSearchCondition condition, Model model) {
		// 기본값 설정
		int page = condition.getPage() == 0 ? 1 : condition.getPage();
	    int size = condition.getSize() == 0 ? 10 : condition.getSize();
	    int groupSize = 5;
	    
	    // 도서 목록 및 전체 개수
	    condition.setPage(page);
	    condition.setSize(size);
	    condition.setStart((page - 1) * size);
	    
	    // 페이지 그룹 계산
	    List<BookDTO> books = bookMapper.getBooksByCondition(condition);
	    int total = bookMapper.countBooksByCondition(condition);
	    int totalPages = (int) Math.ceil((double) total / size);
	    int currentGroup = (int) Math.ceil((double) page / groupSize);
	    int startPage = (currentGroup - 1) * groupSize + 1;
	    int endPage = Math.min(currentGroup * groupSize, totalPages);
	    
	    // 모델 바인딩
	    model.addAttribute("books", books);
	    model.addAttribute("total", total);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("groupSize", groupSize);
	    model.addAttribute("currentGroup", currentGroup);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("condition", condition);

	    return "books/bookList"; // JSP 조각 뷰
	}
	
	// 도서 상세보기
	@GetMapping("/books/{bookId}")
	public String bookDetail(@PathVariable int bookId, HttpSession session, Model model) {
	    MemberDTO user = getLoginUser(session);
	    String username = (user != null) ? user.getUsername() : null;

	    BookDTO book = bookService.getBookDetail(bookId, username);
	    if (book == null) return "redirect:/books";

	    model.addAttribute("book", book);
	    return render("books/bookDetail", model);
	}

}

