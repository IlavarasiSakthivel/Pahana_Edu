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
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            if (userDAO == null) {
                throw new IllegalStateException("UserDAO is not initialized");
            }

            User user = userDAO.findByUsername(username);

            // Debug: print user object details
            if (user != null) {
                System.out.println("User found: username=" + user.getUsername() +
                                   ", hashedPassword=" + user.getPassword() +
                                   ", role=" + user.getRole() +
                                   ", email=" + user.getEmail() +
                                   ", fullName=" + user.getFullName());
            } else {
                System.out.println("No user found for username: " + username);
            }

            if (user == null) {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            // Debug: print user object to log
            System.out.println("User object: " + user);


            String hashedPassword = user.getPassword();
            if (hashedPassword == null) {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            boolean passwordOk = false;
            try {
                passwordOk = PasswordUtil.checkPassword(password, hashedPassword);
            } catch (Exception ex) {
                ex.printStackTrace();
                request.setAttribute("errorMessage", "Password check failed. Please contact admin.");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            if (passwordOk) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace(); // This will print the real error to your server log
            request.setAttribute("errorMessage", "An internal error occurred: " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}