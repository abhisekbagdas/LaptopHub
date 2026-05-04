package com.icp.laptophub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    // This runs when you visit /cart in the browser
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Just forward to the cart page
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp")
                .forward(request, response);
    }

}