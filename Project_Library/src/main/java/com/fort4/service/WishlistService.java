package com.fort4.service;

import java.util.List;

public interface WishlistService {
	
    boolean addWishlist(String username, int bookId);

    boolean removeWishlist(String username, int bookId);

    boolean isWished(String username, int bookId);

    List<Integer> getWishlist(String username);

	boolean toggleWishlist(String username, int bookId);
}
