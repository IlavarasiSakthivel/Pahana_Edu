package com.example.demo.filter;

import com.example.demo.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

// Restrict /reports/* to ADMIN and MANAGER only
@WebFilter(urlPatterns = {"/reports/*"})
public class RoleFilter implements Filter {
    @Override public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest r = (HttpServletRequest) req;
        HttpServletResponse s = (HttpServletResponse) res;
        User u = (User) r.getSession().getAttribute("loggedUser");
        if (u == null) { s.sendRedirect(r.getContextPath()+"/index.jsp"); return; }
        if (!("ADMIN".equals(u.getRole()) || "MANAGER".equals(u.getRole()))) {
            r.getRequestDispatcher("/forbidden.jsp").forward(req, res);
            return;
        }
        chain.doFilter(req, res);
    }
}
