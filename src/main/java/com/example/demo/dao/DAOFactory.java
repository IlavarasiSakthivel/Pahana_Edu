package com.example.demo.dao;

import com.example.demo.dao.impl.BillDAOImpl;
import com.example.demo.dao.impl.CustomerDAOImpl;
import com.example.demo.dao.impl.ItemDAOImpl;
import com.example.demo.dao.impl.UserDAOImpl;

public class DAOFactory {
    public static UserDAO getUserDAO() {
        return new UserDAOImpl();
    }

    public static CustomerDAO getCustomerDAO() {
        return new CustomerDAOImpl();
    }

    public static ItemDAO getItemDAO() {
        return new ItemDAOImpl();
    }

    public static BillDAO getBillDAO() {
        return new BillDAOImpl();
    }
}