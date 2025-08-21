package com.example.demo.dao;

import com.example.demo.model.Bill;
import com.example.demo.model.BillItem;
import com.example.demo.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {
    public int createBill(String customerAccountNumber, BigDecimal total) throws SQLException {
        String sql = "INSERT INTO bills(customer_account_number, total_amount) VALUES(?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, customerAccountNumber);
            ps.setBigDecimal(2, total);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        throw new SQLException("Cannot create bill");
    }

    public void addBillItem(int billId, int itemId, int qty, BigDecimal unitPrice, BigDecimal lineTotal) throws SQLException {
        String sql = "INSERT INTO bill_items(bill_id, item_id, quantity, price_at_time) VALUES(?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, billId);
            ps.setInt(2, itemId);
            ps.setInt(3, qty);
            ps.setBigDecimal(4, unitPrice);
            ps.executeUpdate();
        }
    }

    public Bill findByIdWithItems(int billId) {
        Bill bill = null;
        String bsql = "SELECT b.*, c.id AS customer_id, c.account_number AS customer_account_number, c.name AS customer_name " +
                      "FROM bills b JOIN customers c ON b.customer_account_number = c.account_number WHERE b.id=?";
        String isql = "SELECT bi.*, it.name AS itemName FROM bill_items bi " +
                "JOIN items it ON it.id = bi.item_id WHERE bill_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps1 = c.prepareStatement(bsql)) {

            ps1.setInt(1, billId);
            try (ResultSet rs = ps1.executeQuery()) {
                if (rs.next()) {
                    bill = new Bill();
                    bill.setId(rs.getInt("id"));
                    bill.setCustomerId(rs.getInt("customer_id"));
                    bill.setCustomerAccountNumber(rs.getString("customer_account_number"));
                    bill.setCustomerName(rs.getString("customer_name"));
                    bill.setTotal(rs.getBigDecimal("total_amount"));
                    Timestamp ts = rs.getTimestamp("bill_date");
                    bill.setCreatedAt(ts != null ? ts.toLocalDateTime() : null);
                }
            }

            if (bill != null) {
                List<BillItem> items = new ArrayList<>();
                try (PreparedStatement ps2 = c.prepareStatement(isql)) {
                    ps2.setInt(1, billId);
                    try (ResultSet rs2 = ps2.executeQuery()) {
                        while (rs2.next()) {
                            BillItem bi = new BillItem();
                            bi.setId(rs2.getInt("id"));
                            bi.setBillId(rs2.getInt("bill_id"));
                            bi.setItemId(rs2.getInt("item_id"));
                            bi.setQty(rs2.getInt("quantity"));
                            bi.setUnitPrice(rs2.getBigDecimal("price_at_time"));
                            bi.setLineTotal(rs2.getBigDecimal("price_at_time").multiply(BigDecimal.valueOf(bi.getQty())));
                            bi.setItemName(rs2.getString("itemName"));
                            items.add(bi);
                        }
                    }
                }
                bill.setItems(items);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return bill;
    }

    public List<Bill> listRecent(int limit) {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT b.id, c.id AS customer_id, c.account_number AS customer_account_number, c.name AS customer_name, b.total_amount, b.bill_date " +
                     "FROM bills b JOIN customers c ON b.customer_account_number = c.account_number ORDER BY b.bill_date DESC LIMIT ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Bill b = new Bill();
                    b.setId(rs.getInt("id"));
                    b.setCustomerId(rs.getInt("customer_id"));
                    b.setCustomerAccountNumber(rs.getString("customer_account_number"));
                    b.setCustomerName(rs.getString("customer_name"));
                    b.setTotal(rs.getBigDecimal("total_amount"));
                    Timestamp ts = rs.getTimestamp("bill_date");
                    b.setCreatedAt(ts != null ? ts.toLocalDateTime() : null);
                    list.add(b);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public BigDecimal totalSalesForDate(String date) {
        BigDecimal total = BigDecimal.ZERO;
        String sql = "SELECT SUM(total_amount) AS totalSales FROM bills WHERE DATE(bill_date) = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, date);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getBigDecimal("totalSales");
                    if (total == null) total = BigDecimal.ZERO;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<Bill> getBillsByDateRange(Date startDate, Date endDate) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT b.id, c.id AS customer_id, c.account_number AS customer_account_number, c.name AS customer_name, b.total_amount, b.bill_date " +
                     "FROM bills b JOIN customers c ON b.customer_account_number = c.account_number WHERE b.bill_date BETWEEN ? AND ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Bill b = new Bill();
                    b.setId(rs.getInt("id"));
                    b.setCustomerId(rs.getInt("customer_id"));
                    b.setCustomerAccountNumber(rs.getString("customer_account_number"));
                    b.setCustomerName(rs.getString("customer_name"));
                    b.setTotal(rs.getBigDecimal("total_amount"));
                    Timestamp ts = rs.getTimestamp("bill_date");
                    b.setCreatedAt(ts != null ? ts.toLocalDateTime() : null);
                    bills.add(b);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return bills;
    }
}
