package com.icp.laptophub.controller;

import com.icp.laptophub.dao.AdminDao;
import com.icp.laptophub.dao.AdminDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObjectBuilder;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

/**
 * Admin Servlet handles all admin panel API requests and dashboard rendering.
 * Provides endpoints for analytics, products, users management and product operations.
 */
@WebServlet("/admin/*")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
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

        if (path.equals("/api/analytics")) {
            writeAnalyticsResponse(out);
        } else if (path.equals("/api/dailySales")) {
            String monthStr = request.getParameter("month");
            int monthVal = 5; // Default to May or current month
            try {
                if (monthStr != null) {
                    monthVal = Integer.parseInt(monthStr);
                } else {
                    monthVal = java.time.LocalDate.now().getMonthValue();
                }
            } catch (NumberFormatException e) {
                monthVal = java.time.LocalDate.now().getMonthValue();
            }
            writeDailySalesResponse(monthVal, out);
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
                    .add("description", p.get("description") != null ? (String) p.get("description") : "")
                    .add("image", p.get("image") != null ? (String) p.get("image") : "default.png")
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
                    .add("isBanned", (Boolean) u.get("isBanned"))
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
            // Handle product editing
            else if (path.equals("/api/editProduct")) {
                handleEditProduct(request, out);
            }
            // Handle product deletion
            else if (path.equals("/api/deleteProduct")) {
                handleDeleteProduct(request, out);
            }
            // Handle user banning
            else if (path.equals("/api/banUser")) {
                handleBanUser(request, out);
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
            out.print("{\"success\":false,\"message\":\"Error processing request: " + e.getMessage() + "\"}");
        }

        out.flush();
    }

    /**
     * Handles adding a new product with image upload via admin panel.
     */
    private void handleAddProduct(HttpServletRequest request, PrintWriter out) throws ServletException, IOException {
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        
        String combinedName = (brand != null && !brand.trim().isEmpty()) ? brand + " " + name : name;
        
        String imagePath = handleImageUpload(request);

        boolean success = adminDao.addProduct(combinedName, price, stock, 1, description, imagePath);

        out.print("{\"success\":" + success + ",\"message\":\"" + (success ? "Product added successfully" : "Failed to add product") + "\"}");
    }

    /**
     * Handles editing an existing product with optional image replacement via admin panel.
     */
    private void handleEditProduct(HttpServletRequest request, PrintWriter out) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        
        String combinedName = (brand != null && !brand.trim().isEmpty()) ? brand + " " + name : name;
        
        String imagePath = handleImageUpload(request);

        boolean success = adminDao.editProduct(id, combinedName, price, stock, description, imagePath);

        out.print("{\"success\":" + success + ",\"message\":\"" + (success ? "Product updated successfully" : "Failed to update product") + "\"}");
    }

    private String handleImageUpload(HttpServletRequest request) throws ServletException, IOException {
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
            String uploadPath = getServletContext().getRealPath("") + File.separator + "static" + File.separator + "images" + File.separator + "productImage";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            
            filePart.write(uploadPath + File.separator + fileName);
            return "static/images/productImage/" + fileName;
        }
        return null;
    }

    private String getFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "default.png";
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
     * Handles banning a user by ID.
     */
    private void handleBanUser(HttpServletRequest request, PrintWriter out) {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = adminDao.banUser(id);

        out.print("{\"success\":" + success + ",\"message\":\"" + (success ? "User banned successfully" : "Failed to ban user") + "\"}");
    }

    /**
     * Handles deleting a user by ID.
     */
    private void handleDeleteUser(HttpServletRequest request, PrintWriter out) {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = adminDao.deleteUser(id);

        out.print("{\"success\":" + success + ",\"message\":\"" + (success ? "User removed successfully" : "Failed to remove user") + "\"}");
    }
    /**
     * Writes daily sales data for a specific month as JSON array.
     */
    private void writeDailySalesResponse(int month, PrintWriter out) {
        List<Map<String, Object>> dailySales = adminDao.getDailySalesForMonth(month);
        JsonArrayBuilder dsBuilder = Json.createArrayBuilder();
        for (Map<String, Object> ds : dailySales) {
            dsBuilder.add(Json.createObjectBuilder()
                    .add("date", (String) ds.get("date"))
                    .add("sales", (Double) ds.get("sales")));
        }
        out.print(dsBuilder.build().toString());
    }
}