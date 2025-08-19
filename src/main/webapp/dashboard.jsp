
<%@ page import="com.example.demo.model.User" %>
<%
    User loggedUser = (User) session.getAttribute("loggedUser");
    if (loggedUser == null) { response.sendRedirect("index.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-100">
<div class="p-6 bg-sky-700 text-white">
    <h1 class="text-2xl font-bold">Welcome, <%= loggedUser.getUsername() %></h1>
    <p class="mt-1">Role: <%= loggedUser.getRole() %></p>
</div>

<div class="p-6">
    <% if ("ADMIN".equals(loggedUser.getRole())) { %>
    <a href="users.jsp" class="block bg-sky-800 text-white p-4 rounded mt-2">Manage Users</a>
    <% } %>
    <a href="customers.jsp" class="block bg-sky-800 text-white p-4 rounded mt-2">Manage Customers</a>
    <a href="items.jsp" class="block bg-sky-800 text-white p-4 rounded mt-2">Manage Items</a>
    <a href="bills.jsp" class="block bg-sky-800 text-white p-4 rounded mt-2">Billing</a>
    <a href="help.jsp" class="block bg-sky-800 text-white p-4 rounded mt-2">Help</a>
    <a href="logout.jsp" class="block bg-red-600 text-white p-4 rounded mt-2">Logout</a>
</div>
</body>
</html>
