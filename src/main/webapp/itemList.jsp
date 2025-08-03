<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Item List - Pahana Edu</title>
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
        <h1 class="text-2xl font-semibold text-gray-800">Item Management</h1>
        <a href="${pageContext.request.contextPath}/items/new" class="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md flex items-center">
          <i class="fas fa-plus mr-2"></i> Add New Item
        </a>
      </div>

      <div class="bg-white shadow overflow-hidden sm:rounded-md">
        <ul class="divide-y divide-gray-200">
          <c:forEach items="${items}" var="item">
            <li>
              <div class="px-4 py-4 sm:px-6">
                <div class="flex items-center justify-between">
                  <div class="flex items-center">
                    <div class="flex-shrink-0 bg-green-100 rounded-md p-3">
                      <i class="fas fa-book text-green-600"></i>
                    </div>
                    <div class="ml-4">
                      <h3 class="text-lg font-medium text-green-600">${item.name}</h3>
                      <p class="text-sm text-gray-500">ID: ${item.itemId}</p>
                    </div>
                  </div>
                  <div class="flex space-x-2">
                    <a href="${pageContext.request.contextPath}/items/edit?itemId=${item.itemId}" class="bg-yellow-100 hover:bg-yellow-200 text-yellow-800 px-3 py-1 rounded-md text-sm">
                      <i class="fas fa-edit mr-1"></i> Edit
                    </a>
                  </div>
                </div>
                <div class="mt-2 flex items-center text-sm text-gray-500">
                  <i class="fas fa-tag mr-1.5 text-gray-400"></i>
                  Price: LKR ${item.price}
                </div>
              </div>
            </li>
          </c:forEach>
        </ul>
      </div>
    </div>
  </div>
</div>
</body>
</html>