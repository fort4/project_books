package com.fort4.controller;

import com.fort4.dto.BookDTO;
import com.fort4.dto.MemberDTO;
import com.fort4.dto.RentalDTO;
import com.fort4.dto.SearchCondition;
import com.fort4.mapper.BookMapper;
import com.fort4.mapper.CategoryMapper;
import com.fort4.mapper.RentalMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

import java.time.LocalDateTime;
import java.util.List;

@Controller
public class BookController extends BaseController {

    @Autowired
    private BookMapper bookMapper;
    @Autowired
    private RentalMapper rentalMapper;
    @Autowired
    private CategoryMapper categoryMapper;

    @GetMapping("/books")
    public String bookList(@ModelAttribute SearchCondition cond, Model model, HttpSession session) {
        MemberDTO user = getLoginUser(session);
        if (user == null) return "redirect:/index";

        model.addAttribute("topBooks", rentalMapper.getTopRentedBooks());

        int page = cond.getPage() == 0 ? 1 : cond.getPage();
        int size = cond.getSize() == 0 ? 5 : cond.getSize();
        cond.setPage(page);
        cond.setSize(size);
        cond.setStart((page - 1) * size);

        model.addAttribute("books", bookMapper.getBooksPaged(cond));
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", (int) Math.ceil((double) bookMapper.countBooks(cond) / size));
        model.addAttribute("size", size);
        model.addAttribute("keyword", cond.getKeyword());
        model.addAttribute("sort", cond.getSort());
        model.addAttribute("order", cond.getOrder());
        model.addAttribute("categories", categoryMapper.getAllCategories());
        model.addAttribute("categoryId", cond.getCategoryId());

        return render("books/books", model);
    }
    
    // AJAX 전용 컨트롤러
    @GetMapping("/books/ajax")
    public String ajaxBookList(@ModelAttribute SearchCondition cond, Model model) {
        int page = cond.getPage() == 0 ? 1 : cond.getPage();
        int size = cond.getSize() == 0 ? 5 : cond.getSize();
        cond.setPage(page);
        cond.setSize(size);
        cond.setStart((page - 1) * size);

        List<BookDTO> books = bookMapper.getBooksPaged(cond);
        int totalBooks = bookMapper.countBooks(cond);
        int totalPages = (int) Math.ceil((double) totalBooks / size);

        model.addAttribute("books", books);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("size", size);
        model.addAttribute("keyword", cond.getKeyword());
        model.addAttribute("sort", cond.getSort());
        model.addAttribute("order", cond.getOrder());
        model.addAttribute("categoryId", cond.getCategoryId());
        model.addAttribute("categories", categoryMapper.getAllCategories());

        return "books/bookListFragment"; // 얘는 목록만 출력하게
    }

    @GetMapping("/books/{bookId}")
    public String bookDetail(@PathVariable int bookId, Model model, HttpSession session) {
        if (getLoginUser(session) == null) return "redirect:/index";

        BookDTO book = bookMapper.getBookById(bookId);
        if (book == null) return "redirect:/books";

        model.addAttribute("book", book);
        return render("books/bookDetail", model);
    }

    @PostMapping("/books/{bookId}/rent")
    public String rentBook(@PathVariable int bookId, HttpSession session, RedirectAttributes redirectAttrs) {
        MemberDTO user = getLoginUser(session);
        if (user == null) return "redirect:/index";
        if (isAdmin(user)) {
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
        MemberDTO user = getLoginUser(session);
        if (user == null) return "redirect:/index";

        RentalDTO rental = rentalMapper.getRentalByBookIdAndUsername(bookId, user.getUsername());
        if (!isAdmin(user) && (rental == null || !rental.getUsername().equals(user.getUsername()))) {
            redirectAttrs.addFlashAttribute("errorMsg", "반납 권한이 없습니다.");
            return "redirect:/books/" + bookId;
        }

        rentalMapper.returnBook(rental.getRentalId());
        bookMapper.updateIsRentedFalse(bookId);

        redirectAttrs.addFlashAttribute("successMsg", "도서를 반납했습니다.");
        return "redirect:/books/" + bookId;
    }


    // 도서 등록
    @GetMapping("/books/add")
    public String addBookForm(HttpSession session, Model model) {
        MemberDTO user = getLoginUser(session);
        if (!isAdmin(user)) return "redirect:/books";

        model.addAttribute("categories", categoryMapper.getAllCategories());
        return render("books/addBook", model);
    }

    @PostMapping("/books/add")
    public String addBook(@ModelAttribute BookDTO book,
                          RedirectAttributes redirectAttrs,
                          HttpSession session) {
        MemberDTO user = getLoginUser(session);
        if (!isAdmin(user)) return "redirect:/books";

        bookMapper.insertBook(book);
        redirectAttrs.addFlashAttribute("successMsg", "도서가 등록되었습니다.");
        return "redirect:/books";
    }

    // 도서 수정
    @GetMapping("/books/edit/{bookId}")
    public String editBookForm(@PathVariable int bookId, Model model, HttpSession session) {
        MemberDTO user = getLoginUser(session);
        if (!isAdmin(user)) return "redirect:/books";

        BookDTO book = bookMapper.getBookById(bookId);
        if (book == null) return "redirect:/books";

        model.addAttribute("book", book);
        model.addAttribute("categories", categoryMapper.getAllCategories());
        return render("books/editBook", model);
    }

    @PostMapping("/books/edit")
    public String editBook(@ModelAttribute BookDTO book,
                           RedirectAttributes redirectAttrs,
                           HttpSession session) {
        MemberDTO user = getLoginUser(session);
        if (!isAdmin(user)) return "redirect:/books";

        bookMapper.updateBook(book);
        redirectAttrs.addFlashAttribute("successMsg", "도서가 수정되었습니다.");
        return "redirect:/books";
    }

    // 도서 삭제
    @GetMapping("/books/delete/{bookId}")
    public String deleteBook(@PathVariable int bookId,
                             HttpSession session,
                             RedirectAttributes redirectAttrs) {
        MemberDTO user = getLoginUser(session);
        if (!isAdmin(user)) return "redirect:/books";

        bookMapper.deleteBook(bookId);
        redirectAttrs.addFlashAttribute("successMsg", "도서가 삭제되었습니다.");
        return "redirect:/books";
    }

    // 내 대여 목록 보기
    @GetMapping("/myrentals")
    public String myRentals(HttpSession session, Model model) {
        MemberDTO user = getLoginUser(session);
        if (user == null) return "redirect:/index";

        List<RentalDTO> rentals = rentalMapper.getMyRentals(user.getUsername());
        model.addAttribute("rentals", rentals);
        return render("rentals/myRentals", model);
    }



    
    
}
