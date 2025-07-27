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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If a GET request comes to /login, typically you want to display the login form.
        // This means forwarding to your login JSP (e.g., index.jsp or login.jsp).

        // Example: Forward to index.jsp to display the login form
        request.getRequestDispatcher("/index.jsp").forward(request, response);
        // Make sure index.jsp exists in your src/main/webapp directory.

        // Or, if you just want a simple message for testing:
        // response.getWriter().println("This is the login page (GET request). Please submit your form.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if("user@example.com".equals(email) && "password123".equals(password)) {
            request.getSession().setAttribute("userEmail", email);
            response.sendRedirect("home.jsp"); // Redirect after successful login
        } else {
            request.getSession().setAttribute("errorMessage", "Invalid email or password.");
            response.sendRedirect("index.jsp"); // Redirect back to login page with error
        }
    }
}