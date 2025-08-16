package com.example.demo.servlet;

import com.example.demo.dao.DAOFactory;
import com.example.demo.dao.BillDAO;
import com.example.demo.dao.CustomerDAO;
import com.example.demo.dao.ItemDAO;
import com.example.demo.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private CustomerDAO customerDAO;
    private ItemDAO itemDAO;
    private BillDAO billDAO;

    @Override
    public void init() {
        customerDAO = DAOFactory.getCustomerDAO();
        itemDAO = DAOFactory.getItemDAO();
        billDAO = DAOFactory.getBillDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Get dashboard data
            int customerCount = customerDAO.getAllCustomers().size();
            int itemCount = itemDAO.getAllItems().size();
            int lowStockCount = itemDAO.getLowStockItems().size();

            // Get today's sales
            LocalDate today = LocalDate.now();
            List<com.example.demo.model.Bill> todayBills = billDAO.getBillsByDateRange(
                    java.sql.Date.valueOf(today),
                    java.sql.Date.valueOf(today.plusDays(1))
            );
            double todaySales = todayBills.stream().mapToDouble(bill -> bill.getTotalAmount()).sum();

            request.setAttribute("customerCount", customerCount);
            request.setAttribute("itemCount", itemCount);
            request.setAttribute("lowStockCount", lowStockCount);
            request.setAttribute("todaySales", todaySales);

            // Forward to appropriate dashboard based on role
            if ("admin".equals(user.getRole())) {
                request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/staff/dashboard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }
}