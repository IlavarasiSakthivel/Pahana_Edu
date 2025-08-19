<%@ page import="com.example.demo.model.Item" %>
<%
    Item it = (Item) request.getAttribute("item");
    boolean editing = it != null && it.getId() > 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= editing ? "Edit" : "New" %> Item</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-50">
<div class="p-6 bg-sky-700 text-white"><h1 class="text-xl font-bold"><%= editing ? "Edit" : "New" %> Item</h1></div>

<form action="<%=request.getContextPath()%>/items" method="post" class="p-6 grid gap-4 max-w-xl">
    <input type="hidden" name="action" value="save">
    <% if (editing) { %><input type="hidden" name="id" value="<%= it.getId() %>"><% } %>

    <label class="block">
        <span class="text-gray-700">Name</span>
        <input name="name" required value="<%= editing ? it.getName() : "" %>" class="mt-1 w-full border p-2 rounded"/>
    </label>
    <label class="block">
        <span class="text-gray-700">Price</span>
        <input type="number" step="0.01" min="0" name="price" required value="<%= editing ? it.getPrice() : "" %>" class="mt-1 w-full border p-2 rounded"/>
    </label>
    <label class="block">
        <span class="text-gray-700">Stock</span>
        <input type="number" min="0" name="stock" required value="<%= editing ? it.getStock() : 0 %>" class="mt-1 w-full border p-2 rounded"/>
    </label>

    <div class="flex gap-3">
        <button class="bg-sky-700 text-white px-4 py-2 rounded">Save</button>
        <a class="px-4 py-2 border rounded" href="<%=request.getContextPath()%>/items">Cancel</a>
    </div>
</form>
</body>
</html>
