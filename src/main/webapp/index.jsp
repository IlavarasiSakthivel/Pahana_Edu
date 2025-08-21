<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body class="min-h-screen bg-gradient-to-br from-sky-200 via-white to-sky-400 flex items-center justify-center relative overflow-hidden">
    <div class="absolute inset-0 pointer-events-none opacity-30 z-0"
        style="background: url('https://www.toptal.com/designers/subtlepatterns/uploads/symphony.png') repeat;"></div>
    <div class="w-full max-w-md bg-white p-10 rounded-3xl shadow-xl relative z-10">
        <div class="flex flex-col items-center mb-7">
            <div class="mb-4">
                <span class="inline-block bg-sky-100 rounded-full p-4 shadow">
                    <i class="fas fa-book-open fa-2x text-sky-600"></i>
                </span>
            </div>
            <h1 class="text-4xl font-black text-sky-800 drop-shadow-lg">Pahana Edu</h1>
            <p class="text-lg text-gray-500 mt-3 font-medium">POS & Billing System</p>
        </div>
        <div class="text-center mb-6">
            <p class="text-gray-700">Welcome! Please login to your account.</p>
        </div>
        <%
            String error = (String) request.getAttribute("errorMessage");
            if (error != null) {
        %>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4 shadow"><i class="fas fa-exclamation-circle mr-2"></i><%= error %></div>
        <% } %>
        <form action="<%= request.getContextPath() %>/auth/login" method="post" class="space-y-5">
            <div>
                <label for="username" class="block text-sm font-semibold text-gray-700 mb-1">Username</label>
                <input type="text" id="username" name="username" required
                       class="focus:ring-sky-500 focus:border-sky-500 block w-full sm:text-base border-gray-300 rounded-lg p-2 border shadow-sm" placeholder="Enter your username">
            </div>
            <div>
                <label for="password" class="block text-sm font-semibold text-gray-700 mb-1">Password</label>
                <input type="password" id="password" name="password" required
                       class="focus:ring-sky-500 focus:border-sky-500 block w-full sm:text-base border-gray-300 rounded-lg p-2 border shadow-sm" placeholder="Enter your password">
            </div>
            <button type="submit"
                    class="w-full py-2 px-4 rounded-lg font-bold shadow-md text-white bg-gradient-to-r from-sky-600 to-sky-800 hover:from-sky-700 hover:to-sky-900 transition-all text-lg">
                <i class="fas fa-sign-in-alt mr-2"></i>Sign In
            </button>
        </form>
        <div class="text-center my-5">
            <div class="inline-flex items-center w-full justify-center">
                <hr class="w-1/5 border-gray-300">
                <span class="mx-3 text-gray-400">or</span>
                <hr class="w-1/5 border-gray-300">
            </div>
            <a href="<%= request.getContextPath() %>/register.jsp"
                class="mt-5 inline-block w-full py-2 px-4 rounded-lg bg-green-500 hover:bg-green-700 text-white font-bold shadow transition-all duration-200">
                <i class="fas fa-user-plus mr-1"></i>Sign Up
            </a>
        </div>
        <div class="mt-4 text-center">
            <a href="<%= request.getContextPath() %>/help.jsp" class="text-sky-700 hover:text-sky-900 text-sm font-semibold underline">
                <i class="fas fa-question-circle mr-1"></i>Help
            </a>
        </div>
    </div>
</body>
</html>
