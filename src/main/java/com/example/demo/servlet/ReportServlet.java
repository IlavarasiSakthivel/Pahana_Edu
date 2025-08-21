package com.example.demo.servlet;

import com.example.demo.dao.BillDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/reports/sales")
public class ReportServlet extends HttpServlet {
    private final BillDAO billDAO = new BillDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String date = req.getParameter("date");
        if (date == null || date.isBlank()) date = LocalDate.now().toString();

        req.setAttribute("date", date);
        req.setAttribute("total", billDAO.totalSalesForDate(date));
        req.getRequestDispatcher("/reports/sales.jsp").forward(req, resp);
    }
}
