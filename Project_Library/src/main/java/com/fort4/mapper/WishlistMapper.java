package com.fort4.mapper;

import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface WishlistMapper {

    int addWishlist(@Param("username") String username, @Param("bookId") int bookId);

    int removeWishlist(@Param("username") String username, @Param("bookId") int bookId);

    boolean isWished(@Param("username") String username, @Param("bookId") int bookId);

    List<Integer> getWishlistByUser(@Param("username") String username);
    
    int deleteByBookId(@Param("bookId") int bookId);
}

