package com.icp.laptophub.entity;

import java.math.BigDecimal;

public class CartItem {
    private int productId;
    private String name;
    private String imageUrl;
    private BigDecimal price;
    private int quantity;
    
    public CartItem(int productId, String name, String imageUrl, BigDecimal price, int quantity) {
        this.productId = productId;
        this.name = name;
        this.imageUrl = imageUrl;
        this.price = price;
        this.quantity = quantity;
    }
    
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public BigDecimal getTotalPrice() {
        return price.multiply(new BigDecimal(quantity));
    }
}
