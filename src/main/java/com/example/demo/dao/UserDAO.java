package com.example.demo.dao;

import com.example.demo.entity.User;
import java.sql.*;

public class UserDAO {
    private Connection connection;

    public UserDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/demo", "root", "password"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save(User user) {
        try {
            String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public User authenticate(String email, String password) {
        try {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
