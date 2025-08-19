package com.example.demo.servlet;

import com.example.demo.service.UserService;
import com.example.demo.entity.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        userService.register(name, email, password);

        response.sendRedirect("login.jsp");
    }
}
