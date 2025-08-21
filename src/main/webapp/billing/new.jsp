<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.demo.model.Item" %>
<%@ page import="com.example.demo.model.Customer" %>
<%@ page import="java.util.List" %>

<%
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    if (customers == null) customers = java.util.Collections.emptyList();

    List<Item> items = (List<Item>) request.getAttribute("items");
    if (items == null) items = java.util.Collections.emptyList();
%>

<!DOCTYPE html>
<html>
<head>
    <title>New Bill</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-50">

<div class="p-6 flex justify-between bg-sky-700 text-white items-center">
    <h1 class="text-xl font-bold">Create New Bill</h1>
    <a href="${pageContext.request.contextPath}/bills" class="bg-gray-600 px-3 py-1 rounded hover:bg-gray-700">Back to Bills</a>
</div>

<div class="p-6 bg-white shadow rounded">
    <form action="${pageContext.request.contextPath}/bills" method="post">
        <input type="hidden" name="action" value="create">

        <!-- Customer Selection -->
        <div class="mb-4">
            <label class="block font-semibold mb-1" for="customerId">Select Customer:</label>
            <select name="customerId" id="customerId" class="w-full border rounded px-2 py-1">
                <c:forEach var="c" items="${customers}">
                    <option value="${c.id}">${c.name} (ID: ${c.id})</option>
                </c:forEach>
            </select>
        </div>

        <!-- Items Table -->
        <div class="mb-4">
            <label class="block font-semibold mb-1">Select Items:</label>
            <table class="min-w-full border">
                <thead class="bg-sky-100">
                <tr>
                    <th class="p-2 border">Item</th>
                    <th class="p-2 border">Price</th>
                    <th class="p-2 border">Quantity</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${items}" varStatus="status">
                    <tr>
                        <td class="p-2 border">${item.name}</td>
                        <td class="p-2 border">Rs. ${item.price}</td>
                        <td class="p-2 border">
                            <input type="number" min="0" value="0" class="w-20 border rounded px-1 py-0.5"
                                   name="qty" id="qty${status.index}">
                            <input type="hidden" name="itemId" value="${item.id}">
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Submit Button -->
        <div>
            <button type="submit" class="bg-green-600 px-4 py-2 text-white rounded hover:bg-green-700">
                Create Bill
            </button>
        </div>
    </form>
</div>

</body>
</html>
