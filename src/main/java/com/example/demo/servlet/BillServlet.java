package com.example.demo.servlet;

import com.example.demo.dao.DAOFactory;
import com.example.demo.dao.BillDAO;
import com.example.demo.dao.CustomerDAO;
import com.example.demo.dao.ItemDAO;
import com.example.demo.model.Bill;
import com.example.demo.model.Bill_Item;
import com.example.demo.model.Customer;
import com.example.demo.model.Item;
import com.example.demo.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/billing")
public class BillServlet extends HttpServlet {
    private BillDAO billDAO;
    private CustomerDAO customerDAO;
    private ItemDAO itemDAO;

    @Override
    public void init() {
        billDAO = DAOFactory.getBillDAO();
        customerDAO = DAOFactory.getCustomerDAO();
        itemDAO = DAOFactory.getItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null || "new".equals(action)) {
                // Show new bill form
                List<Customer> customers = customerDAO.getAllCustomers();
                List<Item> items = itemDAO.getAllItems();
                request.setAttribute("customers", customers);
                request.setAttribute("items", items);
                request.getRequestDispatcher("/billing/form.jsp").forward(request, response);
            } else if ("view".equals(action)) {
                // View bill details
                int id = Integer.parseInt(request.getParameter("id"));
                Bill bill = billDAO.getBillById(id);
                request.setAttribute("bill", bill);
                request.getRequestDispatcher("/billing/view.jsp").forward(request, response);
            } else if ("list".equals(action)) {
                // List all bills
                List<Bill> bills = billDAO.getAllBills();
                request.setAttribute("bills", bills);
                request.getRequestDispatcher("/billing/list.jsp").forward(request, response);
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
            if ("create".equals(action)) {
                // Create new bill
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");

                String customerAccountNumber = request.getParameter("customerAccountNumber");
                String[] itemIds = request.getParameterValues("itemId");
                String[] quantities = request.getParameterValues("quantity");

                if (itemIds == null || quantities == null || itemIds.length != quantities.length) {
                    request.setAttribute("errorMessage", "Invalid bill items");
                    request.getRequestDispatcher("/billing/form.jsp").forward(request, response);
                    return;
                }

                List<Bill_Item> billItems = new ArrayList<>();
                double totalAmount = 0;

                for (int i = 0; i < itemIds.length; i++) {
                    int itemId = Integer.parseInt(itemIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);

                    Item item = itemDAO.getItemById(itemId);
                    if (item.getStockQuantity() < quantity) {
                        request.setAttribute("errorMessage", "Insufficient stock for item: " + item.getName());
                        request.getRequestDispatcher("/billing/form.jsp").forward(request, response);
                        return;
                    }

                    Bill_Item billItem = new Bill_Item();
                    billItem.setItemId(itemId);
                    billItem.setQuantity(quantity);
                    billItem.setPriceAtTime(item.getPrice());
                    billItems.add(billItem);

                    totalAmount += item.getPrice() * quantity;

                    // Update stock
                    item.setStockQuantity(item.getStockQuantity() - quantity);
                    itemDAO.updateItem(item);
                }

                Bill bill = new Bill();
                bill.setCustomerAccountNumber(customerAccountNumber);
                bill.setTotalAmount(totalAmount);
                bill.setBillDate(LocalDateTime.now());
                bill.setCashierId(user.getId());
                bill.setBillItems(billItems);

                int billId = billDAO.saveBill(bill);

                response.sendRedirect(request.getContextPath() + "/billing?action=view&id=" + billId);
            }
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }
}