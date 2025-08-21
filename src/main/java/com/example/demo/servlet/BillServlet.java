package com.example.demo.servlet;

import com.example.demo.model.Bill;
import com.example.demo.model.BillItem;
import com.example.demo.model.Item;
import com.example.demo.service.BillingService;
import com.example.demo.service.CustomerService;
import com.example.demo.service.ItemService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/bills")
public class BillServlet extends HttpServlet {
    private final BillingService billingService = new BillingService();
    private final CustomerService customerService = new CustomerService();
    private final ItemService itemService = new ItemService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                req.setAttribute("customers", customerService.list(null));
                req.setAttribute("items", itemService.list(null));
                req.getRequestDispatcher("/bills/new.jsp").forward(req, resp);
                break;

            case "receipt":
                int billId = Integer.parseInt(req.getParameter("id"));
                Bill bill = billingService.getBill(billId);
                req.setAttribute("bill", bill);
                req.getRequestDispatcher("/billing/reciept.jsp").forward(req, resp);
                break;

            default:
                List<Bill> bills = billingService.recent(50);
                req.setAttribute("bills", bills != null ? bills : new ArrayList<>());
                req.getRequestDispatcher("/bills/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if ("create".equals(action)) {
            try {
                int customerId = Integer.parseInt(req.getParameter("customerId"));
                String[] itemIds = req.getParameterValues("itemId");
                String[] qtys = req.getParameterValues("qty");

                List<BillItem> items = new ArrayList<>();
                for (int i = 0; i < itemIds.length; i++) {
                    int id = Integer.parseInt(itemIds[i]);
                    int qty = Integer.parseInt(qtys[i]);
                    Item it = itemService.get(id);
                    if (it == null || qty <= 0) continue;

                    BillItem bi = new BillItem();
                    bi.setItemId(id);
                    bi.setQty(qty);
                    bi.setUnitPrice(it.getPrice());
                    items.add(bi);
                }

                int billId = billingService.createBill(customerId, items);
                resp.sendRedirect(req.getContextPath() + "/bills?action=receipt&id=" + billId);

            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("errorMessage", "Failed to create bill: " + e.getMessage());
                doGet(req, resp);
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/bills");
        }
    }
}
