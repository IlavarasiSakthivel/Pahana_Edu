package com.example.demo.servlet;

import com.example.demo.dao.BillDAO;
import com.example.demo.dao.impl.BillDAOImpl;
import com.example.demo.model.Bill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {
    private BillDAO billDAO = new BillDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        List<Bill> bills = null;
        if (startDateStr != null && endDateStr != null) {
            try {
                Date startDate = Date.valueOf(startDateStr);
                Date endDate = Date.valueOf(endDateStr);
                bills = billDAO.getBillsByDateRange(startDate, endDate);
            } catch (Exception e) {
                request.setAttribute("error", "Invalid date format or database error.");
            }
        }

        request.setAttribute("bills", bills);
        request.getRequestDispatcher("/report.jsp").forward(request, response);
    }
}