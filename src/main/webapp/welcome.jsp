<%@ page import="com.example.demo.entity.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head><title>Welcome</title></head>
<body>
<h2>Welcome, <%= user.getName() %>!</h2>
<p>Email: <%= user.getEmail() %></p>
<a href="login.jsp">Logout</a>
</body>
</html>
