package com.example.demo.servlet;

import com.example.demo.model.Item;
import com.example.demo.service.ItemService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/items")
public class ItemServlet extends HttpServlet {
    private final ItemService service = new ItemService();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";
        switch (action) {
            case "new":
            case "edit":
                if ("edit".equals(action)) {
                    int id = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("item", service.get(id));
                }
                req.getRequestDispatcher("/items/itemForm.jsp").forward(req, resp);
                break;
            default:
                String q = req.getParameter("q");
                req.setAttribute("items", service.list(q));
                req.getRequestDispatcher("/items/itemList.jsp").forward(req, resp);
        }
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("save".equals(action)) {
            Item it = new Item();
            String idStr = req.getParameter("id");
            it.setId(idStr == null || idStr.isBlank() ? 0 : Integer.parseInt(idStr));
            it.setName(req.getParameter("name"));
            it.setPrice(new BigDecimal(req.getParameter("price")));
            it.setStock(Integer.parseInt(req.getParameter("stock")));
            service.save(it);
            resp.sendRedirect(req.getContextPath()+"/items");
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            service.delete(id);
            resp.sendRedirect(req.getContextPath()+"/items");
        } else {
            resp.sendRedirect(req.getContextPath()+"/items");
        }
    }
}
