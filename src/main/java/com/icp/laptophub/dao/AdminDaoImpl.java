package com.icp.laptophub.dao;

import com.icp.laptophub.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Implementation of AdminDao for database operations.
 * Handles all data access for admin panel functionality using the original schema.
 */
public class AdminDaoImpl implements AdminDao {

    @Override
    public Map<String, Object> getDashboardMetrics() {
        Map<String, Object> metrics = new HashMap<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();

            // Total Revenue (Sum of quantity * price from carts and products)
            String revSql = "SELECT SUM(c.quantity * p.price) AS revenue FROM carts c JOIN products p ON c.product_id = p.product_id";
            try (PreparedStatement psRev = conn.prepareStatement(revSql);
                 ResultSet rsRev = psRev.executeQuery()) {
                if (rsRev.next()) {
                    metrics.put("revenue", rsRev.getDouble("revenue"));
                } else {
                    metrics.put("revenue", 0.0);
                }
            }

            // Total Profit (mocked as 20% of revenue for demonstration)
            double revenue = (Double) metrics.get("revenue");
            metrics.put("grossProfit", revenue * 0.20);

            // Total Users
            String userSql = "SELECT COUNT(*) AS total_users FROM users";
            try (PreparedStatement psUser = conn.prepareStatement(userSql);
                 ResultSet rsUser = psUser.executeQuery()) {
                if (rsUser.next()) {
                    metrics.put("totalUsers", rsUser.getInt("total_users"));
                } else {
                    metrics.put("totalUsers", 0);
                }
            }

            // Total Orders (we'll count carts as orders)
            String orderSql = "SELECT COUNT(*) AS total_orders FROM carts";
            try (PreparedStatement psOrder = conn.prepareStatement(orderSql);
                 ResultSet rsOrder = psOrder.executeQuery()) {
                if (rsOrder.next()) {
                    metrics.put("totalOrders", rsOrder.getInt("total_orders"));
                } else {
                    metrics.put("totalOrders", 0);
                }
            }

        } catch (SQLException e) {
            System.out.println("Error fetching dashboard metrics: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return metrics;
    }

    @Override
    public List<Map<String, Object>> getMonthlySales() {
        List<Map<String, Object>> monthlySales = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            // Group sales by month using carts created_at
            String sql = "SELECT DATE_FORMAT(c.created_at, '%b') AS month, SUM(c.quantity * p.price) AS sales " +
                    "FROM carts c JOIN products p ON c.product_id = p.product_id " +
                    "GROUP BY DATE_FORMAT(c.created_at, '%b'), MONTH(c.created_at) " +
                    "ORDER BY MONTH(c.created_at)";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("month", rs.getString("month"));
                    map.put("sales", rs.getDouble("sales"));
                    monthlySales.add(map);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching monthly sales: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return monthlySales;
    }

    @Override
    public List<Map<String, Object>> getDailySalesHeatmap() {
        List<Map<String, Object>> heatmapData = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            // Get order counts by date from carts
            String sql = "SELECT DATE(created_at) AS date, COUNT(*) AS count " +
                    "FROM carts " +
                    "GROUP BY DATE(created_at) " +
                    "ORDER BY date DESC LIMIT 365";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("date", rs.getString("date"));
                    map.put("count", rs.getInt("count"));
                    heatmapData.add(map);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching heatmap data: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return heatmapData;
    }

    @Override
    public List<Map<String, Object>> getRecentTransactions(int limit) {
        List<Map<String, Object>> transactions = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT c.cart_id, u.username, (c.quantity * p.price) AS total_amount, c.created_at " +
                    "FROM carts c " +
                    "JOIN users u ON c.user_id = u.user_id " +
                    "JOIN products p ON c.product_id = p.product_id " +
                    "ORDER BY c.created_at DESC LIMIT ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, limit);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("orderId", rs.getInt("cart_id"));
                        map.put("username", rs.getString("username"));
                        map.put("amount", rs.getDouble("total_amount"));
                        map.put("status", "Delivered"); // Mock status
                        map.put("date", rs.getString("created_at"));
                        transactions.add(map);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching recent transactions: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return transactions;
    }

    @Override
    public List<Map<String, Object>> getAllProducts() {
        List<Map<String, Object>> products = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT product_id, name, price FROM products ORDER BY product_id DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("product_id"));
                    map.put("name", rs.getString("name"));
                    map.put("price", rs.getDouble("price"));
                    map.put("stock", 10); // Mock stock
                    products.add(map);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return products;
    }

    @Override
    public List<Map<String, Object>> getAllUsers() {
        List<Map<String, Object>> users = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT user_id, username, email, created_at FROM users ORDER BY user_id DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("user_id"));
                    map.put("name", rs.getString("username"));
                    map.put("email", rs.getString("email"));
                    String username = rs.getString("username");
                    if ("admin".equalsIgnoreCase(username) || "admin1".equalsIgnoreCase(username)) {
                        map.put("role", "admin");
                    } else {
                        map.put("role", "customer");
                    }
                    map.put("registered", rs.getString("created_at"));
                    users.add(map);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching users: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return users;
    }

    @Override
    public boolean addProduct(String model, double price, int stock, int brandId, String description) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            // Get an admin user_id to satisfy the foreign key constraint
            int adminUserId = 1;
            String userSql = "SELECT user_id FROM users WHERE username = 'admin' OR username = 'admin1' LIMIT 1";
            try (PreparedStatement psUser = conn.prepareStatement(userSql);
                 ResultSet rsUser = psUser.executeQuery()) {
                if (rsUser.next()) {
                    adminUserId = rsUser.getInt("user_id");
                }
            }

            String sql = "INSERT INTO products (user_id, name, description, price, image) VALUES (?, ?, ?, ?, 'default.png')";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, adminUserId);
                ps.setString(2, model);
                ps.setString(3, description);
                ps.setDouble(4, price);
                ps.executeUpdate();
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Error adding product: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public boolean deleteProduct(int productId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM products WHERE product_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, productId);
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error deleting product: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public boolean deleteUser(int userId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM users WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error deleting user: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }
}