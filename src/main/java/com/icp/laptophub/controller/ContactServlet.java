package com.icp.laptophub.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet("/contact")
public class ContactServlet  extends HttpServlet {

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response)
            throws jakarta.servlet.ServletException, java.io.IOException {
        // Forward to contact.jsp
        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }
}
