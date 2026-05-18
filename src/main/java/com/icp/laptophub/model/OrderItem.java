package com.icp.laptophub.model;

import java.math.BigDecimal;

public class OrderItem {

    private int itemId;
    private int orderId;
    private int productId;
    private String productName;
    private String image;
    private BigDecimal unitPrice;
    private int quantity;
    private BigDecimal totalPrice;

    public OrderItem() {}

    public OrderItem(int orderId, int productId, String productName,
                     String image, BigDecimal unitPrice, int quantity) {
        this.orderId = orderId;
        this.productId = productId;
        this.productName = productName;
        this.image = image;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.totalPrice = unitPrice.multiply(BigDecimal.valueOf(quantity));
    }

    // ── Getters ──────────────────────────────────────
    public int getItemId()           { return itemId; }
    public int getOrderId()          { return orderId; }
    public int getProductId()        { return productId; }
    public String getProductName()   { return productName; }
    public String getImage()         { return image; }
    public BigDecimal getUnitPrice() { return unitPrice; }
    public int getQuantity()         { return quantity; }
    public BigDecimal getTotalPrice(){ return totalPrice; }

    // ── Setters ──────────────────────────────────────
    public void setItemId(int itemId)                { this.itemId = itemId; }
    public void setOrderId(int orderId)              { this.orderId = orderId; }
    public void setProductId(int productId)          { this.productId = productId; }
    public void setProductName(String productName)   { this.productName = productName; }
    public void setImage(String image)               { this.image = image; }
    public void setUnitPrice(BigDecimal unitPrice)   { this.unitPrice = unitPrice; }
    public void setQuantity(int quantity)            { this.quantity = quantity; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }
}
