<%@ page import="com.example.demo.model.User" %>
<%
    User u = (User) session.getAttribute("loggedUser");
    if (u == null) { response.sendRedirect(request.getContextPath()+"/index.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body class="min-h-screen bg-gradient-to-br from-sky-200 via-white to-sky-400 flex relative overflow-hidden">
    <div class="absolute inset-0 pointer-events-none opacity-30 z-0"
         style="background: url('https://www.toptal.com/designers/subtlepatterns/uploads/symphony.png') repeat;"></div>
    <div class="flex w-full min-h-screen relative z-10">
        <!-- Sidebar -->
        <aside class="w-64 bg-white shadow-xl px-6 py-8 flex flex-col space-y-8">
            <div class="flex flex-col items-center mb-4">
                <span class="inline-block bg-sky-100 rounded-full p-4 shadow">
                    <i class="fas fa-user-tie fa-2x text-sky-700"></i>
                </span>
                <h2 class="text-xl font-bold text-sky-700 mt-3">Staff Panel</h2>
            </div>
            <nav class="flex-1 space-y-2">
                <a href="<%= request.getContextPath() %>/staff_dashboard.jsp" class="flex items-center p-3 rounded-lg text-sky-700 font-semibold bg-sky-100 hover:bg-sky-200 transition">
                    <i class="fas fa-tachometer-alt mr-3"></i> Dashboard
                </a>
                <a href="customers.jsp" class="flex items-center p-3 rounded-lg text-gray-700 hover:bg-gray-100 transition">
                    <i class="fas fa-users mr-3"></i> Customers
                </a>
                <a href="items.jsp" class="flex items-center p-3 rounded-lg text-gray-700 hover:bg-gray-100 transition">
                    <i class="fas fa-boxes mr-3"></i> Items
                </a>
                <a href="bills.jsp" class="flex items-center p-3 rounded-lg text-gray-700 hover:bg-gray-100 transition">
                    <i class="fas fa-receipt mr-3"></i> Billing
                </a>
                <a href="reports.jsp" class="flex items-center p-3 rounded-lg text-gray-700 hover:bg-gray-100 transition">
                    <i class="fas fa-chart-bar mr-3"></i> Reports
                </a>
                <a href="help.jsp" class="flex items-center p-3 rounded-lg text-sky-700 hover:bg-sky-100 transition">
                    <i class="fas fa-question-circle mr-3"></i> Help
                </a>
            </nav>
            <div class="mt-auto text-center">
                <a href="<%= request.getContextPath() %>/index.jsp" class="inline-flex items-center justify-center bg-sky-600 hover:bg-sky-700 text-white font-bold py-2 px-5 rounded shadow transition-all duration-200 w-full">
                    <i class="fas fa-sign-out-alt mr-2"></i>Logout
                </a>
            </div>
        </aside>
        <!-- Main content -->
        <main class="flex-1 px-8 py-12">
            <header class="p-6 bg-sky-700 text-white rounded-3xl shadow flex justify-between items-center mb-8">
                <div>
                    <h1 class="text-2xl md:text-3xl font-bold">Staff Dashboard</h1>
                    <p class="text-lg">Welcome, <%= u.getUsername() %> (<%= u.getRole() %>)</p>
                </div>
            </header>
            <div class="p-1 grid md:grid-cols-3 gap-6">
                <!-- Customers -->
                <a class="block bg-white border rounded-2xl p-6 shadow hover:shadow-lg transition"
                   href="<%=request.getContextPath()%>/customers">
                    <h3 class="text-sky-800 font-semibold flex items-center mb-2">
                        <i class="fas fa-users mr-2"></i> Customers
                    </h3>
                    <p class="text-sm text-gray-600">Add / Update / View</p>
                </a>

                <!-- Items -->
                <a class="block bg-white border rounded-2xl p-6 shadow hover:shadow-lg transition"
                   href="<%=request.getContextPath()%>/items">
                    <h3 class="text-sky-800 font-semibold flex items-center mb-2">
                        <i class="fas fa-boxes mr-2"></i> Items
                    </h3>
                    <p class="text-sm text-gray-600">Stock & Prices</p>
                </a>

                <!-- POS / Billing -->
                <a class="block bg-white border rounded-2xl p-6 shadow hover:shadow-lg transition"
                   href="<%=request.getContextPath()%>/bills?action=new">
                    <h3 class="text-sky-800 font-semibold flex items-center mb-2">
                        <i class="fas fa-receipt mr-2"></i> POS
                    </h3>
                    <p class="text-sm text-gray-600">Create Bill</p>
                </a>

                <% if ("MANAGER".equals(u.getRole())) { %>
                <!-- Sales Report (Manager only) -->
                <a class="block bg-white border rounded-2xl p-6 shadow hover:shadow-lg transition"
                   href="<%=request.getContextPath()%>/reports/sales">
                    <h3 class="text-sky-800 font-semibold flex items-center mb-2">
                        <i class="fas fa-chart-bar mr-2"></i> Sales Report
                    </h3>
                    <p class="text-sm text-gray-600">Daily totals</p>
                </a>
                <% } %>

                <!-- Inventory Alerts -->
                <a class="block bg-white border rounded-2xl p-6 shadow hover:shadow-lg transition"
                   href="<%=request.getContextPath()%>/items?filter=low-stock">
                    <h3 class="text-sky-800 font-semibold flex items-center mb-2">
                        <i class="fas fa-exclamation-triangle mr-2"></i> Low Stock
                    </h3>
                    <p class="text-sm text-gray-600">Check items running out</p>
                </a>

                <!-- Customer Orders -->
                <a class="block bg-white border rounded-2xl p-6 shadow hover:shadow-lg transition"
                   href="<%=request.getContextPath()%>/orders">
                    <h3 class="text-sky-800 font-semibold flex items-center mb-2">
                        <i class="fas fa-shopping-cart mr-2"></i> Orders
                    </h3>
                    <p class="text-sm text-gray-600">Track customer orders</p>
                </a>

                <!-- Support / Helpdesk -->
                <a class="block bg-white border rounded-2xl p-6 shadow hover:shadow-lg transition"
                   href="<%=request.getContextPath()%>/help">
                    <h3 class="text-sky-800 font-semibold flex items-center mb-2">
                        <i class="fas fa-headset mr-2"></i> Support
                    </h3>
                    <p class="text-sm text-gray-600">Staff & Customer help</p>
                </a>
            </div>

        </main>
    </div>
</body>
</html>
