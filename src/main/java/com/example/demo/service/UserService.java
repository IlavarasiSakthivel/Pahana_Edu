package com.example.demo.service;

import com.example.demo.dao.UserDAO;
import com.example.demo.entity.User;
import java.sql.Connection;

public class UserService {
    private final UserDAO userDAO;

    public UserService(Connection connection) {
        this.userDAO = new UserDAO(connection);
    }

    // Return the User object, not boolean
    public com.example.demo.model.User login(String email, String password) {
        return userDAO.authenticate(email, password); // returns model.User or null
    }

    public void register(String name, String email, String password, String role) {
        com.example.demo.model.User user = new com.example.demo.model.User();
        user.setUsername(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role); // set role if you have it
        userDAO.registerUser(user);
    }

    // Overloaded register method for cases where role is not provided
    public void register(String name, String email, String password) {
        register(name, email, password, "STAFF"); // default role
    }
}
