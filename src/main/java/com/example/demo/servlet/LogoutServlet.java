package com.example.demo.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/auth/logout")
public class LogoutServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getSession().invalidate();
        resp.sendRedirect(req.getContextPath()+"/index.jsp");
    }
}
