<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Generate Bill - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<!-- Navigation -->
<nav class="bg-indigo-600 text-white shadow-lg">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <div class="flex items-center">
                <div class="flex-shrink-0 flex items-center">
                    <i class="fas fa-book-open text-2xl mr-2"></i>
                    <span class="font-bold text-xl">Pahana Edu</span>
                </div>
                <div class="hidden md:ml-6 md:flex md:space-x-8">
                    <a href="${pageContext.request.contextPath}/home.jsp" class="border-transparent text-indigo-200 hover:border-gray-300 hover:text-white inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                        Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/customers/list" class="border-indigo-500 text-white inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                        Customers
                    </a>
                    <a href="${pageContext.request.contextPath}/items/list" class="border-transparent text-indigo-200 hover:border-gray-300 hover:text-white inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                        Items
                    </a>
                    <a href="${pageContext.request.contextPath}/help.jsp" class="border-transparent text-indigo-200 hover:border-gray-300 hover:text-white inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                        Help
                    </a>
                </div>
            </div>
            <div class="flex items-center">
                <div class="ml-3 relative">
                    <div class="flex items-center space-x-4">
                        <span class="text-sm">Welcome, ${user.username}</span>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="text-sm bg-indigo-700 hover:bg-indigo-800 px-3 py-1 rounded-md">
                            <i class="fas fa-sign-out-alt mr-1"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
    <div class="px-4 py-6 sm:px-0">
        <div class="border-4 border-dashed border-gray-200 rounded-lg p-6">
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-2xl font-semibold text-gray-800">Generate Bill</h1>
                <div class="flex space-x-2">
                    <button onclick="window.print()" class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-md flex items-center">
                        <i class="fas fa-print mr-2"></i> Print Bill
                    </button>
                    <a href="${pageContext.request.contextPath}/customers/list" class="bg-indigo-500 hover:bg-indigo-600 text-white px-4 py-2 rounded-md flex items-center">
                        <i class="fas fa-arrow-left mr-2"></i> Back to Customers
                    </a>
                </div>
            </div>


            <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                <div class="px-4 py-5 sm:p-6">
                    <div class="text-center mb-6">
                        <h2 class="text-2xl font-bold text-indigo-600">PAHANA EDU</h2>
                        <p class="text-gray-600">Bookshop Management System</p>
                        <p class="text-gray-500 text-sm mt-1">Colombo City</p>
                    </div>

                    <div class="border-t border-b border-gray-200 py-4 mb-6">
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <h3 class="text-lg font-medium text-gray-900">Bill To:</h3>
                                <p class="mt-1 text-sm text-gray-600">${customer.name}</p>
                                <p class="text-sm text-gray-600">${customer.address}</p>
                                <p class="text-sm text-gray-600">Phone: ${customer.phone}</p>
                                <p class="text-sm text-gray-600">Account: ${customer.accountNo}</p>
                            </div>
                            <div class="text-right">
                                <p class="text-sm text-gray-600">Bill Date: <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/></p>
                                <p class="text-sm text-gray-600">Bill #: BILL-${customer.accountNo}</p>
                            </div>
                        </div>
                    </div>

                    <table class="min-w-full divide-y divide-gray-200 mb-6">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Quantity</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Rate</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">Units Consumed</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${customer.unitsConsumed}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">LKR 50.00</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">LKR ${customer.unitsConsumed * 50}</td>
                        </tr>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="3" class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 text-right">Total:</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-gray-900">LKR ${customer.unitsConsumed * 50}</td>
                        </tr>
                        </tfoot>
                    </table>

                    <div class="text-center text-sm text-gray-500 mt-8">
                        <p>Thank you for your business!</p>
                        <p class="mt-1">For any inquiries, please contact our customer service.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>