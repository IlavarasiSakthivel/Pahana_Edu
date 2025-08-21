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
    <script>
        function exportTableToCSV(tableId, filename) {
            var csv = [];
            var rows = document.querySelectorAll("#" + tableId + " tr");
            for (var i = 0; i < rows.length; i++) {
                var row = [], cols = rows[i].querySelectorAll("th, td");
                for (var j = 0; j < cols.length; j++)
                    row.push('"' + cols[j].innerText.replace(/"/g, '""') + '"');
                csv.push(row.join(","));
            }
            // Download CSV
            var csvFile = new Blob([csv.join("\n")], { type: "text/csv" });
            var downloadLink = document.createElement("a");
            downloadLink.download = filename;
            downloadLink.href = window.URL.createObjectURL(csvFile);
            downloadLink.style.display = "none";
            document.body.appendChild(downloadLink);
            downloadLink.click();
            document.body.removeChild(downloadLink);
        }
    </script>
</head>
<body class="bg-sky-50">
<div class="p-6 flex justify-between bg-sky-700 text-white">
    <h1 class="text-xl font-bold">Stock Report</h1>
    <div class="flex gap-2">
        <%
            // Get user role from session (assumes it's set as "role" or use loggedUser)
            String role = (String) session.getAttribute("role");
            if (role == null) {
                com.example.demo.model.User loggedUser = (com.example.demo.model.User) session.getAttribute("loggedUser");
                if (loggedUser != null) {
                    role = loggedUser.getRole();
                }
            }
            String dashboardUrl = "admin_dashboard.jsp";
            if (role != null && (role.equalsIgnoreCase("MANAGER") || role.equalsIgnoreCase("CASHIER"))) {
                dashboardUrl = "staff_dashboard.jsp";
            }
        %>
        <a href="<%=request.getContextPath()%>/<%=dashboardUrl%>" class="bg-sky-800 px-4 py-2 rounded shadow hover:bg-sky-900 transition">Dashboard</a>
    </div>
</div>
<div class="p-6 max-w-5xl mx-auto">
    <div class="bg-white rounded-lg shadow p-6 mb-8">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-xl font-semibold text-sky-800">Low Stock Items</h2>
            <button onclick="exportTableToCSV('lowStockTable', 'low_stock_items.csv')" class="bg-sky-700 text-white px-4 py-1 rounded hover:bg-sky-800 transition">Export CSV</button>
        </div>
        <div class="overflow-x-auto">
            <table id="lowStockTable" class="min-w-full bg-white border">
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
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-xl font-semibold text-sky-800">All Items Stock</h2>
            <button onclick="exportTableToCSV('allStockTable', 'all_stock_items.csv')" class="bg-sky-700 text-white px-4 py-1 rounded hover:bg-sky-800 transition">Export CSV</button>
        </div>
        <div class="overflow-x-auto">
            <table id="allStockTable" class="min-w-full bg-white border">
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