package com.example.demo.model;

import java.math.BigDecimal;

public class BillItem {
    private int id;
    private int billId;
    private int itemId;
    private int qty;
    private BigDecimal unitPrice;
    private BigDecimal lineTotal;
    private String itemName; // convenience for views

    // getters/setters
    public int getId(){return id;}
    public void setId(int id){this.id=id;}
    public int getBillId(){return billId;}
    public void setBillId(int billId){this.billId=billId;}
    public int getItemId(){return itemId;}
    public void setItemId(int itemId){this.itemId=itemId;}
    public int getQty(){return qty;}
    public void setQty(int qty){this.qty=qty;}
    public BigDecimal getUnitPrice(){return unitPrice;}
    public void setUnitPrice(BigDecimal unitPrice){this.unitPrice=unitPrice;}
    public BigDecimal getLineTotal(){return lineTotal;}
    public void setLineTotal(BigDecimal lineTotal){this.lineTotal=lineTotal;}
    public String getItemName(){return itemName;}
    public void setItemName(String itemName){this.itemName=itemName;}
}
