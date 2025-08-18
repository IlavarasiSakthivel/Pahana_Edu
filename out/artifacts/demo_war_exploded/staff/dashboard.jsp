<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="flex min-h-screen">
    <!-- Sidebar -->
    <div class="bg-sky-800 text-white w-64">
        <div class="p-4 text-2xl font-bold">Pahana Edu</div>
        <nav class="mt-6">
            <a href="${pageContext.request.contextPath}/dashboard" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-tachometer-alt mr-2"></i>Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/customers" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-users mr-2"></i>Customers
            </a>
            <a href="${pageContext.request.contextPath}/items" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-box mr-2"></i>Items
            </a>
            <a href="${pageContext.request.contextPath}/billing" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-file-invoice-dollar mr-2"></i>Billing
            </a>
            <a href="${pageContext.request.contextPath}/reports?type=sales" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-chart-bar mr-2"></i>Sales Report
            </a>
            <a href="${pageContext.request.contextPath}/reports?type=stock" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-warehouse mr-2"></i>Stock Report
            </a>
            <a href="${pageContext.request.contextPath}/help.jsp" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-question-circle mr-2"></i>Help
            </a>
            <a href="${pageContext.request.contextPath}/auth/logout" class="block py-2.5 px-4 rounded hover:bg-sky-700">
                <i class="fas fa-sign-out-alt mr-2"></i>Logout
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="flex-1 p-8">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-sky-800">Staff Dashboard</h1>
            <div class="text-sm text-gray-600">
                Welcome, <span class="font-semibold">${user.fullName}</span> |
                <span class="capitalize">${user.role}</span>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-white p-6 rounded-lg shadow">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-sky-100 text-sky-800">
                        <i class="fas fa-users text-2xl"></i>
                    </div>
                    <div class="ml-4">
                        <h2 class="text-lg font-semibold text-gray-700">Total Customers</h2>
                        <p class="text-2xl font-bold">${customerCount}</p>
                    </div>
                </div>
            </div>

            <div class="bg-white p-6 rounded-lg shadow">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-sky-100 text-sky-800">
                        <i class="fas fa-box text-2xl"></i>
                    </div>
                    <div class="ml-4">
                        <h2 class="text-lg font-semibold text-gray-700">Total Items</h2>
                        <p class="text-2xl font-bold">${itemCount}</p>
                    </div>
                </div>
            </div>

            <div class="bg-white p-6 rounded-lg shadow">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-sky-100 text-sky-800">
                        <i class="fas fa-exclamation-triangle text-2xl"></i>
                    </div>
                    <div class="ml-4">
                        <h2 class="text-lg font-semibold text-gray-700">Low Stock Items</h2>
                        <p class="text-2xl font-bold">${lowStockCount}</p>
                    </div>
                </div>
            </div>

            <div class="bg-white p-6 rounded-lg shadow">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-sky-100 text-sky-800">
                        <i class="fas fa-chart-line text-2xl"></i>
                    </div>
                    <div class="ml-4">
                        <h2 class="text-lg font-semibold text-gray-700">Today's Sales</h2>
                        <p class="text-2xl font-bold">Rs. ${todaySales}</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-lg shadow p-6">
            <h2 class="text-xl font-semibold text-sky-800 mb-4">Quick Actions</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <a href="${pageContext.request.contextPath}/customers?action=new"
                   class="bg-sky-700 hover:bg-sky-800 text-white py-3 px-4 rounded-lg text-center transition duration-300">
                    <i class="fas fa-user-plus mr-2"></i>Add New Customer
                </a>
                <a href="${pageContext.request.contextPath}/items?action=new"
                   class="bg-sky-700 hover:bg-sky-800 text-white py-3 px-4 rounded-lg text-center transition duration-300">
                    <i class="fas fa-plus-circle mr-2"></i>Add New Item
                </a>
                <a href="${pageContext.request.contextPath}/billing?action=new"
                   class="bg-sky-700 hover:bg-sky-800 text-white py-3 px-4 rounded-lg text-center transition duration-300">
                    <i class="fas fa-file-invoice mr-2"></i>Create New Bill
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>