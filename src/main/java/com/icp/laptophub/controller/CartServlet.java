package com.icp.laptophub.controller;

import com.icp.laptophub.dao.CartDao;
import com.icp.laptophub.dao.CartDaoImpl;
import com.icp.laptophub.entity.CartItem;
import com.icp.laptophub.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartDao cartDao = new CartDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Fetch cart from database
        List<CartItem> cartItems = cartDao.fetchAllCartItemsByUser(user.getId());
        
        // Calculate totals
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            subtotal = subtotal.add(item.getTotalPrice());
        }
        
        BigDecimal discount = BigDecimal.ZERO; // Simple logic: no discount by default
        BigDecimal total = subtotal.subtract(discount);
        
        // Update session cart count for navbar
        int cartCount = cartDao.getCartItemCount(user.getId());
        session.setAttribute("cartCount", cartCount);
        
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
            
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            // Must be logged in to add to cart
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
            
        String action = request.getParameter("action");
        String productIdStr = request.getParameter("productId");
        
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        int productId = Integer.parseInt(productIdStr);
        int userId = user.getId();
        
        if (action == null || action.equals("add")) {
            cartDao.addProductToCart(userId, productId);
        } 
        else if (action.equals("increase")) {
            cartDao.increaseQuantity(userId, productId);
        }
        else if (action.equals("decrease")) {
            cartDao.decreaseQuantity(userId, productId);
        }
        else if (action.equals("remove")) {
            cartDao.removeProductFromCart(userId, productId);
        }
        
        // Redirect back to cart page
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}