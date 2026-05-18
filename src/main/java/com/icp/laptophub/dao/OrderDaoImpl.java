package com.icp.laptophub.dao;

import com.icp.laptophub.model.CartItem;
import com.icp.laptophub.model.Order;
import com.icp.laptophub.model.OrderItem;
import com.icp.laptophub.utils.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDaoImpl implements OrderDao {

    // ─────────────────────────────────────────────────────────────────────────
    // placeOrder: inserts order → inserts items → clears cart  (all in one tx)
    // ─────────────────────────────────────────────────────────────────────────
    @Override
    public int placeOrder(Order order, List<CartItem> cartItems) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false); // begin transaction

            // 1) Insert into orders
            String orderSql = "INSERT INTO orders " +
                    "(user_id, full_name, phone, address, city, payment_method, " +
                    " subtotal, discount, total, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, order.getUserId());
            orderStmt.setString(2, order.getFullName());
            orderStmt.setString(3, order.getPhone());
            orderStmt.setString(4, order.getAddress());
            orderStmt.setString(5, order.getCity());
            orderStmt.setString(6, order.getPaymentMethod());
            orderStmt.setBigDecimal(7, order.getSubtotal());
            orderStmt.setBigDecimal(8, order.getDiscount());
            orderStmt.setBigDecimal(9, order.getTotal());
            orderStmt.setString(10, "Pending");
            orderStmt.executeUpdate();

            ResultSet generatedKeys = orderStmt.getGeneratedKeys();
            if (!generatedKeys.next()) {
                conn.rollback();
                return -1;
            }
            int orderId = generatedKeys.getInt(1);

            // 2) Insert each cart item as an order_item
            String itemSql = "INSERT INTO order_items " +
                    "(order_id, product_id, product_name, image, unit_price, quantity, total_price) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement itemStmt = conn.prepareStatement(itemSql);
            for (CartItem ci : cartItems) {
                BigDecimal lineTotal = ci.getPrice().multiply(BigDecimal.valueOf(ci.getQuantity()));
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, ci.getProductId());
                itemStmt.setString(3, ci.getName());
                itemStmt.setString(4, ci.getImageUrl());
                itemStmt.setBigDecimal(5, ci.getPrice());
                itemStmt.setInt(6, ci.getQuantity());
                itemStmt.setBigDecimal(7, lineTotal);
                itemStmt.addBatch();
            }
            itemStmt.executeBatch();

            // 3) Clear the user's cart
            String clearCart = "DELETE FROM carts WHERE user_id = ?";
            PreparedStatement clearStmt = conn.prepareStatement(clearCart);
            clearStmt.setInt(1, order.getUserId());
            clearStmt.executeUpdate();

            conn.commit(); // everything succeeded
            return orderId;

        } catch (SQLException e) {
            System.out.println("Error placing order: " + e.getMessage());
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            return -1;
        } finally {
            try { if (conn != null) conn.setAutoCommit(true); } catch (SQLException ex) { ex.printStackTrace(); }
            DatabaseConnection.closeConnection(conn);
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // findOrderById: fetches order header + its items
    // ─────────────────────────────────────────────────────────────────────────
    @Override
    public Order findOrderById(int orderId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();

            // Fetch order header
            String sql = "SELECT * FROM orders WHERE order_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (!rs.next()) return null;

            Order order = mapOrder(rs);

            // Fetch associated items
            String itemSql = "SELECT * FROM order_items WHERE order_id = ?";
            PreparedStatement itemStmt = conn.prepareStatement(itemSql);
            itemStmt.setInt(1, orderId);
            ResultSet itemRs = itemStmt.executeQuery();

            List<OrderItem> items = new ArrayList<>();
            while (itemRs.next()) {
                items.add(mapOrderItem(itemRs));
            }
            order.setItems(items);
            return order;

        } catch (SQLException e) {
            System.out.println("Error fetching order: " + e.getMessage());
            return null;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // findOrdersByUserId: all orders for a user, newest first
    // ─────────────────────────────────────────────────────────────────────────
    @Override
    public List<Order> findOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                orders.add(mapOrder(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching user orders: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return orders;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // Private helpers
    // ─────────────────────────────────────────────────────────────────────────
    private Order mapOrder(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setOrderId(rs.getInt("order_id"));
        o.setUserId(rs.getInt("user_id"));
        o.setFullName(rs.getString("full_name"));
        o.setPhone(rs.getString("phone"));
        o.setAddress(rs.getString("address"));
        o.setCity(rs.getString("city"));
        o.setPaymentMethod(rs.getString("payment_method"));
        o.setSubtotal(rs.getBigDecimal("subtotal"));
        o.setDiscount(rs.getBigDecimal("discount"));
        o.setTotal(rs.getBigDecimal("total"));
        o.setStatus(rs.getString("status"));
        o.setCreatedAt(rs.getTimestamp("created_at"));
        return o;
    }

    private OrderItem mapOrderItem(ResultSet rs) throws SQLException {
        OrderItem i = new OrderItem();
        i.setItemId(rs.getInt("item_id"));
        i.setOrderId(rs.getInt("order_id"));
        i.setProductId(rs.getInt("product_id"));
        i.setProductName(rs.getString("product_name"));
        i.setImage(rs.getString("image"));
        i.setUnitPrice(rs.getBigDecimal("unit_price"));
        i.setQuantity(rs.getInt("quantity"));
        i.setTotalPrice(rs.getBigDecimal("total_price"));
        return i;
    }
}
