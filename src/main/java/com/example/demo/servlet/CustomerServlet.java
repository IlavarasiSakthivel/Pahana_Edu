package com.example.demo.servlet;

import com.example.demo.dao.DAOFactory;
import com.example.demo.dao.CustomerDAO;
import com.example.demo.model.Customer;
import com.example.demo.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = DAOFactory.getCustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                // List all customers
                List<Customer> customers = customerDAO.getAllCustomers();
                request.setAttribute("customers", customers);
                request.getRequestDispatcher("/customers/list.jsp").forward(request, response);
            } else if ("new".equals(action)) {
                // Show new customer form
                request.getRequestDispatcher("/customers/form.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                // Show edit customer form
                String accountNumber = request.getParameter("accountNumber");
                Customer customer = customerDAO.getCustomerByAccountNumber(accountNumber);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/customers/form.jsp").forward(request, response);
            } else if ("view".equals(action)) {
                // View customer details
                String accountNumber = request.getParameter("accountNumber");
                Customer customer = customerDAO.getCustomerByAccountNumber(accountNumber);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/customers/view.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("save".equals(action)) {
                // Save or update customer
                String accountNumber = request.getParameter("accountNumber");
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                String telephone = request.getParameter("telephone");
                String unitsConsumedStr = request.getParameter("unitsConsumed");

                // Validate input
                if (!ValidationUtil.isValidAccountNumber(accountNumber)) {
                    request.setAttribute("errorMessage", "Invalid account number");
                    request.getRequestDispatcher("/customers/form.jsp").forward(request, response);
                    return;
                }

                if (!ValidationUtil.isValidPhone(telephone)) {
                    request.setAttribute("errorMessage", "Invalid phone number");
                    request.getRequestDispatcher("/customers/form.jsp").forward(request, response);
                    return;
                }

                int unitsConsumed = 0;
                try {
                    unitsConsumed = Integer.parseInt(unitsConsumedStr);
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Units consumed must be a number");
                    request.getRequestDispatcher("/customers/form.jsp").forward(request, response);
                    return;
                }

                Customer customer = new Customer();
                customer.setAccountNumber(accountNumber);
                customer.setName(name);
                customer.setAddress(address);
                customer.setTelephone(telephone);
                customer.setUnitsConsumed(unitsConsumed);

                // Check if it's a new customer or update
                Customer existingCustomer = customerDAO.getCustomerByAccountNumber(accountNumber);
                if (existingCustomer == null) {
                    // New customer
                    customer.setRegistrationDate(LocalDate.now());
                    customerDAO.saveCustomer(customer);
                } else {
                    // Update existing customer
                    customer.setRegistrationDate(existingCustomer.getRegistrationDate());
                    customerDAO.updateCustomer(customer);
                }

                response.sendRedirect(request.getContextPath() + "/customers");
            } else if ("delete".equals(action)) {
                // Delete customer
                String accountNumber = request.getParameter("accountNumber");
                customerDAO.deleteCustomer(accountNumber);
                response.sendRedirect(request.getContextPath() + "/customers");
            }
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }
}