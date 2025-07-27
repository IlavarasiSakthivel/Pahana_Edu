package com.example.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the signup page
        request.getRequestDispatcher("/signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Simple validation (improve as needed, including persistence!)
        if (email == null || password == null || !password.equals(confirmPassword)) {
            request.getSession().setAttribute("errorMessage", "Passwords do not match or missing fields.");
            response.sendRedirect("signup.jsp");
            return;
        }

        // Here, insert code to save new user to your database or storage.
        // For demo: Assume email is always unique/registration successful

        request.getSession().setAttribute("successMessage", "Registration successful! You can now log in.");
        response.sendRedirect("signup.jsp");
    }
}