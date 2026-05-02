package com.icp.laptophub.dao;

import com.icp.laptophub.entity.Product;
import com.icp.laptophub.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProductDaoImpl implements ProductDao {

    @Override
    public boolean insertProduct(Product product) {
        if (findProductByName(product.getName()) != null) {
            System.out.println("Product already exists: " + product.getName());
            return false;
        }

        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO products (user_id, name, description, price, image) VALUES (?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, product.getUserId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getDescription());
            ps.setBigDecimal(4, product.getPrice());
            ps.setString(5, product.getImage());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
//            throw new RuntimeException(e);
            System.out.println("Error while inserting product: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public ArrayList<Product> fetchAllProducts() {
        ArrayList<Product> products = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM products";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("user_id"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getString("image"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                products.add(product);
            }
             return products;
        } catch (SQLException e) {
            System.out.println("Error while fetching products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return products;
    }

    @Override
    public Product findProductByName(String name) {
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM products WHERE LOWER(name) = LOWER(?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                rs.getInt("product_id"),
                rs.getString("name"),
                rs.getInt("user_id"),
                rs.getString("description"),
                rs.getBigDecimal("price"),
                rs.getString("image"),
                rs.getTimestamp("created_at"),
                rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error while fetching product: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    @Override
    public Product findProductById(int id) {
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM products WHERE product_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("user_id"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getString("image"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error while fetching product: " + e.getMessage());
        }finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    @Override
    public boolean updateProduct(Product product) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE products SET name = ?, description = ?, price = ?, image = ? WHERE product_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setString(4, product.getImage());
            ps.setInt(5, product.getId());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error while updating product: " + e.getMessage());
        }finally {
            DatabaseConnection.closeConnection(conn);
        }
        return false;
    }

    @Override
    public boolean deleteProduct(int id) {
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM products WHERE product_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error while deleting product: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return false;
    }

    @Override
    public ArrayList<Product> searchProducts(String keyword) {
        ArrayList<Product> products = new ArrayList<>();
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM products WHERE LOWER(name) LIKE LOWER(?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("user_id"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getString("image"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Error while searching products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return products;
    }

    @Override
    public ArrayList<Product> fetchAllProductsByUserId(int userId) {
        ArrayList<Product> products = new ArrayList<>();
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM products WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("user_id"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getString("image"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                products.add(product);
            }
        }catch (SQLException e) {
            System.out.println("Error while fetching products by user id: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return products;
    }

    @Override
    public ArrayList<Product> searchProductsByUserId(int userId, String keyword) {
        ArrayList<Product> products = new ArrayList<>();
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM products WHERE user_id = ? AND LOWER(name) LIKE LOWER(?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("user_id"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getString("image"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Error while searching products by user id: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return products;
    }

    @Override
    public boolean checkUserForProduct(int userId, int productId) {
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT user_id FROM products WHERE product_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int productUserId = rs.getInt("user_id");
                return userId == productUserId;
            }
        } catch (SQLException e) {
            System.out.println("Error while checking user for product: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return false;
    }
}
