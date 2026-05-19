package com.icp.laptophub.controller;

import com.icp.laptophub.dao.CartDao;
import com.icp.laptophub.dao.CartDaoImpl;
import com.icp.laptophub.dao.OrderDao;
import com.icp.laptophub.dao.OrderDaoImpl;
import com.icp.laptophub.model.CartItem;
import com.icp.laptophub.model.Order;
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

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartDao cartDao   = new CartDaoImpl();
    private final OrderDao orderDao = new OrderDaoImpl();

    // ── GET: show the checkout form ──────────────────────────────────────────
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

        // Redirect back to cart if empty
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Compute totals
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            if (item.getTotalPrice() != null) {
                subtotal = subtotal.add(item.getTotalPrice());
            }
        }
        BigDecimal discount = BigDecimal.ZERO;
        BigDecimal total    = subtotal.subtract(discount);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal",  subtotal);
        request.setAttribute("discount",  discount);
        request.setAttribute("total",     total);

        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp")
               .forward(request, response);
    }

    // ── POST: place the order ────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Read form fields
        String fullName       = request.getParameter("fullName");
        String phone          = request.getParameter("phone");
        String address        = request.getParameter("address");
        String city           = request.getParameter("city");
        String paymentMethod  = request.getParameter("paymentMethod");

        // Basic server-side validation
        if (fullName == null || fullName.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()
                || address == null || address.trim().isEmpty()
                || city == null || city.trim().isEmpty()) {

            request.setAttribute("error", "Please fill in all required fields.");
            doGet(request, response); // re-show the form
            return;
        }

        // Fetch current cart items
        List<CartItem> cartItems = cartDao.fetchAllCartItemsByUser(user.getId());
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Recalculate totals on the server (never trust client-sent totals)
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            if (item.getTotalPrice() != null) {
                subtotal = subtotal.add(item.getTotalPrice());
            }
        }
        BigDecimal discount = BigDecimal.ZERO;
        BigDecimal total    = subtotal.subtract(discount);

        // Build Order object
        Order order = new Order(
                user.getId(),
                fullName.trim(),
                phone.trim(),
                address.trim(),
                city.trim(),
                paymentMethod != null ? paymentMethod : "COD",
                subtotal,
                discount,
                total
        );

        // Persist (inserts order + items, clears cart)
        int orderId = orderDao.placeOrder(order, cartItems);
        if (orderId == -1) {
            request.setAttribute("error", "Something went wrong while placing your order. Please try again.");
            doGet(request, response);
            return;
        }

        // Update cart count badge in session
        session.setAttribute("cartCount", 0);

        response.sendRedirect(request.getContextPath() + "/order-confirmation?orderId=" + orderId);
    }
}
