package com.example.demo.servlet;

import com.example.demo.service.UserService;
import com.example.demo.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            java.sql.Connection connection = java.sql.DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/pahana_edu?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                    "root",
                    "G7#v9Lp@3XqZ!tR8"            );
            userService = new UserService(connection);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        com.example.demo.model.User entityUser = userService.login(email, password);

        com.example.demo.model.User user = null;
        if (entityUser != null) {
            user = new com.example.demo.model.User();
            user.setId(entityUser.getId());
            user.setEmail(entityUser.getEmail());
            user.setUsername(entityUser.getUsername());
            user.setPassword(entityUser.getPassword());
            user.setRole(entityUser.getRole());
        }

        if (user != null) {
            request.getSession().setAttribute("userEmail", email);
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
