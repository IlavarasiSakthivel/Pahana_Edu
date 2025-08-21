package com.example.demo.dao.impl;

import com.example.demo.dao.BillDAO;
import com.example.demo.model.Bill;
import com.example.demo.config.DatabaseConfig;
import com.example.demo.model.BillItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAOImpl extends BillDAO {
    @Override
    public Bill getBillById(int id) throws Exception {
        String sql = "SELECT * FROM bills WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Bill bill = extractBillFromResultSet(rs);
                bill.setBillItems(getBillItems(bill.getId())); // fixed method name
                return bill;
            }
            return null;
        }
    }

    @Override
    public List<Bill> getAllBills() throws Exception {
        String sql = "SELECT * FROM bills ORDER BY bill_date DESC";
        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Bill bill = extractBillFromResultSet(rs);
                bill.setBillItems(getBillItems(bill.getId())); // fixed method name
                bills.add(bill);
            }
        }
        return bills;
    }

    @Override
    public int saveBill(Bill bill) throws Exception {
        String sql = "INSERT INTO bills (customer_account_number, total_amount, bill_date, cashier_id) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, bill.getCustomerAccountNumber());
            stmt.setDouble(2, bill.getTotalAmount());
            stmt.setTimestamp(3, Timestamp.valueOf(bill.getBillDate()));
            stmt.setInt(4, bill.getCashierId());
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                int billId = rs.getInt(1);
                saveBillItems(billId, bill.getBillItems()); // fixed getter name
                return billId;
            }
            return -1;
        }
    }

    @Override
    public List<Bill> getBillsByCustomer(String accountNumber) throws Exception {
        String sql = "SELECT * FROM bills WHERE customer_account_number = ? ORDER BY bill_date DESC";
        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, accountNumber);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Bill bill = extractBillFromResultSet(rs);
                bill.setBillItems(getBillItems(bill.getId()));
                bills.add(bill);
            }
        }
        return bills;
    }

    @Override
    public List<Bill> getBillsByDateRange(Date startDate, Date endDate) throws Exception {
        String sql = "SELECT * FROM bills WHERE bill_date BETWEEN ? AND ? ORDER BY bill_date DESC";
        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, startDate);
            stmt.setDate(2, endDate);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Bill bill = extractBillFromResultSet(rs);
                bill.setBillItems(getBillItems(bill.getId()));
                bills.add(bill);
            }
        }
        return bills;
    }

    private List<BillItem> getBillItems(int billId) throws Exception {
        String sql = "SELECT * FROM bill_items WHERE bill_id = ?";
        List<BillItem> billItems = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                BillItem billItem = new BillItem();
                billItem.setBillId(rs.getInt("bill_id"));
                billItem.setItemId(rs.getInt("item_id"));
                billItem.setQuantity(rs.getInt("quantity"));
                billItem.setPriceAtTime(rs.getDouble("price_at_time"));
                billItems.add(billItem);
            }
        }
        return billItems;
    }

    private void saveBillItems(int billId, List<BillItem> billItems) throws Exception {
        String sql = "INSERT INTO bill_items (bill_id, item_id, quantity, price_at_time) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (BillItem billItem : billItems) {
                stmt.setInt(1, billId);
                stmt.setInt(2, billItem.getItemId());
                stmt.setInt(3, billItem.getQuantity());
                stmt.setDouble(4, billItem.getPriceAtTime());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }

    private Bill extractBillFromResultSet(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setId(rs.getInt("id"));
        bill.setCustomerAccountNumber(rs.getString("customer_account_number"));
        bill.setTotalAmount(rs.getDouble("total_amount"));
        bill.setBillDate(rs.getTimestamp("bill_date").toLocalDateTime());
        bill.setCashierId(rs.getInt("cashier_id"));
        return bill;
    }
}