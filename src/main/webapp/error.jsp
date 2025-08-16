<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="min-h-screen flex items-center justify-center bg-gray-100">
<div class="w-full max-w-md bg-white p-8 rounded-lg shadow-md text-center">
    <div class="text-red-500 text-6xl mb-4">
        <i class="fas fa-exclamation-triangle"></i>
    </div>
    <h1 class="text-3xl font-bold text-gray-800 mb-4">Oops! Something went wrong</h1>
    <p class="text-gray-600 mb-6">We're sorry, but an error has occurred. Please try again later.</p>
    <a href="${pageContext.request.contextPath}/dashboard" class="bg-sky-700 hover:bg-sky-800 text-white py-2 px-4 rounded">
        <i class="fas fa-home mr-2"></i>Go to Dashboard
    </a>
</div>
</body>
</html>