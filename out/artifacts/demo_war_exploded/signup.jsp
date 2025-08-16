<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="min-h-screen flex items-center justify-center bg-gray-100">
<div class="w-full max-w-md bg-white p-8 rounded-lg shadow-md">
    <div class="text-center mb-8">
        <h1 class="text-3xl font-bold text-sky-800">Pahana Edu</h1>
        <p class="text-gray-600 mt-2">Staff Registration</p>
    </div>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/auth/signup" method="post" class="space-y-6">
        <div>
            <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
            <div class="mt-1 relative rounded-md shadow-sm">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i class="fas fa-user text-gray-400"></i>
                </div>
                <input type="text" id="username" name="username" required
                       class="pl-10 focus:ring-sky-500 focus:border-sky-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
            </div>
        </div>

        <div>
            <label for="fullName" class="block text-sm font-medium text-gray-700">Full Name</label>
            <div class="mt-1 relative rounded-md shadow-sm">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i class="fas fa-id-card text-gray-400"></i>
                </div>
                <input type="text" id="fullName" name="fullName" required
                       class="pl-10 focus:ring-sky-500 focus:border-sky-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
            </div>
        </div>

        <div>
            <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
            <div class="mt-1 relative rounded-md shadow-sm">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i class="fas fa-envelope text-gray-400"></i>
                </div>
                <input type="email" id="email" name="email" required
                       class="pl-10 focus:ring-sky-500 focus:border-sky-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
            </div>
        </div>

        <div>
            <label for="role" class="block text-sm font-medium text-gray-700">Role</label>
            <select id="role" name="role" required
                    class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-sky-500 focus:border-sky-500">
                <option value="">Select a role</option>
                <option value="admin">Administrator</option>
                <option value="manager">Manager</option>
                <option value="cashier">Cashier</option>
            </select>
        </div>

        <div>
            <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
            <div class="mt-1 relative rounded-md shadow-sm">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i class="fas fa-lock text-gray-400"></i>
                </div>
                <input type="password" id="password" name="password" required
                       class="pl-10 focus:ring-sky-500 focus:border-sky-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
            </div>
        </div>

        <div>
            <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Confirm Password</label>
            <div class="mt-1 relative rounded-md shadow-sm">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i class="fas fa-lock text-gray-400"></i>
                </div>
                <input type="password" id="confirmPassword" name="confirmPassword" required
                       class="pl-10 focus:ring-sky-500 focus:border-sky-500 block w-full sm:text-sm border-gray-300 rounded-md p-2 border">
            </div>
        </div>

        <div>
            <button type="submit" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-sky-700 hover:bg-sky-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-sky-500">
                Sign Up
            </button>
        </div>
    </form>

    <div class="mt-6 text-center">
        <p class="text-sm text-gray-600">
            Already have an account? <a href="${pageContext.request.contextPath}/index.jsp" class="font-medium text-sky-700 hover:text-sky-800">Sign In</a>
        </p>
    </div>
</div>
</body>
</html>