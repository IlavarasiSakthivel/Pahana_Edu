package com.example.demo.model;

public class Customer {
    private int id;
    private String accountNumber;
    private String name;
    private String address;
    private String telephone;
    private int unitsConsumed;

    public Customer() {}

    public Customer(int id, String accountNumber, String name, String address, String telephone, int unitsConsumed) {
        this.id = id; this.accountNumber = accountNumber; this.name = name;
        this.address = address; this.telephone = telephone; this.unitsConsumed = unitsConsumed;
    }

    // getters and setters...
    public int getId(){return id;}
    public void setId(int id){this.id=id;}
    public String getAccountNumber(){return accountNumber;}
    public void setAccountNumber(String a){this.accountNumber=a;}
    public String getName(){return name;}
    public void setName(String n){this.name=n;}
    public String getAddress(){return address;}
    public void setAddress(String a){this.address=a;}
    public String getTelephone(){return telephone;}
    public void setTelephone(String t){this.telephone=t;}
    public int getUnitsConsumed(){return unitsConsumed;}
    public void setUnitsConsumed(int u){this.unitsConsumed=u;}
}
