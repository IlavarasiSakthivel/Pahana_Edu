<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Item Form - Pahana Edu</title>
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
            <a href="${pageContext.request.contextPath}/items" class="block py-2.5 px-4 rounded bg-sky-700">
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
                <c:if test="${empty item}">Add New Item</c:if>
                <c:if test="${not empty item}">Edit Item</c:if>
            </h1>
            <a href="${pageContext.request.contextPath}/items"
               class="text-sky-700 hover:text-sky-900 flex items-center">
                <i class="fas fa-arrow-left mr-2"></i>Back to Items
            </a>
        </div>

        <div class="bg-white rounded-lg shadow p-6">
            <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <%= request.getAttribute("errorMessage") %>
            </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/items" method="post">
                <input type="hidden" name="action" value="save">
                <c:if test="${not empty item}">
                    <input type="hidden" name="id" value="${item.id}">
                </c:if>

                <div class="grid grid-cols-1 gap-6">
                    <div>
                        <label for="name" class="block text-sm font-medium text-gray-700">Name</label>
                        <input type="text" id="name" name="name" value="${item.name}" required
                               class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                    </div>

                    <div>
                        <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                        <textarea id="description" name="description" rows="3"
                                  class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">${item.description}</textarea>
                    </div>

                    <div>
                        <label for="category" class="block text-sm font-medium text-gray-700">Category</label>
                        <select id="category" name="category" required
                                class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                            <option value="">Select a category</option>
                            <option value="Books" ${item.category == 'Books' ? 'selected' : ''}>Books</option>
                            <option value="Stationery" ${item.category == 'Stationery' ? 'selected' : ''}>Stationery</option>
                            <option value="Educational Toys" ${item.category == 'Educational Toys' ? 'selected' : ''}>Educational Toys</option>
                            <option value="Art Supplies" ${item.category == 'Art Supplies' ? 'selected' : ''}>Art Supplies</option>
                            <option value="Other" ${item.category == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>

                    <div>
                        <label for="price" class="block text-sm font-medium text-gray-700">Price (Rs.)</label>
                        <input type="number" id="price" name="price" value="${item.price}" min="0.01" step="0.01" required
                               class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                    </div>

                    <div>
                        <label for="stockQuantity" class="block text-sm font-medium text-gray-700">Stock Quantity</label>
                        <input type="number" id="stockQuantity" name="stockQuantity" value="${item.stockQuantity}" min="0" required
                               class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                    </div>

                    <div class="flex justify-end">
                        <a href="${pageContext.request.contextPath}/items"
                           class="bg-gray-300 hover:bg-gray-400 text-gray-800 py-2 px-4 rounded mr-2">
                            Cancel
                        </a>
                        <button type="submit" class="bg-sky-700 hover:bg-sky-800 text-white py-2 px-4 rounded">
                            <c:if test="${empty item}">Add Item</c:if>
                            <c:if test="${not empty item}">Update Item</c:if>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>