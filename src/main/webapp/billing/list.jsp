<%@ page import="java.util.List"%>
<%@ page import="com.example.demo.model.Bill" %>

<%
    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bills</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-50">
<div class="p-6 bg-sky-700 text-white flex justify-between">
    <h1 class="text-xl font-bold">Recent Bills</h1>
    <a href="<%=request.getContextPath()%>/bills?action=new" class="bg-green-600 px-3 py-1 rounded">New Bill</a>
</div>

<div class="p-6">
    <table class="min-w-full bg-white border">
        <thead class="bg-sky-100">
        <tr><th class="p-2 border">ID</th><th class="p-2 border">Customer ID</th><th class="p-2 border">Total</th><th class="p-2 border">Date</th><th class="p-2 border">Actions</th></tr>
        </thead>
        <tbody>
        <% for (Bill b : bills) { %>
        <tr>
            <td class="p-2 border"><%= b.getId() %></td>
            <td class="p-2 border"><%= b.getCustomerId() %></td>
            <td class="p-2 border">Rs. <%= b.getTotal() %></td>
            <td class="p-2 border"><%= b.getCreatedAt() %></td>
            <td class="p-2 border">
                <a class="text-sky-700" href="<%=request.getContextPath()%>/bills?action=receipt&id=<%=b.getId()%>">Receipt</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
