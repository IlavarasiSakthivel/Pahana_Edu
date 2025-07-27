package com.example.demo;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Simple authentication logic (use a DB or external system in production)
        if("user@example.com".equals(email) && "password123".equals(password)) {
            // Set user attribute or session as needed
            request.getSession().setAttribute("userEmail", email);

            // Redirect or forward to a success page
            response.sendRedirect("home.jsp");
        } else {
            // Set an error message in the session instead of request
            request.getSession().setAttribute("errorMessage", "Invalid email or password.");
            // Redirect to login page instead of forwarding
            response.sendRedirect("index.jsp");
        }
    }
}