package com.icp.laptophub.controller;

import com.icp.laptophub.dao.CartDao;
import com.icp.laptophub.dao.CartDaoImpl;
import com.icp.laptophub.model.CartItem;
import com.icp.laptophub.model.User;
import com.icp.laptophub.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartDao cartDao = new CartDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<CartItem> cartItems = cartDao.findCartItemsByUserId(user.getId());
        BigDecimal subtotal = BigDecimal.ZERO;

        for (CartItem item : cartItems) {
            if (item.getTotalPrice() != null) {
                subtotal = subtotal.add(item.getTotalPrice());
            }
        }

        BigDecimal discount = BigDecimal.ZERO;
        BigDecimal total = subtotal.subtract(discount);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("discount", discount);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/WEB-INF/views/cart.jsp")
                .forward(request, response);
    }

}