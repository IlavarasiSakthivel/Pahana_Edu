package com.example.demo.dao.impl;

import com.example.demo.dao.ItemDAO;
import com.example.demo.model.Item;
import com.example.demo.config.DatabaseConfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAOImpl implements ItemDAO {
    @Override
    public Item getItemById(int id) throws Exception {
        String sql = "SELECT * FROM items WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractItemFromResultSet(rs);
            }
            return null;
        }
    }

    @Override
    public List<Item> getAllItems() throws Exception {
        String sql = "SELECT * FROM items";
        List<Item> items = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                items.add(extractItemFromResultSet(rs));
            }
        }
        return items;
    }

    @Override
    public void saveItem(Item item) throws Exception {
        String sql = "INSERT INTO items (name, description, price, stock_quantity, category) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, item.getName());
            stmt.setString(2, item.getDescription());
            stmt.setDouble(3, item.getPrice());
            stmt.setInt(4, item.getStockQuantity());
            stmt.setString(5, item.getCategory());
            stmt.executeUpdate();
        }
    }

    @Override
    public void updateItem(Item item) throws Exception {
        String sql = "UPDATE items SET name = ?, description = ?, price = ?, stock_quantity = ?, category = ? WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, item.getName());
            stmt.setString(2, item.getDescription());
            stmt.setDouble(3, item.getPrice());
            stmt.setInt(4, item.getStockQuantity());
            stmt.setString(5, item.getCategory());
            stmt.setInt(6, item.getId());
            stmt.executeUpdate();
        }
    }

    @Override
    public void deleteItem(int id) throws Exception {
        String sql = "DELETE FROM items WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    @Override
    public List<Item> getLowStockItems() throws Exception {
        String sql = "SELECT * FROM items WHERE stock_quantity < 10";
        List<Item> items = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                items.add(extractItemFromResultSet(rs));
            }
        }
        return items;
    }

    private Item extractItemFromResultSet(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setDescription(rs.getString("description"));
        item.setPrice(rs.getDouble("price"));
        item.setStockQuantity(rs.getInt("stock_quantity"));
        item.setCategory(rs.getString("category"));
        return item;
    }
}