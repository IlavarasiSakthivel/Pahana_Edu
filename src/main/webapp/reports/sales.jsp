<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sales Report - Pahana Edu</title>
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
            <a href="${pageContext.request.contextPath}/reports?type=sales" class="block py-2.5 px-4 rounded bg-sky-700">
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
            <h1 class="text-3xl font-bold text-sky-800">Sales Report</h1>
            <a href="${pageContext.request.contextPath}/dashboard"
               class="text-sky-700 hover:text-sky-900 flex items-center">
                <i class="fas fa-arrow-left mr-2"></i>Back to Dashboard
            </a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white p-6 rounded-lg shadow">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-sky-100 text-sky-800">
                        <i class="fas fa-calendar-alt text-2xl"></i>
                    </div>
                    <div class="ml-4">
                        <h2 class="text-lg font-semibold text-gray-700">This Month's Sales</h2>
                        <p class="text-2xl font-bold">Rs. ${monthSales}</p>
                    </div>
                </div>
            </div>

            <div class="bg-white p-6 rounded-lg shadow">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-sky-100 text-sky-800">
                        <i class="fas fa-calendar-day text-2xl"></i>
                    </div>
                    <div class="ml-4">
                        <h2 class="text-lg font-semibold text-gray-700">Today's Sales</h2>
                        <p class="text-2xl font-bold">Rs. ${todaySales}</p>
                    </div>
                </div>
            </div>

            <div class="bg-white p-6 rounded-lg shadow">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-sky-100 text-sky-800">
                        <i class="fas fa-file-invoice text-2xl"></i>
                    </div>
                    <div class="ml-4">
                        <h2 class="text-lg font-semibold text-gray-700">Bills This Month</h2>
                        <p class="text-2xl font-bold">${monthBills}</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-lg shadow p-6 mb-8">
            <h2 class="text-xl font-semibold text-sky-800 mb-4">Top Customers This Month</h2>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Account Number</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Telephone</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Total Purchases</th>
                    </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach var="customer" items="${topCustomers}">
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">${customer.accountNumber}</td>
                            <td class="px-6 py-4 whitespace-nowrap">${customer.name}</td>
                            <td class="px-6 py-4 whitespace-nowrap">${customer.telephone}</td>
                            <td class="px-6 py-4 whitespace-nowrap">Rs. ${customer.totalPurchases}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>