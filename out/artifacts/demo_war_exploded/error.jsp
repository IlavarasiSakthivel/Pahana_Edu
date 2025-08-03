<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
<div class="max-w-md w-full bg-white shadow-lg rounded-lg p-6">
    <div class="flex justify-center">
        <div class="bg-red-100 rounded-full p-4">
            <i class="fas fa-exclamation-triangle text-red-500 text-3xl"></i>
        </div>
    </div>
    <div class="mt-4 text-center">
        <h3 class="text-lg font-medium text-gray-900">Oops! Something went wrong</h3>
        <p class="mt-2 text-sm text-gray-500">
            We're sorry, but an error has occurred while processing your request.
        </p>
        <div class="mt-6">
            <a href="${pageContext.request.contextPath}/home.jsp" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                <i class="fas fa-home mr-2"></i> Go to Homepage
            </a>
        </div>
    </div>
</div>
</body>
</html>