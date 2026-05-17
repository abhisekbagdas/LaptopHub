package com.icp.laptophub.controller;

import com.icp.laptophub.dao.AdminDao;
import com.icp.laptophub.dao.AdminDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObjectBuilder;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

/**
 * Admin Servlet handles all admin panel API requests and dashboard rendering.
 * Provides endpoints for analytics, products, users management and product operations.
 */
@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private AdminDao adminDao;

    @Override
    public void init() throws ServletException {
        adminDao = new AdminDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        // Handle dashboard view request
        if (path == null || path.equals("/") || path.equals("/dashboard")) {
            request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
            return;
        }

        // Set response type to JSON for API endpoints
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Route to appropriate API handler based on path
        if (path.equals("/api/analytics")) {
            writeAnalyticsResponse(out);
        } else if (path.equals("/api/products")) {
            writeProductsResponse(out);
        } else if (path.equals("/api/users")) {
            writeUsersResponse(out);
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            out.print("{\"error\":\"Endpoint not found\"}");
        }
        out.flush();
    }

    /**
     * Writes analytics data as JSON response including KPIs, monthly sales, heatmap and recent transactions.
     */
    private void writeAnalyticsResponse(PrintWriter out) {
        JsonObjectBuilder rootBuilder = Json.createObjectBuilder();

        // Add KPI metrics
        Map<String, Object> metrics = adminDao.getDashboardMetrics();
        JsonObjectBuilder kpiBuilder = Json.createObjectBuilder();
        for (Map.Entry<String, Object> entry : metrics.entrySet()) {
            if (entry.getValue() instanceof Number) {
                kpiBuilder.add(entry.getKey(), ((Number) entry.getValue()).doubleValue());
            } else {
                kpiBuilder.add(entry.getKey(), entry.getValue().toString());
            }
        }
        rootBuilder.add("metrics", kpiBuilder);

        // Add monthly sales data
        List<Map<String, Object>> monthlySales = adminDao.getMonthlySales();
        JsonArrayBuilder msBuilder = Json.createArrayBuilder();
        for (Map<String, Object> ms : monthlySales) {
            msBuilder.add(Json.createObjectBuilder()
                    .add("month", (String) ms.get("month"))
                    .add("sales", (Double) ms.get("sales")));
        }
        rootBuilder.add("monthlySales", msBuilder);

        // Add heatmap data for daily sales
        List<Map<String, Object>> heatmapData = adminDao.getDailySalesHeatmap();
        JsonArrayBuilder hmBuilder = Json.createArrayBuilder();
        for (Map<String, Object> hm : heatmapData) {
            hmBuilder.add(Json.createObjectBuilder()
                    .add("date", (String) hm.get("date"))
                    .add("count", (Integer) hm.get("count")));
        }
        rootBuilder.add("heatmapData", hmBuilder);

        // Add recent transactions
        List<Map<String, Object>> recentTransactions = adminDao.getRecentTransactions(5);
        JsonArrayBuilder txBuilder = Json.createArrayBuilder();
        for (Map<String, Object> tx : recentTransactions) {
            txBuilder.add(Json.createObjectBuilder()
                    .add("orderId", (Integer) tx.get("orderId"))
                    .add("username", (String) tx.get("username"))
                    .add("amount", (Double) tx.get("amount"))
                    .add("status", (String) tx.get("status"))
                    .add("date", (String) tx.get("date")));
        }
        rootBuilder.add("recentTransactions", txBuilder);

        out.print(rootBuilder.build().toString());
    }

    /**
     * Writes all products as JSON response.
     */
    private void writeProductsResponse(PrintWriter out) {
        List<Map<String, Object>> products = adminDao.getAllProducts();
        JsonArrayBuilder arrBuilder = Json.createArrayBuilder();
        for (Map<String, Object> p : products) {
            arrBuilder.add(Json.createObjectBuilder()
                    .add("id", (Integer) p.get("id"))
                    .add("name", (String) p.get("name"))
                    .add("price", (Double) p.get("price"))
                    .add("stock", (Integer) p.get("stock")));
        }
        out.print(arrBuilder.build().toString());
    }

    /**
     * Writes all users as JSON response.
     */
    private void writeUsersResponse(PrintWriter out) {
        List<Map<String, Object>> users = adminDao.getAllUsers();
        JsonArrayBuilder arrBuilder = Json.createArrayBuilder();
        for (Map<String, Object> u : users) {
            arrBuilder.add(Json.createObjectBuilder()
                    .add("id", (Integer) u.get("id"))
                    .add("name", (String) u.get("name"))
                    .add("email", (String) u.get("email"))
                    .add("role", (String) u.get("role"))
                    .add("registered", (String) u.get("registered")));
        }
        out.print(arrBuilder.build().toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Handle product addition
            if (path.equals("/api/addProduct")) {
                handleAddProduct(request, out);
            }
            // Handle product deletion
            else if (path.equals("/api/deleteProduct")) {
                handleDeleteProduct(request, out);
            }
            // Handle user deletion
            else if (path.equals("/api/deleteUser")) {
                handleDeleteUser(request, out);
            }
            // Invalid action
            else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"Invalid action\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Error processing request\"}");
        }

        out.flush();
    }

    /**
     * Handles adding a new product via admin panel.
     */
    private void handleAddProduct(HttpServletRequest request, PrintWriter out) {
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int brandId = 1; // Default to Dell for demo if brand isn't specified

        boolean success = adminDao.addProduct(name, price, stock, brandId, "Added from Admin Panel");

        out.print("{\"success\":" + success + ",\"message\":\"" + (success ? "Product added successfully" : "Failed to add product") + "\"}");
    }

    /**
     * Handles deleting a product by ID.
     */
    private void handleDeleteProduct(HttpServletRequest request, PrintWriter out) {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = adminDao.deleteProduct(id);

        out.print("{\"success\":" + success + ",\"message\":\"" + (success ? "Product removed successfully" : "Failed to remove product") + "\"}");
    }

    /**
     * Handles deleting a user by ID.
     */
    private void handleDeleteUser(HttpServletRequest request, PrintWriter out) {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = adminDao.deleteUser(id);

        out.print("{\"success\":" + success + ",\"message\":\"" + (success ? "User removed successfully" : "Failed to remove user") + "\"}");
    }
//    My Changes test
}