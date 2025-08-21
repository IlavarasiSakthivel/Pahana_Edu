package com.example.demo.servlet;

import com.example.demo.dao.BillDAO;
import com.example.demo.model.Bill;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/reports/sales")
public class ReportServlet extends HttpServlet {

    private final BillDAO billDAO = new BillDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String dateStr = req.getParameter("date");
        if (dateStr == null || dateStr.isBlank()) {
            dateStr = LocalDate.now().toString();
        }

        req.setAttribute("date", dateStr);
        req.setAttribute("total", billDAO.totalSalesForDate(dateStr));

        Date sqlDate = Date.valueOf(dateStr);
        List<Bill> bills = billDAO.getBillsByDateRange(sqlDate, sqlDate);
        req.setAttribute("bills", bills);

        req.getRequestDispatcher("/reports/sales.jsp").forward(req, resp);
    }
}
