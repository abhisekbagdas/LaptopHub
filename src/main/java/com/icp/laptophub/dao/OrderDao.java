package com.icp.laptophub.dao;

import com.icp.laptophub.model.CartItem;
import com.icp.laptophub.model.Order;

import java.util.List;

public interface OrderDao {
    /**
     * Inserts the order + all order_items, then clears the user's cart.
     * @return the generated order_id, or -1 on failure
     */
    int placeOrder(Order order, List<CartItem> cartItems);

    /** Fetches a single order with its items by order_id. */
    Order findOrderById(int orderId);

    /** Fetches all orders placed by a user (newest first). */
    List<Order> findOrdersByUserId(int userId);
}
