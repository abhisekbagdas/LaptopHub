package com.icp.laptophub.controller;

import com.icp.laptophub.dao.ProductDao;
import com.icp.laptophub.dao.ProductDaoImpl;
import com.icp.laptophub.entity.CartItem;
import com.icp.laptophub.entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final ProductDao productDao = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        HttpSession session = request.getSession();
        
        // Suppress unchecked cast warning as we know what we put in session
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cartItems", cartItems);
        }
        
        // Calculate totals
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            subtotal = subtotal.add(item.getTotalPrice());
        }
        
        BigDecimal discount = BigDecimal.ZERO; // Simple logic: no discount by default
        BigDecimal total = subtotal.subtract(discount);
        
        // Make these available to the JSP
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("discount", discount);
        request.setAttribute("total", total);

        // Forward to the cart page
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
        String action = request.getParameter("action");
        String productIdStr = request.getParameter("productId");
        
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        int productId = Integer.parseInt(productIdStr);
        HttpSession session = request.getSession();
        
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cartItems", cartItems);
        }
        
        if (action == null || action.equals("add")) {
            // Find if item already exists in cart
            boolean found = false;
            for (CartItem item : cartItems) {
                if (item.getProductId() == productId) {
                    item.setQuantity(item.getQuantity() + 1);
                    found = true;
                    break;
                }
            }
            
            // If not found, fetch from DB and add new
            if (!found) {
                Product product = productDao.findProductById(productId);
                if (product != null) {
                    CartItem newItem = new CartItem(
                        product.getId(),
                        product.getName(),
                        product.getImage(),
                        product.getPrice(),
                        1
                    );
                    cartItems.add(newItem);
                }
            }
        } 
        else if (action.equals("increase")) {
            for (CartItem item : cartItems) {
                if (item.getProductId() == productId) {
                    item.setQuantity(item.getQuantity() + 1);
                    break;
                }
            }
        }
        else if (action.equals("decrease")) {
            for (int i = 0; i < cartItems.size(); i++) {
                CartItem item = cartItems.get(i);
                if (item.getProductId() == productId) {
                    if (item.getQuantity() > 1) {
                        item.setQuantity(item.getQuantity() - 1);
                    } else {
                        cartItems.remove(i);
                    }
                    break;
                }
            }
        }
        else if (action.equals("remove")) {
            for (int i = 0; i < cartItems.size(); i++) {
                if (cartItems.get(i).getProductId() == productId) {
                    cartItems.remove(i);
                    break;
                }
            }
        }
        
        // Update cart count for the navbar
        int cartCount = 0;
        for (CartItem item : cartItems) {
            cartCount += item.getQuantity();
        }
        session.setAttribute("cartCount", cartCount);
        
        // Redirect back to cart page
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}