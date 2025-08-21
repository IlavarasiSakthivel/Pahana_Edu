<!-- DEBUG: new.jsp loaded at ${pageContext.request.requestURI} -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.model.Customer" %>
<%@ page import="com.example.demo.model.Item" %>
<%
    // Ensure customers and items are loaded from the request (set by servlet/controller)
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    List<Item> items = (List<Item>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html>
<head>
    <title>New Bill - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function addRow() {
            const table = document.getElementById('itemsTable').getElementsByTagName('tbody')[0];
            const row = table.rows[0].cloneNode(true);
            row.querySelector('select').selectedIndex = 0;
            row.querySelector('input').value = '';
            table.appendChild(row);
        }
        function removeRow(btn) {
            const table = document.getElementById('itemsTable').getElementsByTagName('tbody')[0];
            if (table.rows.length > 1) {
                btn.closest('tr').remove();
            }
        }
    </script>
</head>
<body class="bg-sky-50">
<div class="max-w-3xl mx-auto mt-10 bg-white p-8 rounded shadow">
    <h1 class="text-2xl font-bold mb-6 text-sky-700">Create New Bill</h1>
    <!-- Debug: print customers and items size -->
    <div style="display:none">
        Customers size: <c:out value="${fn:length(customers)}"/>
        Items size: <c:out value="${fn:length(items)}"/>
    </div>
    <form method="post" action="${pageContext.request.contextPath}/bills?action=create">
        <div class="mb-4">
            <label class="block mb-1 font-medium">Customer</label>
            <div class="flex gap-2">
                <input type="text" name="customerNameInput" placeholder="Type customer name or account" class="flex-1 border rounded px-3 py-2" autocomplete="off"/>
                <select name="customerAccountNumber" class="flex-1 border rounded px-3 py-2">
                    <option value="">-- Select Customer --</option>
                    <% if (customers != null) {
                        for (Customer c : customers) { %>
                            <option value="<%= c.getAccountNumber() %>"><%= c.getName() %> (<%= c.getAccountNumber() %>)</option>
                    <%  }
                       } %>
                </select>
            </div>
            <div class="text-xs text-gray-500 mt-1">
                You can either select a customer from the dropdown or type their name/account number above.
            </div>
        </div>
        <div class="mb-4">
            <label class="block mb-1 font-medium">Items</label>
            <table class="min-w-full border" id="itemsTable">
                <thead>
                <tr class="bg-sky-100">
                    <th class="p-2 border">Item</th>
                    <th class="p-2 border">Quantity</th>
                    <th class="p-2 border">Action</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="p-2 border">
                        <div class="flex gap-2">
                            <input type="text" name="itemNameInput[]" placeholder="Type item name" class="flex-1 border rounded px-2 py-1" autocomplete="off"/>
                            <select name="itemId[]" class="flex-1 border rounded px-2 py-1">
                                <option value="">-- Select Item --</option>
                                <% if (items != null) {
                                    for (Item i : items) { %>
                                        <option value="<%= i.getId() %>"><%= i.getName() %></option>
                                <%  }
                                   } %>
                            </select>
                        </div>
                        <div class="text-xs text-gray-500 mt-1">
                            You can either select an item from the dropdown or type its name above.
                        </div>
                    </td>
                    <td class="p-2 border">
                        <input type="number" name="qty[]" min="1" class="w-20 border rounded px-2 py-1" required/>
                    </td>
                    <td class="p-2 border text-center">
                        <button type="button" onclick="addRow()" class="text-green-600 px-2">+</button>
                        <button type="button" onclick="removeRow(this)" class="text-red-600 px-2">-</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="mt-6 flex justify-end">
            <button type="submit" class="bg-sky-700 hover:bg-sky-800 text-white px-6 py-2 rounded">Create Bill</button>
        </div>
    </form>
    <div class="text-xs text-gray-500 mt-4">
        If you fill both the input and dropdown for customer or item, the dropdown value will be used if selected; otherwise, the input value will be used.
    </div>
</div>
</body>
</html>
