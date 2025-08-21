package com.example.demo.dao;

import com.example.demo.model.Customer;
import com.example.demo.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.example.demo.model.Customer;
import com.example.demo.util.DBConnection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import java.util.ArrayList;

public abstract class CustomerDAO {

    public List<Customer> findAll(String q) {
        List<Customer> data = new ArrayList<>();
        String sql = "SELECT * FROM customers " +
                (q != null && !q.isBlank() ? "WHERE name LIKE ? OR account_number LIKE ? " : "") +
                "ORDER BY id DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            if (q != null && !q.isBlank()) {
                ps.setString(1, "%" + q + "%");
                ps.setString(2, "%" + q + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    data.add(map(rs));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return data;
    }

    public Customer findById(int id) {
        String sql = "SELECT * FROM customers WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void create(Customer cust) {
        String sql = "INSERT INTO customers(account_number,name,address,telephone,units_consumed) VALUES(?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, cust.getAccountNumber());
            ps.setString(2, cust.getName());
            ps.setString(3, cust.getAddress());
            ps.setString(4, cust.getTelephone());
            ps.setInt(5, cust.getUnitsConsumed());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void update(Customer cust) {
        String sql = "UPDATE customers SET account_number=?, name=?, address=?, telephone=?, units_consumed=? WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, cust.getAccountNumber());
            ps.setString(2, cust.getName());
            ps.setString(3, cust.getAddress());
            ps.setString(4, cust.getTelephone());
            ps.setInt(5, cust.getUnitsConsumed());
            ps.setInt(6, cust.getId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("DELETE FROM customers WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    private Customer map(ResultSet rs) throws SQLException {
        return new Customer(
                rs.getInt("id"),
                rs.getString("account_number"),
                rs.getString("name"),
                rs.getString("address"),
                rs.getString("telephone"),
                rs.getInt("units_consumed")
        );
    }

    public abstract Customer getCustomerByAccountNumber(String accountNumber) throws Exception;

    public abstract Customer getCustomerById(int id) throws Exception;

    public abstract List<Customer> getAllCustomers() throws Exception;

    public abstract void addCustomer(Customer customer) throws Exception;

    public abstract void saveCustomer(Customer customer) throws Exception;

    public abstract void updateCustomer(Customer customer) throws Exception;

    public abstract void deleteCustomer(int id) throws Exception;

    public abstract void deleteCustomer(String accountNumber) throws Exception;
}
