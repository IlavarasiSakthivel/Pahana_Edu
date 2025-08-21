<%@ page import="com.example.demo.model.User" %>
<%
    User u = (User) session.getAttribute("loggedUser");
    if (u == null) { response.sendRedirect(request.getContextPath()+"/index.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body class="min-h-screen bg-gradient-to-br from-sky-200 via-white to-sky-400 flex items-center justify-center relative overflow-hidden">
    <div class="absolute inset-0 pointer-events-none opacity-30 z-0"
         style="background: url('https://www.toptal.com/designers/subtlepatterns/uploads/symphony.png') repeat;"></div>
    <div class="w-full max-w-xl bg-white p-10 rounded-3xl shadow-xl relative z-10">
        <div class="flex flex-col items-center mb-7">
            <span class="inline-block bg-yellow-100 rounded-full p-4 shadow mb-3">
                <i class="fas fa-user fa-2x text-yellow-600"></i>
            </span>
            <h1 class="text-3xl font-black text-yellow-800 drop-shadow-lg">Welcome to your Dashboard</h1>
            <p class="text-md text-gray-500 mt-2 font-medium">Hello, <b><%= u.getUsername() %></b>! Here is your personal space.</p>
        </div>
        <div class="text-center mt-6">
            <a href="<%= request.getContextPath() %>/index.jsp" class="inline-block bg-yellow-500 hover:bg-yellow-600 text-white font-bold py-2 px-5 rounded shadow transition-all duration-200">
                <i class="fas fa-sign-out-alt mr-2"></i>Logout
            </a>
        </div>
    </div>
</body>
</html>

