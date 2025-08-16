<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bill Details - Pahana Edu</title>
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
            <a href="${pageContext.request.contextPath}/billing" class="block py-2.5 px-4 rounded bg-sky-700">
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
            <h1 class="text-3xl font-bold text-sky-800">Bill Details</h1>
            <div>
                <button onclick="window.print()" class="bg-sky-700 hover:bg-sky-800 text-white py-2 px-4 rounded mr-2">
                    <i class="fas fa-print mr-2"></i>Print Bill
                </button>
                <a href="${pageContext.request.contextPath}/billing" class="bg-gray-300 hover:bg-gray-400 text-gray-800 py-2 px-4 rounded">
                    <i class="fas fa-arrow-left mr-2"></i>Back
                </a>
            </div>
        </div>

        <div class="bg-white rounded-lg shadow p-6">
            <div class="grid grid-cols-2 gap-8 mb-8">
                <div>
                    <h2 class="text-xl font-semibold text-sky-700 mb-4">Bill Information</h2>
                    <p><span class="font-medium">Bill ID:</span> ${bill.id}</p>
                    <p><span class="font-medium">Date:</span> <fmt:formatDate value="${bill.billDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                    <p><span class="font-medium">Cashier ID:</span> ${bill.cashierId}</p>
                </div>
                <div>
                    <h2 class="text-xl font-semibold text-sky-700 mb-4">Customer Information</h2>
                    <p><span class="font-medium">Account Number:</span> ${bill.customerAccountNumber}</p>
                    <p><span class="font-medium">Name:</span> ${customer.name}</p>
                    <p><span class="font-medium">Address:</span> ${customer.address}</p>
                    <p><span class="font-medium">Telephone:</span> ${customer.telephone}</p>
                </div>
            </div>

            <div class="mb-8">
                <h2 class="text-xl font-semibold text-sky-700 mb-4">Items</h2>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Item ID</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Price</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Quantity</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Total</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="billItem" items="${bill.billItems}">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">${billItem.itemId}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${itemsMap[billItem.itemId].name}</td>
                                <td class="px-6 py-4 whitespace-nowrap">Rs. ${billItem.priceAtTime}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${billItem.quantity}</td>
                                <td class="px-6 py-4 whitespace-nowrap">Rs. ${billItem.priceAtTime * billItem.quantity}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="4" class="px-6 py-4 text-right font-semibold">Total Amount:</td>
                            <td class="px-6 py-4 font-semibold">Rs. ${bill.totalAmount}</td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>