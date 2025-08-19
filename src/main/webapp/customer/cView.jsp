<%@ page import="com.example.demo.model.Customer" %>
<%
    Customer c = (Customer) request.getAttribute("customer");
    if (c == null) { response.sendRedirect(request.getContextPath()+"/customers"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-50">
<div class="p-6 bg-sky-700 text-white">
    <h1 class="text-xl font-bold">Customer Details</h1>
</div>
<div class="p-6">
    <div class="bg-white p-6 rounded shadow max-w-xl">
        <p><strong>Account #:</strong> <%= c.getAccountNumber() %></p>
        <p><strong>Name:</strong> <%= c.getName() %></p>
        <p><strong>Address:</strong> <%= c.getAddress() %></p>
        <p><strong>Telephone:</strong> <%= c.getTelephone() %></p>
        <p><strong>Units Consumed:</strong> <%= c.getUnitsConsumed() %></p>
        <div class="mt-4">
            <a class="bg-sky-700 text-white px-4 py-2 rounded" href="<%=request.getContextPath()%>/bills?action=new">Create Bill</a>
        </div>
    </div>
</div>
</body>
</html>
