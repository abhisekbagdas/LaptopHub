package com.icp.laptophub.model;

import java.math.BigDecimal;

public class CartItem {
    private int cartId;
    private int productId;
    private String name;
    private String shortSpec;
    private int quantity;
    private BigDecimal price;
    private String imageUrl;
    private BigDecimal totalPrice;

    public CartItem() {
    }

    public CartItem(int cartId, int productId, String name, String imageUrl, BigDecimal price, int quantity) {
        this.cartId = cartId;
        this.productId = productId;
        this.name = name;
        this.imageUrl = imageUrl;
        this.price = price;
        this.quantity = quantity;
    }

    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }

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

    public BigDecimal getTotalPrice() {
        if (totalPrice != null) {
            return totalPrice;
        }
        if (price == null) {
            return null;
        }
        return price.multiply(BigDecimal.valueOf(quantity));
    }

    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }
}
