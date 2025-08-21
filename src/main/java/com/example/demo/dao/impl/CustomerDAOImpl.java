package com.example.demo.dao.impl;

import com.example.demo.dao.CustomerDAO;
import com.example.demo.model.Customer;
import com.example.demo.config.DatabaseConfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class CustomerDAOImpl extends CustomerDAO {
    @Override
    public Customer getCustomerByAccountNumber(String accountNumber) throws Exception {
        String sql = "SELECT * FROM customers WHERE account_number = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, accountNumber);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractCustomerFromResultSet(rs);
            }
            return null;
        }
    }

    @Override
    public Customer getCustomerById(int id) throws Exception {
        return null;
    }

    @Override
    public List<Customer> getAllCustomers() throws Exception {
        String sql = "SELECT * FROM customers";
        List<Customer> customers = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                customers.add(extractCustomerFromResultSet(rs));
            }
        }
        return customers;
    }

    @Override
    public void addCustomer(Customer customer) throws Exception {

    }

    @Override
    public void saveCustomer(Customer customer) throws Exception {
        String sql = "INSERT INTO customers (account_number, name, address, telephone, units_consumed, registration_date) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, customer.getAccountNumber());
            stmt.setString(2, customer.getName());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getTelephone());
            stmt.setInt(5, customer.getUnitsConsumed());

            stmt.executeUpdate();
        }
    }

    @Override
    public void updateCustomer(Customer customer) throws Exception {
        String sql = "UPDATE customers SET name = ?, address = ?, telephone = ?, units_consumed = ? WHERE account_number = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getTelephone());
            stmt.setInt(4, customer.getUnitsConsumed());
            stmt.setString(5, customer.getAccountNumber());
            stmt.executeUpdate();
        }
    }

    @Override
    public void deleteCustomer(int id) throws Exception {

    }

    @Override
    public void deleteCustomer(String accountNumber) throws Exception {
        String sql = "DELETE FROM customers WHERE account_number = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, accountNumber);
            stmt.executeUpdate();
        }
    }

    private Customer extractCustomerFromResultSet(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setAccountNumber(rs.getString("account_number"));
        customer.setName(rs.getString("name"));
        customer.setAddress(rs.getString("address"));
        customer.setTelephone(rs.getString("telephone"));
        customer.setUnitsConsumed(rs.getInt("units_consumed"));
        return customer;
    }
}