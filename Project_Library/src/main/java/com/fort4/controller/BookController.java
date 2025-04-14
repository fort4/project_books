package com.fort4.controller;

import com.fort4.dto.BookDTO;
import com.fort4.dto.MemberDTO;
import com.fort4.dto.RentalDTO;
import com.fort4.mapper.BookMapper;
import com.fort4.mapper.RentalMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

import java.time.LocalDateTime;
import java.util.List;

@Controller
public class BookController {

    @Autowired
    private BookMapper bookMapper;
    
    @Autowired
    private RentalMapper rentalMapper;

    @GetMapping("/books")
    public String bookList(@RequestParam(value = "keyword", required = false) String keyword,
                           Model model, HttpSession session) {

        if (session.getAttribute("loginUser") == null) {
            return "redirect:/index";
        }

        List<BookDTO> books;
        if (keyword != null && !keyword.trim().isEmpty()) {
            books = bookMapper.searchBooks(keyword);
        } else {
            books = bookMapper.getAllBooks();
        }

        model.addAttribute("books", books);
        return "books";
    }

    
    @GetMapping("/books/{bookId}")
    public String bookDetail(@PathVariable("bookId") int bookId, Model model, HttpSession session) {
        // 로그인 체크
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/index";
        }

        BookDTO book = bookMapper.getBookById(bookId);
        if (book == null) {
            return "redirect:/books"; // 없는 책이면 목록으로
        }

        model.addAttribute("book", book);
        return "bookDetail"; // → /WEB-INF/views/bookDetail.jsp
    }
    
    @PostMapping("/books/{bookId}/rent")
    public String rentBook(@PathVariable int bookId, HttpSession session, RedirectAttributes redirectAttrs) {
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/index";
        
        // 관리자 대여 금지
        if (user.getRole().equals("admin")) {
            redirectAttrs.addFlashAttribute("errorMsg", "관리자는 대여할 수 없습니다.");
            return "redirect:/books/" + bookId;
        }

        if (rentalMapper.countNotReturned(bookId) > 0) {
            redirectAttrs.addFlashAttribute("errorMsg", "이미 대여중인 도서입니다.");
            return "redirect:/books/" + bookId;
        }

        RentalDTO rental = new RentalDTO();
        rental.setBookId(bookId);
        rental.setUsername(user.getUsername());
        rental.setRentalDate(LocalDateTime.now());
        rental.setReturned(false);

        rentalMapper.insertRental(rental);
        bookMapper.updateIsRentedTrue(bookId);

        redirectAttrs.addFlashAttribute("successMsg", "도서를 대여했습니다.");
        return "redirect:/books/" + bookId;
    }

    
    @PostMapping("/books/{bookId}/return")
    public String returnBook(@PathVariable int bookId, HttpSession session, RedirectAttributes redirectAttrs) {
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/index";

        RentalDTO rental = rentalMapper.getRentalByBookIdAndUsername(bookId, user.getUsername());
        if (!user.getRole().equals("admin") && (rental == null || !rental.getUsername().equals(user.getUsername()))) {
            redirectAttrs.addFlashAttribute("errorMsg", "반납 권한이 없습니다.");
            return "redirect:/books/" + bookId;
        }

        rentalMapper.returnBook(rental.getRentalId());
        bookMapper.updateIsRentedFalse(bookId);

        redirectAttrs.addFlashAttribute("successMsg", "도서를 반납했습니다.");
        return "redirect:/books/" + bookId;
    }
    
    @GetMapping("/books/add")
    public String addBookForm(HttpSession session) {
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        if (user == null || !user.getRole().equals("admin")) {
            return "redirect:/books";
        }
        return "addBook";
    }

    @PostMapping("/books/add")
    public String addBook(@ModelAttribute BookDTO book,
                          RedirectAttributes redirectAttrs,
                          HttpSession session) {
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        if (user == null || !user.getRole().equals("admin")) {
            return "redirect:/books";
        }

        bookMapper.insertBook(book);
        redirectAttrs.addFlashAttribute("successMsg", "도서가 등록되었습니다.");
        return "redirect:/books";
    }



    
    
}
