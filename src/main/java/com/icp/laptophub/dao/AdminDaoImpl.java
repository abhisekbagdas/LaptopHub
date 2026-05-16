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
 * Handles all data access for admin panel functionality.
 */
public class AdminDaoImpl implements AdminDao {

    @Override
    public Map<String, Object> getDashboardMetrics() {
        Map<String, Object> metrics = new HashMap<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();

            // Total Revenue (Sum of total_amount from Order where status is Delivered)
            String revSql = "SELECT SUM(total_amount) AS revenue FROM `Order` WHERE order_status = 'Delivered'";
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

            // Total Users (customers)
            String userSql = "SELECT COUNT(*) AS total_users FROM users WHERE role = 'customer'";
            try (PreparedStatement psUser = conn.prepareStatement(userSql);
                 ResultSet rsUser = psUser.executeQuery()) {
                if (rsUser.next()) {
                    metrics.put("totalUsers", rsUser.getInt("total_users"));
                } else {
                    metrics.put("totalUsers", 0);
                }
            }

            // Total Orders
            String orderSql = "SELECT COUNT(*) AS total_orders FROM `Order`";
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
            // Group sales by month
            String sql = "SELECT DATE_FORMAT(order_date, '%b') AS month, SUM(total_amount) AS sales " +
                         "FROM `Order` " +
                         "WHERE order_status = 'Delivered' " +
                         "GROUP BY DATE_FORMAT(order_date, '%b'), MONTH(order_date) " +
                         "ORDER BY MONTH(order_date)";
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
            // Get order counts by date
            String sql = "SELECT DATE(order_date) AS date, COUNT(*) AS count " +
                         "FROM `Order` " +
                         "GROUP BY DATE(order_date) " +
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
            String sql = "SELECT o.order_id, u.username, o.total_amount, o.order_status, o.order_date " +
                         "FROM `Order` o " +
                         "JOIN users u ON o.user_id = u.user_id " +
                         "ORDER BY o.order_date DESC LIMIT ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, limit);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("orderId", rs.getInt("order_id"));
                        map.put("username", rs.getString("username"));
                        map.put("amount", rs.getDouble("total_amount"));
                        map.put("status", rs.getString("order_status"));
                        map.put("date", rs.getString("order_date"));
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
            String sql = "SELECT l.laptop_id, l.model, b.brand_name, l.price, l.stock_quantity " +
                         "FROM Laptop l " +
                         "JOIN Brand b ON l.brand_id = b.brand_id " +
                         "ORDER BY l.laptop_id DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("laptop_id"));
                    map.put("name", rs.getString("brand_name") + " " + rs.getString("model"));
                    map.put("price", rs.getDouble("price"));
                    map.put("stock", rs.getInt("stock_quantity"));
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
            String sql = "SELECT user_id, username, email, role, registration_date FROM users ORDER BY user_id DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("user_id"));
                    map.put("name", rs.getString("username"));
                    map.put("email", rs.getString("email"));
                    map.put("role", rs.getString("role"));
                    map.put("registered", rs.getString("registration_date"));
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
            String sql = "INSERT INTO Laptop (brand_id, model, price, stock_quantity, description, added_date) VALUES (?, ?, ?, ?, ?, CURDATE())";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, brandId);
                ps.setString(2, model);
                ps.setDouble(3, price);
                ps.setInt(4, stock);
                ps.setString(5, description);
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
            String sql = "DELETE FROM Laptop WHERE laptop_id = ?";
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
