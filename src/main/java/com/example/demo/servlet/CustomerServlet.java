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
import java.util.List;

@WebServlet("/customers/*")
public class CustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/list")) {
                listCustomers(request, response);
            } else if (pathInfo.equals("/new")) {
                showNewForm(request, response);
            } else if (pathInfo.equals("/edit")) {
                showEditForm(request, response);
            } else if (pathInfo.equals("/view")) {
                viewCustomer(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo.equals("/add")) {
                addCustomer(request, response);
            } else if (pathInfo.equals("/update")) {
                updateCustomer(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Customer> customers = customerDAO.getAllCustomers();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/customer/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/customer/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String accountNo = request.getParameter("accountNo");
        Customer existingCustomer = customerDAO.getCustomer(accountNo);
        request.setAttribute("customer", existingCustomer);
        request.getRequestDispatcher("/customer/form.jsp").forward(request, response);
    }

    private void viewCustomer(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String accountNo = request.getParameter("accountNo");
        Customer customer = customerDAO.getCustomer(accountNo);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/customer/view.jsp").forward(request, response);
    }

    private void addCustomer(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String accountNo = request.getParameter("accountNo");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));

        Customer newCustomer = new Customer(accountNo, name, address, phone, unitsConsumed);
        customerDAO.addCustomer(newCustomer);
        response.sendRedirect(request.getContextPath() + "/customers/list");
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String accountNo = request.getParameter("accountNo");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));

        Customer customer = new Customer(accountNo, name, address, phone, unitsConsumed);
        customerDAO.updateCustomer(customer);
        response.sendRedirect(request.getContextPath() + "/customers/list");
    }
}