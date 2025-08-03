package com.example.demo.servlet;

import com.example.demo.dao.CustomerDAO;
import com.example.demo.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/bill/*")
public class BillServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && pathInfo.equals("/generate")) {
            try {
                generateBill(request, response);
            } catch (SQLException e) {
                throw new ServletException("Database error", e);
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void generateBill(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String accountNo = request.getParameter("accountNo");
        Customer customer = customerDAO.getCustomer(accountNo);

        if (customer != null) {
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/bill/generate.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Customer not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}