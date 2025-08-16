<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Form - Pahana Edu</title>
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
            <a href="${pageContext.request.contextPath}/customers" class="block py-2.5 px-4 rounded bg-sky-700">
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
            <h1 class="text-3xl font-bold text-sky-800">
                <c:if test="${empty customer}">Add New Customer</c:if>
                <c:if test="${not empty customer}">Edit Customer</c:if>
            </h1>
            <a href="${pageContext.request.contextPath}/customers"
               class="text-sky-700 hover:text-sky-900 flex items-center">
                <i class="fas fa-arrow-left mr-2"></i>Back to Customers
            </a>
        </div>

        <div class="bg-white rounded-lg shadow p-6">
            <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <%= request.getAttribute("errorMessage") %>
            </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/customers" method="post">
                <input type="hidden" name="action" value="save">

                <div class="grid grid-cols-1 gap-6">
                    <c:if test="${empty customer}">
                        <div>
                            <label for="accountNumber" class="block text-sm font-medium text-gray-700">Account Number</label>
                            <input type="text" id="accountNumber" name="accountNumber" required
                                   class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                        </div>
                    </c:if>
                    <c:if test="${not empty customer}">
                        <input type="hidden" name="accountNumber" value="${customer.accountNumber}">
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Account Number</label>
                            <div class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 bg-gray-100">
                                    ${customer.accountNumber}
                            </div>
                        </div>
                    </c:if>

                    <div>
                        <label for="name" class="block text-sm font-medium text-gray-700">Name</label>
                        <input type="text" id="name" name="name" value="${customer.name}" required
                               class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                    </div>

                    <div>
                        <label for="address" class="block text-sm font-medium text-gray-700">Address</label>
                        <textarea id="address" name="address" rows="3" required
                                  class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">${customer.address}</textarea>
                    </div>

                    <div>
                        <label for="telephone" class="block text-sm font-medium text-gray-700">Telephone</label>
                        <input type="text" id="telephone" name="telephone" value="${customer.telephone}" required
                               class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                    </div>

                    <div>
                        <label for="unitsConsumed" class="block text-sm font-medium text-gray-700">Units Consumed</label>
                        <input type="number" id="unitsConsumed" name="unitsConsumed" value="${customer.unitsConsumed}" min="0"
                               class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                    </div>

                    <div class="flex justify-end">
                        <a href="${pageContext.request.contextPath}/customers"
                           class="bg-gray-300 hover:bg-gray-400 text-gray-800 py-2 px-4 rounded mr-2">
                            Cancel
                        </a>
                        <button type="submit" class="bg-sky-700 hover:bg-sky-800 text-white py-2 px-4 rounded">
                            <c:if test="${empty customer}">Add Customer</c:if>
                            <c:if test="${not empty customer}">Update Customer</c:if>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>