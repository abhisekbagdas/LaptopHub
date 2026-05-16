package com.icp.laptophub.controller;

import com.icp.laptophub.model.Product;
import com.icp.laptophub.utils.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> products = new ArrayList<>();
        String sql = "SELECT product_id, user_id, name, description, price, image, created_at FROM products ORDER BY created_at DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setUserId(rs.getInt("user_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setImage(rs.getString("image"));
                product.setCreatedAt(rs.getTimestamp("created_at"));

                products.add(product);
            }

            // Pass the list to the JSP
            request.setAttribute("products", products);

            // Forward to the JSP
            request.getRequestDispatcher("/WEB-INF/views/product.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle error: redirect to error page or set error attribute
            request.setAttribute("errorMessage", "Failed to load products. Please try again later.");
//            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}