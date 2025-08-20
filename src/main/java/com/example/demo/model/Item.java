package com.example.demo.model;

import java.math.BigDecimal;

public class Item {
    private int id;
    private String name;
    private BigDecimal price;
    private int stock;

    public Item(){}

    public Item(int id, String name, BigDecimal price, int stock){
        this.id=id; this.name=name; this.price=price; this.stock=stock;
    }

    // getters/setters
    public int getId(){return id;}
    public void setId(int id){this.id=id;}
    public String getName(){return name;}
    public void setName(String name){this.name=name;}
    public BigDecimal getPrice(){return price;}
    public void setPrice(BigDecimal price){this.price=price;}
    public int getStock(){return stock;}
    public void setStock(int stock){this.stock=stock;}
}
