package com.example.demo.servlet;

import com.example.demo.dao.UserDAO;
import com.example.demo.model.User;
import com.example.demo.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/auth/login")
public class AuthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Simple MySQL connection check endpoint: GET /auth/login
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                response.setContentType("text/plain");
                response.getWriter().println("MySQL connection: SUCCESS");
            } else {
                response.setContentType("text/plain");
                response.getWriter().println("MySQL connection: FAILED (conn is null or closed)");
            }
        } catch (Exception e) {
            response.setContentType("text/plain");
            response.getWriter().println("MySQL connection: ERROR");
            response.getWriter().println(e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            // Use your real UserDAO implementation (e.g., UserDAOImpl)
            UserDAO userDAO = new com.example.demo.dao.impl.UserDAOImpl(conn);
            User user = userDAO.authenticate(username, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedUser", user); // Make attribute match JSP expectation
                String role = user.getRole(); // assuming getRole() returns "admin", "staff", "manager", or "customer"
                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect(request.getContextPath() + "/admin_dashboard.jsp");
                } else if ("cashier".equalsIgnoreCase(role) || "manager".equalsIgnoreCase(role)) {
                    response.sendRedirect(request.getContextPath() + "/staff_dashboard.jsp");
                } else if ("customer".equalsIgnoreCase(role)) {
                    response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
                } else {
                    // Default fallback
                    response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
                }
            } else {
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Login error: " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
