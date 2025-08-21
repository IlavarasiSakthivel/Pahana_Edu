package com.example.demo.service;

import com.example.demo.dao.CustomerDAO;
import com.example.demo.model.Customer;

import java.util.List;

public class CustomerService {
    private final CustomerDAO dao = new CustomerDAO() {
        @Override
        public Customer getCustomerByAccountNumber(String accountNumber) throws Exception {
            return null;
        }

        @Override
        public Customer getCustomerById(int id) throws Exception {
            return null;
        }

        @Override
        public List<Customer> getAllCustomers() throws Exception {
            return List.of();
        }

        @Override
        public void addCustomer(Customer customer) throws Exception {

        }

        @Override
        public void saveCustomer(Customer customer) throws Exception {

        }

        @Override
        public void updateCustomer(Customer customer) throws Exception {

        }

        @Override
        public void deleteCustomer(int id) throws Exception {

        }

        @Override
        public void deleteCustomer(String accountNumber) throws Exception {

        }
    };

    public List<Customer> list(String q){ return dao.findAll(q); }
    public Customer get(int id){ return dao.findById(id); }
    public void save(Customer c){
        if (c.getId() == 0) dao.create(c); else dao.update(c);
    }
    public void delete(int id){ dao.delete(id); }
}
