package com.icp.laptophub.controller;

import com.icp.laptophub.dao.OrderDao;
import com.icp.laptophub.dao.OrderDaoImpl;
import com.icp.laptophub.model.Order;
import com.icp.laptophub.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/order-confirmation")
public class OrderConfirmationServlet extends HttpServlet {

    private final OrderDao orderDao = new OrderDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(orderIdParam.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        Order order = orderDao.findOrderById(orderId);

        // Security: ensure order belongs to the logged-in user
        if (order == null || order.getUserId() != user.getId()) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        request.setAttribute("order", order);
        request.getRequestDispatcher("/WEB-INF/views/order-confirmation.jsp")
               .forward(request, response);
    }
}
