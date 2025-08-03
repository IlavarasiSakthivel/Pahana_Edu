package com.example.demo.servlet;

import com.example.demo.dao.ItemDAO;
import com.example.demo.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/items/*")
public class ItemServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/list")) {
                listItems(request, response);
            } else if (pathInfo.equals("/new")) {
                showNewForm(request, response);
            } else if (pathInfo.equals("/edit")) {
                showEditForm(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo.equals("/add")) {
                addItem(request, response);
            } else if (pathInfo.equals("/update")) {
                updateItem(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private void listItems(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Item> items = itemDAO.getAllItems();
        request.setAttribute("items", items);
        request.getRequestDispatcher("/item/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/item/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String itemId = request.getParameter("itemId");
        Item existingItem = itemDAO.getItem(itemId);
        request.setAttribute("item", existingItem);
        request.getRequestDispatcher("/item/form.jsp").forward(request, response);
    }

    private void addItem(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String itemId = request.getParameter("itemId");
        String name = request.getParameter("name");
        BigDecimal price = new BigDecimal(request.getParameter("price"));

        Item newItem = new Item(itemId, name, price);
        itemDAO.addItem(newItem);
        response.sendRedirect(request.getContextPath() + "/items/list");
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String itemId = request.getParameter("itemId");
        String name = request.getParameter("name");
        BigDecimal price = new BigDecimal(request.getParameter("price"));

        Item item = new Item(itemId, name, price);
        itemDAO.updateItem(item);
        response.sendRedirect(request.getContextPath() + "/items/list");
    }
}