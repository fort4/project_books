package com.fort4.service.impl;

import com.fort4.mapper.WishlistMapper;
import com.fort4.service.WishlistService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class WishlistServiceImpl implements WishlistService {

    private final WishlistMapper wishlistMapper;
    
    @Override
    public boolean addWishlist(String username, int bookId) {
        return wishlistMapper.addWishlist(username, bookId) > 0;
    }

    @Override
    public boolean removeWishlist(String username, int bookId) {
        return wishlistMapper.removeWishlist(username, bookId) > 0;
    }

    @Override
    public boolean isWished(String username, int bookId) {
        return wishlistMapper.isWished(username, bookId);
    }

    @Override
    public List<Integer> getWishlist(String username) {
        return wishlistMapper.getWishlistByUser(username);
    }
    
    @Override
    public boolean toggleWishlist(String username, int bookId) {
        if (wishlistMapper.isWished(username, bookId)) {
            wishlistMapper.removeWishlist(username, bookId);
            return true;  // removed
        } else {
            wishlistMapper.addWishlist(username, bookId);
            return false; // added
        }
    }

}
