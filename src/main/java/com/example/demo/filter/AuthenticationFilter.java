package com.example.demo.filter;

import com.example.demo.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    private static final String[] PUBLIC_PATHS = {
            "/index.jsp", "/auth/login", "/auth/logout", "/help.jsp"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // Allow public paths without authentication
        for (String publicPath : PUBLIC_PATHS) {
            if (path.startsWith(publicPath)) {
                chain.doFilter(request, response);
                return;
            }
        }

        // Check for static resources
        if (path.startsWith("/static/") || path.endsWith(".css") || path.endsWith(".js") || path.endsWith(".png")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;

        if (user == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp");
            return;
        }

        // Role-based access control
        if (path.startsWith("/admin/") && !"admin".equals(user.getRole())) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/dashboard");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}