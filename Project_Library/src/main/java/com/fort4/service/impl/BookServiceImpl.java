package com.fort4.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fort4.dto.BookDTO;
import com.fort4.dto.BookSearchCondition;
import com.fort4.dto.RentalDTO;
import com.fort4.dto.RentalRequestDTO;
import com.fort4.mapper.BookMapper;
import com.fort4.mapper.RentalMapper;
import com.fort4.mapper.RentalRequestMapper;
import com.fort4.service.BookService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BookServiceImpl implements BookService {

    private final BookMapper bookMapper;
    private final RentalMapper rentalMapper;
    private final RentalRequestMapper rentalRequestMapper;

    @Override
    public BookDTO getBookById(int bookId) {
        return bookMapper.getBookById(bookId);
    }
    
    @Override
    public List<BookDTO> getBooks(BookSearchCondition condition) {
        return bookMapper.getBooksByCondition(condition);
    }

    @Override
    public int countBooks(BookSearchCondition condition) {
        return bookMapper.countBooksByCondition(condition);
    }
    
    @Override
    public BookDTO getBookDetail(int bookId, String username) {
        BookDTO book = bookMapper.getBookById(bookId);
        if (book == null) return null;

        if (username != null) {
            RentalDTO rental = rentalMapper.findRentalByBookAndUser(bookId, username);
            RentalRequestDTO request = rentalRequestMapper.findLatestRequestByBookAndUser(bookId, username);
            book.setMyRental(rental);
            book.setMyRequest(request);
        }

        return book;
    }

}
