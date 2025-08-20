<%@ page import="com.example.demo.model.User" %>
<%
    User u = (User) session.getAttribute("loggedUser");
    if (u == null) { response.sendRedirect(request.getContextPath()+"/index.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-50">
<header class="p-6 bg-sky-700 text-white">
    <div class="flex justify-between">
        <div>
            <h1 class="text-2xl font-bold">Admin Dashboard</h1>
            <p>Welcome, <%= u.getUsername() %> (ADMIN)</p>
        </div>
        <a href="<%= request.getContextPath() %>/auth/logout" class="self-center bg-red-600 px-3 py-1 rounded">Logout</a>
    </div>
</header>

<main class="p-6 grid md:grid-cols-3 gap-4">
    <a class="block bg-white border rounded p-4 shadow hover:shadow-lg" href="<%=request.getContextPath()%>/customers">
        <h3 class="text-sky-800 font-semibold">Manage Customers</h3>
        <p class="text-sm text-gray-600">Add, Edit, Delete, View</p>
    </a>
    <a class="block bg-white border rounded p-4 shadow hover:shadow-lg" href="<%=request.getContextPath()%>/items">
        <h3 class="text-sky-800 font-semibold">Manage Items</h3>
        <p class="text-sm text-gray-600">Stock & Prices</p>
    </a>
    <a class="block bg-white border rounded p-4 shadow hover:shadow-lg" href="<%=request.getContextPath()%>/bills">
        <h3 class="text-sky-800 font-semibold">Billing / POS</h3>
        <p class="text-sm text-gray-600">Create & Print Bills</p>
    </a>
    <a class="block bg-white border rounded p-4 shadow hover:shadow-lg" href="<%=request.getContextPath()%>/reports/sales">
        <h3 class="text-sky-800 font-semibold">Sales Report</h3>
        <p class="text-sm text-gray-600">Daily totals</p>
    </a>
</main>
</body>
</html>
