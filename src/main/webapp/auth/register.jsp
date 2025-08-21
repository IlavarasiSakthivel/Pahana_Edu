<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body class="min-h-screen flex items-center justify-center bg-sky-50">
<div class="w-full max-w-md bg-white p-8 rounded-lg shadow-md">
    <div class="text-center mb-8">
        <h1 class="text-3xl font-bold text-sky-800">Pahana Edu</h1>
        <p class="text-gray-600 mt-2">Create your account</p>
    </div>
    <form action="<%= request.getContextPath() %>/auth/register" method="post" class="space-y-6">
        <div>
            <label for="name" class="block text-sm font-medium text-gray-700">Name</label>
            <input type="text" id="name" name="name" required class="mt-1 block w-full rounded border-gray-300 p-2"/>
        </div>
        <div>
            <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
            <input type="email" id="email" name="email" required class="mt-1 block w-full rounded border-gray-300 p-2"/>
        </div>
        <div>
            <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
            <input type="password" id="password" name="password" required class="mt-1 block w-full rounded border-gray-300 p-2"/>
        </div>
        <button type="submit"
                class="w-full bg-sky-700 hover:bg-sky-800 text-white font-bold py-2 px-4 rounded">
            Sign Up
        </button>
    </form>
    <div class="mt-4 text-center">
        <a href="<%= request.getContextPath() %>/index.jsp" class="text-sky-600 hover:text-sky-800 font-semibold">Back to Login</a>
    </div>
</div>
</body>
</html>
<html>
<head><title>Register</title></head>
<body>
<h2>Register</h2>
<form action="register" method="post">
    Name: <input type="text" name="name" required><br/>
    Email: <input type="email" name="email" required><br/>
    Password: <input type="password" name="password" required><br/>
    <button type="submit">Register</button>
</form>
<a href="index.jsp">Already have an account? Login</a>
</body>
</html>