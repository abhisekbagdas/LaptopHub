package com.icp.laptophub.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Product {
    private int product_id;
    private String name;
    private int userId;
    private String description;
    private BigDecimal price;
    private String image;
    private int stock;
    private Timestamp createdAt;
    private Timestamp updatedAt;


    public Product() {
    }

    public Product(String name, String description, BigDecimal price, String image, int userId, int stock) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.image = image;
        this.userId = userId;
        this.stock = stock;
    }

    public Product(int product_id, String name, int userId, String description, BigDecimal price, String image,
                   int stock, Timestamp createdAt, Timestamp updatedAt) {
        this.product_id = product_id;
        this.name = name;
        this.userId = userId;
        this.description = description;
        this.price = price;
        this.image = image;
        this.stock = stock;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getId() { return product_id; }
    public String getName() { return name; }
    public int getUserId() { return userId; }
    public String getDescription() { return description; }
    public BigDecimal getPrice() { return price; }
    public String getImage() { return image; }
    public int getStock() { return stock; }
    public Timestamp getCreatedAt() { return createdAt; }
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setId(int product_id) { this.product_id = product_id; }
    public void setName(String name) { this.name = name; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setDescription(String description) { this.description = description; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public void setImage(String image) { this.image = image; }
    public void setStock(int stock) { this.stock = stock; }
    public void setProductId(int productId) {this.product_id = productId;}
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "[" + product_id + "] " + name + " (Created: " + createdAt + ") Stock: " + stock;
    }

}

