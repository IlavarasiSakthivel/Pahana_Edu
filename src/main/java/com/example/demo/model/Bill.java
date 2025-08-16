package com.example.demo.model;

import java.time.LocalDateTime;
import java.util.List;

public class Bill {
    private int id;
    private String customerAccountNumber;
    private double totalAmount;
    private LocalDateTime billDate;
    private int cashierId;
    private List<Bill_Item> billItems;

    // Constructors, getters, setters
    public Bill() {}

    public Bill(int id, String customerAccountNumber, double totalAmount, LocalDateTime billDate, int cashierId) {
        this.id = id;
        this.customerAccountNumber = customerAccountNumber;
        this.totalAmount = totalAmount;
        this.billDate = billDate;
        this.cashierId = cashierId;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCustomerAccountNumber() { return customerAccountNumber; }
    public void setCustomerAccountNumber(String customerAccountNumber) { this.customerAccountNumber = customerAccountNumber; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public LocalDateTime getBillDate() { return billDate; }
    public void setBillDate(LocalDateTime billDate) { this.billDate = billDate; }
    public int getCashierId() { return cashierId; }
    public void setCashierId(int cashierId) { this.cashierId = cashierId; }
    public List<Bill_Item> getBillItems() { return billItems; }
    public void setBillItems(List<Bill_Item> billItems) { this.billItems = billItems; }
}