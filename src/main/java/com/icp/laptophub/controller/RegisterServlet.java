package com.icp.laptophub.controller;

import com.icp.laptophub.dao.UserDao;
import com.icp.laptophub.dao.UserDaoImpl;
import com.icp.laptophub.entity.User;
import com.icp.laptophub.utils.PasswordUtil;
import com.icp.laptophub.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        StringBuilder errors = new StringBuilder();

        if (ValidationUtil.isNullOrEmpty(username)
                || !ValidationUtil.isAlphanumericStartingWithLetter(username)
                || username.length() < 5) {
            errors.append("Username must be alphanumeric, start with a letter, and be at least 5 characters. ");
        }
        if (!ValidationUtil.isValidEmail(email)) {
            errors.append("Invalid email format. ");
        }
        if (!ValidationUtil.isValidPassword(password)) {
            errors.append("Password must be 8+ characters with uppercase, number, and symbol. ");
        }
        if (!ValidationUtil.doPasswordsMatch(password, confirmPassword)) {
            errors.append("Passwords do not match. ");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("error", errors.toString().trim());
            request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                    .forward(request, response);
            return;
        }

        String hashedPassword = PasswordUtil.getHashPassword(password);
        User user = new User(username, email, hashedPassword);

        boolean success = userDao.insertUser(user);

        if (!success) {
            request.setAttribute("error", "Username or email already exists.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                    .forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/login");
    }
}