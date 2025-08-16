<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Management - Pahana Edu</title>
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
            <h1 class="text-3xl font-bold text-sky-800">Customer Management</h1>
            <a href="${pageContext.request.contextPath}/customers?action=new"
               class="bg-sky-700 hover:bg-sky-800 text-white py-2 px-4 rounded flex items-center">
                <i class="fas fa-plus mr-2"></i>Add Customer
            </a>
        </div>

        <div class="bg-white rounded-lg shadow overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Account Number</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Address</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Telephone</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Units Consumed</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <c:forEach var="customer" items="${customers}">
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap">${customer.accountNumber}</td>
                        <td class="px-6 py-4 whitespace-nowrap">${customer.name}</td>
                        <td class="px-6 py-4 whitespace-nowrap">${customer.address}</td>
                        <td class="px-6 py-4 whitespace-nowrap">${customer.telephone}</td>
                        <td class="px-6 py-4 whitespace-nowrap">${customer.unitsConsumed}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                            <a href="${pageContext.request.contextPath}/customers?action=view&accountNumber=${customer.accountNumber}"
                               class="text-sky-700 hover:text-sky-900 mr-3">
                                <i class="fas fa-eye"></i> View
                            </a>
                            <a href="${pageContext.request.contextPath}/customers?action=edit&accountNumber=${customer.accountNumber}"
                               class="text-indigo-600 hover:text-indigo-900 mr-3">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a href="#" onclick="confirmDelete('${customer.accountNumber}')"
                               class="text-red-600 hover:text-red-900">
                                <i class="fas fa-trash"></i> Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    function confirmDelete(accountNumber) {
        if (confirm("Are you sure you want to delete this customer?")) {
            window.location.href = "${pageContext.request.contextPath}/customers?action=delete&accountNumber=" + accountNumber;
        }
    }
</script>
</body>
</html>