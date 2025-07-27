<%@ include file="head.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
</head>
<body class="min-h-screen flex flex-col items-center justify-center bg-gray-50">
<div class="bg-white p-8 shadow-lg rounded-lg w-full max-w-md">
    <h2 class="text-2xl font-bold mb-6 text-rose-600 text-center">Create an Account</h2>

    <% String error = (String) session.getAttribute("errorMessage"); %>
    <% if(error != null) { %>
    <div class="bg-rose-100 border border-rose-400 text-rose-700 px-4 py-2 rounded mb-4 text-center">
        <%= error %>
    </div>
    <% session.removeAttribute("errorMessage"); %>
    <% } %>

    <% String success = (String) session.getAttribute("successMessage"); %>
    <% if(success != null) { %>
    <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-2 rounded mb-4 text-center">
        <%= success %>
    </div>
    <% session.removeAttribute("successMessage"); %>
    <% } %>

    <form action="SignUpServlet" method="post" class="space-y-4">
        <div>
            <label class="block text-gray-700 mb-1" for="email">Email</label>
            <input
                    type="email"
                    name="email"
                    id="email"
                    required
                    class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-rose-400"
            />
        </div>
        <div>
            <label class="block text-gray-700 mb-1" for="password">Password</label>
            <input
                    type="password"
                    name="password"
                    id="password"
                    required
                    class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-rose-400"
            />
        </div>
        <div>
            <label class="block text-gray-700 mb-1" for="confirmPassword">Confirm Password</label>
            <input
                    type="password"
                    name="confirmPassword"
                    id="confirmPassword"
                    required
                    class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-rose-400"
            />
        </div>
        <button
                type="submit"
                class="w-full bg-rose-500 hover:bg-rose-600 text-white font-semibold py-2 px-4 rounded transition"
        >Sign Up</button>
    </form>

    <p class="mt-4 text-center text-gray-600 text-sm">
        Already have an account?
        <a href="LoginServlet" class="text-rose-500 hover:underline">Log in</a>
    </p>
</div>
</body>
</html>