package com.laptopvault.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;

/**
 * GetReviewsServlet — returns approved reviews as JSON.
 * Maps to: GET /GetReviewsServlet?filter=all&page=1
 *
 * Place this file in: src/main/java/com/laptopvault/servlet/GetReviewsServlet.java
 */
@WebServlet("/GetReviewsServlet")
public class GetReviewsServlet extends HttpServlet {

    private static final String DB_URL      = "jdbc:mysql://localhost:3306/laptopvault";
    private static final String DB_USER     = "root";
    private static final String DB_PASSWORD = "your_password";

    private static final int PAGE_SIZE = 6;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // ── Params ──
        String filter = request.getParameter("filter");
        String pageStr = request.getParameter("page");

        int page = 1;
        try { page = Integer.parseInt(pageStr); } catch (Exception ignored) {}
        int offset = (page - 1) * PAGE_SIZE;

        // ── Build query ──
        StringBuilder sql = new StringBuilder(
                "SELECT name, product, title, body, rating, date, verified " +
                        "FROM reviews WHERE approved = true "
        );

        if (filter != null && !filter.equals("all")) {
            try {
                int r = Integer.parseInt(filter);
                if (r >= 1 && r <= 5) sql.append("AND rating = ").append(r).append(" ");
            } catch (NumberFormatException ignored) {}
        }

        sql.append("ORDER BY date DESC LIMIT ").append(PAGE_SIZE).append(" OFFSET ").append(offset);

        // ── Execute & build JSON ──
        StringBuilder json = new StringBuilder("[");
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql.toString())) {

            boolean first = true;
            while (rs.next()) {
                if (!first) json.append(",");
                json.append("{")
                        .append("\"name\":\"").append(escJson(rs.getString("name"))).append("\",")
                        .append("\"product\":\"").append(escJson(rs.getString("product"))).append("\",")
                        .append("\"title\":\"").append(escJson(rs.getString("title"))).append("\",")
                        .append("\"body\":\"").append(escJson(rs.getString("body"))).append("\",")
                        .append("\"rating\":").append(rs.getInt("rating")).append(",")
                        .append("\"date\":\"").append(escJson(rs.getString("date"))).append("\",")
                        .append("\"verified\":").append(rs.getBoolean("verified"))
                        .append("}");
                first = false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("[]");
            return;
        }

        json.append("]");
        out.print(json.toString());
    }

    /** Escape characters that would break the JSON string */
    private String escJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}