package com.fort4.controller.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fort4.controller.BaseController;
import com.fort4.dto.BookDTO;
import com.fort4.dto.MemberDTO;
import com.fort4.mapper.BookMapper;
import com.fort4.service.WishlistService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class WishlistController extends BaseController {

    private final WishlistService wishlistService;
    private final BookMapper bookMapper;

    @GetMapping("/wishlist")
    public String wishlistPage(HttpSession session, Model model) {
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/member/login";

        List<Integer> bookIds = wishlistService.getWishlist(user.getUsername());
        List<BookDTO> books = new ArrayList<>();
        for (int id : bookIds) {
            BookDTO book = bookMapper.getBookById(id);
            if (book != null) books.add(book);
        }

        model.addAttribute("wishlist", books);
        return render("member/wishlist", model);
    }
}
