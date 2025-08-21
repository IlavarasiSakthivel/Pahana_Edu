<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.model.Item" %>
<%@ page import="com.example.demo.service.ItemService" %>
<%
    ItemService itemService = new ItemService();
    List<Item> allItems = itemService.list(null);
    List<Item> lowStockItems = new java.util.ArrayList<>();
    for (Item it : allItems) {
        if (it.getStock() < 10) lowStockItems.add(it);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Stock Report</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-50">
<div class="p-6 flex justify-between bg-sky-700 text-white">
    <h1 class="text-xl font-bold">Stock Report</h1>
    <a href="<%=request.getContextPath()%>/admin_dashboard.jsp" class="px-3 py-1 bg-sky-800 rounded">Dashboard</a>
</div>
<div class="p-6 max-w-5xl mx-auto">
    <div class="bg-white rounded-lg shadow p-6 mb-8">
        <h2 class="text-xl font-semibold text-sky-800 mb-4">Low Stock Items</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white border">
                <thead class="bg-sky-100">
                <tr>
                    <th class="p-2 border">ID</th>
                    <th class="p-2 border">Name</th>
                    <th class="p-2 border">Category</th>
                    <th class="p-2 border">Price</th>
                    <th class="p-2 border">Stock</th>
                </tr>
                </thead>
                <tbody>
                <% if (!lowStockItems.isEmpty()) {
                    for (Item item : lowStockItems) { %>
                <tr>
                    <td class="p-2 border"><%= item.getId() %></td>
                    <td class="p-2 border"><%= item.getName() %></td>
                    <td class="p-2 border"><%= item.getCategory() != null ? item.getCategory() : "" %></td>
                    <td class="p-2 border">Rs. <%= item.getPrice() %></td>
                    <td class="p-2 border">
                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                            <%= item.getStock() %>
                        </span>
                    </td>
                </tr>
                <% }
                } else { %>
                <tr>
                    <td colspan="5" class="p-2 border text-center text-gray-500">No low stock items.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <div class="bg-white rounded-lg shadow p-6">
        <h2 class="text-xl font-semibold text-sky-800 mb-4">All Items Stock</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white border">
                <thead class="bg-sky-100">
                <tr>
                    <th class="p-2 border">ID</th>
                    <th class="p-2 border">Name</th>
                    <th class="p-2 border">Category</th>
                    <th class="p-2 border">Price</th>
                    <th class="p-2 border">Stock</th>
                </tr>
                </thead>
                <tbody>
                <% if (!allItems.isEmpty()) {
                    for (Item item : allItems) { %>
                <tr>
                    <td class="p-2 border"><%= item.getId() %></td>
                    <td class="p-2 border"><%= item.getName() %></td>
                    <td class="p-2 border"><%= item.getCategory() != null ? item.getCategory() : "" %></td>
                    <td class="p-2 border">Rs. <%= item.getPrice() %></td>
                    <td class="p-2 border">
                        <% if (item.getStock() < 10) { %>
                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                            <%= item.getStock() %>
                        </span>
                        <% } else { %>
                            <%= item.getStock() %>
                        <% } %>
                    </td>
                </tr>
                <% }
                } else { %>
                <tr>
                    <td colspan="5" class="p-2 border text-center text-gray-500">No items found.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>