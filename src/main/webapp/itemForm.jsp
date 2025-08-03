<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${empty item ? 'Add' : 'Edit'} Item - Pahana Edu</title>
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
                    <a href="${pageContext.request.contextPath}/customers/list" class="border-transparent text-indigo-200 hover:border-gray-300 hover:text-white inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
                        Customers
                    </a>
                    <a href="${pageContext.request.contextPath}/items/list" class="border-indigo-500 text-white inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">
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
                <h1 class="text-2xl font-semibold text-gray-800">
                    <c:if test="${empty item}">Add New Item</c:if>
                    <c:if test="${not empty item}">Edit Item</c:if>
                </h1>
                <a href="${pageContext.request.contextPath}/items/list" class="text-indigo-600 hover:text-indigo-800 flex items-center">
                    <i class="fas fa-arrow-left mr-2"></i> Back to Items
                </a>
            </div>

            <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                <div class="px-4 py-5 sm:p-6">
                    <form action="${pageContext.request.contextPath}/items/${empty item ? 'add' : 'update'}" method="post">
                        <input type="hidden" name="itemId" value="${item.itemId}">

                        <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
                            <div>
                                <label for="itemId" class="block text-sm font-medium text-gray-700">Item ID</label>
                                <input type="text" name="itemId" id="itemId" value="${item.itemId}" required
                                       class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md p-2 border"
                                ${empty item ? '' : 'readonly'}>
                            </div>

                            <div>
                                <label for="name" class="block text-sm font-medium text-gray-700">Item Name</label>
                                <input type="text" name="name" id="name" value="${item.name}" required
                                       class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md p-2 border">
                            </div>

                            <div>
                                <label for="price" class="block text-sm font-medium text-gray-700">Price (LKR)</label>
                                <input type="number" name="price" id="price" value="${item.price}" step="0.01" required
                                       class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md p-2 border">
                            </div>
                        </div>

                        <div class="mt-6">
                            <button type="submit" class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                <i class="fas fa-save mr-2"></i> ${empty item ? 'Add Item' : 'Update Item'}
                            </button>
                            <a href="${pageContext.request.contextPath}/items/list" class="ml-3 inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>