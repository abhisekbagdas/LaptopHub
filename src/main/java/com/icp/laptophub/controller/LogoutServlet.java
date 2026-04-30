package com.icp.laptophub.controller;

import com.icp.laptophub.utils.CookieUtil;
import com.icp.laptophub.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        SessionUtil.invalidateSession(request);

        CookieUtil.deleteCookie(response, "username");

        response.sendRedirect(request.getContextPath() + "/login");
    }
}
