package com.example.demo.dao;

import com.example.demo.model.User;
import java.util.List;

public interface UserDAO {
    User findByUsername(String username) throws Exception;
    User findById(int id) throws Exception;
    void save(User user) throws Exception;
    void update(User user) throws Exception;
    void delete(int id) throws Exception;
    List<User> getAllUsers() throws Exception;
}