package com.icp.laptophub.dao;

import java.util.List;
import java.util.Map;

/**
 * Data Access Object for admin panel operations.
 * Provides methods to fetch dashboard analytics, manage products and users.
 */
public interface AdminDao {
    /**
     * Retrieves key performance indicators for the dashboard.
     * @return Map containing metrics like revenue, profit, total orders, and users
     */
    Map<String, Object> getDashboardMetrics();

    /**
     * Retrieves monthly sales data for charting.
     * @return List of maps containing month and sales amount
     */
    List<Map<String, Object>> getMonthlySales();

    /**
     * Retrieves daily sales heatmap data for the last year.
     * @return List of maps containing date and order count
     */
    List<Map<String, Object>> getDailySalesHeatmap();

    /**
     * Retrieves recent transactions with a specified limit.
     * @param limit Maximum number of transactions to retrieve
     * @return List of maps containing transaction details
     */
    List<Map<String, Object>> getRecentTransactions(int limit);

    /**
     * Retrieves all products with their details.
     * @return List of maps containing product information
     */
    List<Map<String, Object>> getAllProducts();

    /**
     * Retrieves all users with their details.
     * @return List of maps containing user information
     */
    List<Map<String, Object>> getAllUsers();

    /**
     * Adds a new product to the inventory.
     * @param model Product model name
     * @param price Product price
     * @param stock Initial stock quantity
     * @param brandId Brand identifier
     * @param description Product description
     * @return true if product was added successfully, false otherwise
     */
    boolean addProduct(String model, double price, int stock, int brandId, String description);

    /**
     * Deletes a product by its ID.
     * @param productId ID of the product to delete
     * @return true if product was deleted successfully, false otherwise
     */
    boolean deleteProduct(int productId);

    /**
     * Deletes a user by their ID.
     * @param userId ID of the user to delete
     * @return true if user was deleted successfully, false otherwise
     */
    boolean deleteUser(int userId);
}
