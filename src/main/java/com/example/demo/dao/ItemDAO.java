package com.example.demo.dao;

import com.example.demo.model.Item;
import com.example.demo.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {
    public void addItem(Item item) throws SQLException {
        Connection conn = null;
        CallableStatement cs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "{call AddItem(?, ?, ?)}";
            cs = conn.prepareCall(sql);
            cs.setString(1, item.getItemId());
            cs.setString(2, item.getName());
            cs.setBigDecimal(3, item.getPrice());
            cs.execute();
        } finally {
            if (cs != null) cs.close();
            if (conn != null) conn.close();
        }
    }

    public void updateItem(Item item) throws SQLException {
        Connection conn = null;
        CallableStatement cs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "{call UpdateItem(?, ?, ?)}";
            cs = conn.prepareCall(sql);
            cs.setString(1, item.getItemId());
            cs.setString(2, item.getName());
            cs.setBigDecimal(3, item.getPrice());
            cs.execute();
        } finally {
            if (cs != null) cs.close();
            if (conn != null) conn.close();
        }
    }

    public Item getItem(String itemId) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Item item = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM items WHERE item_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, itemId);
            rs = ps.executeQuery();

            if (rs.next()) {
                item = new Item();
                item.setItemId(rs.getString("item_id"));
                item.setName(rs.getString("name"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setCreatedAt(rs.getTimestamp("created_at"));
                item.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return item;
    }

    public List<Item> getAllItems() throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Item> items = new ArrayList<>();

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM items";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Item item = new Item();
                item.setItemId(rs.getString("item_id"));
                item.setName(rs.getString("name"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setCreatedAt(rs.getTimestamp("created_at"));
                item.setUpdatedAt(rs.getTimestamp("updated_at"));
                items.add(item);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return items;
    }
}