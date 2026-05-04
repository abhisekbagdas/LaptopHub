package com.icp.laptophub.controller;

import com.icp.laptophub.dao.ProductDao;
import com.icp.laptophub.dao.ProductDaoImpl;
import com.icp.laptophub.entity.Product;
import com.icp.laptophub.entity.User;
import com.icp.laptophub.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.math.BigDecimal;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private final ProductDao productDao = new ProductDaoImpl();

    private boolean isAdmin(User user) {
        return user != null && "admin".equalsIgnoreCase(user.getUsername());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        User user = (User) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String success = (String) SessionUtil.getAttribute(request, "success");
        if (success != null) {
            request.setAttribute("success", success);
            SessionUtil.removeAttribute(request, "success");
        }

        if ("entry".equalsIgnoreCase(action)) {
            if (!isAdmin(user)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            request.getRequestDispatcher("/WEB-INF/views/product-entry.jsp")
                    .forward(request, response);
            return;
        }

        if (action == null) {
            ArrayList<Product> products = productDao.fetchAllProductsByUserId(user.getId());
            request.setAttribute("products", products);
            request.getRequestDispatcher("/WEB-INF/views/product.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        User user = (User) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("create".equalsIgnoreCase(action)) {
            if (!isAdmin(user)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String priceValue = request.getParameter("price");
            String image = request.getParameter("image");
            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("error", "Product name is required.");
                request.getRequestDispatcher("/WEB-INF/views/product-entry.jsp")
                        .forward(request, response);
                return;
            }

            if (description == null || description.trim().isEmpty()) {
                request.setAttribute("error", "Product description is required.");
                request.getRequestDispatcher("/WEB-INF/views/product-entry.jsp")
                        .forward(request, response);
                return;
            }

            BigDecimal price;
            try {
                price = new BigDecimal(priceValue);
            } catch (NumberFormatException ex) {
                request.setAttribute("error", "Product price must be a valid number.");
                request.getRequestDispatcher("/WEB-INF/views/product-entry.jsp")
                        .forward(request, response);
                return;
            }

            if (price.compareTo(BigDecimal.ZERO) <= 0) {
                request.setAttribute("error", "Product price must be greater than zero.");
                request.getRequestDispatcher("/WEB-INF/views/product-entry.jsp")
                        .forward(request, response);
                return;
            }

            Product product = new Product(name.trim(), description.trim(), price, image, user.getId());

            if (productDao.insertProduct(product)) {
                SessionUtil.setAttribute(request, "success", "Product created successfully.");
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            request.setAttribute("error", "Failed to create product.");
            request.getRequestDispatcher("/WEB-INF/views/product-entry.jsp")
                    .forward(request, response);
        }
    }
}
