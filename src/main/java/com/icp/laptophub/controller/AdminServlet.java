package com.icp.laptophub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    // In-memory storage (replace with database later)
    private List<Product> products = new ArrayList<>();
    private List<User> users = new ArrayList<>();
    private int nextProductId = 5;
    private int nextUserId = 5;

    @Override
    public void init() throws ServletException {
        // Sample data
        products.add(new Product(1, "Dell XPS 15", 80000.00, 5));
        products.add(new Product(2, "MSI Gaming Laptop", 101999.99, 3));
        products.add(new Product(3, "Lenovo ThinkPad", 699999.99, 8));
        products.add(new Product(4, "MacBook Air", 130999.99, 4));

        users.add(new User(1, "John Doe", "john@example.com", "Admin"));
        users.add(new User(2, "Jane Smith", "jane@example.com", "User"));
        users.add(new User(3, "Mike Johnson", "mike@example.com", "User"));
        users.add(new User(4, "Sarah Wilson", "sarah@example.com", "User"));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path == null || path.equals("/")) {
            // Load the admin page
            request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
        } else if (path.equals("/products")) {
            // Get all products as JSON (manual string building)
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < products.size(); i++) {
                Product p = products.get(i);
                if (i > 0) json.append(",");
                json.append("{")
                        .append("\"id\":").append(p.getId()).append(",")
                        .append("\"name\":\"").append(escapeJson(p.getName())).append("\",")
                        .append("\"price\":").append(p.getPrice()).append(",")
                        .append("\"stock\":").append(p.getStock())
                        .append("}");
            }
            json.append("]");

            out.print(json.toString());
            out.flush();

        } else if (path.equals("/users")) {
            // Get all users as JSON (manual string building)
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < users.size(); i++) {
                User u = users.get(i);
                if (i > 0) json.append(",");
                json.append("{")
                        .append("\"id\":").append(u.getId()).append(",")
                        .append("\"name\":\"").append(escapeJson(u.getName())).append("\",")
                        .append("\"email\":\"").append(escapeJson(u.getEmail())).append("\",")
                        .append("\"role\":\"").append(escapeJson(u.getRole())).append("\"")
                        .append("}");
            }
            json.append("]");

            out.print(json.toString());
            out.flush();
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            if (path.equals("/addProduct")) {
                // Add product
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));

                Product product = new Product(nextProductId++, name, price, stock);
                products.add(product);

                out.print("{\"success\":true,\"message\":\"Product added successfully\"}");

            } else if (path.equals("/removeProduct")) {
                // Remove product
                int id = Integer.parseInt(request.getParameter("id"));
                boolean removed = products.removeIf(p -> p.getId() == id);

                out.print("{\"success\":" + removed + ",\"message\":\"" +
                        (removed ? "Product removed successfully" : "Product not found") + "\"}");

            } else if (path.equals("/addUser")) {
                // Add user
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String role = request.getParameter("role");

                User user = new User(nextUserId++, name, email, role);
                users.add(user);

                out.print("{\"success\":true,\"message\":\"User added successfully\"}");

            } else if (path.equals("/removeUser")) {
                // Remove user
                int id = Integer.parseInt(request.getParameter("id"));
                boolean removed = users.removeIf(u -> u.getId() == id);

                out.print("{\"success\":" + removed + ",\"message\":\"" +
                        (removed ? "User removed successfully" : "User not found") + "\"}");

            } else {
                out.print("{\"success\":false,\"message\":\"Invalid action\"}");
            }
        } catch (Exception e) {
            out.print("{\"success\":false,\"message\":\"Error: " + escapeJson(e.getMessage()) + "\"}");
        }

        out.flush();
    }

    // Helper method to escape JSON strings
    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    // Inner classes for data models
    class Product {
        private int id;
        private String name;
        private double price;
        private int stock;

        public Product(int id, String name, double price, int stock) {
            this.id = id;
            this.name = name;
            this.price = price;
            this.stock = stock;
        }

        public int getId() { return id; }
        public String getName() { return name; }
        public double getPrice() { return price; }
        public int getStock() { return stock; }
    }

    class User {
        private int id;
        private String name;
        private String email;
        private String role;

        public User(int id, String name, String email, String role) {
            this.id = id;
            this.name = name;
            this.email = email;
            this.role = role;
        }

        public int getId() { return id; }
        public String getName() { return name; }
        public String getEmail() { return email; }
        public String getRole() { return role; }
    }
}