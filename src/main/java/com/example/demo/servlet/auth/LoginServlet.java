package com.example.demo.servlet.auth;

import com.example.demo.dao.DAOFactory;
import com.example.demo.dao.UserDAO;
import com.example.demo.model.User;
import com.example.demo.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = DAOFactory.getUserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("GET /auth/login: contextPath=" + request.getContextPath() + ", requestURI=" + request.getRequestURI());
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("POST /auth/login: contextPath=" + request.getContextPath() + ", requestURI=" + request.getRequestURI());
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            if (userDAO == null) {
                throw new IllegalStateException("UserDAO is not initialized");
            }

            User user = userDAO.findByUsername(username);

            if (user == null || user.getPassword() == null) {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            boolean passwordOk = false;
            try {
                passwordOk = PasswordUtil.checkPassword(password, user.getPassword());
            } catch (Exception ex) {
                ex.printStackTrace();
                request.setAttribute("errorMessage", "Password check failed. Please contact admin.");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            if (passwordOk) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                // Ensure dashboard exists and is mapped correctly
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An internal error occurred: " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}