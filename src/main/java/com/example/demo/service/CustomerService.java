package com.example.demo.service;

import com.example.demo.dao.CustomerDAO;
import com.example.demo.model.Customer;

import java.util.List;

public class CustomerService {
    private final CustomerDAO dao = new CustomerDAO();

    public List<Customer> list(String q){ return dao.findAll(q); }
    public Customer get(int id){ return dao.findById(id); }
    public void save(Customer c){
        if (c.getId() == 0) dao.create(c); else dao.update(c);
    }
    public void delete(int id){ dao.delete(id); }
}
