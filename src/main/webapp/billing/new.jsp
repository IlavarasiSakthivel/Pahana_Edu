<%@ page import="java.util.List"%>
<%@ page import="com.example.demo.model.Customer" %>
<%@ page import="com.example.demo.model.Item" %>

<%
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    List<Item> items = (List<Item>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html>
<head>
    <title>New Bill</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function addRow() {
            const selectHtml = document.getElementById('itemSelectTemplate').innerHTML;
            const tbody = document.getElementById('rows');
            const tr = document.createElement('tr');
            tr.innerHTML = `
        <td class="border p-2">${selectHtml}</td>
        <td class="border p-2"><input name="qty" type="number" min="1" value="1" class="border p-1 w-20"></td>
        <td class="border p-2"><button type="button" onclick="this.closest('tr').remove()" class="text-red-700">Remove</button></td>
      `;
            tbody.appendChild(tr);
        }
    </script>
</head>
<body class="bg-sky-50">
<div class="p-6 bg-sky-700 text-white flex justify-between">
    <h1 class="text-xl font-bold">Create Bill</h1>
    <a href="<%=request.getContextPath()%>/bills" class="bg-sky-800 px-3 py-1 rounded">Back</a>
</div>

<form action="<%=request.getContextPath()%>/bills" method="post" class="p-6">
    <input type="hidden" name="action" value="create">
    <div class="bg-white p-4 rounded shadow max-w-3xl">
        <label class="block mb-3">
            
            <span class="text-gray-700">Customer</span>
            <select name="customerId" required class="border p-2 rounded w-full mt-1">
                <option value="">-- Select --</option>
                <% for (Customer c : customers) { %>
                <option value="<%= c.getId() %>"><%= c.getAccountNumber() %> - <%= c.getName() %></option>
                <% } %>
            </select>
        </label>

        <div class="flex justify-between items-center mb-2">
            <h3 class="text-sky-800 font-semibold">Items</h3>
            <button type="button" onclick="addRow()" class="bg-green-600 text-white px-3 py-1 rounded">Add Item</button>
        </div>

        <table class="min-w-full bg-white border">
            <thead class="bg-sky-100">
            <tr><th class="p-2 border">Item</th><th class="p-2 border">Qty</th><th class="p-2 border">Action</th></tr>
            </thead>
            <tbody id="rows"></tbody>
        </table>

        <template id="itemSelectTemplate">
            <select name="itemId" class="border p-1 rounded">
                <% for (Item it : items) { %>
                <option value="<%= it.getId() %>"><%= it.getName() %> (Rs.<%= it.getPrice() %>, Stock:<%= it.getStock() %>)</option>
                <% } %>
            </select>
        </template>

        <div class="mt-4">
            <button class="bg-sky-700 text-white px-4 py-2 rounded">Create Bill</button>
        </div>
    </div>
</form>
</body>
</html>
