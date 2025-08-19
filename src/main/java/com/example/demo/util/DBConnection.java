package com.example.demo.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static Connection connection;

    private DBConnection() {}

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/pahana_edu?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                        "root",
                        "G7#v9Lp@3XqZ!tR8"
                );
            }
        } catch (Exception e) {
            throw new RuntimeException("DB connection failed", e);
        }
        return connection;
    }
}
