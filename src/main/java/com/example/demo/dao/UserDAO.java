package com.example.demo.dao;

import com.example.demo.model.User;
import com.example.demo.util.DBUtil;
import java.sql.*;

public class UserDAO {
    public User checkLogin(String username, String password) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;
        System.out.println("Trying login for: " + username + " / " + password);

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            System.out.println("received sql: " + sql );
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
            }
        } catch (SQLException e) {
            // Log the exception for debugging purposes.
            // In a real application, you'd use a proper logging framework like SLF4J, Log4j, or Logback.
            System.err.println("Database error during login for user: " + username);
            e.printStackTrace(); // This prints the full stack trace to the standard error stream.

            // Re-throw the exception or wrap it in a custom exception
            // so the calling code knows something went wrong.
            throw new SQLException("Failed to check login credentials.", e);

        } finally {
            // This block is guaranteed to execute, whether an exception occurred or not.
            // It's essential for closing resources.
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
                System.out.println("User found! Creating user object.");

            } catch (SQLException e) {
                // Log any errors that occur while closing resources.
                System.err.println("Error closing database resources.");
                e.printStackTrace();
            }
        }
        return user;
    }
}