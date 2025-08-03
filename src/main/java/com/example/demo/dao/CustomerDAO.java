package com.example.demo.dao;

import com.example.demo.model.Customer;
import com.example.demo.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    public void addCustomer(Customer customer) throws SQLException {
        Connection conn = null;
        CallableStatement cs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "{call AddCustomer(?, ?, ?, ?, ?)}";
            cs = conn.prepareCall(sql);
            cs.setString(1, customer.getAccountNo());
            cs.setString(2, customer.getName());
            cs.setString(3, customer.getAddress());
            cs.setString(4, customer.getPhone());
            cs.setInt(5, customer.getUnitsConsumed());
            cs.execute();
        } finally {
            if (cs != null) cs.close();
            if (conn != null) conn.close();
        }
    }

    public void updateCustomer(Customer customer) throws SQLException {
        Connection conn = null;
        CallableStatement cs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "{call UpdateCustomer(?, ?, ?, ?, ?)}";
            cs = conn.prepareCall(sql);
            cs.setString(1, customer.getAccountNo());
            cs.setString(2, customer.getName());
            cs.setString(3, customer.getAddress());
            cs.setString(4, customer.getPhone());
            cs.setInt(5, customer.getUnitsConsumed());
            cs.execute();
        } finally {
            if (cs != null) cs.close();
            if (conn != null) conn.close();
        }
    }

    public Customer getCustomer(String accountNo) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Customer customer = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM customers WHERE account_no = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, accountNo);
            rs = ps.executeQuery();

            if (rs.next()) {
                customer = new Customer();
                customer.setAccountNo(rs.getString("account_no"));
                customer.setName(rs.getString("name"));
                customer.setAddress(rs.getString("address"));
                customer.setPhone(rs.getString("phone"));
                customer.setUnitsConsumed(rs.getInt("units_consumed"));
                customer.setCreatedAt(rs.getTimestamp("created_at"));
                customer.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return customer;
    }

    public List<Customer> getAllCustomers() throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Customer> customers = new ArrayList<>();

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM customers";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Customer customer = new Customer();
                customer.setAccountNo(rs.getString("account_no"));
                customer.setName(rs.getString("name"));
                customer.setAddress(rs.getString("address"));
                customer.setPhone(rs.getString("phone"));
                customer.setUnitsConsumed(rs.getInt("units_consumed"));
                customer.setCreatedAt(rs.getTimestamp("created_at"));
                customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                customers.add(customer);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return customers;
    }
}