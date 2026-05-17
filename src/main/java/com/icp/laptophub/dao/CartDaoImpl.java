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
    public boolean addProductToCart(int userId, int productId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String checkSql = "SELECT cart_id FROM carts WHERE user_id = ? AND product_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                return increaseQuantity(userId, productId);
            } else {
                String insertSql = "INSERT INTO carts (user_id, product_id, quantity) VALUES (?, ?, 1)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, productId);
                insertStmt.executeUpdate();
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Error adding product to cart: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public boolean increaseQuantity(int userId, int productId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE carts SET quantity = quantity + 1 WHERE user_id = ? AND product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error increasing quantity: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public boolean decreaseQuantity(int userId, int productId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();

            String checkSql = "SELECT quantity FROM carts WHERE user_id = ? AND product_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                int quantity = rs.getInt("quantity");
                if (quantity > 1) {
                    String updateSql = "UPDATE carts SET quantity = quantity - 1 WHERE user_id = ? AND product_id = ?";
                    PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                    updateStmt.setInt(1, userId);
                    updateStmt.setInt(2, productId);
                    updateStmt.executeUpdate();
                    return true;
                } else {
                    return removeProductFromCart(userId, productId);
                }
            }
            return false;
        } catch (SQLException e) {
            System.out.println("Error decreasing quantity: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public boolean removeProductFromCart(int userId, int productId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM carts WHERE user_id = ? AND product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error removing product from cart: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public List<CartItem> fetchAllCartItemsByUser(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT c.cart_id, c.product_id, c.quantity, p.name, p.description, p.image, p.price " +
                    "FROM carts c " +
                    "JOIN products p ON c.product_id = p.product_id " +
                    "WHERE c.user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                BigDecimal unitPrice = rs.getBigDecimal("price");
                int quantity = rs.getInt("quantity");
                CartItem item = new CartItem(
                        rs.getInt("cart_id"),
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        unitPrice,
                        quantity
                );
                item.setShortSpec(rs.getString("description"));
                cartItems.add(item);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching cart items: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return cartItems;
    }

    @Override
    public List<CartItem> findCartItemsByUserId(int userId) {
        return fetchAllCartItemsByUser(userId);
    }

    @Override
    public int getCartItemCount(int userId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT SUM(quantity) as total_items FROM carts WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("total_items");
            }
        } catch (SQLException e) {
            System.out.println("Error getting cart item count: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return 0;
    }
}
