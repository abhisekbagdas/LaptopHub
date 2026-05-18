package com.icp.laptophub.controller.filter;

import com.icp.laptophub.model.User;
import com.icp.laptophub.utils.SessionUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    // Defining paths that do NOT require login
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
            "/",
            "/home",
            "/products",
            "/about-us",
            "/contact",
            "/static/",
            "/login",
            "/register"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        // Allow static resources to pass through
        if (path.startsWith("/static/")) {
            chain.doFilter(request, response);
            return;
        }

        User user = (User) SessionUtil.getAttribute(req, "user");
        boolean isLoggedIn = user != null;
        boolean isPublicPath = PUBLIC_PATHS.stream().anyMatch(path::startsWith);

        // Restrict admin access to admin@example.com only
        if (path.startsWith("/admin")) {
            if (!isLoggedIn || !user.getEmail().equals("admin@example.com")) {
                // Return 403 Forbidden or redirect to home. Let's send a 403 error.
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied. Admin only.");
                return;
            }
        }

        // 1. If NOT logged in and trying to access a protected page
        if (!isLoggedIn && !isPublicPath) {
            // Save the original URL to redirect back after login
            String returnUrl = req.getRequestURI();
            if (req.getQueryString() != null) {
                returnUrl += "?" + req.getQueryString();
            }

            // Redirect to login with the return URL
            res.sendRedirect(contextPath + "/login?returnUrl=" + java.net.URLEncoder.encode(returnUrl, "UTF-8"));
            return;
        }

        // 2. If logged in and trying to access login/register, redirect to home (or saved returnUrl)
        if (isLoggedIn && (path.equals("/login") || path.equals("/register"))) {
            // Optional: You could check for a returnUrl here too, but usually logged-in users go to home
            res.sendRedirect(contextPath + "/home");
            return;
        }

        chain.doFilter(request, response);
    }
}