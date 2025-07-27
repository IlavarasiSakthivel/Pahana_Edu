<%@ include file="head.jsp" %>

<html>
<head>
    <title>Home</title>
</head>
<body class="bg-gray-50 min-h-screen flex flex-col">
<!-- Navigation Bar -->
<nav class="bg-white shadow p-4 flex items-center justify-between">
    <div class="font-bold text-xl text-rose-500">MyApp</div>
    <ul class="flex space-x-4">
        <li><a href="/" class="text-gray-700 hover:text-rose-500">Home</a></li>
        <li><a href="/about" class="text-gray-700 hover:text-rose-500">About</a></li>
        <li><a href="/contact" class="text-gray-700 hover:text-rose-500">Contact</a></li>
    </ul>
</nav>

<!-- Main Content -->
<main class="flex-grow flex flex-col items-center justify-center px-4">
    <h1 class="text-3xl font-bold text-rose-600 mb-4">Welcome to the Home Page!</h1>
    <p class="text-lg text-gray-700 mb-6 text-center max-w-lg">
        This is your application's home page. Start by exploring the navigation links or customizing this area with more content!
    </p>
    <a href="/dashboard" class="inline-block px-6 py-2 bg-rose-500 text-white rounded hover:bg-rose-600 transition">
        Go to Dashboard
    </a>
</main>

<!-- Footer -->
<footer class="bg-white border-t py-3 text-center text-gray-500 text-sm">
    © 2025 MyApp. All rights reserved.
</footer>
</body>
</html>