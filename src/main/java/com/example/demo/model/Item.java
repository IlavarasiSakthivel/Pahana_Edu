package com.example.demo.model;

import java.math.BigDecimal;

public class Item {
    private int id;
    private String name;
    private String description;
    private double price;
    private int stockQuantity;
    private String category;

    public Item() {
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public BigDecimal getPrice() {
        return java.math.BigDecimal.valueOf(price);
    }
    public void setPrice(double price) {
        this.price = price;
    }

    // For servlet compatibility - handle BigDecimal
    public void setPrice(java.math.BigDecimal price) {
        this.price = price != null ? price.doubleValue() : 0.0;
    }

    // Optional: for direct double access
    public double getPriceAsDouble() {
        return price;
    }
    public java.math.BigDecimal getPriceAsBigDecimal() {
        return java.math.BigDecimal.valueOf(price);
    }

    public int getStockQuantity() {
        return stockQuantity;
    }
    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    // For servlet compatibility
    public void setStock(int stock) {
        this.stockQuantity = stock;
    }
    public int getStock() {
        return stockQuantity;
    }

    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
}
