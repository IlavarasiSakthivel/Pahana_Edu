package com.example.demo.dao;

import com.example.demo.model.Bill;
import com.example.demo.model.BillItem;
import com.example.demo.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    public int createBill(int customerId, BigDecimal total) throws SQLException {
        String sql = "INSERT INTO bills(customer_id,total) VALUES(?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, customerId);
            ps.setBigDecimal(2, total);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        throw new SQLException("Cannot create bill");
    }

    public void addBillItem(int billId, int itemId, int qty, BigDecimal unitPrice, BigDecimal lineTotal) throws SQLException {
        String sql = "INSERT INTO bill_items(bill_id,item_id,qty,unit_price,line_total) VALUES(?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, billId);
            ps.setInt(2, itemId);
            ps.setInt(3, qty);
            ps.setBigDecimal(4, unitPrice);
            ps.setBigDecimal(5, lineTotal);
            ps.executeUpdate();
        }
    }

    public Bill findByIdWithItems(int billId) {
        Bill bill = null;
        String bsql = "SELECT * FROM bills WHERE id=?";
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
                    bill.setTotal(rs.getBigDecimal("total"));
                    bill.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
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
                            bi.setQty(rs2.getInt("qty"));
                            bi.setUnitPrice(rs2.getBigDecimal("unit_price"));
                            bi.setLineTotal(rs2.getBigDecimal("line_total"));
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
        String sql = "SELECT * FROM bills ORDER BY created_at DESC LIMIT ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Bill b = new Bill();
                    b.setId(rs.getInt("id"));
                    b.setCustomerId(rs.getInt("customer_id"));
                    b.setTotal(rs.getBigDecimal("total"));
                    b.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
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
        String sql = "SELECT SUM(total) AS totalSales FROM bills WHERE DATE(created_at) = ?";
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
        String sql = "SELECT * FROM bills WHERE created_at BETWEEN ? AND ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Bill b = new Bill();
                    b.setId(rs.getInt("id"));
                    b.setCustomerId(rs.getInt("customer_id"));
                    b.setTotal(rs.getBigDecimal("total"));
                    b.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    bills.add(b);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return bills;
    }
}
