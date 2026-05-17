package com.icp.laptophub.dao;

import com.icp.laptophub.entity.CartItem;

import java.util.List;
//
public interface CartDao {
    boolean addProductToCart(int userId, int productId);
    boolean increaseQuantity(int userId, int productId);
    boolean decreaseQuantity(int userId, int productId);
    boolean removeProductFromCart(int userId, int productId);
    List<CartItem> fetchAllCartItemsByUser(int userId);
    int getCartItemCount(int userId);
}
