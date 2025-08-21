package com.example.demo.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private DBConnection() {}

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/pahana_edu?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                    "root",
                    "G7#v9Lp@3XqZ!tR8"
            );
        } catch (Exception e) {
            throw new RuntimeException("DB connection failed", e);
        }
    }
}
