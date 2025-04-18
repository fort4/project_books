package com.fort4.controller.admin;

import com.fort4.mapper.BookMapper;
import com.fort4.service.FileStorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/books")
@RequiredArgsConstructor
public class BookAdminController {

    private final BookMapper bookMapper;
    private final FileStorageService fileStorageService;

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

    // — 도서 삭제 —
    @PostMapping("/{bookId}/delete")
    public String deleteBook(@PathVariable int bookId,
                             RedirectAttributes ra) {
        bookMapper.deleteBook(bookId);
        ra.addFlashAttribute("successMsg", "도서가 삭제되었습니다.");
        return "redirect:/admin/books";
    }
}
