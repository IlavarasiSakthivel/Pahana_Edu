package com.example.demo.filter;

import com.example.demo.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter(urlPatterns = {"/dashboards/*","/customers/*","/items/*","/bills/*","/reports/*"})
public class AuthFilter implements Filter {
    @Override public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest r = (HttpServletRequest) req;
        HttpServletResponse s = (HttpServletResponse) res;
        User u = (User) r.getSession().getAttribute("loggedUser");
        if (u == null) {
            s.sendRedirect(r.getContextPath() + "/index.jsp");
            return;
        }
        chain.doFilter(req, res);
    }
}
