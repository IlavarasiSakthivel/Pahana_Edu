package com.example.demo.servlet.auth;

import com.example.demo.dao.DAOFactory;
import com.example.demo.dao.UserDAO;
import com.example.demo.model.User;
import com.example.demo.util.PasswordUtil;
import com.example.demo.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/auth/signup")
public class SignUpServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = DAOFactory.getUserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/auth/signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");

        // Validation
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username is required");
            request.getRequestDispatcher("/auth/signup.jsp").forward(request, response);
            return;
        }

        if (password == null || password.length() < 8) {
            request.setAttribute("errorMessage", "Password must be at least 8 characters");
            request.getRequestDispatcher("/auth/signup.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match");
            request.getRequestDispatcher("/auth/signup.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("errorMessage", "Invalid email address");
            request.getRequestDispatcher("/auth/signup.jsp").forward(request, response);
            return;
        }

        try {
            // Check if username already exists
            User existingUser = userDAO.findByUsername(username);
            if (existingUser != null) {
                request.setAttribute("errorMessage", "Username already exists");
                request.getRequestDispatcher("/auth/signup.jsp").forward(request, response);
                return;
            }

            // Create new user
            User user = new User();
            user.setUsername(username);
            user.setPassword(PasswordUtil.hashPassword(password));
            user.setRole(role);
            user.setEmail(email);
            user.setFullName(fullName);

            userDAO.save(user);

            // Redirect to login page with success message
            request.setAttribute("successMessage", "Account created successfully. Please login.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }
}