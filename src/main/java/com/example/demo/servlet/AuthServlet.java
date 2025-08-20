package com.example.demo.servlet;

import com.example.demo.dao.UserDAO;
import com.example.demo.model.User;
import com.example.demo.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;

public class AuthServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);
            User user = userDAO.authenticate(username, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=2");
        }
    }
}
