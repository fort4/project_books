package com.fort4.controller.admin;

import com.fort4.dto.BookDTO;
import com.fort4.mapper.BookMapper;
import com.fort4.service.FileStorageService;
import lombok.RequiredArgsConstructor;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/books")
@RequiredArgsConstructor
public class BookAdminController extends BaseAdminController {

    private final BookMapper bookMapper;
    private final FileStorageService fileStorageService;
    
    @GetMapping
    public String adminBookManage(Model model) {
    	List<BookDTO> books = bookMapper.getAllBooksIncludingDeleted();
    	List<BookDTO> deletedBooks = bookMapper.getDeletedBooks();
    	
        model.addAttribute("books", books);
        model.addAttribute("deletedBooks", deletedBooks);
        
        return render("admin/bookManage", model); // 관리자 전용 도서 목록
    }
    
    // — 이미지 업로드 —
    @PostMapping("/{bookId}/upload-image")
    public String uploadImage(@PathVariable int bookId,
                              @RequestParam("imageFile") MultipartFile file,
                              RedirectAttributes ra) {
        // 파일 저장 → 상대 URL 반환
        String imageUrl = fileStorageService.store(file);
        // DB에 URL 갱신(imgUrl 컬럼에는 파일명만 들어간다)
        bookMapper.updateImageUrl(bookId, imageUrl);
        ra.addFlashAttribute("successMsg", "이미지가 업로드되었습니다.");
        return "redirect:/books/" + bookId;
    }

    // — 이미지 삭제 —
    @PostMapping("/{bookId}/delete-image")
    public String deleteImage(@PathVariable int bookId,
                              RedirectAttributes ra) {
        // DB에서 기존 URL 꺼내서 물리 파일 삭제
        String existing = bookMapper.getBookById(bookId).getImageUrl();
        fileStorageService.delete(existing);
        // DB 필드 초기화
        bookMapper.updateImageUrl(bookId, null);
        ra.addFlashAttribute("successMsg", "이미지가 삭제되었습니다.");
        return "redirect:/books/" + bookId;
    }

    // 도서 논리 삭제
    @PostMapping("/softdelete")
    public String softDeleteBook(@RequestParam("bookId") int bookId,
                             HttpSession session,
                             RedirectAttributes redirectAttrs) {
        bookMapper.softDeleteBook(bookId);
        redirectAttrs.addFlashAttribute("successMsg", "도서가 삭제되었습니다.");

        return "redirect:/admin/books";
    }
    // 도서 논리삭제 목록
    @GetMapping("/deleted")
    public String showDeletedBooks(Model model) {
        List<BookDTO> deletedBooks = bookMapper.getDeletedBooks();
        model.addAttribute("deletedBooks", deletedBooks);
        return render("admin/bookManage", model); // 같은 페이지에 표시
    }
    // 도서 논리삭제 복구
    @PostMapping("/restore")
    public String restoreBook(@RequestParam int bookId,
                              RedirectAttributes redirectAttrs) {
        bookMapper.restoreBook(bookId);
        redirectAttrs.addFlashAttribute("successMsg", "도서가 복구되었습니다.");
        return "redirect:/admin/books/deleted";
    }
    // 도서 ㄹㅇ찐삭제
    @PostMapping("/delete")
    public String permanentlyDelete(@RequestParam int bookId,
                                    RedirectAttributes redirectAttrs) {
        bookMapper.deleteBook(bookId);
        redirectAttrs.addFlashAttribute("successMsg", "도서가 영구 삭제되었습니다.");
        return "redirect:/admin/books/deleted";
    }

    
}
