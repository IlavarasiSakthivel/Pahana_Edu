package com.example.demo.service;

import com.example.demo.dao.UserDAO;
import com.example.demo.entity.User;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    // Return the User object, not boolean
    public User login(String email, String password) {
        return userDAO.authenticate(email, password); // returns entity.User or null
    }

    public void register(String name, String email, String password, String role) {
        User user = new User(name, email, password);
        user.setRole(role); // set role if you have it
        userDAO.save(user);
    }

    // Overloaded register method for cases where role is not provided
    public void register(String name, String email, String password) {
        register(name, email, password, "STAFF"); // default role
    }
}
