package com.icp.laptophub.controller;

import com.icp.laptophub.dao.ProductDao;
import com.icp.laptophub.dao.ProductDaoImpl;
import com.icp.laptophub.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private final ProductDao productDao = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        
        // Fetch all products to display on the home page
        List<Product> products = productDao.fetchAllProducts();
        
        // Set the products so home.jsp can loop through them
        request.setAttribute("featuredProducts", products);
        
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
