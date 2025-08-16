package com.example.demo.dao;

import com.example.demo.model.Customer;
import java.util.List;

public interface CustomerDAO {
    Customer getCustomerByAccountNumber(String accountNumber) throws Exception;
    List<Customer> getAllCustomers() throws Exception;
    void saveCustomer(Customer customer) throws Exception;
    void updateCustomer(Customer customer) throws Exception;
    void deleteCustomer(String accountNumber) throws Exception;
}