package com.icp.laptophub.model;

import java.math.BigDecimal;

public class CartItem {
    private int productId;
    private String name;
    private String shortSpec; // e.g., description
    private int quantity;
    private BigDecimal price; // Unit price
    private String imageUrl;
    private BigDecimal totalPrice; // Calculated: quantity * price

    // Getters and Setters
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getShortSpec() { return shortSpec; }
    public void setShortSpec(String shortSpec) { this.shortSpec = shortSpec; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }
}