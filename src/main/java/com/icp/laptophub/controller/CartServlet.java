package com.icp.laptophub.controller;

import com.icp.laptophub.dao.CartDao;
import com.icp.laptophub.dao.CartDaoImpl;
import com.icp.laptophub.model.CartItem;
import com.icp.laptophub.model.User;
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

        List<CartItem> cartItems = cartDao.fetchAllCartItemsByUser(user.getId());

        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            if (item.getTotalPrice() != null) {
                subtotal = subtotal.add(item.getTotalPrice());
            }
        }

        BigDecimal discount = BigDecimal.ZERO;
        BigDecimal total = subtotal.subtract(discount);

        int cartCount = cartDao.getCartItemCount(user.getId());
        session.setAttribute("cartCount", cartCount);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("discount", discount);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
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

            // Redirect back to the page the user came from with a success flag
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                // Append cartSuccess param to the referer URL
                String separator = referer.contains("?") ? "&" : "?";
                response.sendRedirect(referer + separator + "cartSuccess=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/home?cartSuccess=true");
            }
            return;
        } else if (action.equals("increase")) {
            cartDao.increaseQuantity(userId, productId);
        } else if (action.equals("decrease")) {
            cartDao.decreaseQuantity(userId, productId);
        } else if (action.equals("remove")) {
            cartDao.removeProductFromCart(userId, productId);
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
