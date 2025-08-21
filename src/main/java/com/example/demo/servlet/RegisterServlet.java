package com.example.demo.servlet;

import com.example.demo.service.UserService;
import com.example.demo.entity.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        try {
            // Example: replace with proper connection acquisition for your environment
            Class.forName("com.mysql.cj.jdbc.Driver");
            java.sql.Connection connection = java.sql.DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/pahana_edu?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                    "root",
                    "G7#v9Lp@3XqZ!tR8"
            );
            userService = new UserService(connection);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        userService.register(name, email, password);

        response.sendRedirect("index.jsp");
    }
}
