<%@ page import="java.math.BigDecimal"%>
<%
    String date = (String) request.getAttribute("date");
    BigDecimal total = (BigDecimal) request.getAttribute("total");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Sales Report</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-sky-50">
<div class="p-6 bg-sky-700 text-white flex justify-between">
    <h1 class="text-xl font-bold">Daily Sales</h1>
    <a href="<%=request.getContextPath()%>/dashboards/admin-dashboard.jsp" class="bg-sky-800 px-3 py-1 rounded">Dashboard</a>
</div>

<div class="p-6">
    <form method="get" class="mb-4 flex gap-3">
        <input type="date" name="date" value="<%= date %>" class="border p-2 rounded">
        <button class="bg-sky-700 text-white px-4 py-2 rounded" formaction="<%=request.getContextPath()%>/reports/sales">View</button>
    </form>

    <div class="bg-white p-6 rounded shadow max-w-lg">
        <p class="text-gray-700">Date: <strong><%= date %></strong></p>
        <p class="text-gray-700 mt-2">Total Sales: <strong>Rs. <%= total %></strong></p>
    </div>
</div>
</body>
</html>
