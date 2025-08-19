package com.example.demo.servlet;

import com.example.demo.service.UserService;
import com.example.demo.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        com.example.demo.entity.User entityUser = userService.login(email, password);

        com.example.demo.model.User user = null;
        if (entityUser != null) {
            user = new com.example.demo.model.User(
                entityUser.getId(),
                entityUser.getEmail(),
                entityUser.getRole()
            );
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
