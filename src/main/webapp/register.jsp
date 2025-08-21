<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body class="min-h-screen bg-gradient-to-br from-sky-200 via-white to-sky-400 flex items-center justify-center relative overflow-hidden">
    <div class="absolute inset-0 pointer-events-none opacity-30 z-0"
        style="background: url('https://www.toptal.com/designers/subtlepatterns/uploads/symphony.png') repeat;"></div>
    <div class="w-full max-w-md bg-white p-10 rounded-3xl shadow-xl relative z-10">
        <div class="flex flex-col items-center mb-7">
            <span class="inline-block bg-sky-100 rounded-full p-4 shadow mb-3">
                <i class="fas fa-user-plus fa-2x text-green-600"></i>
            </span>
            <h1 class="text-3xl font-black text-sky-800 drop-shadow-lg">Sign Up</h1>
            <p class="text-md text-gray-500 mt-2 font-medium">Create your Pahana Edu account</p>
        </div>
        <form action="register" method="post" class="space-y-5">
            <div>
                <label for="name" class="block text-sm font-semibold text-gray-700 mb-1">Name</label>
                <input type="text" id="name" name="name" required class="block w-full rounded-lg border-gray-300 p-2 focus:ring-sky-500 focus:border-sky-500 shadow-sm" placeholder="Your name">
            </div>
            <div>
                <label for="email" class="block text-sm font-semibold text-gray-700 mb-1">Email</label>
                <input type="email" id="email" name="email" required class="block w-full rounded-lg border-gray-300 p-2 focus:ring-sky-500 focus:border-sky-500 shadow-sm" placeholder="Your email">
            </div>
            <div>
                <label for="password" class="block text-sm font-semibold text-gray-700 mb-1">Password</label>
                <input type="password" id="password" name="password" required class="block w-full rounded-lg border-gray-300 p-2 focus:ring-sky-500 focus:border-sky-500 shadow-sm" placeholder="Choose a password">
            </div>
            <button type="submit"
                    class="w-full py-2 px-4 rounded-lg font-bold shadow-md text-white bg-gradient-to-r from-green-500 to-green-700 hover:from-green-600 hover:to-green-800 transition-all text-lg">
                <i class="fas fa-user-plus mr-1"></i>Sign Up
            </button>
        </form>
        <div class="mt-6 text-center">
            <a href="index.jsp"
               class="inline-block text-sky-700 hover:text-sky-900 text-sm font-semibold underline">
                <i class="fas fa-arrow-left mr-1"></i>Back to Login
            </a>
        </div>
    </div>
</body>
</html>
