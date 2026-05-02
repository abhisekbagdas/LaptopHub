package com.icp.laptophub.dao;

import com.icp.laptophub.entity.Product;

import java.util.ArrayList;

public interface ProductDao {

    boolean insertProduct(Product product);
    ArrayList<Product> fetchAllProducts();
    Product findProductByName(String name);

    Product findProductById(int id);
    boolean updateProduct(Product product);
    boolean deleteProduct(int id);
    ArrayList<Product> searchProducts(String keyword);

    ArrayList<Product> fetchAllProductsByUserId(int userId);
    ArrayList<Product> searchProductsByUserId(int userId, String keyword);

    boolean checkUserForProduct(int userId, int productId);
}