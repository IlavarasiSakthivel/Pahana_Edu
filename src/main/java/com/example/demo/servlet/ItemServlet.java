package com.example.demo.servlet;

import com.example.demo.dao.DAOFactory;
import com.example.demo.dao.ItemDAO;
import com.example.demo.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/items")
public class ItemServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() {
        itemDAO = DAOFactory.getItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                // List all items
                List<Item> items = itemDAO.getAllItems();
                request.setAttribute("items", items);
                request.getRequestDispatcher("/items/list.jsp").forward(request, response);
            } else if ("new".equals(action)) {
                // Show new item form
                request.getRequestDispatcher("/items/form.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                // Show edit item form
                int id = Integer.parseInt(request.getParameter("id"));
                Item item = itemDAO.getItemById(id);
                request.setAttribute("item", item);
                request.getRequestDispatcher("/items/form.jsp").forward(request, response);
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
                // Save or update item
                String idStr = request.getParameter("id");
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                String priceStr = request.getParameter("price");
                String stockStr = request.getParameter("stockQuantity");
                String category = request.getParameter("category");

                // Validate input
                if (name == null || name.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Item name is required");
                    request.getRequestDispatcher("/items/form.jsp").forward(request, response);
                    return;
                }

                double price = 0;
                try {
                    price = Double.parseDouble(priceStr);
                    if (price <= 0) {
                        throw new NumberFormatException();
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Price must be a positive number");
                    request.getRequestDispatcher("/items/form.jsp").forward(request, response);
                    return;
                }

                int stockQuantity = 0;
                try {
                    stockQuantity = Integer.parseInt(stockStr);
                    if (stockQuantity < 0) {
                        throw new NumberFormatException();
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Stock quantity must be a non-negative number");
                    request.getRequestDispatcher("/items/form.jsp").forward(request, response);
                    return;
                }

                Item item = new Item();
                item.setName(name);
                item.setDescription(description);
                item.setPrice(price);
                item.setStockQuantity(stockQuantity);
                item.setCategory(category);

                // Check if it's a new item or update
                if (idStr == null || idStr.isEmpty()) {
                    // New item
                    itemDAO.saveItem(item);
                } else {
                    // Update existing item
                    item.setId(Integer.parseInt(idStr));
                    itemDAO.updateItem(item);
                }

                response.sendRedirect(request.getContextPath() + "/items");
            } else if ("delete".equals(action)) {
                // Delete item
                int id = Integer.parseInt(request.getParameter("id"));
                itemDAO.deleteItem(id);
                response.sendRedirect(request.getContextPath() + "/items");
            }
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }
}