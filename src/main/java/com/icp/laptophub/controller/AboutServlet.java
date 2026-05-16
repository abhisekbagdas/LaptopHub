package com.icp.laptophub.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet("/about-us")
public class AboutServlet extends HttpServlet {

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response)
            throws jakarta.servlet.ServletException, java.io.IOException {
        // Forward to about.jsp
        request.getRequestDispatcher("/WEB-INF/views/about.jsp").forward(request, response);
    }
}
