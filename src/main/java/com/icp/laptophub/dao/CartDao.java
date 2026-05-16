package com.icp.laptophub.dao;

import com.icp.laptophub.model.CartItem;

import java.util.List;

public interface CartDao {
    List<CartItem> findCartItemsByUserId(int userId);
}

