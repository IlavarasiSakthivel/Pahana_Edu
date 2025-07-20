<%@ include file="head.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <title>Login Page</title>
</head>
<body class="min-h-screen flex items-center justify-center bg-gray-100">
<div class="w-full max-w-sm bg-white p-8 rounded-lg shadow-md">
  <h2 class="text-2xl font-bold mb-6 text-center">Sign In</h2>

  <% if(session.getAttribute("errorMessage") != null) { %>
    <div class="text-red-500 mb-4 text-center"><%= session.getAttribute("errorMessage") %></div>
    <% session.removeAttribute("errorMessage"); %>
  <% } %>
  <form class="space-y-5" action="LoginServlet" method="post">
    <div>
      <label class="block text-gray-700 mb-1" for="email">Email</label>
      <input id="email" name="email" type="email" required class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-400" />
    </div>
    <div>
      <label class="block text-gray-700 mb-1" for="password">Password</label>
      <input id="password" name="password" type="password" required class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-400" />
    </div>
    <button type="submit" class="w-full bg-blue-500 text-white py-2 rounded hover:bg-blue-600 transition">Login</button>
  </form>
</div>
</body>
</html>