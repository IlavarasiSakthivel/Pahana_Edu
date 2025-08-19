package com.example.demo.servlet;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/auth/login")
public class AuthServlet extends HttpServlet {
    private final UserService service = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = service.login(email, password);

        if (user != null) {
            req.getSession().setAttribute("loggedUser", user);
            // example: check role (you need a role column in your entity & DB)
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/dashboards/admin-dashboard.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/dashboards/staff-dashboard.jsp");
            }
        } else {
            req.setAttribute("errorMessage", "Invalid username or password.");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        }
    }
}
