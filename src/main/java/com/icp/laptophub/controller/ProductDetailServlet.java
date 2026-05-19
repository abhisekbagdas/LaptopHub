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
import java.util.ArrayList;

@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

    private ProductDao productDao;

    @Override
    public void init() {
        productDao = new ProductDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        try {
            int productId = Integer.parseInt(idParam);
            Product product = productDao.findProductById(productId);

            if (product != null) {
                // Fetch some products for the related products section
                List<Product> allProducts = productDao.fetchAllProducts();
                List<Product> relatedProducts = new ArrayList<>();
                int maxRelated = 4;
                for (Product p : allProducts) {
                    if (p.getId() != productId) {
                        relatedProducts.add(p);
                        if (relatedProducts.size() >= maxRelated) {
                            break;
                        }
                    }
                }

                request.setAttribute("product", product);
                request.setAttribute("relatedProducts", relatedProducts);
                request.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/products");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }
}
