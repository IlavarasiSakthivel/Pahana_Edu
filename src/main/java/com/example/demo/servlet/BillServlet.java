package com.example.demo.servlet;

import com.example.demo.model.Bill;
import com.example.demo.model.BillItem;
import com.example.demo.model.Item;
import com.example.demo.service.BillingService;
import com.example.demo.service.CustomerService;
import com.example.demo.service.ItemService;
import com.example.demo.util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
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

            case "list":
            default:
                List<Bill> bills = new ArrayList<>();
                String sql = "SELECT b.id, c.id AS customer_id, c.account_number AS customer_account_number, c.name AS customer_name, b.total_amount, b.bill_date " +
                             "FROM bills b " +
                             "JOIN customers c ON b.customer_account_number = c.account_number";
                System.out.println("DEBUG: Executing SQL: " + sql);
                try (Connection conn = DBConnection.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery(sql)) {
                    boolean hasRows = false;
                    while (rs.next()) {
                        hasRows = true;
                        Bill billList = new Bill();
                        billList.setId(rs.getInt("id"));
                        billList.setCustomerId(rs.getInt("customer_id"));
                        billList.setCustomerAccountNumber(rs.getString("customer_account_number"));
                        billList.setCustomerName(rs.getString("customer_name"));
                        billList.setTotal(rs.getBigDecimal("total_amount"));
                        java.sql.Timestamp ts = rs.getTimestamp("bill_date");
                        billList.setCreatedAt(ts != null ? ts.toLocalDateTime() : null);
                        bills.add(billList);
                        // Print each bill for debugging
                        System.out.println("DEBUG: Bill row: id=" + billList.getId() +
                            ", customerId=" + billList.getCustomerId() +
                            ", customerAccountNumber=" + billList.getCustomerAccountNumber() +
                            ", customerName=" + billList.getCustomerName() +
                            ", total=" + billList.getTotal() +
                            ", createdAt=" + billList.getCreatedAt());
                    }
                    if (!hasRows) {
                        System.out.println("DEBUG: No rows returned from bills/customers join query.");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                System.out.println("DEBUG: Bills list size = " + bills.size());
                req.setAttribute("bills", bills);
                req.getRequestDispatcher("/billing/list.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if ("create".equals(action)) {
            try {
                String customerAccountNumber = req.getParameter("customerAccountNumber");
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

                int billId = billingService.createBill(customerAccountNumber, items);
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
