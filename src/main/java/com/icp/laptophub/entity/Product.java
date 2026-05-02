package com.icp.laptophub.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Product {
    private int product_id;
    private String name;
    private int userId;
    private String description;
    private BigDecimal price;
    private String image;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Product(String name, String description, BigDecimal price, String image, int userId) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.image = image;
        this.userId = userId;
    }

    public Product(int product_id, String name, int userId, String description, BigDecimal price, String image,
                   Timestamp createdAt, Timestamp updatedAt) {
        this.product_id = product_id;
        this.name = name;
        this.userId = userId;
        this.description = description;
        this.price = price;
        this.image = image;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getId() { return product_id; }
    public String getName() { return name; }
    public int getUserId() { return userId; }
    public String getDescription() { return description; }
    public BigDecimal getPrice() { return price; }
    public String getImage() { return image; }
    public Timestamp getCreatedAt() { return createdAt; }
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setId(int product_id) { this.product_id = product_id; }
    public void setName(String name) { this.name = name; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setDescription(String description) { this.description = description; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public void setImage(String image) { this.image = image; }

    @Override
    public String toString() {
        return "[" + product_id + "] " + name + " (Created: " + createdAt + ")";
    }
}

