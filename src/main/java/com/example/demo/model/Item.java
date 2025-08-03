package com.example.demo.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Item {
    private String itemId;
    private String name;
    private BigDecimal price;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructors, getters, and setters
    public Item() {}

    public Item(String itemId, String name, BigDecimal price) {
        this.itemId = itemId;
        this.name = name;
        this.price = price;
    }

    // Getters and setters for all fields
    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}