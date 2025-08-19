<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body class="min-h-screen flex items-center justify-center bg-sky-100">
<div class="w-full max-w-md bg-white p-8 rounded-lg shadow-md">
    <div class="text-center mb-8">
        <h1 class="text-3xl font-bold text-sky-700">Pahana Edu</h1>
        <p class="text-gray-600 mt-2">POS & Billing System</p>
    </div>
    <%
        String error = (String) request.getAttribute("errorMessage");
        if (error != null) {
    %>
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4"><%= error %></div>
    <% } %>
    <form action="<%= request.getContextPath() %>/auth/login" method="post" class="space-y-6">
        <div>
            <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
            <input type="text" id="username" name="username" required
                   class="mt-1 focus:ring-sky-500 focus:border-sky-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
        </div>
        <div>
            <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
            <input type="password" id="password" name="password" required
                   class="mt-1 focus:ring-sky-500 focus:border-sky-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
        </div>
        <button type="submit"
                class="w-full py-2 px-4 rounded-md text-white bg-sky-700 hover:bg-sky-800">Sign In</button>
    </form>
    <div class="mt-6 text-center">
        <a href="<%= request.getContextPath() %>/help.jsp" class="text-sky-700 hover:text-sky-800 text-sm">Help</a>
    </div>
</div>
</body>
</html>
