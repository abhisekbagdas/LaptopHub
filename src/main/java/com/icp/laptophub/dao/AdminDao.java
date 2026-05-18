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
     * Retrieves daily sales data for a specific month for charting.
     * @param month 1-based month (1-12)
     * @return List of maps containing date and sales amount
     */
    List<Map<String, Object>> getDailySalesForMonth(int month);

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
     * @param imagePath Path to the uploaded product image
     * @return true if product was added successfully, false otherwise
     */
    boolean addProduct(String model, double price, int stock, int brandId, String description, String imagePath);

    /**
     * Edits an existing product.
     * @param productId Product identifier
     * @param name New product name
     * @param price New product price
     * @param stock New stock quantity
     * @param description New description
     * @param imagePath New image path (can be null to keep existing)
     * @return true if product was updated successfully, false otherwise
     */
    boolean editProduct(int productId, String name, double price, int stock, String description, String imagePath);

    /**
     * Deletes a product by its ID.
     * @param productId ID of the product to delete
     * @return true if product was deleted successfully, false otherwise
     */
    boolean deleteProduct(int productId);

    /**
     * Bans a user by their ID (sets is_banned to TRUE).
     * @param userId ID of the user to ban
     * @return true if user was banned successfully, false otherwise
     */
    boolean banUser(int userId);

    /**
     * Deletes a user by their ID.
     * @param userId ID of the user to delete
     * @return true if user was deleted successfully, false otherwise
     */
    boolean deleteUser(int userId);
}