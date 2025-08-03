<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login - Pahana Edu</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="min-h-screen flex items-center justify-center bg-gray-100">
<div class="w-full max-w-md bg-white p-8 rounded-lg shadow-md">
  <div class="text-center mb-8">
    <h1 class="text-3xl font-bold text-indigo-600">Pahana Edu</h1>
    <p class="text-gray-600 mt-2">Bookshop Management System</p>
  </div>

  <% if (request.getAttribute("errorMessage") != null) { %>
  <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
    <%= request.getAttribute("errorMessage") %>
  </div>
  <% } %>

  <form action="${pageContext.request.contextPath}/auth/login" method="post" class="space-y-6">
    <div>
      <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
      <div class="mt-1 relative rounded-md shadow-sm">
        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
          <i class="fas fa-user text-gray-400"></i>
        </div>
        <input type="text" id="username" name="username" required
               class="pl-10 focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
      </div>
    </div>

    <div>
      <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
      <div class="mt-1 relative rounded-md shadow-sm">
        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
          <i class="fas fa-lock text-gray-400"></i>
        </div>
        <input type="password" id="password" name="password" required
               class="pl-10 focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
      </div>
    </div>

    <div>
      <button type="submit" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
        Sign In
      </button>
    </div>
  </form>

  <div class="mt-6 text-center">
    <p class="text-sm text-gray-600">
      Need help? <a href="${pageContext.request.contextPath}/help.jsp" class="font-medium text-indigo-600 hover:text-indigo-500">Visit Help Section</a>
    </p>
  </div>
</div>
</body>
</html>