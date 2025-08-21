package com.example.demo.dao;

import com.example.demo.model.Item;
import com.example.demo.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public abstract class ItemDAO {

    public List<Item> findAll(String q) {
        List<Item> data = new ArrayList<>();
        String sql = "SELECT * FROM items " +
                (q != null && !q.isBlank() ? "WHERE name LIKE ? " : "") +
                "ORDER BY id DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            if (q != null && !q.isBlank()) {
                ps.setString(1, "%" + q + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    data.add(map(rs));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return data;
    }

    public Item findById(int id) {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM items WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void create(Item it) {
        String sql = "INSERT INTO items(name,price,stock) VALUES(?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, it.getName());
            ps.setBigDecimal(2, it.getPriceAsBigDecimal());
            ps.setInt(3, it.getStock());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void update(Item it) {
        String sql = "UPDATE items SET name=?, price=?, stock=? WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, it.getName());
            ps.setBigDecimal(2, it.getPriceAsBigDecimal());
            ps.setInt(3, it.getStock());
            ps.setInt(4, it.getId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("DELETE FROM items WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    private Item map(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        // Try to get price as BigDecimal if possible, else as double
        try {
            item.setPrice(rs.getBigDecimal("price"));
        } catch (Exception e) {
            item.setPrice(rs.getDouble("price"));
        }
        // Support both 'stock' and 'stock_quantity' column names
        try {
            item.setStock(rs.getInt("stock"));
        } catch (SQLException e) {
            try {
                item.setStockQuantity(rs.getInt("stock_quantity"));
            } catch (SQLException ex) {
                // ignore
            }
        }
        try {
            item.setDescription(rs.getString("description"));
        } catch (SQLException e) {
            // ignore if column doesn't exist
        }
        try {
            item.setCategory(rs.getString("category"));
        } catch (SQLException e) {
            // ignore if column doesn't exist
        }
        return item;
    }

    public void decreaseStock(int itemId, int qty){
        String sql = "UPDATE items SET stock = stock - ? WHERE id=? AND stock >= ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, qty);
            ps.setInt(2, itemId);
            ps.setInt(3, qty);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public abstract Item getItemById(int id) throws Exception;

    public abstract List<Item> getAllItems() throws Exception;

    public abstract void saveItem(Item item) throws Exception;

    public abstract void updateItem(Item item) throws Exception;

    public abstract void deleteItem(int id) throws Exception;

    public abstract List<Item> getLowStockItems() throws Exception;
}
