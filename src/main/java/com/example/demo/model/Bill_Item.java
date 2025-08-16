package com.example.demo.model;

public class Bill_Item {
    private int billId;
    private int itemId;
    private int quantity;
    private double priceAtTime;

    // Constructors, getters, setters
    public Bill_Item() {}

    public Bill_Item(int billId, int itemId, int quantity, double priceAtTime) {
        this.billId = billId;
        this.itemId = itemId;
        this.quantity = quantity;
        this.priceAtTime = priceAtTime;
    }

    // Getters and setters
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getPriceAtTime() { return priceAtTime; }
    public void setPriceAtTime(double priceAtTime) { this.priceAtTime = priceAtTime; }
}