package com.icp.laptophub.dao;

import com.icp.laptophub.model.CartItem;
import com.icp.laptophub.utils.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDaoImpl implements CartDao {

    @Override
    public List<CartItem> findCartItemsByUserId(int userId) {
        List<CartItem> items = new ArrayList<>();

        String sql = "SELECT c.product_id, c.quantity, p.name, p.description, p.price, p.image " +
                "FROM carts c INNER JOIN products p ON c.product_id = p.product_id " +
                "WHERE c.user_id = ? ORDER BY c.created_at DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    BigDecimal unitPrice = rs.getBigDecimal("price");
                    int quantity = rs.getInt("quantity");

                    item.setProductId(rs.getInt("product_id"));
                    item.setName(rs.getString("name"));
                    item.setShortSpec(rs.getString("description"));
                    item.setQuantity(quantity);
                    item.setPrice(unitPrice);
                    item.setImageUrl(rs.getString("image"));
                    item.setTotalPrice(unitPrice.multiply(BigDecimal.valueOf(quantity)));

                    items.add(item);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error while fetching cart items: " + e.getMessage());
        }

        return items;
    @Override
    public boolean addToCart(int userId, int productId) {
        String sql = "INSERT INTO carts (user_id, product_id, quantity) VALUES (?, ?, 1) " +
                     "ON DUPLICATE KEY UPDATE quantity = quantity + 1";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error while adding to cart: " + e.getMessage());
            return false;
        }
    }
}

