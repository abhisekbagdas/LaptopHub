package com.icp.laptophub.controller.filter;

import com.icp.laptophub.utils.SessionUtil;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        if (path.startsWith("/static/")) {
            chain.doFilter(request, response);
            return;
        }

        boolean isLoggedIn = SessionUtil.getAttribute(req, "user") != null;
        boolean isAuthPage = "/login".equals(path) || "/register".equals(path);

        if (!isLoggedIn && !isAuthPage) {
            res.sendRedirect(contextPath + "/login");
            return;
        }

        if (isLoggedIn && isAuthPage) {
            res.sendRedirect(contextPath + "/home");
            return;
        }

        chain.doFilter(request, response);
    }
}
