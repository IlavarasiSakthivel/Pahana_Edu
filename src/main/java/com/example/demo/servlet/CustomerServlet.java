package com.example.demo.servlet;

import com.example.demo.model.Customer;
import com.example.demo.service.CustomerService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {
    private final CustomerService service = new CustomerService();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
            case "edit":
                if ("edit".equals(action)) {
                    int id = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("customer", service.get(id));
                }
                req.getRequestDispatcher("/customers/form.jsp").forward(req, resp);
                break;
            case "view":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("customer", service.get(id));
                req.getRequestDispatcher("/customers/view.jsp").forward(req, resp);
                break;
            default:
                String q = req.getParameter("q");
                req.setAttribute("customers", service.list(q));
                req.getRequestDispatcher("/customers/list.jsp").forward(req, resp);
        }
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("save".equals(action)) {
            Customer c = new Customer();
            String idStr = req.getParameter("id");
            c.setId(idStr == null || idStr.isBlank() ? 0 : Integer.parseInt(idStr));
            c.setAccountNumber(req.getParameter("accountNumber"));
            c.setName(req.getParameter("name"));
            c.setAddress(req.getParameter("address"));
            c.setTelephone(req.getParameter("telephone"));
            c.setUnitsConsumed(Integer.parseInt(req.getParameter("unitsConsumed")));
            service.save(c);
            resp.sendRedirect(req.getContextPath()+"/customers");
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            service.delete(id);
            resp.sendRedirect(req.getContextPath()+"/customers");
        } else {
            resp.sendRedirect(req.getContextPath()+"/customers");
        }
    }
}
